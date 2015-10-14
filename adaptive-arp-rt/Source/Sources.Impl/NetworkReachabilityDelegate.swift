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
import ReachabilitySwift

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
        
        if let reachability = Reachability.reachabilityForInternetConnection() {
            let isReachableViaWiFi = reachability.isReachableViaWiFi()
            logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "isReachableViaWiFi: \(isReachableViaWiFi)")
            
            let isReachableViaWWAN = reachability.isReachableViaWWAN()
            logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "isReachableViaWWAN: \(isReachableViaWWAN)")
            
            if isReachableViaWiFi || isReachableViaWWAN {
                logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "isReachable!")
                callback.onResult(true)
            } else {
                logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "isUnreachable!")
                callback.onError(INetworkReachabilityCallbackError.Unreachable)
            }
            
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
        
        self.isNetworkReachable(url, callback: callback)
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
