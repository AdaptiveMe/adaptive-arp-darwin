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
import AdaptiveArpApi

#if os(iOS)
    import UIKit
#endif 
#if os(OSX)
    import Cocoa
#endif

public class HttpInterceptorProtocol : NSURLProtocol {
    
    /// Logging variable
    let logger:ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge()
    let loggerTag:String = "HttpInterceptorProtocol"
    
    /// Connection
    var connection: NSURLConnection!
    
    /// Async Request Queue
    private class var queue : NSOperationQueue {
        return NSOperationQueue.mainQueue()
    }
    
    /// Key for intercepting the requests
    private class var httpInterceptorKey: String {
        return "HttpInterceptorProtocolHandledKey"
    }
    
    /// Base path for adaptive requests
    private class var adaptiveBasePath:NSString {
        return "https://adaptiveapp/"
    }
    
    /// Initializes an NSURLProtocol object.
    override public init(request: NSURLRequest, cachedResponse: NSCachedURLResponse?, client: NSURLProtocolClient?) {
        
        let newRequest:NSMutableURLRequest = request.mutableCopy() as! NSMutableURLRequest
        newRequest.setValue("true", forHTTPHeaderField: HttpInterceptorProtocol.httpInterceptorKey)
        super.init(request: newRequest, cachedResponse: cachedResponse, client: client)
    }
    
    
    /// Returns whether the protocol subclass can handle the specified request.
    override public class func canInitWithRequest(request: NSURLRequest) -> Bool {
        
        // var method = request.HTTPMethod
        // var url = request.URL!.absoluteString
        
        if request.valueForHTTPHeaderField(httpInterceptorKey) == nil {
            return true
        } else if NSURLProtocol.propertyForKey(httpInterceptorKey, inRequest: request) == nil {
            return true
        } else {
            return false
        }
    }
    
    
    /// Starts protocol-specific loading of the request. When this method is called, the subclass implementation should start loading the request, providing feedback to the URL loading system via the NSURLProtocolClient protocol.
    override public func startLoading() {
        
        let newRequest:NSMutableURLRequest = self.request.mutableCopy() as! NSMutableURLRequest
        
        let method = newRequest.HTTPMethod
        let url : String? = newRequest.URL!.absoluteString
        
        if let url = url {
            
            if url.hasPrefix(HttpInterceptorProtocol.adaptiveBasePath as String) && method == "GET" {
                
                // FILE MANAGEMENT (via REALM)
                
                let resourceData = AppResourceManager.sharedInstance.retrieveWebResource(newRequest.URL!.path!)
                
                if resourceData != nil {
                    let response = NSURLResponse(URL: self.request.URL!, MIMEType: resourceData!.raw_type as String, expectedContentLength: resourceData!.data.length, textEncodingName: "utf-8")
                    self.client!.URLProtocol(self, didReceiveResponse: response, cacheStoragePolicy: .NotAllowed)
                    self.client!.URLProtocol(self, didLoadData: resourceData!.data)
                    self.client!.URLProtocolDidFinishLoading(self)
                } else {
                    let response : NSHTTPURLResponse! = NSHTTPURLResponse(URL: self.request.URL!, statusCode: 404, HTTPVersion: "1.1", headerFields: nil)
                    self.client!.URLProtocol(self, didReceiveResponse: response, cacheStoragePolicy: .NotAllowed)
                    self.client!.URLProtocol(self, didLoadData: "<html><body><h1>404</h1></body></html>".dataUsingEncoding(NSUTF8StringEncoding)!)
                    self.client!.URLProtocolDidFinishLoading(self)
                }
                
            } else if url.hasPrefix(HttpInterceptorProtocol.adaptiveBasePath as String) && method == "POST" {
                
                // ADAPTIVE NATIVE CALLS
                
                if let body:NSData = newRequest.HTTPBody {
                    
                    if let bodyString:NSString = NSString(data: body, encoding: NSUTF8StringEncoding) {
                        
                        let requestHeaders = newRequest.allHTTPHeaderFields!
                        
                        // Parse the http body request and converto into a APIRequest Object
                        let apiRequest:APIRequest = APIRequest.Serializer.fromJSON(bodyString as String)
                        
                        // Check the version of the API inside the request attributes
                        if let tsVersion: String = apiRequest.getApiVersion() {
                            if !tsVersion.isEqual(AppRegistryBridge.sharedInstance.getAPIVersion()){
                                logger.log(ILoggingLogLevel.Warn, category:loggerTag, message: "The API version of the Typescript API is not the same as the Platform API version")
                            }
                        } else {
                            logger.log(ILoggingLogLevel.Error, category:loggerTag, message: "There is no attribute inside APIRequest indicating the TS version ")
                        }
                        
                        // Call the service and return the data
                        let apiResponse:APIResponse = ServiceHandler.sharedInstance.handleServiceUrl(apiRequest)
                        let data:NSString = APIResponse.Serializer.toJSON(apiResponse)
                        
                        // Create the response                        
                        var responseHeaders:[String : String] = requestHeaders
                        responseHeaders["Content-Type"] = "application/javascript; charset=utf-8";
                        responseHeaders["Content-Length"] = "\(data.length)";
                        let response : NSHTTPURLResponse! = NSHTTPURLResponse(URL: self.request.URL!, statusCode: 200, HTTPVersion: "1.1", headerFields: responseHeaders as [String : String])
                        
                        if let nsData:NSData = data.dataUsingEncoding(NSUTF8StringEncoding) {                            
                            self.client!.URLProtocol(self, didReceiveResponse: response, cacheStoragePolicy: .NotAllowed)
                            self.client!.URLProtocol(self, didLoadData: nsData)
                            self.client!.URLProtocolDidFinishLoading(self)
                            
                        } else {
                            logger.log(ILoggingLogLevel.Error, category:loggerTag, message: "There is a a problem converting the response to nsdata")
                        }
                        
                    } else {
                        logger.log(ILoggingLogLevel.Error, category:loggerTag, message: "There is a a problem converting the body to string")
                    }
                    
                } else {
                    logger.log(ILoggingLogLevel.Error, category:loggerTag, message: "There is a a problem obtaining the body of the request")
                }
                
            } else if Utils.validateRegexp(url, regexp: "^data:(.*)\\/(.*);base64,(.*)") && method == "GET" {
                
                // JAVASCRIPT INLINE REQUESTS
                self.forwardResponse(newRequest)
            
            } else {
                
                // VALIDATE RESOURCE
                if IOParser.sharedInstance.validateResource(url) {
                    self.forwardResponse(newRequest)
                } else {
                    self.forwardResponse(newRequest)
                    // VALIDATE SERVICE
                    if let st = IOParser.sharedInstance.getServiceTokenByURI(url) {
                        if IOParser.sharedInstance.validateService(st) {
                            self.forwardResponse(newRequest)
                        } else {
                            self.nonPermisionResponse(newRequest)
                        }
                    } else {
                        self.nonPermisionResponse(newRequest)
                    }
                }
            }
        } else {
            logger.log(ILoggingLogLevel.Error, category:loggerTag, message: "The url received is null")
        }
    }
    
