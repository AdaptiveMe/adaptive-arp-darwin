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

public class ServiceImpl : IService {
    
    /// Logging variable
    let logger : ILogging = LoggingImpl()
    
    /// Array of registered services
    var services : [Service]
    
    /// Queue for the services calls
    let q : dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
    
    /**
    Class constructor
    */
    init() {
        
        services = [Service]()
    }
    
    /**
    Get a reference to a registered service by name.
    
    :param: serviceName Name of service.
    
    :returns: A service, if registered, or null of the service does not exist.
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func getService(serviceName : String) -> Service? {
        
        for service in services {
            
            if(service.getName() == serviceName) {
                
                logger.log(ILoggingLogLevel.DEBUG, category: "ServiceImpl", message: "Returning \(service.getName()) from the service pull")
                return service
            }
        }
        
        logger.log(ILoggingLogLevel.WARN, category: "ServiceImpl", message: "\(serviceName) is not founded on the pull")
        
        return nil
    }
    
    /**
    Request async a service for an Url
    
    :param: serviceRequest Service Request to call
    :param: service        Service called
    :param: callback       Callback to call after execution
    :author: Ferran Vila Conesa
    :since: ARP1.0
    :see: https://github.com/jquave/SwiftPOSTTutorial
    */
    public func invokeService(serviceRequest : ServiceRequest, service : Service, callback : IServiceResultCallback) {
        
        // TODO: handle http status WARNING codes for: NotRegisteredService, NotTrusted, IncorrectScheme
        // TODO: Use the encoding of the request in order to convert the string (*1)
        
        // Create a que task for executing the service
        
        let t = async(q) { () -> String? in
            
            if(!self.isRegistered(service)){
                
                callback.onError(IServiceResultCallbackError.ServiceNotRegistered)
                self.logger.log(ILoggingLogLevel.ERROR, category: "ServiceImpl", message: "\(service.getName()) is not registered on the pull")
                return nil
            }
            
            // Prepare the url with all the parameters of the endpoint
            let endpoint: Endpoint = service.getEndpoint()
            let  url: String = endpoint.getScheme() + "://" + endpoint.getHost() + ":" + String(endpoint.getPort()) + endpoint.getPath()
            
            self.logger.log(ILoggingLogLevel.DEBUG, category: "ServiceImpl", message: "The url of the request is: \(url)")
            
            // Check the url for malforming
            if(Utils.validateUrl(url)){
                callback.onError(IServiceResultCallbackError.MalformedUrl)
                self.logger.log(ILoggingLogLevel.ERROR, category: "ServiceImpl", message: "Malformed url: \(url)")
                return nil
            }
            
            let data: NSData = (serviceRequest.getContent() as NSString).dataUsingEncoding(NSUTF8StringEncoding)!
            
            // Call the function that composes the Request
            self.post(url, method: service.getMethod(), contentType: serviceRequest.getContentType(), contentLenght: serviceRequest.getContentLength(), content: NSInputStream(data: data)) { (succeeded: UInt, responseContent: NSString?, warning: IServiceResultCallbackWarning?, error: IServiceResultCallbackError?) -> () in
                
                if(succeeded == 0) {
                    
                    // Compose the response
                    
                    // TODO: set the values for ContentType, ContentBinary, ContentBinaryLenght, headers and sessions
                    
                    var response: ServiceResponse = ServiceResponse()
                    
                    response.setContent(responseContent!)
                    response.setContentLength(String(responseContent!.length))
                    
                    self.logger.log(ILoggingLogLevel.DEBUG, category: "ServiceImpl", message: "\(service.getName()) is called correctly")
                    callback.onResult(response)
                }
                else if (succeeded == 1){
                    
                    // TODO: Compose the Service Response
                    
                    var response: ServiceResponse = ServiceResponse()
                    self.logger.log(ILoggingLogLevel.WARN, category: "ServiceImpl", message: "There was an warning calling the service: \(service.getName()) \(error!)")
                    callback.onWarning(response, warning: warning!)
                }
                else {
                    
                    self.logger.log(ILoggingLogLevel.ERROR, category: "ServiceImpl", message: "There was an error calling the service: \(service.getName()) \(error!)")
                    callback.onError(error!)
                }
            }
            
            return nil
        }
        
        // Execute the task
        var v: String? = t.await()
    }
    
