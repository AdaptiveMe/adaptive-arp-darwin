/**
--| ADAPTIVE RUNTIME PLATFORM |----------------------------------------------------------------------------------------

(C) Copyright 2013-2015 Carlos Lozano Diez t/a Adaptive.me <http://adaptive.me>.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the
License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0 . Unless required by appli-
-cable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,  WITHOUT
WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the  License  for the specific language governing
permissions and limitations under the License.

Original author:

* Carlos Lozano Diez
<http://github.com/carloslozano>
<http://twitter.com/adaptivecoder>
<mailto:carlos@adaptive.me>

Contributors:

* Ferran Vila Conesa
<http://github.com/fnva>
<http://twitter.com/ferran_vila>
<mailto:ferran.vila.conesa@gmail.com>

* See source code files for contributors.

Release:

* @version v2.0.2

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation
import AdaptiveArpApi
#if os(iOS)
    import UIKit
#endif
#if os(OSX)
    import WebKit
#endif

/**
Interface for Managing the Services operations
Auto-generated implementation of IService specification.
*/
public class ServiceDelegate : BaseCommunicationDelegate, IService {
    
    /// Logger variable
    let logger : ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge()
    let loggerTag : String = "ServiceDelegate"
    
    /**
    Internal class to encapsulate the session information of the requests/response to one endpoint.
    This class mantains the cookies, Session attributes, Headers and user-agent between consecutive
    requests/responses for one endpoint
    */
    class Header {
        
        var headers : [ServiceHeader]!
        var cookies : [ServiceSessionCookie]!
        var attributes : [ServiceSessionAttribute]!
        var userAgent : String!
        
        init(){
            headers = [ServiceHeader]()
            cookies = [ServiceSessionCookie]()
            attributes = [ServiceSessionAttribute]()
            userAgent = ""
        }
    }
    
    /// Dictionary for storing the session information. The key of the dictionary is the service-endpoint name
    var headers:[String : Header]!
    
    /**
    Default Constructor.
    */
    public override init() {
        super.init()
        
        headers = [String : Header]()
    }
    
    /**
    Obtains a ServiceToken for the given parameters to be used for the creation of requests.
    
    @param serviceName  Service name.
    @param endpointName Endpoint name.
    @param functionName Function name.
    @param method       Method type.
    @return ServiceToken to create a service request or null if the given parameter combination is not
    configured in the platform's XML service definition file.
    @since v2.0.6
    */
    public func getServiceToken(serviceName : String, endpointName : String, functionName : String, method : IServiceMethod) -> ServiceToken? {
        
        // Check if the service is registered
        if !self.isServiceRegistered(serviceName, endpointName: endpointName, functionName: functionName, method: method)! {
            
            logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The service you are trying to obtain a token is not registered in the io config platform file. Please register it")
            return nil
        }
        
        // Create a token and return it
        return convertToServiceToken(serviceName, endpointName: endpointName, functionName: functionName, method: method)
    }
    
    /**
    Obtains a Service token by a concrete uri (http://domain.com/path). This method would be useful when
    a service response is a redirect (3XX) and it is necessary to make a request to another host and we
    don't know by advance the name of the service.
    
    @param uri Unique Resource Identifier for a Service-Endpoint-Path-Method
    @return ServiceToken to create a service request or null if the given parameter is not
    configured in the platform's XML service definition file.
    @since v2.1.4
    */
    public func getServiceTokenByUri(uri : String) -> ServiceToken? {
        
        if let serviceToken:ServiceToken = IOParser.sharedInstance.getServiceTokenByURI(uri) {
            if self.isServiceRegistered(serviceToken) {
                return serviceToken
            }
        }
        
        logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The service you are trying to obtain by URI is not registered in the io config platform file.")
        return nil
    }
    
