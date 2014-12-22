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
#elseif os(OSX)
    import Cocoa
#endif

public class HttpInterceptorProtocol : NSURLProtocol {
    
    /// Logging variable
    let logger:ILogging = LoggingImpl()
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
    
    /// Constructor
    override public init() {
        super.init()
    }
    
    /// Initializes an NSURLProtocol object.
    override public init(request: NSURLRequest, cachedResponse: NSCachedURLResponse?, client: NSURLProtocolClient?) {
        
        var newRequest:NSMutableURLRequest = request.mutableCopy() as NSMutableURLRequest
        newRequest.setValue("true", forHTTPHeaderField: HttpInterceptorProtocol.httpInterceptorKey)
        super.init(request: newRequest, cachedResponse: cachedResponse, client: client)
    }
    
    
    /// Returns whether the protocol subclass can handle the specified request.
    override public class func canInitWithRequest(request: NSURLRequest) -> Bool {
        
        var method = request.HTTPMethod
        var url = request.URL.absoluteString
        
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
        
        var newRequest:NSMutableURLRequest = self.request.mutableCopy() as NSMutableURLRequest
        
        var method = newRequest.HTTPMethod
        var url = newRequest.URL!.absoluteString
        
        // HOWTO override headers
        // var newHeaders = NSMutableDictionary(dictionary: newRequest.allHTTPHeaderFields!)
        // newHeaders.setValue("Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; WOW64; Trident/6.0)", forKey: "User-Agent")
        // newRequest.allHTTPHeaderFields = newHeaders
        
        
        // HOWTO: referer
        // var referer:String? = request.valueForHTTPHeaderField("referer")
        // logger.log(ILoggingLogLevel.INFO, category:"HttpInterceptorProtocol", message: "referer: \(referer)")
        
        if let url = url {
            
            if url.hasPrefix(HttpInterceptorProtocol.adaptiveBasePath) && method == "GET" {
                
                // FILE MANAGEMENT (via REALM)
                
                var resourceData = AppResourceManager.sharedInstance.retrieveWebResource(newRequest.URL!.path!)
                
                if resourceData != nil {
                    var response = NSURLResponse(URL: self.request.URL, MIMEType: resourceData!.raw_type, expectedContentLength: resourceData!.data.length, textEncodingName: "utf-8")
                    self.client!.URLProtocol(self, didReceiveResponse: response, cacheStoragePolicy: .NotAllowed)
                    self.client!.URLProtocol(self, didLoadData: resourceData!.data)
                    self.client!.URLProtocolDidFinishLoading(self)
                } else {
                    var response : NSHTTPURLResponse! = NSHTTPURLResponse(URL: self.request.URL, statusCode: 404, HTTPVersion: "1.1", headerFields: nil)
                    self.client!.URLProtocol(self, didReceiveResponse: response, cacheStoragePolicy: .NotAllowed)
                    self.client!.URLProtocol(self, didLoadData: "<html><body><h1>404</h1></body></html>".dataUsingEncoding(NSUTF8StringEncoding)!)
                    self.client!.URLProtocolDidFinishLoading(self)
                }
                
            } else if url.hasPrefix(HttpInterceptorProtocol.adaptiveBasePath) && method == "POST" {
                
                // ADAPTIVE NATIVE CALLS
                
                var data:NSData? = ServiceHandler.sharedInstance.handleServiceUrl(newRequest)
                var response:NSURLResponse?
                
                if let data = data {
                    
                    // syncronous responses
                    var jsonData:NSData? = NSJSONSerialization.dataWithJSONObject(data, options: NSJSONWritingOptions.allZeros, error: nil)
                    
                    if let jsonData = jsonData {
                        
                        response = NSURLResponse(URL: self.request.URL, MIMEType: "application/javascript", expectedContentLength:jsonData.length, textEncodingName: "utf-8")
                        self.client!.URLProtocol(self, didLoadData: jsonData)
                        
                    } else {
                        logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "There is an error parsing the syncronous response to JSON")
                        
                        response = NSURLResponse(URL: self.request.URL, MIMEType: "application/javascript", expectedContentLength:0, textEncodingName: "utf-8")
                    }
                    
                } else {
                    // asyncronous responses
                    response = NSURLResponse(URL: self.request.URL, MIMEType: "application/javascript", expectedContentLength: 0, textEncodingName: "utf-8")
                }
                
                self.client!.URLProtocol(self, didReceiveResponse: response!, cacheStoragePolicy: .NotAllowed)
                self.client!.URLProtocolDidFinishLoading(self)
                
            } else {
                
                // EXTERNAL URL'S AND RESOURCES
                
                NSURLProtocol.setProperty("", forKey: HttpInterceptorProtocol.httpInterceptorKey, inRequest: newRequest)
                NSURLConnection.sendAsynchronousRequest(newRequest, queue: HttpInterceptorProtocol.queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                    if (error == nil) {
                        self.client!.URLProtocol(self, didReceiveResponse: response, cacheStoragePolicy: .NotAllowed)
                        self.client!.URLProtocol(self, didLoadData: data)
                        self.client!.URLProtocolDidFinishLoading(self)
                        NSURLProtocol.removePropertyForKey(HttpInterceptorProtocol.httpInterceptorKey, inRequest: newRequest)
                    } else {
                        self.client!.URLProtocol(self, didFailWithError: error)
                        NSURLProtocol.removePropertyForKey(HttpInterceptorProtocol.httpInterceptorKey, inRequest: newRequest)
                    }
                })
            }
        } else {
            logger.log(ILoggingLogLevel.ERROR, category:loggerTag, message: "The url received is null")
        }
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