    private func nonPermisionResponse(newRequest:NSMutableURLRequest) {
        
        let response : NSHTTPURLResponse! = NSHTTPURLResponse(URL: self.request.URL!, statusCode: 403, HTTPVersion: "1.1", headerFields: nil)
        self.client!.URLProtocol(self, didReceiveResponse: response, cacheStoragePolicy: .NotAllowed)
        self.client!.URLProtocol(self, didLoadData: "The service you're trying to call is not registered in the io-services config file.".dataUsingEncoding(NSUTF8StringEncoding)!)
        self.client!.URLProtocolDidFinishLoading(self)
        NSURLProtocol.removePropertyForKey(HttpInterceptorProtocol.httpInterceptorKey, inRequest: newRequest)
    }
    
    private func forwardResponse(newRequest:NSMutableURLRequest) {
        NSURLProtocol.setProperty("", forKey: HttpInterceptorProtocol.httpInterceptorKey, inRequest: newRequest)
        
        NSURLSession.sharedSession().dataTaskWithRequest(newRequest, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if (error == nil) {
                self.client!.URLProtocol(self, didReceiveResponse: response!, cacheStoragePolicy: .NotAllowed)
                self.client!.URLProtocol(self, didLoadData: data!)
                self.client!.URLProtocolDidFinishLoading(self)
                NSURLProtocol.removePropertyForKey(HttpInterceptorProtocol.httpInterceptorKey, inRequest: newRequest)
            } else {
                self.client!.URLProtocol(self, didFailWithError: error!)
                NSURLProtocol.removePropertyForKey(HttpInterceptorProtocol.httpInterceptorKey, inRequest: newRequest)
            }
        })
        
        /*NSURLConnection.sendAsynchronousRequest(newRequest, queue: HttpInterceptorProtocol.queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if (error == nil) {
                self.client!.URLProtocol(self, didReceiveResponse: response, cacheStoragePolicy: .NotAllowed)
                self.client!.URLProtocol(self, didLoadData: data)
                self.client!.URLProtocolDidFinishLoading(self)
                NSURLProtocol.removePropertyForKey(HttpInterceptorProtocol.httpInterceptorKey, inRequest: newRequest)
            } else {
                self.client!.URLProtocol(self, didFailWithError: error)
                NSURLProtocol.removePropertyForKey(HttpInterceptorProtocol.httpInterceptorKey, inRequest: newRequest)
            }
        })*/
    }
    
    /// Stops protocol-specific loading of the request.
    override public func stopLoading() {
        
        if self.connection != nil {
            self.connection.cancel()
        }
        self.connection = nil
        
    }
    
    /// Returns a canonical version of the specified request. It is up to each concrete protocol implementation to define what “canonical” means. A protocol should guarantee that the same input request always yields the same canonical form.
    override public class func canonicalRequestForRequest(request: NSURLRequest) -> NSURLRequest {
        
        return request
    }
    
    /// Returns whether two requests are equivalent for cache purposes.
    override public class func requestIsCacheEquivalent(aRequest: NSURLRequest, toRequest bRequest: NSURLRequest) -> Bool {
        
        return false
    }
    
    /// Sent when the connection has received sufficient data to construct the URL response for its request.
    func connection(connection: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        
        self.client!.URLProtocol(self, didReceiveResponse: response, cacheStoragePolicy: .NotAllowed)
    }
    
    /// Sent as a connection loads data incrementally.
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        
        self.client!.URLProtocol(self, didLoadData: data)
    }
    
    /// Sent when a connection has finished loading successfully.
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        
        self.client!.URLProtocolDidFinishLoading(self)
        
    }
    
    /// Sent when a connection fails to load its request successfully.
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!) {
        
        self.client!.URLProtocol(self, didFailWithError: error)
    }
}