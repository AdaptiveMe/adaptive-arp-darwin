/*
* =| ADAPTIVE RUNTIME PLATFORM |=======================================================================================
*
* (C) Copyright 2013-2014 Carlos Lozano Diez t/a Adaptive.me <http://adaptive.me>.
*
* Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with
* the License. You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
* an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the
* specific language governing permissions and limitations under the License.
*
* Original author:
*
*     * Carlos Lozano Diez
*                 <http://github.com/carloslozano>
*                 <http://twitter.com/adaptivecoder>
*                 <mailto:carlos@adaptive.me>
*
* Contributors:
*
*     * Ferran Vila Conesa
*                 <http://github.com/fnva>
*                 <http://twitter.com/ferran_vila>
*                 <mailto:ferran.vila.conesa@gmail.com>
*
* =====================================================================================================================
*/

import Foundation
import Alamofire
import SwiftyJSON
import AdaptiveArpApi

public class ServiceImpl : NSObject, IService {
    
    /// Logging variable
    let logger : ILogging = LoggingImpl()
    let loggerTag:String = "ServiceImpl"
    
    /// Array of registered services
    var services : [Service]
    
    /// Class constructor
    public override init() {
        
        services = [Service]()
    }
    
    /// Get a reference to a registered service by name.
    /// :param: serviceName Name of service.
    /// :returns: A service, if registered, or null of the service does not exist.
    /// :author: Ferran Vila Conesa
    /// :since: ARP1.0
    public func getService(serviceName : String) -> Service? {
        
        for service in services {
            
            if(service.getName() == serviceName) {
                
                logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Returning \(service.getName()!) from the service pull")
                return service
            }
        }
        
        logger.log(ILoggingLogLevel.WARN, category: loggerTag, message: "\(serviceName) is not founded on the pull")
        
        return nil
    }
    
    /// Check whether a service by the given service is already registered.
    /// :param: service Service to check
    /// :returns: True if the service is registered, false otherwise.
    /// :author: Ferran Vila Conesa
    /// :since: ARP1.0
    public func isRegistered(service : Service) -> Bool {
        
        return self.getService(service.getName()!) != nil ? true : false
    }
    
    /// Check whether a service by the given name is registered.
    /// :param: serviceName Service name to call
    /// :returns: True if the service is registered, false otherwise.
    /// :author: Ferran Vila Conesa
    /// :since: ARP1.0
    public func isRegistered(serviceName : String) -> Bool {
        
        return self.getService(serviceName) != nil ? true : false
    }
    
