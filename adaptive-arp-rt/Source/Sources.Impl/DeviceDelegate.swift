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
    var listeners: [IButtonListener]?
    
    /**
       Default Constructor.
    */
    public override init() {
        super.init()
        
        #if os(iOS)
            
            listeners = [IButtonListener]()
            
            let device: UIDevice = UIDevice.currentDevice()
            deviceInfo = DeviceInfo(name: device.name, model: device.model, vendor: "Apple", uuid: NSUUID().UUIDString)
            
        #endif
        #if os(OSX)
            
            let host: NSHost = NSHost.currentHost()
            deviceInfo = DeviceInfo(name: host.name!, model: getSysValue("hw.model"), vendor: "Apple", uuid: NSUUID().UUIDString)
            
        #endif
        
    }

    /**
       Register a new listener that will receive button events.

       @param listener to be registered.
       @since ARP1.0
    */
    public func addButtonListener(listener : IButtonListener) {
        
        // TODO: fire the event of button clicked and iterate for every listener. Find where the fire event is located
        
        #if os(iOS)
            
            for list in listeners! {
                if list.isEqual(listener) {
                    
                    // If the listener has alredy registered
                    
                    logger.log(ILoggingLogLevel.WARN, category: loggerTag, message: "The listener \(listener) has alredy registered")
                    return
                }
            }
            
            // Register the listener
            listeners!.append(listener)
            logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Listener \(listener) registered")
            
        #endif
        #if os(OSX)
            
            // in OSX there are no hardware buttons
            logger.log(ILoggingLogLevel.WARN, category: loggerTag, message: "This device doesn't have support for this kind of listeners because there aren't hardware buttons")
            
        #endif
    }

    /**
       Returns the device information for the current device executing the runtime.

       @return DeviceInfo for the current device.
       @since ARP1.0
    */
    public func getDeviceInfo() -> DeviceInfo? {
        
        logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "name: \(self.deviceInfo!.getName()), model: \(self.deviceInfo!.getModel()), vendor: \(self.deviceInfo!.getVendor()), uuid: \(self.deviceInfo!.getUuid())")
        
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
        
        logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Country=\(country)")
        logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Language=\(language)")
        
        return Locale(language: language, country: country)
    }

    /**
       De-registers an existing listener from receiving button events.

       @param listener to be removed.
       @since ARP1.0
    */
    public func removeButtonListener(listener : IButtonListener) {
        
        #if os(iOS)
            
            for (index, list) in enumerate(listeners!) {
                if list.isEqual(listener) {
                    
                    // Remove the listener
                    listeners!.removeAtIndex(index)
                    
                    logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "The listener \(listener) it has been removed")
                    return
                }
            }
            
            //
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "Listener \(listener) is not registered in the system")
            
        #endif
        #if os(OSX)
            
            // in OSX there are no hardware buttons
            logger.log(ILoggingLogLevel.WARN, category: loggerTag, message: "This device doesn't have support for this kind of listeners because there aren't hardware buttons")
            
        #endif

    }

    /**
       Removed all existing listeners from receiving button events.

       @since ARP1.0
    */
    public func removeButtonListeners() {
        
        #if os(iOS)
            
            var listCount:Int = listeners!.count
            
            // Remove all the listeners
            listeners!.removeAll(keepCapacity: false)
            
            logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Removed \(listCount) listeners from the system")
            
        #endif
        #if os(OSX)
            
            // in OSX there are no hardware buttons
            logger.log(ILoggingLogLevel.WARN, category: loggerTag, message: "This device doesn't have support for this kind of listeners because there aren't hardware buttons")
            
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
