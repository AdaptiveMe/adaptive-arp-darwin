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
#if os(iOS)
    import UIKit
#endif
#if os(OSX)
    import Cocoa
#endif

/**
Interface for Managing the Device operations
Auto-generated implementation of IDevice specification.
*/
public class DeviceDelegate : BaseSystemDelegate, IDevice {
    
    /// Logger variable
    let logger : ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge()
    let loggerTag : String = "DeviceDelegate"
    
    /// Variable that stores the device information
    var deviceInfo:DeviceInfo?
    
    /// Array of Listeners
    var buttonListeners: [IButtonListener]!
    var orientationListeners: [IDeviceOrientationListener]!
    
    /**
    Default Constructor.
    */
    public override init() {
        super.init()
        
        #if os(iOS)
            
            buttonListeners = [IButtonListener]()
            orientationListeners = [IDeviceOrientationListener]()
            
            let device: UIDevice = UIDevice.currentDevice()
            deviceInfo = DeviceInfo(name: device.name, model: device.model, vendor: "Apple", uuid: "\(device.identifierForVendor)")
            
        #endif
        #if os(OSX)
            
            let host: NSHost = NSHost.currentHost()
            deviceInfo = DeviceInfo(name: host.name!, model: getSysValue("hw.model"), vendor: "Apple", uuid: NSUUID().UUIDString)
            
        #endif
        
    }
    
    /**
    Returns the device information for the current device executing the runtime.
    
    @return DeviceInfo for the current device.
    @since ARP1.0
    */
    public func getDeviceInfo() -> DeviceInfo? {
        
        logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "name: \(self.deviceInfo!.getName()), model: \(self.deviceInfo!.getModel()), vendor: \(self.deviceInfo!.getVendor()), uuid: \(self.deviceInfo!.getUuid())")
        