    /// Register a new service
    /// :param: service Service to register
    /// :author: Ferran Vila Conesa
    /// :since: ARP1.0
    public func registerService(service : Service) {
        
        if service.getName() == "" || service.getName()!.isEmpty {
            
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "The service has no name. Impossible to add to the pull")
        } else {
            
            services.append(service)
            logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Adding \(service.getName()!) to the service pull")
        }
    }
    
    /// Unregister a service
    /// :param: service service to unregister
    /// :author: Ferran Vila Conesa
    /// :since: ARP1.0
    public func unregisterService(service : Service) {
        
        for (index, s) in enumerate(services) {
            
            if(s == service) {
                
                services.removeAtIndex(index)
                
                logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Removing \(service.getName()!) to the service pull")
                
                return
            }
        }
        
        logger.log(ILoggingLogLevel.WARN, category: loggerTag, message: "\(service.getName()!) is not founded in the pull for removing")
    }
    
    /// Unregister all services.
    /// :author: Ferran Vila Conesa
    /// :since: ARP1.0
    public func unregisterServices() {
        
        logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Removing all services from thee service pull")
        
        services.removeAll(keepCapacity: false)
    }
    
    /// Request async a service for an Url
    /// :param: serviceRequest Service Request to call
    /// :param: service        Service called
    /// :param: callback       Callback to call after execution
    /// :author: Ferran Vila Conesa
    /// :since: ARP1.0
    public func invokeService(serviceRequest : ServiceRequest, service : Service, callback : IServiceResultCallback) {
        
        // TODO: SERVICE: the PROXY parameter is not used
        // TODO: REQUEST: Request Content Type parameter is not used
        // TODO: REQUEST: Request Content Lenght parameter is not used
        // TODO: REQUEST: Request Protocol version parameter is not used
        // TODO: REQUEST: Session parameter is not used
        // TODO: REQUEST: Content Encoding parameter is not used
        // TODO: REQUETS headers is not used -> Generate a problem with the tests -> Refactor
        
        // Check for registered services
        if(!self.isRegistered(service)){
            callback.onError(IServiceResultCallbackError.NotRegisteredService)
            self.logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "\(service.getName()!) is not registered on the pull")
            return
        }
        
        // Prepare the url with all the parameters of the endpoint
        let endpoint: Endpoint = service.getEndpoint()!
        var url: String = endpoint.getScheme()!
        url = url + "://"
        url = url + endpoint.getHost()! + ":" + String(endpoint.getPort())
        url = url + endpoint.getPath()!
        
        self.logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "The url of the request is: \(url)")
        
        // Check the url for malforming
        if(Utils.validateUrl(url)){
            callback.onError(IServiceResultCallbackError.MalformedUrl)
            self.logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "Malformed url: \(url)")
            return
        }
        
        // Prepare the JSON content for POST parameters embedded in Content
        var data:NSData = serviceRequest.getContent()!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
        var localError: NSError?
        var json: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &localError)
        
        // Prepare the request with Alamofire Manager
        // let configuration = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        // Headers
        /*if let headers = serviceRequest.getHeaders() {
            
            var defaultHeaders = Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]
            for header:Header in headers {
                
                defaultHeaders[header.getName()!] = header.getData()
            }
            configuration.HTTPAdditionalHeaders = defaultHeaders
        }*/
        
        // Method
        var method:Alamofire.Method!
        if serviceRequest.getMethod() == Service.ServiceMethod.GET.toString() {
            method = .GET
        } else {
            method = .POST
        }
        
        // Make the request
        var notSecured = false
        //let manager = Alamofire.Manager(configuration: configuration)
        if let dict = json as? [String: AnyObject] {
            
            //manager.request(method, url, parameters: dict, encoding: .JSON)
            Alamofire.request(method, url, parameters: dict, encoding: .JSON)
            
                /*.responseJSON { (request, response, JSON, error) in }*/ // JSON response
                .responseString { (request, response, string, error) in
                    
                    // Error
                    if (error != nil) {
                        
                        self.logger.log(ILoggingLogLevel.ERROR, category: self.loggerTag, message: "\(error!.description)")
                        callback.onError(IServiceResultCallbackError.Unknown)
                        return
                    }
                    
                    // Check for Not secured url
                    if startsWith(url, "https://") {
                        self.logger.log(ILoggingLogLevel.DEBUG, category: self.loggerTag, message: "Secured URL (https): \(url)")
                    } else {
                        self.logger.log(ILoggingLogLevel.WARN, category: self.loggerTag, message: "NOT Secured URL (https): \(url)")
                        notSecured = true
                    }
                    
                    self.logger.log(ILoggingLogLevel.DEBUG, category: self.loggerTag, message: "status code: \(response!.statusCode)")
                    
                    var serviceResponse:ServiceResponse!
                    switch (response!.statusCode) {
                    case 200..<399:
                        
                        // TODO: RESPONSE the contentEncoding field is not used
                        // TODO: RESPONSE the contentType field is not used
                        // TODO: RESPONSE: the session and the headers fields are copied from the request
                        
                        var contentBinary = [UInt8](string!.utf8)
                        
                        serviceResponse = ServiceResponse()
                        serviceResponse.setContent(string!)
                        serviceResponse.setContentEncoding("application/json")
                        serviceResponse.setContentLength("\(string!.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))")
                        serviceResponse.setContentBinary(contentBinary)
                        serviceResponse.setContentBinaryLength(contentBinary.count)
                        serviceResponse.setHeaders(serviceRequest.getHeaders()!)
                        serviceResponse.setSession(serviceRequest.getSession()!)
                        serviceResponse.setContentEncoding(serviceRequest.getContentEncoding()!)
                        
                    default:
                        serviceResponse = nil
                    }
                    
                    switch (response!.statusCode) {
                    case 200..<299:
                        
                        if notSecured {
                            callback.onWarning(serviceResponse, warning: IServiceResultCallbackWarning.NotSecure)
                        } else {
                            callback.onResult(serviceResponse)
                        }
                        
                    case 300..<399:
                        callback.onWarning(serviceResponse, warning: IServiceResultCallbackWarning.Redirected)
                    case 400:
                        callback.onError(IServiceResultCallbackError.Unknown)
                    case 401:
                        callback.onError(IServiceResultCallbackError.NotAuthenticated)
                    case 403:
                        callback.onError(IServiceResultCallbackError.Forbidden)
                    case 404:
                        callback.onError(IServiceResultCallbackError.NotFound)
                    case 405:
                        callback.onError(IServiceResultCallbackError.MethodNotAllowed)
                    case 406:
                        callback.onError(IServiceResultCallbackError.NotAllowed)
                    case 408:
                        callback.onError(IServiceResultCallbackError.TimeOut)
                    case 444:
                        callback.onError(IServiceResultCallbackError.NoResponse)
                    case 400..<499:
                        callback.onError(IServiceResultCallbackError.Unreachable)
                    case 500..<599:
                        callback.onError(IServiceResultCallbackError.Unreachable)
                    default:
                        callback.onError(IServiceResultCallbackError.Unknown)
                    }
            }
        }
        
    }
    
}