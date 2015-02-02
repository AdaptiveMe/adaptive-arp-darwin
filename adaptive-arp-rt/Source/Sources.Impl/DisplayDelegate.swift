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

    * @version v2.0.4

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation
#if os(iOS)
    import UIKit
#endif
#if os(OSX)
    import Cocoa
#endif

/**
   Interface for Managing the Display operations
   Auto-generated implementation of IDisplay specification.
*/
public class DisplayDelegate : BaseSystemDelegate, IDisplay {
    
    /// Logger variable
    let logger : ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge()
    let loggerTag : String = "DisplayDelegate"
    
    /// Array of Listeners
    var orientationListeners: [IDisplayOrientationListener]!

    /**
       Default Constructor.
    */
    public override init() {
        super.init()
        
        #if os(iOS)
            
            orientationListeners = [IDisplayOrientationListener]()
            
        #endif
        #if os(OSX)
            
        #endif
    }
    
    /**
    Returns the current orientation of the display. Please note that this may be different from the orientation
    of the device. For device orientation, use the IDevice APIs.
    
    @return The current orientation of the display.
    @since ARP 2.0.5
    */
    public func getOrientationCurrent() -> ICapabilitiesOrientation? {
        
        #if os(iOS)
            
            switch UIApplication.sharedApplication().statusBarOrientation {
                
            case UIInterfaceOrientation.Portrait:
                return ICapabilitiesOrientation.Portrait_Up
                
            case UIInterfaceOrientation.PortraitUpsideDown:
                return ICapabilitiesOrientation.Portrait_Down
                
            case UIInterfaceOrientation.LandscapeLeft:
                return ICapabilitiesOrientation.Landscape_Left
                
            case UIInterfaceOrientation.LandscapeRight:
                return ICapabilitiesOrientation.Landscape_Right
                
            case UIInterfaceOrientation.Unknown:
                return ICapabilitiesOrientation.Unknown
                
            }
        #endif
        #if os(OSX)
            return ICapabilitiesOrientation.Portrait_Up
        #endif
    }

    /**
       Add a listener to start receiving display orientation change events.

       @param listener Listener to add to receive orientation change events.
       @since ARP 2.0.5
    */
    public func addDisplayOrientationListener(listener : IDisplayOrientationListener) {
        
        #if os(iOS)
            
            for list:IDisplayOrientationListener in orientationListeners {
                if list.getId() == listener.getId() {
                    
                    // If the listener has alredy registered
                    
                    logger.log(ILoggingLogLevel.WARN, category: loggerTag, message: "The listener \(listener) has alredy registered")
                    return
                }
            }
            
            // Register the listener
            orientationListeners.append(listener)
            logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Listener \(listener) registered")
            
        #endif
        #if os(OSX)
            
            // in OSX there are no orientation events
            logger.log(ILoggingLogLevel.WARN, category: loggerTag, message: "This device doesn't have support for this kind of listeners because there is no way to rotate this hardware, Unless you are Hulk 💪")
            
        #endif
    }
    
    /**
    Function that handles an event of rotation on the display. Propagates every event to the listeners
    */
    func orientationEvent(originOrientation:ICapabilitiesOrientation, destinationOrientation:ICapabilitiesOrientation, state:RotationEventState) {
        
        var event:RotationEvent = RotationEvent()
        event.setOrigin(originOrientation)
        event.setDestination(destinationOrientation)
        event.setState(state)
        event.setTimestamp(Int64(NSDate().timeIntervalSince1970*1000))
        
        // Iterate all over the registered listeners and send an event
        for list in orientationListeners {
            list.onResult(event)
        }
        
    }

    /**
       Remove a listener to stop receiving display orientation change events.

       @param listener Listener to remove from receiving orientation change events.
       @since ARP 2.0.5
    */
    public func removeDisplayOrientationListener(listener : IDisplayOrientationListener) {
        
        #if os(iOS)
            
            for (index, list) in enumerate(orientationListeners) {
                if list.getId() == listener.getId() {
                    
                    // Remove the listener
                    orientationListeners.removeAtIndex(index)
                    
                    logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "The listener \(listener) it has been removed")
                    return
                }
            }
            
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "Listener \(listener) is not registered in the system")
            
        #endif
        #if os(OSX)
            
            // in OSX there are no orientation events
            logger.log(ILoggingLogLevel.WARN, category: loggerTag, message: "This device doesn't have support for this kind of listeners because there is no way to rotate this hardware, Unless you are Hulk 💪")
            
        #endif
    }

    /**
       Remove all listeners receiving display orientation events.

       @since ARP 2.0.5
    */
    public func removeDisplayOrientationListeners() {
        
        #if os(iOS)
            
            var listCount:Int = orientationListeners.count
            
            // Remove all the listeners
            orientationListeners.removeAll(keepCapacity: false)
            
            logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Removed \(listCount) orientationListeners from the system")
            
        #endif
        #if os(OSX)
            
            // in OSX there are no orientation events
            logger.log(ILoggingLogLevel.WARN, category: loggerTag, message: "This device doesn't have support for this kind of listeners because there is no way to rotate this hardware, Unless you are Hulk 💪")
            
        #endif
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