    private func post(url : String, method: Service.ServiceMethod, contentType: String, contentLenght: Int, content: NSInputStream, postCompleted : (succeeded: UInt, responseContent: NSString?, warning: IServiceResultCallbackWarning?, error: IServiceResultCallbackError?) -> ()) {
        
        // TODO: The type of the service is not used (Service.ServiceType)
        // TODO: The Proxy parameter of the Endpoint is not used
        // TODO: The headers parameters is not used
        // TODO: The method atribute of the ServiceRequest is not used
        // TODO: The protocol version of the Service Request is not used
        // TODO: The raw content of the Service Request is not used
        // TODO: The session attribute of Service Request is not used
        
        // Create and prepare the request and the sesion
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var session = NSURLSession.sharedSession()
        
        // Prepare the Service Request
        let contentType: String = contentType != "" ? contentType : "application/json"
        
        var err: NSError?
        request.HTTPBodyStream = content
        request.addValue(contentType, forHTTPHeaderField: "Content-Type")
        request.addValue(contentType, forHTTPHeaderField: "Accept")
        request.addValue(String(contentLenght), forHTTPHeaderField: "Content-Length")
        request.HTTPMethod = method == Service.ServiceMethod.POST ? "POST" : "GET"
        request.HTTPShouldUsePipelining = true
        
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            // Cast the response and the errors
            let httpResponse: NSHTTPURLResponse = response as NSHTTPURLResponse
            
            // TODO: inspect the error and determine what to do
            let nsError: NSError? = error as NSError
            
            // There was an error on the data task
            if(nsError != nil) {
                
                self.logger.log(ILoggingLogLevel.ERROR, category: "ServiceImpl", message: "The call of the service is getting an error")
                
                postCompleted(succeeded: 2, responseContent: nil, warning: nil, error: IServiceResultCallbackError.Unreachable)
            }
            else {
                
                //Converting data to String
                let responseText:NSString = NSString(data:data, encoding:NSUTF8StringEncoding)!
                
                // Check for Not secured url
                if (url as NSString).containsString("https://") {
                    self.logger.log(ILoggingLogLevel.DEBUG, category: "ServiceImpl", message: "Secured URL (https): \(url)")
                } else {
                    self.logger.log(ILoggingLogLevel.WARN, category: "ServiceImpl", message: "NOT Secured URL (https): \(url)")
                    
                    postCompleted(succeeded: 1, responseContent: responseText, warning: IServiceResultCallbackWarning.NotSecure, error: nil)
                }
                
                self.logger.log(ILoggingLogLevel.DEBUG, category: "ServiceImpl", message: "status code: \(httpResponse.statusCode)")
                
                switch (httpResponse.statusCode) {
                case 200..<299:
                    postCompleted(succeeded: 0, responseContent: responseText, warning: nil, error: nil)
                case 300..<399:
                    postCompleted(succeeded: 1, responseContent: responseText, warning: IServiceResultCallbackWarning.Redirected, error: nil)
                case 400:
                    postCompleted(succeeded: 2, responseContent: nil, warning: nil, error: IServiceResultCallbackError.Wrong_Params)
                case 401:
                    postCompleted(succeeded: 2, responseContent: nil, warning: nil, error: IServiceResultCallbackError.NotAuthenticated)
                case 403:
                    postCompleted(succeeded: 2, responseContent: nil, warning: nil, error: IServiceResultCallbackError.Forbidden)
                case 404:
                    postCompleted(succeeded: 2, responseContent: nil, warning: nil, error: IServiceResultCallbackError.NotFound)
                case 405:
                    postCompleted(succeeded: 2, responseContent: nil, warning: nil, error: IServiceResultCallbackError.MethodNotAllowed)
                case 406:
                    postCompleted(succeeded: 2, responseContent: nil, warning: nil, error: IServiceResultCallbackError.NotAllowed)
                case 408:
                    postCompleted(succeeded: 2, responseContent: nil, warning: nil, error: IServiceResultCallbackError.TimeOut)
                case 444:
                    postCompleted(succeeded: 2, responseContent: nil, warning: nil, error: IServiceResultCallbackError.NoResponse)
                case 400..<499:
                    postCompleted(succeeded: 2, responseContent: nil, warning: nil, error: IServiceResultCallbackError.Unreachable)
                case 500..<599:
                    postCompleted(succeeded: 2, responseContent: nil, warning: nil, error: IServiceResultCallbackError.Unreachable)
                default:
                    postCompleted(succeeded: 2, responseContent: nil, warning: nil, error: IServiceResultCallbackError.Unreachable)
                    
                }
                
            }
        })
        
        // Start the task
        task.resume()
    }
    
    /**
    Check whether a service by the given service is already registered.
    
    :param: service Service to check
    
    :returns: True if the service is registered, false otherwise.
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func isRegistered(service : Service) -> Bool {
        
        // TODO: now we are comparing the services by name, but the correct way is doing by a comparison using a extensing. But the element Service has to implement the Equatable interface
        // :see: http://stackoverflow.com/questions/24102024/how-to-check-if-an-element-is-in-an-array
        
        return self.getService(service.getName()) != nil ? true : false
    }
    
    /**
    Check whether a service by the given name is registered.
    
    :param: serviceName Service name to call
    
    :returns: True if the service is registered, false otherwise.
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func isRegistered(serviceName : String) -> Bool {
        
        // TODO: now we are comparing the services by name, but the correct way is doing by a comparison using a extensing. But the element Service has to implement the Equatable interface
        // :see: http://stackoverflow.com/questions/24102024/how-to-check-if-an-element-is-in-an-array
        
        return self.getService(serviceName) != nil ? true : false
    }
    
    /**
    Register a new service
    
    :param: service Service to register
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func registerService(service : Service) {
        
        services.append(service)
        
        logger.log(ILoggingLogLevel.DEBUG, category: "ServiceImpl", message: "Adding \(service.getName()) to the service pull")
    }
    
    /**
    Unregister a service
    
    :param: service service to unregister
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func unregisterService(service : Service) {
        
        for (index, s) in enumerate(services) {
            
            if(s.getName() == service.getName()) {
                
                services.removeAtIndex(index)
                
                logger.log(ILoggingLogLevel.DEBUG, category: "ServiceImpl", message: "Removing \(service.getName()) to the service pull")
                
                return
            }
        }
        
        logger.log(ILoggingLogLevel.WARN, category: "ServiceImpl", message: "\(service.getName()) is not founded in the pull for removing")
    }
    
    /**
    Unregister all services.
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func unregisterServices() {
        
        logger.log(ILoggingLogLevel.DEBUG, category: "ServiceImpl", message: "Removing all services from thee service pull")
        
        services.removeAll(keepCapacity: false)
    }
    
}