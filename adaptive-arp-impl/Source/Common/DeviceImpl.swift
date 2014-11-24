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
#if os(iOS)
    import UIKit
    #elseif os(OSX)
    import Cocoa
#endif

public class DeviceImpl : NSObject, IDevice {
    
    /// Logging variable
    let logger : ILogging = LoggingImpl()
    let loggerTag : String = "DeviceImpl"
    
    /// Variable that stores the device information
    var deviceInfo:DeviceInfo?
    
    /// Array of Listeners
    var listeners: [IButtonListener]?
    
    /**
    Class constructor
    */
    override public init() {
        
        super.init()
        
        #if os(iOS)
            
            listeners = [IButtonListener]()
            
            let device: UIDevice = UIDevice.currentDevice()
            deviceInfo = DeviceInfo(name: device.name, model: device.model, vendor: "Apple", uuid: NSUUID().UUIDString)
            
        #elseif os(OSX)
            
            let host: NSHost = NSHost.currentHost()            
            deviceInfo = DeviceInfo(name: host.name!, model: getSysValue("hw.model"), vendor: "Apple", uuid: NSUUID().UUIDString)
            
        #endif
    }
    
    /**
    Gets the device information of the device
    
    :returns: Object Bean containing all the device information
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func getDeviceInfo() -> DeviceInfo? {
        
        logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "name: \(self.deviceInfo!.getName()), model: \(self.deviceInfo!.getModel()), vendor: \(self.deviceInfo!.getVendor()), uuid: \(self.deviceInfo!.getUuid())")
        
        return self.deviceInfo!
    }
    
    /**
    Gets the current Locale for the device.
    
    :returns: The current Locale information.
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func getLocaleCurrent() -> AdaptiveArpApi.Locale? {
        
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
    * Register a new listener that will receive button events.
    *
    * @param listener to be registered.
    * @autor Ferran Vila Conesa
    * @since ARP1.0
    */
    public func addButtonListener(listener : IButtonListener) {
        
        #if os(iOS)
            
            for list in listeners! {
                if list.toString() == listener.toString() {
                    
                    // If the listener has alredy registered
                    
                    logger.log(ILoggingLogLevel.WARN, category: loggerTag, message: "The listener \(listener.toString()) has alredy registered")
                    return
                }
            }
            
            // Register the listener
            listeners!.append(listener)
            logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Listener \(listener.toString()) registered")
            
        #elseif os(OSX)
            
            // in OSX there are no hardware buttons
            logger.log(ILoggingLogLevel.WARN, category: loggerTag, message: "This device doesn't have support for this kind of listeners because there aren't hardware buttons")
            
        #endif
    }
    
    /**
    * De-registers an existing listener from receiving button events.
    *
    * @param listener
    * @autor Ferran Vila Conesa
    * @since ARP1.0
    */
    public func removeButtonListener(listener : IButtonListener) {
        
        #if os(iOS)
            
            for (index, list) in enumerate(listeners!) {
                if list.toString() == listener.toString() {
                    
                    // Remove the listener
                    listeners!.removeAtIndex(index)
                    
                    logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "The listener \(listener.toString()) it has been removed")
                    return
                }
            }
            
            //
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "Listener \(listener.toString()) is not registered in the system")
            
        #elseif os(OSX)
            
            // in OSX there are no hardware buttons
            logger.log(ILoggingLogLevel.WARN, category: loggerTag, message: "This device doesn't have support for this kind of listeners because there aren't hardware buttons")
            
        #endif
    }
    
    /**
    * Removed all existing listeners from receiving button events.
    *
    * @autor Ferran Vila Conesa
    * @since ARP1.0
    */
    public func removeButtonListeners() {
        
        #if os(iOS)
            
            var listCount:Int = listeners!.count
            
            // Remove all the listeners
            listeners!.removeAll(keepCapacity: false)
            
            logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Removed \(listCount) listeners from the system")
            
        #elseif os(OSX)
            
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