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
#if os(iOS)
    import AdaptiveArpApiiOS
    #elseif os(OSX)
    import AdaptiveArpApiOSX
#endif

public class NetworkReachabilityImpl : NSObject, INetworkReachability {
    
    /// Logging variable
    let logger : ILogging = LoggingImpl()
    
    /**
    Class constructor
    */
    override init() {
        
    }
    
    public func isNetworkServiceReachable(url : String, callback : INetworkReachabilityCallback) {
        
        // TODO: check the method comment and determine functionality of two methods
    }
    
    /**
    Whether there is connectivity to an url or not.
    
    :param: url      url to look for
    :param: callback Callback called at the end
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func isNetworkReachable(host : String, callback : INetworkReachabilityCallback) {
        
        // TODO: handle http status WARNING codes for: NotRegisteredService, NotTrusted, IncorrectScheme
        
        // Check the url for malforming
        if(Utils.validateUrl(host)){
            // TODO: INetworkReachabilityCallbackError.MalformedUrl
            callback.onError(INetworkReachabilityCallbackError.Forbidden)
            self.logger.log(ILoggingLogLevel.ERROR, category: "NetworkReachabilityImpl", message: "Url malformed: \(host)")
            return
        }
        
        var nsUrl:NSURL = NSURL(string: host)!
        var request = NSURLRequest(URL: nsUrl)
        
        // Creating NSOperationQueue to which the handler block is dispatched when the request completes or failed
        var queue: NSOperationQueue = NSOperationQueue()
        
        // Sending Asynchronous request using NSURLConnection
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler:{
            (response:NSURLResponse!, responseData:NSData!, error: NSError!) -> Void in
            
            if (error != nil){
                
                callback.onError(INetworkReachabilityCallbackError.Unreachable)
                
                self.logger.log(ILoggingLogLevel.ERROR, category: "NetworkReachabilityImpl", message: "\(error.description)")
                
            } else {
                
                let httpResponse: NSHTTPURLResponse = response as NSHTTPURLResponse
                
                //Converting data to String
                let responseText:NSString = NSString(data:responseData, encoding:NSUTF8StringEncoding)!
                
                // Check for Not secured url
                if (host as NSString).containsString("https://") {
                    self.logger.log(ILoggingLogLevel.DEBUG, category: "NetworkReachabilityImpl", message: "Secured URL (https): \(host)")
                } else {
                    self.logger.log(ILoggingLogLevel.WARN, category: "NetworkReachabilityImpl", message: "NOT Secured URL (https): \(host)")
                    
                    callback.onWarning(responseText, warning: INetworkReachabilityCallbackWarning.NotSecure)
                }
                
                self.logger.log(ILoggingLogLevel.DEBUG, category: "NetworkReachabilityImpl", message: "status code: \(httpResponse.statusCode)")
                
                switch (httpResponse.statusCode) {
                case 200..<299:
                    callback.onResult(responseText)
                case 300..<399:
                    callback.onWarning(responseText, warning: INetworkReachabilityCallbackWarning.Redirected)
                case 400:
                    callback.onError(INetworkReachabilityCallbackError.Wrong_Params)
                case 401:
                    callback.onError(INetworkReachabilityCallbackError.NotAuthenticated)
                case 403:
                    callback.onError(INetworkReachabilityCallbackError.Forbidden)
                case 404:
                    callback.onError(INetworkReachabilityCallbackError.NotFound)
                case 405:
                    callback.onError(INetworkReachabilityCallbackError.MethodNotAllowed)
                case 406:
                    callback.onError(INetworkReachabilityCallbackError.NotAllowed)
                case 408:
                    callback.onError(INetworkReachabilityCallbackError.TimeOut)
                case 444:
                    callback.onError(INetworkReachabilityCallbackError.NoResponse)
                case 400..<499:
                    callback.onError(INetworkReachabilityCallbackError.Unreachable)
                case 500..<599:
                    callback.onError(INetworkReachabilityCallbackError.Unreachable)
                default:
                    callback.onError(INetworkReachabilityCallbackError.Unreachable)

                }
            }
        })
    }
}