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

/**
   Interface for Managing the Network status
   Auto-generated implementation of INetworkStatus specification.
*/
public class NetworkStatusDelegate : BaseCommunicationDelegate, INetworkStatus {
    
    /// Logger variable
    let logger : ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge()
    let loggerTag : String = "NetworkStatusDelegate"
    
    /// Listeners Pull
    var listeners:[INetworkStatusListener]!
    
    /// Reachability Utils
    var reachability:Reachability? = nil

    /**
       Default Constructor.
    */
    public override init() {
        super.init()
        listeners = [INetworkStatusListener]()
    }

    /**
       Add the listener for network status changes of the app

       @param listener Listener with the result
       @since ARP1.0
    */
    public func addNetworkStatusListener(listener : INetworkStatusListener) {
        
        // check if listener exists
        for (index, l:INetworkStatusListener) in enumerate(listeners) {
            if listener.getId() == l.getId() {
                logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "The listener is alredy on the pull. Replacing...")
                self.removeNetworkStatusListener(listener)
            }
        }
        
        // add the listener
        listeners.append(listener)
        logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Adding \(listener) to the listeners pull")
        
        if reachability == nil {
            
            reachability = Reachability.reachabilityForInternetConnection()
            
            // Clousure for when unreachable
            reachability!.whenReachable = { reachability in
                
                // Iterate all over the listeners and notify
                for (index, l) in enumerate(self.listeners) {
                    if reachability.isReachableViaWiFi() {
                        self.logger.log(ILoggingLogLevel.Debug, category: self.loggerTag, message: "Listener \(listener) reachable via WIFI")
                        l.onResult(ICapabilitiesNet.WIFI)
                    } else {
                        self.logger.log(ILoggingLogLevel.Debug, category: self.loggerTag, message: "Listener \(listener) reachable via WAN")
                        // MARK: it is not possible to determine the G version of the connection: GSM, GPRS, HSPA, etc...
                        l.onResult(ICapabilitiesNet.GSM)
                    }
                }
            }
            
            // Clousure for unreachable
            reachability!.whenUnreachable = { reachability in
                // Iterate all over the listeners and notify
                for (index, l) in enumerate(self.listeners) {
                    
                    self.logger.log(ILoggingLogLevel.Error, category: self.loggerTag, message: "Listener \(listener) unreachable")
                    l.onError(INetworkStatusListenerError.Unreachable)
                }
            }
        }
    }

    /**
       Un-registers an existing listener from receiving network status events.

       @param listener Listener with the result
       @since ARP1.0
    */
    public func removeNetworkStatusListener(listener : INetworkStatusListener) {
        
        for (index, l:INetworkStatusListener) in enumerate(listeners) {
            
            if listener.getId() == l.getId() {
                
                listeners.removeAtIndex(index)
                
                logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Removing \(listener) from the listeners pull")
                
                return
            }
        }
        
        logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "\(listener) is not founded in the pull for removing")
    }

    /**
       Removes all existing listeners from receiving network status events.

       @since ARP1.0
    */
    public func removeNetworkStatusListeners() {
        
        logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Removing all the listeners...")
        listeners.removeAll(keepCapacity: false)
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