    /**
    Create a service request for the given ServiceToken. This method creates the request, populating
    existing headers and cookies for the same service. The request is populated with all the defaults
    for the service being invoked and requires only the request body to be set. Headers and cookies may be
    manipulated as needed by the application before submitting the ServiceRequest via invokeService.
    
    @param serviceToken ServiceToken to be used for the creation of the request.
    @return ServiceRequest with pre-populated headers, cookies and defaults for the service.
    @since v2.0.6
    */
    public func getServiceRequest(serviceToken : ServiceToken) -> ServiceRequest? {
        
        if !self.isServiceRegistered(serviceToken) {
            
            logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The service you are trying to make a request is not registered in the io config platform file. Please register it")
            return nil
        }
        
        let request:ServiceRequest = ServiceRequest()
        
        // Content Encoding - by default UFT-8
        request.setContentEncoding(IServiceContentEncoding.Utf8)
        
        // Set the service Token to the request
        request.setServiceToken(serviceToken)
        
        // User agent - Interrogate Javascript
        let useragent:String = ""
        /*#if os(iOS)
            
            #if (arch(i386) || arch(x86_64)) && os(iOS)
                
                let webview: AnyObject? = AppRegistryBridge.sharedInstance.getPlatformContextWeb().getWebviewPrimary()
                dispatch_async(dispatch_get_main_queue(), {
                    useragent = (webview as! UIWebView).stringByEvaluatingJavaScriptFromString("navigator.userAgent")!
                })
                
            #endif
            
        #endif
        #if os(OSX)
            var webview: AnyObject? = AppRegistryBridge.sharedInstance.getPlatformContextWeb().getWebviewPrimary()
            dispatch_async(dispatch_get_main_queue(), {
            useragent = (webview as WebView).stringByEvaluatingJavaScriptFromString("navigator.userAgent")!
            })
        #endif*/
        request.setUserAgent(useragent)
        
        // Referer host
        request.setRefererHost(serviceToken.getEndpointName()!)
        
        // Content Type - Extract from the service configuration
        request.setContentType(IOParser.sharedInstance.getContentType(serviceToken))
        
        // Headers
        /*if let info:Header = headers[serviceToken.getEndpointName()!] {
            
            // There is previous information of this endpoint
            request.setServiceHeaders(info.headers)
            request.setServiceSession(ServiceSession(cookies: info.cookies, attributes: info.attributes))
            
        } else {
            logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "There is no previous information for this endpoint: \(serviceToken.getEndpointName()!)")
            headers[serviceToken.getEndpointName()!] = Header()
        }*/
        return request
    }
    
    /**
    Returns all the possible service tokens configured in the platform's XML service definition file.
    
    @return Array of service tokens configured.
    @since v2.0.6
    */
    public func getServicesRegistered() -> [ServiceToken]? {
        
        return IOParser.sharedInstance.getServices()
    }
    
    /**
    Checks whether a specific service, endpoint, function and method type is configured in the platform's
    XML service definition file.
    
    @param serviceName  Service name.
    @param endpointName Endpoint name.
    @param functionName Function name.
    @param method       Method type.
    @return Returns true if the service is configured, false otherwise.
    @since v2.0.6
    */
    public func isServiceRegistered(serviceName : String, endpointName : String, functionName : String, method : IServiceMethod) -> Bool? {
        
        if serviceName.isEmpty || serviceName == "" || endpointName.isEmpty || endpointName == "" || functionName.isEmpty || functionName == "" || method == IServiceMethod.Unknown {
            
            logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "There are some parameteres in the ServiceToken that are empty or Unknown")
            
            return false
        }
        
