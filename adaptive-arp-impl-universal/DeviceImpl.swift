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
import UIKit
#endif

public class DeviceImpl : IDevice {    
    
    /// Logging variable
    let logger : ILogging = LoggingImpl()
    
    /// Variable that stores the device information
    var deviceInfo:DeviceInfo
    
    /**
    Class constructor
    */
    init() {
        
        #if os(iOS)
            let device: UIDevice = UIDevice.currentDevice()
            
            deviceInfo = DeviceInfo(name: device.name, model: device.model, vendor: "Apple", uuid: NSUUID().UUIDString)
        #else
            let host: NSHost = NSHost.currentHost()
            
            // TODO: find a better way to do this and get the model identifier in osx
            
            deviceInfo = DeviceInfo(name: host.name!, model: "", vendor: "Apple", uuid: NSUUID().UUIDString)
        #endif
    }
    
    public func addButtonListener(listener : IButtonListener) {
        
        // TODO
    }
    
    public func getDeviceInfo() -> DeviceInfo {
        
        logger.log(ILoggingLogLevel.INFO, category: "DeviceImpl", message: "name: \(self.deviceInfo.getName()), model: \(self.deviceInfo.getModel()), vendor: \(self.deviceInfo.getVendor()), uuid: \(self.deviceInfo.getUuid())")
        
        return self.deviceInfo
    }
    
    /**
    Gets the current Locale for the device.
    
    :returns: The current Locale information.
    */
    public func getLocaleCurrent() -> Locale {
        
        // Gets the current locale of the device
        let currentLocale : NSLocale = NSLocale.currentLocale()
        
        let country : String = currentLocale.displayNameForKey(NSLocaleCountryCode, value: currentLocale.localeIdentifier)!
        let language : String = currentLocale.displayNameForKey(NSLocaleIdentifier, value: currentLocale.localeIdentifier)!
        
        logger.log(ILoggingLogLevel.DEBUG, category: "DeviceImpl", message: "Country=\(country)")
        logger.log(ILoggingLogLevel.DEBUG, category: "DeviceImpl", message: "Language=\(language)")
        
        return Locale(country: country, language: language)
    }
    
    public func removeButtonListener(listener : IButtonListener) {
        
        // TODO
    }
    
    public func removeButtonListeners() {
        
        // TODO
    }
    
}