        return self.deviceInfo!
    }
    
    /**
    Gets the current Locale for the device.
    
    @return The current Locale information.
    @since ARP1.0
    */
    public func getLocaleCurrent() -> Locale? {
        
        // Gets the current locale of the device
        let currentLocale: NSLocale = NSLocale.currentLocale()
        
        let localeComponents: [NSObject : AnyObject] = NSLocale.componentsFromLocaleIdentifier(currentLocale.localeIdentifier)
        
        let country: String = localeComponents[NSLocaleCountryCode] as String
        let language: String = localeComponents[NSLocaleLanguageCode] as String
        
        logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Country=\(country)")
        logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Language=\(language)")
        
        return Locale(language: language, country: country)
    }
    
    /**
    Register a new listener that will receive button events.
    
    @param listener to be registered.
    @since ARP1.0
    */
    public func addButtonListener(listener : IButtonListener) {
        
        // TODO: fire the event of button clicked and iterate for every listener. Find where the fire event is located
        
        #if os(iOS)
            
            for list:IButtonListener in buttonListeners {
                if list.getId() == listener.getId() {
                    
                    // If the listener has alredy registered
                    
                    logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "The listener \(listener) has alredy registered")
                    return
                }
            }
            
            // Register the listener
            buttonListeners.append(listener)
            logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Listener \(listener) registered")
            
        #endif
        #if os(OSX)
            
            // in OSX there are no hardware buttons
            logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "This device doesn't have support for this kind of listeners because there aren't hardware buttons")
            
        #endif
    }
    
    /**
    De-registers an existing listener from receiving button events.
    
    @param listener to be removed.
    @since ARP1.0
    */
    public func removeButtonListener(listener : IButtonListener) {
        
        #if os(iOS)
            
            for (index, list:IButtonListener) in enumerate(buttonListeners) {
                if list.getId() == listener.getId() {
                    
                    // Remove the listener
                    buttonListeners.removeAtIndex(index)
                    
                    logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "The listener \(listener) it has been removed")
                    return
                }
            }
            
            logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Listener \(listener) is not registered in the system")
            
        #endif
        #if os(OSX)
            
            // in OSX there are no hardware buttons
            logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "This device doesn't have support for this kind of listeners because there aren't hardware buttons")
            
        #endif
        
    }
    
    /**
    Removed all existing listeners from receiving button events.
    
    @since ARP1.0
    */
    public func removeButtonListeners() {
        
        #if os(iOS)
            
            var listCount:Int = buttonListeners.count
            
            // Remove all the listeners
            buttonListeners.removeAll(keepCapacity: false)
            
            logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Removed \(listCount) buttonListeners from the system")
            
        #endif
        #if os(OSX)
            
            // in OSX there are no hardware buttons
            logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "This device doesn't have support for this kind of listeners because there aren't hardware buttons")
            
        #endif
    }
    
    /**
    Returns the current orientation of the device. Please note that this may be different from the orientation
    of the display. For display orientation, use the IDisplay APIs.
    
    @return The current orientation of the device.
    @since v2.0.5
    */
    public func getOrientationCurrent() -> ICapabilitiesOrientation? {
        
        #if os(iOS)
            
            switch UIDevice.currentDevice().orientation {
                
            case UIDeviceOrientation.Portrait:
                return ICapabilitiesOrientation.PortraitUp
                
            case UIDeviceOrientation.PortraitUpsideDown:
                return ICapabilitiesOrientation.PortraitDown
                
            case UIDeviceOrientation.LandscapeLeft:
                return ICapabilitiesOrientation.LandscapeLeft
                
            case UIDeviceOrientation.LandscapeRight:
                return ICapabilitiesOrientation.LandscapeRight
                
            case UIDeviceOrientation.FaceUp, UIDeviceOrientation.FaceDown, UIDeviceOrientation.Unknown:
                return ICapabilitiesOrientation.Unknown
                
            }
        #endif
        #if os(OSX)
            return ICapabilitiesOrientation.Portrait_Up
        #endif
    }
    
    /**
    Add a listener to start receiving device orientation change events.
    
    @param listener Listener to add to receive orientation change events.
    @since v2.0.5
    */
    public func addDeviceOrientationListener(listener : IDeviceOrientationListener) {
        
        #if os(iOS)
            
            // Check if the device is able to generate Device Notifications
            if !UIDevice.currentDevice().generatesDeviceOrientationNotifications {
                logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "This device is not able to generate rotation events")
                return
            }
            
            for list:IDeviceOrientationListener in orientationListeners {
                if list.getId() == listener.getId() {
                    
                    // If the listener has alredy registered
                    
                    logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "The listener \(listener) has alredy registered")
                    return
                }
            }
            
            // If there is no listener enabled, add an observer
            if orientationListeners.count == 0 {
                UIDevice.currentDevice().beginGeneratingDeviceOrientationNotifications()
                NSNotificationCenter.defaultCenter().addObserver(self,
                    selector: "orientationEvent",
                    name:UIDeviceOrientationDidChangeNotification,
                    object:nil)
            }
            
            // Register the listener
            orientationListeners.append(listener)
            logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Listener \(listener) registered")
            
        #endif
        #if os(OSX)
            
            // in OSX there are no orientation events
            logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "This device doesn't have support for this kind of listeners because there is no way to rotate this hardware, Unless you are Hulk 💪")
            
        #endif
    }
    
    #if os(iOS)
    /**
    Function that handles an event of rotation on the device. Propagates every event to the listeners
    */
    func orientationEvent() {
        
        if orientationListeners.count == 0 {
            logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "There are Notifications of UIDeviceOrientationDidChangeNotification but there no listener registered on the platfform.")
        } else {
            
            // MARK: There is no way to detect the rotation effect transition.
            // There is only one event fired, when the device finishes the rotation
            
            var event:RotationEvent = RotationEvent()
            event.setOrigin(ICapabilitiesOrientation.Unknown)
            event.setState(RotationEventState.DidFinishRotation)
            event.setTimestamp(Int64(NSDate().timeIntervalSince1970*1000))
            
            switch UIDevice.currentDevice().orientation {
            case UIDeviceOrientation.Unknown, UIDeviceOrientation.FaceUp, UIDeviceOrientation.FaceDown:
                event.setDestination(ICapabilitiesOrientation.Unknown)
            case UIDeviceOrientation.Portrait:
                event.setDestination(ICapabilitiesOrientation.PortraitUp)
            case UIDeviceOrientation.PortraitUpsideDown:
                event.setDestination(ICapabilitiesOrientation.PortraitDown)
            case UIDeviceOrientation.LandscapeLeft:
                event.setDestination(ICapabilitiesOrientation.LandscapeLeft)
            case UIDeviceOrientation.LandscapeRight:
                event.setDestination(ICapabilitiesOrientation.LandscapeRight)
            }
            
            // Iterate all over the registered listeners and send an event
            for list in orientationListeners {
                list.onResult(event)
            }
        }
        
    }
    #endif
    
    /**
    Remove a listener to stop receiving device orientation change events.
    
    @param listener Listener to remove from receiving orientation change events.
    @since v2.0.5
    */
    public func removeDeviceOrientationListener(listener : IDeviceOrientationListener) {
        
        #if os(iOS)
            
            for (index, list) in enumerate(orientationListeners) {
                if list.getId() == listener.getId() {
                    
                    // Remove the listener
                    orientationListeners.removeAtIndex(index)
                    
                    // If there is no listener enabled, remove the observer and the notifications
                    if orientationListeners.count == 0 {
                        NSNotificationCenter.defaultCenter().removeObserver(self)
                        UIDevice.currentDevice().endGeneratingDeviceOrientationNotifications()
                    }
                    
                    logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "The listener \(listener) it has been removed")
                    return
                }
            }
            
            logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Listener \(listener) is not registered in the system")
            
        #endif
        #if os(OSX)
            
            // in OSX there are no orientation events
            logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "This device doesn't have support for this kind of listeners because there is no way to rotate this hardware, Unless you are Hulk 💪")
            
        #endif
    }
    
    /**
    Remove all listeners receiving device orientation events.
    
    @since v2.0.5
    */
    public func removeDeviceOrientationListeners() {
        
        #if os(iOS)
            
            var listCount:Int = orientationListeners.count
            
            // Remove all the listeners
            orientationListeners.removeAll(keepCapacity: false)
                        
            // Remove the observer and the notifications
            NSNotificationCenter.defaultCenter().removeObserver(self)
            UIDevice.currentDevice().endGeneratingDeviceOrientationNotifications()
            
            logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Removed \(listCount) orientationListeners from the system")
            
        #endif
        #if os(OSX)
            
            // in OSX there are no orientation events
            logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "This device doesn't have support for this kind of listeners because there is no way to rotate this hardware, Unless you are Hulk 💪")
            
        #endif
    }
    
    /**
    Returns a variable stored in the memory stack
    
    :param: attr Attribute to query
    :returns: The value of the attribute
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    private func getSysValue(attr: String) -> String {
        var size : UInt = 0
        sysctlbyname(attr, nil, &size, nil, 0)
        var machine = [CChar](count: Int(size), repeatedValue: 0)
        sysctlbyname(attr, &machine, &size, nil, 0)
        return String.fromCString(machine)!
    }
    
}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
