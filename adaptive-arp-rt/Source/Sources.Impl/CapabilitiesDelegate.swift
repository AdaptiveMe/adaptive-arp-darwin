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
#if os(iOS)
    import UIKit
    import CoreMotion
    import MessageUI
    import AddressBook
    import CoreLocation
#endif
#if os(OSX)
    import AppKit
    import CoreLocation
    import CoreServices
    import AddressBook
#endif

/**
Interface for testing the Capabilities operations
Auto-generated implementation of ICapabilities specification.
*/
public class CapabilitiesDelegate : BaseSystemDelegate, ICapabilities {
    
    /// Logger variable
    let logger : ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge()
    let loggerTag : String = "CapabilitiesDelegate"
    
    /// Application
    #if os(iOS)
    var device:UIDevice = UIDevice.currentDevice()
    #endif
    #if os(OSX)
    #endif
    
    /**
    Default Constructor.
    */
    public override init() {
        super.init()
    }
    
    /**
    Determines whether a specific hardware button is supported for interaction.
    
    @param type Type of feature to check.
    @return true is supported, false otherwise.
    @since ARP1.0
    */
    public func hasButtonSupport(type : ICapabilitiesButton) -> Bool? {
        
        switch type {
            
        case ICapabilitiesButton.HomeButton:
            
            #if os(iOS)
                return true
            #endif
            #if os(OSX)
                return false
            #endif
            
        case ICapabilitiesButton.BackButton:
            
            #if os(iOS)
                return false
            #endif
            #if os(OSX)
                return false
            #endif
            
        case ICapabilitiesButton.OptionButton:
            
            #if os(iOS)
                return false
            #endif
            #if os(OSX)
                return false
            #endif
            
        case ICapabilitiesButton.Unknown:
            return false
            
        }
    }
    
    /**
    Determines whether a specific Communication capability is supported by
    the device.
    
    @param type Type of feature to check.
    @return true if supported, false otherwise.
    @since ARP1.0
    */
    public func hasCommunicationSupport(type : ICapabilitiesCommunication) -> Bool? {
        
        switch type {
            
        case ICapabilitiesCommunication.Calendar:
            
            #if os(iOS)
                if let _: AnyObject = NSUserDefaults.standardUserDefaults().valueForKey("eventkit_events_access_granted") {
                    return true
                } else {
                    return false
                }
            #endif
            #if os(OSX)
                if let eventsAccess: AnyObject = NSUserDefaults.standardUserDefaults().valueForKey("eventkit_events_access_granted") {
                    return true
                } else {
                    return false
                }
            #endif
            
        case ICapabilitiesCommunication.Contact:
            
            #if os(iOS)
                
                switch (ABAddressBookGetAuthorizationStatus()){
                    
                case ABAuthorizationStatus.NotDetermined:
                    return false
                case ABAuthorizationStatus.Denied:
                    return false
                case ABAuthorizationStatus.Restricted:
                    return false
                case ABAuthorizationStatus.Authorized:
                    return true
                }
                
            #endif
            #if os(OSX)
                
                if let book = ABAddressBook.sharedAddressBook() {
                    return true
                } else {
                    return false
                }
                
            #endif
            
        case ICapabilitiesCommunication.Mail:
            
            #if os(iOS)
                return MFMailComposeViewController.canSendMail()
            #endif
            #if os(OSX)
                return false
            #endif
            
        case ICapabilitiesCommunication.Messaging:
            
            #if os(iOS)
                return MFMessageComposeViewController.canSendText()
            #endif
            #if os(OSX)
                return false
            #endif
            
        case ICapabilitiesCommunication.Telephony:
            
            #if os(iOS)
                let application = AppRegistryBridge.sharedInstance.getPlatformContext().getContext() as! UIApplication
                return application.canOpenURL(NSURL(string: "tel://")!)
            #endif
            #if os(OSX)
                return false
            #endif
            
        case ICapabilitiesCommunication.Unknown:
            return false
            
        }
    }
    
    /**
    Determines whether a specific Data capability is supported by the device.
    
    @param type Type of feature to check.
    @return true if supported, false otherwise.
    @since ARP1.0
    */
    public func hasDataSupport(type : ICapabilitiesData) -> Bool? {
        
        switch type {
            
        case ICapabilitiesData.Database:
            #if os(iOS)
                return true
            #endif
            #if os(OSX)
                return true
            #endif
        case ICapabilitiesData.File:
            #if os(iOS)
                return true
            #endif
            #if os(OSX)
                return true
            #endif
        case ICapabilitiesData.Cloud:
            #if os(iOS)
                return true
            #endif
            #if os(OSX)
                return true
            #endif
        case ICapabilitiesData.Unknown:
            return false
        }
    }
    
