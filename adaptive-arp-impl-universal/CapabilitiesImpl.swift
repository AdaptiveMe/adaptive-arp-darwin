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
    import CoreMotion
    import MessageUI
    import AddressBook
    import CoreLocation
    #elseif os(OSX)
    import AppKit
    import CoreLocation
#endif


public class CapabilitiesImpl : ICapabilities {
    
    /// Logging variable
    let logger : ILogging = LoggingImpl()
    
    /// Application
    #if os(iOS)
        var application:UIApplication
        var device:UIDevice
    #elseif os(OSX)
        var application:NSApplication
    #endif
    
    /**
    Class constructor
    */
    init() {
        
        #if os(iOS)
            application = AppContextImpl().getContext() as UIApplication
            device = UIDevice.currentDevice()
        #elseif os(OSX)
            application = AppContextImpl().getContext() as NSApplication
        #endif
    }
    
    /**
    Determines whether a specific hardware button is supported for interaction.
    
    :param: type Type of feature to check.
    
    :returns: true is supported, false otherwise.
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func hasButtonSupport(type : ICapabilitiesButton) -> Bool {
        
        switch type {
            
        case ICapabilitiesButton.HomeButton:
            
            #if os(iOS)
                return true
            #elseif os(OSX)
                return false
            #endif
            
        case ICapabilitiesButton.BackButton:
            
            #if os(iOS)
                return false
            #elseif os(OSX)
                return false
            #endif
            
        case ICapabilitiesButton.OptionButton:
            
            #if os(iOS)
                return false
            #elseif os(OSX)
                return false
            #endif
            
        }
    }
    
    /**
    Determines whether a specific Communication capability is supported by
    * the device.
    
    :param: type Type of feature to check.
    
    :returns: true if supported, false otherwise.
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func hasCommunicationSupport(type : ICapabilitiesCommunication) -> Bool {
        
        switch type {
            
        case ICapabilitiesCommunication.Calendar:
            // TODO
            return false
        case ICapabilitiesCommunication.Contact:
            
            #if os(iOS)
                return MFMailComposeViewController.canSendMail()
            #elseif os(OSX)
                //TODO
                return false
            #endif
            
        case ICapabilitiesCommunication.Mail:
            
            #if os(iOS)
                return MFMailComposeViewController.canSendMail()
            #elseif os(OSX)
                //TODO
                return false
            #endif
            
        case ICapabilitiesCommunication.Messaging:
            
            #if os(iOS)
                return MFMessageComposeViewController.canSendText()
            #elseif os(OSX)
                //TODO
                return false
            #endif
            
        case ICapabilitiesCommunication.Telephony:
            
            #if os(iOS)
                return self.application.canOpenURL(NSURL(string: "tel://")!)
            #elseif os(OSX)
                //TODO
                return false
            #endif
            
        }

    }
    
    /**
    Determines whether a specific Data capability is supported by the device.
    
    :param: type Type of feature to check.
    
    :returns: true if supported, false otherwise.
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func hasDataSupport(type : ICapabilitiesData) -> Bool {
        
        switch type {
            
        case ICapabilitiesData.Database:
            // TODO
            return false
        case ICapabilitiesData.File:
            // TODO
            return false
        case ICapabilitiesData.Cloud:
            // TODO
            return false
        }
    }
    
    /**
    Determines whether a specific Media capability is supported by the device.
    
    :param: type Type of feature to check.
    
    :returns: true if supported, false otherwise.
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func hasMediaSupport(type : ICapabilitiesMedia) -> Bool {
        
        switch type {
            
        case ICapabilitiesMedia.Audio_Playback:
            // TODO
            return false
        case ICapabilitiesMedia.Audio_Recording:
            // TODO
            return false
        case ICapabilitiesMedia.Camera:
            
            #if os(iOS)
                return UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Rear) || UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Front)
            #elseif os(OSX)
                //TODO
                return false
            #endif
            
        case ICapabilitiesMedia.Video_Playback:
            // TODO
            return false
        case ICapabilitiesMedia.Video_Recording:
            // TODO
            return false
        }
    }
    
    /**
    Determines whether a specific Net capability is supported by the device.
    
    :param: type Type of feature to check.
    
    :returns: true if supported, false otherwise.
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func hasNetSupport(type : ICapabilitiesNet) -> Bool {
        
        switch type {
            
        case ICapabilitiesNet.GSM:
            // TODO
            return false
        case ICapabilitiesNet.GPRS:
            // TODO
            return false
        case ICapabilitiesNet.HSDPA:
            // TODO
            return false
        case ICapabilitiesNet.LTE:
            // TODO
            return false
        case ICapabilitiesNet.WIFI:
            // TODO
            return false
        case ICapabilitiesNet.Ethernet:
            // TODO
            return false
        }
    }
    
    /**
    Determines whether a specific Notification capability is supported by the device.
    
    :param: type Type of feature to check.
    
    :returns: true if supported, false otherwise.
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func hasNotificationSupport(type : ICapabilitiesNotification) -> Bool {
        
        switch type {
            
        case ICapabilitiesNotification.Alarm:
            // TODO
            return false
        case ICapabilitiesNotification.LocalNotification:
            // TODO
            return false
        case ICapabilitiesNotification.RemoteNotification:
            // TODO
            return false
        case ICapabilitiesNotification.Vibration:
            // TODO
            return false
        }
    }
    
    /**
    Determines whether a specific Sensor capability is supported by the
    * device.
    
    :param: type Type of feature to check.
    
    :returns: true if supported, false otherwise.
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func hasSensorSupport(type : ICapabilitiesSensor) -> Bool {
        
        #if os(iOS)
            var motionManager: CMMotionManager = CMMotionManager()
        #elseif os(OSX)
        #endif
        
        switch type {
            
        case ICapabilitiesSensor.Accelerometer:
            
            #if os(iOS)
                return motionManager.accelerometerAvailable
            #elseif os(OSX)
                // In OSX there is some acceloremeter sensor, but there is no documentation about it. There are some external libraries to deal with it
                return false
            #endif
            
        case ICapabilitiesSensor.Barometer:
            
            #if os(iOS)
                return CMAltimeter.isRelativeAltitudeAvailable()
            #elseif os(OSX)
                return false
            #endif
            
        case ICapabilitiesSensor.Geolocation:
            
            #if os(iOS)
                return CLLocationManager.locationServicesEnabled()
            #elseif os(OSX)
                return CLLocationManager.locationServicesEnabled()
            #endif
            
        case ICapabilitiesSensor.Gyroscope:
            
            #if os(iOS)
                return motionManager.gyroAvailable
            #elseif os(OSX)
                return false
            #endif
            
        case ICapabilitiesSensor.Magnetometer:
            
            #if os(iOS)
                return motionManager.magnetometerAvailable
            #elseif os(OSX)
                return false
            #endif
            
        case ICapabilitiesSensor.Proximity, ICapabilitiesSensor.AmbientLight:
            
            // In iOS the Proximity sensor and the ambien light sensor are the same
            
            #if os(iOS)
                device.proximityMonitoringEnabled = true
                return device.proximityMonitoringEnabled
            #elseif os(OSX)
                return false
            #endif
            
        }
    }
    
}