        return IOParser.sharedInstance.validateService(convertToServiceToken(serviceName, endpointName: endpointName, functionName: functionName, method: method))
    }
    
    /**
    Checks whether a specific token is configured in the platform's XML service definition file.
    
    :param: token Service Token
    
    :returns: Returns true if the service is configured, false otherwise.
    */
    private func isServiceRegistered(token:ServiceToken) -> Bool {
        
        return self.isServiceRegistered(token.getServiceName()!, endpointName: token.getEndpointName()!, functionName: token.getFunctionName()!, method: token.getInvocationMethod()!)!
    }
    
    /**
    Internal method to convert an array of parameters into a service token
    
    :param: serviceName  Name of the service
    :param: endpointName Url of the endpoint
    :param: functionName Path of the function
    :param: method       HTTP method for the call
    
    :returns: Token for making a call
    */
    private func convertToServiceToken(serviceName : String, endpointName : String, functionName : String, method : IServiceMethod) -> ServiceToken {
        
        // Create a token and return it
        let token:ServiceToken = ServiceToken()
        token.setServiceName(serviceName)
        token.setEndpointName(endpointName)
        token.setFunctionName(functionName)
        token.setInvocationMethod(method)
        
        return token
    }
    
    /**
    Executes the given ServiceRequest and provides responses to the given callback handler.
    
    @param serviceRequest ServiceRequest with the request body.
    @param callback       IServiceResultCallback to handle the ServiceResponse.
    @since v2.0.6
    */
    public func invokeService(serviceRequest : ServiceRequest, callback : IServiceResultCallback) {
        
        // TODO: Vaidation Type on ServiceEndpoint. Certificate validation, Fingerprints, etc...
        // Warning CertificateUntrusted
        
        if let token = serviceRequest.getServiceToken() {
            
            if self.isServiceRegistered(token) {
                
                if let  service:Service = IOParser.sharedInstance.getServiceByToken(token) {
                    
                    // url composistion
                    let serviceEndpoint:ServiceEndpoint = service.getServiceEndpoints()![0]
                    let url : NSMutableString = NSMutableString()
                    url.appendString(serviceEndpoint.getHostURI()!)
                    url.appendString(serviceEndpoint.getPaths()![0].getPath()!)
                    
                    // queryParameters
                    if let params:[ServiceRequestParameter] = serviceRequest.getQueryParameters() {
                        
                        if params.count > 0 {
                            
                            url.appendString("?")
                            
                            for (index, param) in params.enumerate() {
                                url.appendString(param.getKeyName()! + "=" + param.getKeyData()!)
                                if index < params.count-1 {
                                    url.appendString("&")
                                }
                            }
                        }
                        
                    } else {
                        // There are no query parameters, nothing to do
                        logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "There are no query parameters, nothing to do")
                    }
                    
                    self.logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "The url of the request is: \(url)")
                    
                    // Check the url for malforming
                    if !Utils.validateUrl(url) {
                        
                        self.logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Malformed url: \(url)")
                        callback.onError(IServiceResultCallbackError.MalformedUrl)
                        return
                        
                    } else {

                        // Prepare the request
                        let request = NSMutableURLRequest()
                        request.HTTPShouldUsePipelining = true
                        request.HTTPShouldHandleCookies = true
                        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
                        
                        
                        switch serviceRequest.getServiceToken()!.getInvocationMethod()! {
                            
                        case IServiceMethod.Post:
                            request.HTTPMethod = "POST"
                        case IServiceMethod.Get:
                            request.HTTPMethod = "GET"
                        case IServiceMethod.Head:
                            request.HTTPMethod = "HEAD"
                        case IServiceMethod.Unknown:
                            request.HTTPMethod = "GET"
                        }
                        
                        request.URL = NSURL(string: url as String)!
                        
                        // Content or BodyParameteres + Content
                        
                        let content:NSMutableString = NSMutableString()
                        if let params:[ServiceRequestParameter] = serviceRequest.getBodyParameters() {
                            
                            // If there are body parameters, append to the content
                            
                            for param in params {
                                content.appendString(param.getKeyName()! + "=" + param.getKeyData()! + "\n")
                            }
                        }
                        
                        if let c = serviceRequest.getContent() {
                            content.appendString(c)
                        }
                        
                        
                        var data:NSData? = nil
                        
                        switch serviceRequest.getContentEncoding()! {
                        case IServiceContentEncoding.Ascii:
                            data = content.dataUsingEncoding(NSASCIIStringEncoding)
                        case IServiceContentEncoding.IsoLatin1:
                            data = content.dataUsingEncoding(NSISOLatin1StringEncoding)
                        case IServiceContentEncoding.Unicode:
                            data = content.dataUsingEncoding(NSUnicodeStringEncoding)
                        case IServiceContentEncoding.Utf8:
                            data = content.dataUsingEncoding(NSUTF8StringEncoding)
                        case IServiceContentEncoding.Unknown:
                            data = content.dataUsingEncoding(NSUTF8StringEncoding)
                        }
                        
                        if let data = data {
                            request.HTTPBody = data
                            
                            // Content Encoding
                            request.addValue(serviceRequest.getContentEncoding()!.toString(), forHTTPHeaderField: "Content-Encoding")
                            
                            // Content Lenght
                            request.addValue("\(data.length)", forHTTPHeaderField: "Content-Length")
                            
                            // Content Type
                            request.addValue("\(serviceRequest.getContentType())", forHTTPHeaderField: "Content-Type")
                            
                            // Referer Host
                            request.addValue("\(serviceRequest.getRefererHost())", forHTTPHeaderField: "Referer")
                            
                            // user-agent
                            request.addValue("\(serviceRequest.getUserAgent())", forHTTPHeaderField: "User-Agent")
                            
                            // HEADERS & SESSION
                            
                            let endpoint = serviceRequest.getServiceToken()!.getEndpointName()!
                            
                            if let h:Header =  headers[endpoint] {
                                
                                self.logger.log(ILoggingLogLevel.Debug, category: self.loggerTag, message: "Loading previous headers information stored")
                                
                                for c:ServiceSessionCookie in h.cookies {
                                    self.logger.log(ILoggingLogLevel.Debug, category: self.loggerTag, message: "Setting cookie: \(c.getCookieName())=\(c.getCookieValue())")
                                    request.addValue(c.getCookieValue()!, forHTTPHeaderField: c.getCookieName()!)
                                }
                                
                            }
                            
                        } else {
                            self.logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "There is an error encoding the data for the request")
                            callback.onError(IServiceResultCallbackError.Unknown)
                            return
                        }
                        
                        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
                            
                            // Cast the response and the errors
                            if let httpResponse: NSHTTPURLResponse = response as? NSHTTPURLResponse {
                                
                                if let error:NSError = error {
                                    
                                    self.logger.log(ILoggingLogLevel.Error, category: self.loggerTag, message: "ERROR \(error.code): \(error.localizedDescription) \(error.debugDescription)")
                                    
                                    callback.onError(IServiceResultCallbackError.Unreachable)
                                    return
                                    
                                } else {
                                    
                                    //self.logger.log(ILoggingLogLevel.Error, category: self.loggerTag, message: "\(data)")
                                    
                                    if let responseText:NSString = NSString(data:data!, encoding:NSUTF8StringEncoding) {
                                        
                                        let sCode:Int32 = Int32(httpResponse.statusCode)
                                        
                                        self.logger.log(ILoggingLogLevel.Debug, category: self.loggerTag, message: "Status code: \(sCode)")
                                        
                                        switch sCode {
                                            
                                        case 200...406, 500...599:
                                            
                                            // VALID RESPONSES (CORRECT AND WARNINGS)
                                            
                                            let response: ServiceResponse = ServiceResponse()
                                            response.setContent(Utils.escapeString(responseText as String))
                                            
                                            //self.logger.log(ILoggingLogLevel.Error, category: self.loggerTag, message: "\(response.getContent()!)")
                                            
                                            response.setContentEncoding(IServiceContentEncoding.Utf8)
                                            response.setContentLength(Int32(responseText.length))
                                            response.setContentType(IOParser.sharedInstance.getContentType(token))
                                            response.setStatusCode(sCode)
                                            
                                            // HEADERS & SESSION
                                            
                                            let endpoint = serviceRequest.getServiceToken()!.getEndpointName()!
                                            
                                            if let h:Header = self.headers[endpoint] {
                                                
                                                h.cookies = self.extractCookies(httpResponse)
                                                self.headers[endpoint] = h
                                                
                                            } else {
                                                
                                                self.logger.log(ILoggingLogLevel.Debug, category: self.loggerTag, message: "There is no previous information on the dictionary of headers and session")
                                                
                                                let h:Header = Header()
                                                h.cookies = self.extractCookies(httpResponse)
                                                self.headers[endpoint] = h
                                            }
                                            
                                            switch sCode {
                                                
                                            case 200...299:
                                                
                                                // Check for Not secured url
                                                if !url.containsString("https://") {
                                                    self.logger.log(ILoggingLogLevel.Warn, category: self.loggerTag, message: "Not Secured URL (https): \(url)")
                                                    callback.onWarning(response, warning: IServiceResultCallbackWarning.NotSecure)
                                                } else {
                                                    callback.onResult(response)
                                                }
                                                
                                                return
                                                
                                            case 300...399:
                                                
                                                self.logger.log(ILoggingLogLevel.Warn, category: self.loggerTag, message: "Redirected Response")
                                                callback.onWarning(response, warning: IServiceResultCallbackWarning.Redirected)
                                                return
                                                
                                            case 400:
                                                
                                                self.logger.log(ILoggingLogLevel.Warn, category: self.loggerTag, message: "Wrong params: \(url)")
                                                callback.onWarning(response, warning: IServiceResultCallbackWarning.WrongParams)
                                                return
                                                
                                            case 401:
                                                
                                                self.logger.log(ILoggingLogLevel.Warn, category: self.loggerTag, message: "Not authenticaded: \(url)")
                                                callback.onWarning(response, warning: IServiceResultCallbackWarning.NotAuthenticated)
                                                return
                                                
                                            case 402:
                                                
                                                self.logger.log(ILoggingLogLevel.Warn, category: self.loggerTag, message: "Payment Required: \(url)")
                                                callback.onWarning(response, warning: IServiceResultCallbackWarning.PaymentRequired)
                                                return
                                                
                                            case 403:
                                                
                                                self.logger.log(ILoggingLogLevel.Warn, category: self.loggerTag, message: "Forbidden: \(url)")
                                                callback.onWarning(response, warning: IServiceResultCallbackWarning.Forbidden)
                                                return
                                                
                                            case 404:
                                                
                                                self.logger.log(ILoggingLogLevel.Warn, category: self.loggerTag, message: "NotFound: \(url)")
                                                callback.onWarning(response, warning: IServiceResultCallbackWarning.NotFound)
                                                return
                                                
                                            case 405:
                                                
                                                self.logger.log(ILoggingLogLevel.Warn, category: self.loggerTag, message: "Method not allowed: \(url)")
                                                callback.onWarning(response, warning: IServiceResultCallbackWarning.MethodNotAllowed)
                                                return
                                                
                                            case 406:
                                                
                                                self.logger.log(ILoggingLogLevel.Warn, category: self.loggerTag, message: "Not allowed: \(url)")
                                                callback.onWarning(response, warning: IServiceResultCallbackWarning.NotAllowed)
                                                return
                                                
                                            case 500...599:
                                                
                                                self.logger.log(ILoggingLogLevel.Warn, category: self.loggerTag, message: "Server error: \(url)")
                                                callback.onWarning(response, warning: IServiceResultCallbackWarning.ServerError)
                                                return
                                                
                                            default:
                                                
                                                self.logger.log(ILoggingLogLevel.Error, category: self.loggerTag, message: "The status code received: \(sCode) is not handled by the plattform")
                                                callback.onError(IServiceResultCallbackError.Unreachable)
                                                return
                                            }
                                            
                                            // INVALID RESPONSES
                                            
                                        case 408:
                                            self.logger.log(ILoggingLogLevel.Error, category: self.loggerTag, message: "There is a timeout calling the service: \(sCode)")
                                            callback.onError(IServiceResultCallbackError.TimeOut)
                                            return
                                        case 444:
                                            self.logger.log(ILoggingLogLevel.Error, category: self.loggerTag, message: "There is no response calling the service: \(sCode)")
                                            callback.onError(IServiceResultCallbackError.NoResponse)
                                            return
                                            
                                        default:
                                            self.logger.log(ILoggingLogLevel.Error, category: self.loggerTag, message: "The status code received: \(sCode) is not handled by the plattform")
                                            callback.onError(IServiceResultCallbackError.Unknown)
                                            return
                                        }
                                        
                                    } else {
                                        
                                        self.logger.log(ILoggingLogLevel.Error, category: self.loggerTag, message: "There's been an error parsing the response on the response of the service invoke")
                                        
                                        callback.onError(IServiceResultCallbackError.Unreachable)
                                        return
                                    }
                                }
                                
                            } else {
                                
                                self.logger.log(ILoggingLogLevel.Error, category: self.loggerTag, message: "ERROR \(error!.code): \(error?.localizedDescription). \(error.debugDescription)")
                                
                                callback.onError(IServiceResultCallbackError.Unreachable)
                                return
                            }
                        })
                        
                        // Start the task
                        task.resume()
                    }
                    
                } else {
                    self.logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The service \(token.getServiceName()) is not registered on the io services config file")
                    callback.onError(IServiceResultCallbackError.NotRegisteredService)
                    return
                }
                
            } else {
                self.logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The service \(token.getServiceName()) is not registered on the io services config file")
                callback.onError(IServiceResultCallbackError.NotRegisteredService)
                return
            }
            
        } else {
            self.logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "There isn't a serviceToken inside the serviceRequest")
            callback.onError(IServiceResultCallbackError.Unreachable)
            return
        }
    }
    
    /**
    Method that extract the cookies from a service response
    
    :param: httpResponse NSHTTPURLResponse with all the cookies
    
    :returns: Array of cookies formated in Adaptive style
    */
    private func extractCookies(httpResponse:NSHTTPURLResponse) -> [ServiceSessionCookie] {
        
        var responseHeaders:[String : String] = [String : String]()
        
        for header in httpResponse.allHeaderFields {
            responseHeaders[header.0 as! String] = header.1 as? String
        }
        
        let responseCookies:[NSHTTPCookie] = NSHTTPCookie.cookiesWithResponseHeaderFields(responseHeaders, forURL: httpResponse.URL!)
        self.logger.log(ILoggingLogLevel.Debug, category: self.loggerTag, message: "Number of cookies received: \(responseCookies.count)")
        
        var cookies:[ServiceSessionCookie] = [ServiceSessionCookie]()
        for c:NSHTTPCookie in responseCookies {
            self.logger.log(ILoggingLogLevel.Error, category: self.loggerTag, message: "cookie [name:\(c.name), value: \(c.value)]")
            let cookie:ServiceSessionCookie = ServiceSessionCookie(cookieName: c.name, cookieValue: c.value)
            //cookie.setCreation()
            cookie.setDomain(c.domain)
            cookie.setExpiry(Int64(c.expiresDate!.timeIntervalSince1970 * 1000))
            cookie.setPath(c.path)
            //cookie.setScheme()
            cookie.setSecure(c.secure)
            cookies.append(cookie)
        }
        
        return cookies
    }
    
}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
