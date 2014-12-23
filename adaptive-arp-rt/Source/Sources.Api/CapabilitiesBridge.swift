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
   Interface for testing the Capabilities operations
   Auto-generated implementation of ICapabilities specification.
*/
public class CapabilitiesBridge : BaseSystemBridge, ICapabilities, APIBridge {

    /**
       API Delegate.
    */
    private var delegate : ICapabilities? = nil

    /**
       Constructor with delegate.

       @param delegate The delegate implementing platform specific functions.
    */
    public init(delegate : ICapabilities?) {
        super.init()
        self.delegate = delegate
    }
    /**
       Get the delegate implementation.
       @return ICapabilities delegate that manages platform specific functions..
    */
    public final func getDelegate() -> ICapabilities? {
        return self.delegate
    }
    /**
       Set the delegate implementation.

       @param delegate The delegate implementing platform specific functions.
    */
    public final func setDelegate(delegate : ICapabilities) {
        self.delegate = delegate;
    }

    /**
       Determines whether a specific hardware button is supported for interaction.

       @param type Type of feature to check.
       @return true is supported, false otherwise.
       @since ARP1.0
    */
    public func hasButtonSupport(type : ICapabilitiesButton ) -> Bool {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup().toString(), message: "CapabilitiesBridge executing hasButtonSupport({\(type)}).")
        }

        var result : Bool = false
        if (self.delegate != nil) {
            result = self.delegate!.hasButtonSupport(type)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup().toString(), message: "CapabilitiesBridge executed 'hasButtonSupport' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup().toString(), message: "CapabilitiesBridge no delegate for 'hasButtonSupport'.")
            }
        }
        return result        
    }

    /**
       Determines whether a specific Communication capability is supported by
the device.

       @param type Type of feature to check.
       @return true if supported, false otherwise.
       @since ARP1.0
    */
    public func hasCommunicationSupport(type : ICapabilitiesCommunication ) -> Bool {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup().toString(), message: "CapabilitiesBridge executing hasCommunicationSupport({\(type)}).")
        }

        var result : Bool = false
        if (self.delegate != nil) {
            result = self.delegate!.hasCommunicationSupport(type)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup().toString(), message: "CapabilitiesBridge executed 'hasCommunicationSupport' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup().toString(), message: "CapabilitiesBridge no delegate for 'hasCommunicationSupport'.")
            }
        }
        return result        
    }

    /**
       Determines whether a specific Data capability is supported by the device.

       @param type Type of feature to check.
       @return true if supported, false otherwise.
       @since ARP1.0
    */
    public func hasDataSupport(type : ICapabilitiesData ) -> Bool {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup().toString(), message: "CapabilitiesBridge executing hasDataSupport({\(type)}).")
        }

        var result : Bool = false
        if (self.delegate != nil) {
            result = self.delegate!.hasDataSupport(type)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup().toString(), message: "CapabilitiesBridge executed 'hasDataSupport' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup().toString(), message: "CapabilitiesBridge no delegate for 'hasDataSupport'.")
            }
        }
        return result        
    }

    /**
       Determines whether a specific Media capability is supported by the
device.

       @param type Type of feature to check.
       @return true if supported, false otherwise.
       @since ARP1.0
    */
    public func hasMediaSupport(type : ICapabilitiesMedia ) -> Bool {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup().toString(), message: "CapabilitiesBridge executing hasMediaSupport({\(type)}).")
        }

        var result : Bool = false
        if (self.delegate != nil) {
            result = self.delegate!.hasMediaSupport(type)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup().toString(), message: "CapabilitiesBridge executed 'hasMediaSupport' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup().toString(), message: "CapabilitiesBridge no delegate for 'hasMediaSupport'.")
            }
        }
        return result        
    }

    /**
       Determines whether a specific Net capability is supported by the device.

       @param type Type of feature to check.
       @return true if supported, false otherwise.
       @since ARP1.0
    */
    public func hasNetSupport(type : ICapabilitiesNet ) -> Bool {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup().toString(), message: "CapabilitiesBridge executing hasNetSupport({\(type)}).")
        }

        var result : Bool = false
        if (self.delegate != nil) {
            result = self.delegate!.hasNetSupport(type)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup().toString(), message: "CapabilitiesBridge executed 'hasNetSupport' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup().toString(), message: "CapabilitiesBridge no delegate for 'hasNetSupport'.")
            }
        }
        return result        
    }

    /**
       Determines whether a specific Notification capability is supported by the
device.

       @param type Type of feature to check.
       @return true if supported, false otherwise.
       @since ARP1.0
    */
    public func hasNotificationSupport(type : ICapabilitiesNotification ) -> Bool {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup().toString(), message: "CapabilitiesBridge executing hasNotificationSupport({\(type)}).")
        }

        var result : Bool = false
        if (self.delegate != nil) {
            result = self.delegate!.hasNotificationSupport(type)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup().toString(), message: "CapabilitiesBridge executed 'hasNotificationSupport' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup().toString(), message: "CapabilitiesBridge no delegate for 'hasNotificationSupport'.")
            }
        }
        return result        
    }

    /**
       Determines whether a specific Sensor capability is supported by the
device.

       @param type Type of feature to check.
       @return true if supported, false otherwise.
       @since ARP1.0
    */
    public func hasSensorSupport(type : ICapabilitiesSensor ) -> Bool {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup().toString(), message: "CapabilitiesBridge executing hasSensorSupport({\(type)}).")
        }

        var result : Bool = false
        if (self.delegate != nil) {
            result = self.delegate!.hasSensorSupport(type)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup().toString(), message: "CapabilitiesBridge executed 'hasSensorSupport' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup().toString(), message: "CapabilitiesBridge no delegate for 'hasSensorSupport'.")
            }
        }
        return result        
    }

    /**
       Invokes the given method specified in the API request object.

       @param request APIRequest object containing method name and parameters.
       @return String with JSON response or a zero length string if the response is asynchronous or null if method not found.
    */
    public override func invoke(request : APIRequest) -> String? {
        var responseJSON : String? = ""
        switch request.getMethodName()! {
            case "hasButtonSupport":
                var type0 : ICapabilitiesButton? = ICapabilitiesButton.toEnum(JSONUtil.dictionifyJSON(request.getParameters()![0])["value"] as String!)
                var response0 : Bool? = self.hasButtonSupport(type0!)
                responseJSON = nil //TODO - Serialize this.gson.toJson(response0);
            case "hasCommunicationSupport":
                var type1 : ICapabilitiesCommunication? = ICapabilitiesCommunication.toEnum(JSONUtil.dictionifyJSON(request.getParameters()![0])["value"] as String!)
                var response1 : Bool? = self.hasCommunicationSupport(type1!)
                responseJSON = nil //TODO - Serialize this.gson.toJson(response1);
            case "hasDataSupport":
                var type2 : ICapabilitiesData? = ICapabilitiesData.toEnum(JSONUtil.dictionifyJSON(request.getParameters()![0])["value"] as String!)
                var response2 : Bool? = self.hasDataSupport(type2!)
                responseJSON = nil //TODO - Serialize this.gson.toJson(response2);
            case "hasMediaSupport":
                var type3 : ICapabilitiesMedia? = ICapabilitiesMedia.toEnum(JSONUtil.dictionifyJSON(request.getParameters()![0])["value"] as String!)
                var response3 : Bool? = self.hasMediaSupport(type3!)
                responseJSON = nil //TODO - Serialize this.gson.toJson(response3);
            case "hasNetSupport":
                var type4 : ICapabilitiesNet? = ICapabilitiesNet.toEnum(JSONUtil.dictionifyJSON(request.getParameters()![0])["value"] as String!)
                var response4 : Bool? = self.hasNetSupport(type4!)
                responseJSON = nil //TODO - Serialize this.gson.toJson(response4);
            case "hasNotificationSupport":
                var type5 : ICapabilitiesNotification? = ICapabilitiesNotification.toEnum(JSONUtil.dictionifyJSON(request.getParameters()![0])["value"] as String!)
                var response5 : Bool? = self.hasNotificationSupport(type5!)
                responseJSON = nil //TODO - Serialize this.gson.toJson(response5);
            case "hasSensorSupport":
                var type6 : ICapabilitiesSensor? = ICapabilitiesSensor.toEnum(JSONUtil.dictionifyJSON(request.getParameters()![0])["value"] as String!)
                var response6 : Bool? = self.hasSensorSupport(type6!)
                responseJSON = nil //TODO - Serialize this.gson.toJson(response6);
            default:
                // 404 - response null.
                responseJSON = nil
        }
        return responseJSON
    }
}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
