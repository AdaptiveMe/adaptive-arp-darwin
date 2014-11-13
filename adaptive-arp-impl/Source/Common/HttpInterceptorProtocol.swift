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


public class HttpInterceptorProtocol : NSURLProtocol {    
    
    /// Logging variable
    let logger:ILogging = LoggingImpl()
    
    /// Connection
    var connection: NSURLConnection!
    /// Key for intercepting the requests
    public class var httpInterceptorKey: String {
        return "HttpInterceptorProtocolHandledKey"
    }
    
    /// Base path for adaptive requests
    let adaptiveBasePath:NSString = "http://adaptiveapp/"
    
    /// Constructor
    override public init() {
        super.init()
    }
    
    /// Initializes an NSURLProtocol object.
    override public init(request: NSURLRequest, cachedResponse: NSCachedURLResponse?, client: NSURLProtocolClient?) {
        super.init(request: request, cachedResponse: cachedResponse, client: client)
    }
    
    /// Returns whether the protocol subclass can handle the specified request.
    override public class func canInitWithRequest(request: NSURLRequest) -> Bool {
        
        let logger:ILogging = LoggingImpl()
        
        var method = request.HTTPMethod
        var url = request.URL.absoluteString
        
        if NSURLProtocol.propertyForKey(HttpInterceptorProtocol.httpInterceptorKey, inRequest: request) != nil {
            return false
        } else {
            logger.log(ILoggingLogLevel.DEBUG, category:"HttpInterceptorProtocol", message: "[\(method)]: \(url!)")
            return true
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
        
        NSURLProtocol.setProperty(true, forKey: HttpInterceptorProtocol.httpInterceptorKey, inRequest: newRequest)
        
        // HOWTO: referer
        // var referer:String? = request.valueForHTTPHeaderField("referer")
        // logger.log(ILoggingLogLevel.INFO, category:"HttpInterceptorProtocol", message: "referer: \(referer)")
        
        if let url = url {
            
            logger.log(ILoggingLogLevel.DEBUG, category:"HttpInterceptorProtocol", message: "[\(method)]: \(url)")
            
            if url.hasPrefix(adaptiveBasePath) && method == "GET" {
                
                var resourceData = AppResourceManager.sharedInstance.retrieveWebResource(newRequest.URL!.path!)
                
                if resourceData != nil {
                    var response = NSURLResponse(URL: self.request.URL, MIMEType: resourceData!.raw_type, expectedContentLength: resourceData!.data.length, textEncodingName: "utf-8")
                    self.client!.URLProtocol(self, didReceiveResponse: response, cacheStoragePolicy: .NotAllowed)
                    self.client!.URLProtocol(self, didLoadData: resourceData!.data)
                    self.client!.URLProtocolDidFinishLoading(self)
                } else {
                    /// MARK: return 404
                }
            } else if url.rangeOfString(adaptiveBasePath) != nil {
                
                // Adaptive Native calls
                
                var params:[String] = url.componentsSeparatedByString("/")
                var service = params[3]
                var method = params[4]
                var argsEncoded = NSString(data: newRequest.HTTPBody!, encoding: NSUTF8StringEncoding)!
                var argsDecoded = CFURLCreateStringByReplacingPercentEscapes(nil, argsEncoded, "")
                
                println("service: \(service)")
                println("method: \(method)")
                println("args: \(argsEncoded)")
                println("args: \(argsDecoded)")
                
                //println(NSString(data: newRequest.HTTPBody!, encoding: NSUTF8StringEncoding))
                
                var htmlBody = "echo from Adaptive Core"
                var data = htmlBody.dataUsingEncoding(NSUTF8StringEncoding)!
                //var dataArray:NSArray = [data]
                // TODO: change by JSON
                //var jsonBody = NSJSONSerialization.dataWithJSONObject(dataArray, options: NSJSONWritingOptions.allZeros, error: nil)!
                //let json = JSON(data).rawData(options: NSJSONWritingOptions.PrettyPrinted, error: nil)!
                var mimeType = "application/javascript"
                var encoding = "utf-8"
                var response = NSURLResponse(URL: self.request.URL, MIMEType: mimeType, expectedContentLength: data.length, textEncodingName: encoding)
                self.client!.URLProtocol(self, didReceiveResponse: response, cacheStoragePolicy: .NotAllowed)
                self.client!.URLProtocol(self, didLoadData: data)
                self.client!.URLProtocolDidFinishLoading(self)
                
            } else {
                
                // Other resources (file://)
                
                self.connection = NSURLConnection(request: newRequest, delegate: self)
            }
        } else {
            logger.log(ILoggingLogLevel.ERROR, category:"HttpInterceptorProtocol", message: "The url recived is null")
        }
        
        
        // HOWTO: override response
        // var htmlBody = "<html><body><h1>Intercepted!</h1></body></html>"
        // var data = htmlBody.dataUsingEncoding(NSUTF8StringEncoding)
        // var mimeType = "text/html"
        // var encoding = "utf-8"
        // var response = NSURLResponse(URL: self.request.URL, MIMEType: mimeType, expectedContentLength: data!.length, textEncodingName: encoding)
        // self.client!.URLProtocol(self, didReceiveResponse: response, cacheStoragePolicy: .NotAllowed)
        // self.client!.URLProtocol(self, didLoadData: data!)
        // self.client!.URLProtocolDidFinishLoading(self)
        
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