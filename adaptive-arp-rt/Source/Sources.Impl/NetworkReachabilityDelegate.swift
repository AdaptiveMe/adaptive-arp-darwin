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

/**
   Interface for Managing the Network reachability operations
   Auto-generated implementation of INetworkReachability specification.
*/
public class NetworkReachabilityDelegate : BaseCommunicationDelegate, INetworkReachability {
    
    /// Logger variable
    let logger : ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge()
    let loggerTag : String = "NetworkReachabilityDelegate"
    
    /**
       Default Constructor.
    */
    public override init() {
        super.init()
    }

    /**
       Whether there is connectivity to a host, via domain name or ip address, or not.

       @param host     domain name or ip address of host.
       @param callback Callback called at the end.
       @since ARP1.0
    */
    public func isNetworkReachable(host : String, callback : INetworkReachabilityCallback) {
        
        var reachability:Reachability = Reachability(hostname: host)
        
        var isReachableViaWiFi = reachability.isReachableViaWiFi()
        logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "isReachableViaWiFi: \(isReachableViaWiFi)")
        
        var isReachableViaWWAN = reachability.isReachableViaWWAN()
        logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "isReachableViaWWAN: \(isReachableViaWWAN)")
        
        if isReachableViaWiFi || isReachableViaWWAN {
            logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "isReachable!")
            callback.onResult(true)
        } else {
            logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "isUnreachable!")
            callback.onError(INetworkReachabilityCallbackError.Unreachable)
        }
    }

    /**
       Whether there is connectivity to an url of a service or not.

       @param url      to look for
       @param callback Callback called at the end
       @since ARP1.0
    */
    public func isNetworkServiceReachable(url : String, callback : INetworkReachabilityCallback) {
        
        // TODO: handle http status WARNING codes for: NotRegisteredService, NotTrusted, IncorrectScheme
        
        // Check the url for malforming
        if(Utils.validateUrl(url)){
            callback.onError(INetworkReachabilityCallbackError.MalformedUrl)
            self.logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Url malformed: \(url)")
            return
        }
        
        var nsUrl:NSURL = NSURL(string: url)!
        var request = NSURLRequest(URL: nsUrl)
        
        // Creating NSOperationQueue to which the handler block is dispatched when the request completes or failed
        var queue: NSOperationQueue = NSOperationQueue()
        
        // Sending Asynchronous request using NSURLConnection
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler:{
            (response:NSURLResponse!, responseData:NSData!, error: NSError!) -> Void in
            
            if (error != nil){
                
                callback.onError(INetworkReachabilityCallbackError.Unreachable)
                
                self.logger.log(ILoggingLogLevel.Error, category: self.loggerTag, message: "\(error.description)")
                
            } else {
                
                let httpResponse: NSHTTPURLResponse = response as! NSHTTPURLResponse
                
                //Converting data to String
                let responseText:NSString = NSString(data:responseData, encoding:NSUTF8StringEncoding)!
                
                // Check for Not secured url
                if (url as NSString).containsString("https://") {
                    self.logger.log(ILoggingLogLevel.Debug, category: self.loggerTag, message: "Secured URL (https): \(url)")
                } else {
                    self.logger.log(ILoggingLogLevel.Warn, category: self.loggerTag, message: "NOT Secured URL (https): \(url)")
                    
                    callback.onWarning(true, warning: INetworkReachabilityCallbackWarning.NotSecure)
                }
                
                self.logger.log(ILoggingLogLevel.Debug, category: self.loggerTag, message: "status code: \(httpResponse.statusCode)")
                
                switch (httpResponse.statusCode) {
                case 200..<299:
                    callback.onResult(true)
                case 300..<399:
                    callback.onWarning(true, warning: INetworkReachabilityCallbackWarning.Redirected)
                case 400:
                    callback.onError(INetworkReachabilityCallbackError.WrongParams)
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
                    callback.onError(INetworkReachabilityCallbackError.Unknown)
                    
                }
            }
        })
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