    /**
    Determines whether a specific Media capability is supported by the
    device.
    
    @param type Type of feature to check.
    @return true if supported, false otherwise.
    @since ARP1.0
    */
    public func hasMediaSupport(type : ICapabilitiesMedia) -> Bool? {
        
        switch type {
            
        case ICapabilitiesMedia.AudioPlayback:
            #if os(iOS)
                return true
            #endif
            #if os(OSX)
                return true
            #endif
        case ICapabilitiesMedia.AudioRecording:
            #if os(iOS)
                return true
            #endif
            #if os(OSX)
                return true
            #endif
        case ICapabilitiesMedia.Camera:
            
            #if os(iOS)
                return UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Rear) || UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Front)
            #endif
            #if os(OSX)
                return true
            #endif
            
        case ICapabilitiesMedia.VideoPlayback:
            #if os(iOS)
                return true
            #endif
            #if os(OSX)
                return true
            #endif
        case ICapabilitiesMedia.VideoRecording:
            #if os(iOS)
                return true
            #endif
            #if os(OSX)
                return true
            #endif
        case ICapabilitiesMedia.Unknown:
            return false
        }
    }
    
    /**
    Determines whether a specific Net capability is supported by the device.
    
    @param type Type of feature to check.
    @return true if supported, false otherwise.
    @since ARP1.0
    */
    public func hasNetSupport(type : ICapabilitiesNet) -> Bool? {
        
        switch type {
            
        case ICapabilitiesNet.GSM:
            #if os(iOS)
                return true
            #endif
            #if os(OSX)
                return false
            #endif
        case ICapabilitiesNet.GPRS:
            #if os(iOS)
                return true
            #endif
            #if os(OSX)
                return false
            #endif
        case ICapabilitiesNet.HSDPA:
            #if os(iOS)
                return true
            #endif
            #if os(OSX)
                return false
            #endif
        case ICapabilitiesNet.LTE:
            #if os(iOS)
                return true
            #endif
            #if os(OSX)
                return false
            #endif
        case ICapabilitiesNet.WIFI:
            #if os(iOS)
                return true
            #endif
            #if os(OSX)
                return true
            #endif
        case ICapabilitiesNet.Ethernet:
            #if os(iOS)
                return false
            #endif
            #if os(OSX)
                return true
            #endif
        case ICapabilitiesNet.Unavailable:
            #if os(iOS)
                return false
            #endif
            #if os(OSX)
                return false
            #endif
        case ICapabilitiesNet.Unknown:
            return false
        }
    }
    
    /**
    Determines whether a specific Notification capability is supported by the
    device.
    
    @param type Type of feature to check.
    @return true if supported, false otherwise.
    @since ARP1.0
    */
    public func hasNotificationSupport(type : ICapabilitiesNotification) -> Bool? {
        
        switch type {
            
        case ICapabilitiesNotification.Alarm:
            #if os(iOS)
                return true
            #endif
            #if os(OSX)
                return true
            #endif
        case ICapabilitiesNotification.LocalNotification:
            #if os(iOS)
                return true
            #endif
            #if os(OSX)
                return true
            #endif
        case ICapabilitiesNotification.RemoteNotification:
            #if os(iOS)
                return true
            #endif
            #if os(OSX)
                return true
            #endif
        case ICapabilitiesNotification.Vibration:
            #if os(iOS)
                return true
            #endif
            #if os(OSX)
                return false
            #endif
        case ICapabilitiesNotification.Unknown:
            return false
        }
    }
    
    /**
    Determines whether a specific Sensor capability is supported by the
    device.
    
    @param type Type of feature to check.
    @return true if supported, false otherwise.
    @since ARP1.0
    */
    public func hasSensorSupport(type : ICapabilitiesSensor) -> Bool? {
        
        #if os(iOS)
            let motionManager: CMMotionManager = CMMotionManager()
        #endif
        #if os(OSX)
        #endif
        
        switch type {
            
        case ICapabilitiesSensor.Accelerometer:
            
            #if os(iOS)
                return motionManager.accelerometerAvailable
            #endif
            #if os(OSX)
                // In OSX there is some acceloremeter sensor, but there is no documentation about it. There are some external libraries to deal with it
                return false
            #endif
            
        case ICapabilitiesSensor.Barometer:
            
            #if os(iOS)
                return CMAltimeter.isRelativeAltitudeAvailable()
            #endif
            #if os(OSX)
                return false
            #endif
            
        case ICapabilitiesSensor.Geolocation:
            
            #if os(iOS)
                return CLLocationManager.locationServicesEnabled()
            #endif
            #if os(OSX)
                return CLLocationManager.locationServicesEnabled()
            #endif
            
        case ICapabilitiesSensor.Gyroscope:
            
            #if os(iOS)
                return motionManager.gyroAvailable
            #endif
            #if os(OSX)
                return false
            #endif
            
        case ICapabilitiesSensor.Magnetometer:
            
            #if os(iOS)
                return motionManager.magnetometerAvailable
            #endif
            #if os(OSX)
                return false
            #endif
            
        case ICapabilitiesSensor.Proximity, ICapabilitiesSensor.AmbientLight:
            
            // In iOS the Proximity sensor and the ambien light sensor are the same
            
            #if os(iOS)
                device.proximityMonitoringEnabled = true
                return device.proximityMonitoringEnabled
            #endif
            #if os(OSX)
                return false
            #endif
            
        case ICapabilitiesSensor.Unknown:
            return false
            
        }
    }
    
    /**
    Determines whether the device/display supports a given orientation.
    
    @param orientation Orientation type.
    @return True if the given orientation is supported, false otherwise.
    @since v2.0.5
    */
    public func hasOrientationSupport(orientation : ICapabilitiesOrientation) -> Bool? {
        
        switch orientation {
            
        case ICapabilitiesOrientation.PortraitUp:
            
            #if os(iOS)
                switch UIDevice.currentDevice().userInterfaceIdiom {
                case UIUserInterfaceIdiom.Pad:
                    return true
                case UIUserInterfaceIdiom.Phone:
                    return true
                case UIUserInterfaceIdiom.Unspecified:
                    return false
                default:
                    return false
                }
            #endif
            #if os(OSX)
                return true
            #endif
            
        case ICapabilitiesOrientation.PortraitDown:
            
            #if os(iOS)
                switch UIDevice.currentDevice().userInterfaceIdiom {
                case UIUserInterfaceIdiom.Pad:
                    return true
                case UIUserInterfaceIdiom.Phone:
                    return false
                case UIUserInterfaceIdiom.Unspecified:
                    return false
                default:
                    return false
                }
            #endif
            #if os(OSX)
                return false
            #endif
            
        case ICapabilitiesOrientation.LandscapeLeft:
            
            #if os(iOS)
                switch UIDevice.currentDevice().userInterfaceIdiom {
                case UIUserInterfaceIdiom.Pad:
                    return true
                case UIUserInterfaceIdiom.Phone:
                    return true
                case UIUserInterfaceIdiom.Unspecified:
                    return false
                default:
                    return true
                }
            #endif
            #if os(OSX)
                return false
            #endif
            
        case ICapabilitiesOrientation.LandscapeRight:
            
            #if os(iOS)
                switch UIDevice.currentDevice().userInterfaceIdiom {
                case UIUserInterfaceIdiom.Pad:
                    return true
                case UIUserInterfaceIdiom.Phone:
                    return true
                case UIUserInterfaceIdiom.Unspecified:
                    return false
                default:
                    return true
                }
            #endif
            #if os(OSX)
                return false
            #endif
            
        case ICapabilitiesOrientation.Unknown:
            return false
        }
    }
    
    /**
    Obtains the default orientation of the device/display. If no default orientation is available on
    the platform, this method will return the current orientation. To capture device or display orientation
    changes please use the IDevice and IDisplay functions and listeners API respectively.
    
    @return The default orientation for the device/display.
    @since v2.0.5
    */
    public func getOrientationDefault() -> ICapabilitiesOrientation? {
        
        #if os(iOS)
            
            // There is no way to obtain the default orientation, returning the current orientation
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
            return ICapabilitiesOrientation.PortraitUp
        #endif
    }
    
    /**
    Provides the device/display orientations supported by the platform. A platform will usually
    support at least one orientation. This is usually PortaitUp.
    
    @return The orientations supported by the device/display of the platform.
    @since v2.0.5
    */
    public func getOrientationsSupported() -> [ICapabilitiesOrientation]? {
        
        var ret: [ICapabilitiesOrientation] = [ICapabilitiesOrientation]()
        
        #if os(iOS)
            switch UIDevice.currentDevice().userInterfaceIdiom {
                
            case UIUserInterfaceIdiom.Pad:
                ret.append(ICapabilitiesOrientation.PortraitUp)
                ret.append(ICapabilitiesOrientation.PortraitDown)
                ret.append(ICapabilitiesOrientation.LandscapeLeft)
                ret.append(ICapabilitiesOrientation.LandscapeRight)
                
            case UIUserInterfaceIdiom.Phone:
                ret.append(ICapabilitiesOrientation.PortraitUp)
                ret.append(ICapabilitiesOrientation.LandscapeLeft)
                ret.append(ICapabilitiesOrientation.LandscapeRight)
                
            case UIUserInterfaceIdiom.Unspecified:
                ret.append(ICapabilitiesOrientation.Unknown)
            default:
                ret.append(ICapabilitiesOrientation.PortraitUp)
            }
        #endif
        #if os(OSX)
            ret.append(ICapabilitiesOrientation.PortraitUp)
        #endif
        
        return ret
    }
    
}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
