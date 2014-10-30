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
*     *
*
* =====================================================================================================================
*/

import Foundation

var requestCount : Int = 0
let httpInterceptorKey : String = "HttpInterceptorProtocolHandledKey"

public class HttpInterceptorProtocol : NSURLProtocol {
    
    var connection: NSURLConnection!
    
    override public class func canInitWithRequest(request: NSURLRequest) -> Bool {
        
        
        if NSURLProtocol.propertyForKey(httpInterceptorKey, inRequest: request) != nil {
            return false
        } else {
            println("------- #\(requestCount++): \(request.HTTPMethod!) = \(request.URL.absoluteString!)")
            return true
        }
    }
    
    override public class func canonicalRequestForRequest(request: NSURLRequest) -> NSURLRequest {
        return request
    }
    
    override public class func requestIsCacheEquivalent(aRequest: NSURLRequest,
        toRequest bRequest: NSURLRequest) -> Bool {
            return false
            //return super.requestIsCacheEquivalent(aRequest, toRequest:bRequest)
    }
    
    override public func startLoading() {
        var newRequest : NSMutableURLRequest = self.request.copy() as NSMutableURLRequest
        // How to override headers
        /*
        var newHeaders = NSMutableDictionary(dictionary: newRequest.allHTTPHeaderFields!)
        newHeaders.setValue("Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; WOW64; Trident/6.0)", forKey: "User-Agent") // IExplorer... lol!
        newRequest.allHTTPHeaderFields = newHeaders
        */
        println("Loading #\(requestCount++): \(newRequest.HTTPMethod) = \(newRequest.URL!.absoluteString!)")
        NSURLProtocol.setProperty(true, forKey: httpInterceptorKey, inRequest: newRequest)
        
        var referrer :String? = request.valueForHTTPHeaderField("referer")
        if referrer == nil {
            referrer = "None"
        }
        if (newRequest.URL!.absoluteString!.rangeOfString("http://html5test.com") != nil || newRequest.URL!.absoluteString!.rangeOfString("https://html5test.com") != nil) {
            // Intercept Start
            var htmlBody = "<html><body><h1>Intercepted!</h1><p>The request to <a href=\"\(newRequest.URL!.absoluteString!)\">\(newRequest.URL!.absoluteString!)</a> was intercepted by HttpInterceptorProtocol. This request came from the following referrer: <a href=\"\( referrer! )\">\( referrer! )</a>.</p><p>Return to <a href=\"http://www.google.com.\">Google</a></body></html>"
            var data = htmlBody.dataUsingEncoding(NSUTF8StringEncoding)
            var mimeType = "text/html"
            var encoding = "utf-8"
            
            var response = NSURLResponse(URL: self.request.URL, MIMEType: mimeType, expectedContentLength: data!.length, textEncodingName: encoding)
            
            self.client!.URLProtocol(self, didReceiveResponse: response, cacheStoragePolicy: .NotAllowed)
            self.client!.URLProtocol(self, didLoadData: data!)
            self.client!.URLProtocolDidFinishLoading(self)
            // Intercept End
        } else {
            self.connection = NSURLConnection(request: newRequest, delegate: self)
        }
    }
    
    override public func stopLoading() {
        if self.connection != nil {
            self.connection.cancel()
        }
        self.connection = nil
        //NSURLProtocol.removePropertyForKey(handlerKey, inRequest: self.request as NSMutableURLRequest)
    }
    
    func connection(connection: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        self.client!.URLProtocol(self, didReceiveResponse: response, cacheStoragePolicy: .NotAllowed)
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        self.client!.URLProtocol(self, didLoadData: data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        self.client!.URLProtocolDidFinishLoading(self)
    }
    
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!) {
        self.client!.URLProtocol(self, didFailWithError: error)
    }
}