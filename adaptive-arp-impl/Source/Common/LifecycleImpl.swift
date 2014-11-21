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

public class LifecycleImpl : NSObject, ILifecycle {
    
    /// Logging variable
    let logger : ILogging = LoggingImpl()
    let loggerTag : String = "LifecycleImpl"
    
    /// Array for saving the registered listeners
    var listeners:[ILifecycleListener]!
    
    // Workaround:
    private struct SubStruct { static var staticVariable: Bool = false }
    
    public class var isBackgroundClassVariable: Bool
        {
        get { return SubStruct.staticVariable }
        set { SubStruct.staticVariable = newValue }
    }
    
    /// Class constructor
    override init() {
        
        listeners = [ILifecycleListener]()
    }
    
    /// Whether the application is in background or not
    /// :return: true if the application is in background;false otherwise
    /// :author: Ferran Vila Conesa
    /// :since: ARP1.0
    public func isBackground() -> Bool {
        
        return SubStruct.staticVariable
    }
    
    /// Add the listener for the lifecycle of the app
    /// :param: listener
    /// :author: Ferran Vila Conesa
    /// :since: ARP1.0
    public func addLifecycleListener(listener : ILifecycleListener) {
        
        logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Adding one listener to the pull")
        listeners.append(listener)
    }
    
    /// Un-registers an existing listener from receiving lifecycle events.
    /// :param: listener
    /// :author: Ferran Vila Conesa
    /// :since: ARP1.0
    public func removeLifecycleListener(listener : ILifecycleListener) {
        
        for (index, l) in enumerate(listeners) {
            
            if(l.getId() == listener.getId()) {
                
                listeners.removeAtIndex(index)
                
                logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Removing \(listener) to the service pull")
                
                return
            }
        }
        
        logger.log(ILoggingLogLevel.WARN, category: loggerTag, message: "\(listener) is not founded in the pull for removing")
    }
    
    /// Removes all existing listeners from receiving lifecycle events.
    /// :param: listener
    /// :author: Ferran Vila Conesa
    /// :since: ARP1.0
    public func removeLifecycleListeners() {
        
        logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Removing all the listeners from thee service pull")
        listeners.removeAll(keepCapacity: false)
    }
    
    /// This function is called by the Appdelegeate in order to propagate an event to the listeners
    /// :param: lifecycle LifeCycle event
    /// :author: Ferran Vila Conesa
    public func changeListenersStatus(lifecycle:Lifecycle) {
        
        // Iterate all over the listeners and fire the event
        for (index, l) in enumerate(listeners) {
            l.onResult(lifecycle)
        }
    }
    
    /// This function is called by the Appdelegeate in order to propagate an event to the listeners
    /// :param: lifecycle LifeCycle event
    /// :param: warning Warning event
    /// :author: Ferran Vila Conesa
    public func changeListenerWarningStatus(lifecycle:Lifecycle, warning: ILifecycleListenerWarning) {
        
        // Iterate all over the listeners and fire the event
        for (index, l) in enumerate(listeners) {
            l.onWarning(lifecycle, warning: warning)
        }
    }
    
    /// This function is called by the Appdelegeate in order to propagate an event to the listeners
    /// :param: error Error event
    /// :author: Ferran Vila Conesa
    public func changeListenerErrorStatus(error: ILifecycleListenerError) {
        
        // Iterate all over the listeners and fire the event
        for (index, l) in enumerate(listeners) {
            l.onError(error)
        }
    }
    
}