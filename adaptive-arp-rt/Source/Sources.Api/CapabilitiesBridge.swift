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

    * @version v2.1.8

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
       Obtains the default orientation of the device/display. If no default orientation is available on
the platform, this method will return the current orientation. To capture device or display orientation
changes please use the IDevice and IDisplay functions and listeners API respectively.

       @return The default orientation for the device/display.
       @since v2.0.5
    */
    public func getOrientationDefault() -> ICapabilitiesOrientation? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "CapabilitiesBridge executing getOrientationDefault.")
        }

        var result : ICapabilitiesOrientation? = nil
        if (self.delegate != nil) {
            result = self.delegate!.getOrientationDefault()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "CapabilitiesBridge executed 'getOrientationDefault' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "CapabilitiesBridge no delegate for 'getOrientationDefault'.")
            }
        }
        return result        
    }

    /**
       Provides the device/display orientations supported by the platform. A platform will usually
support at least one orientation. This is usually PortaitUp.

       @return The orientations supported by the device/display of the platform.
       @since v2.0.5
    */
    public func getOrientationsSupported() -> [ICapabilitiesOrientation]? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "CapabilitiesBridge executing getOrientationsSupported.")
        }

        var result : [ICapabilitiesOrientation]? = nil
        if (self.delegate != nil) {
            result = self.delegate!.getOrientationsSupported()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "CapabilitiesBridge executed 'getOrientationsSupported' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "CapabilitiesBridge no delegate for 'getOrientationsSupported'.")
            }
        }
        return result        
    }

    /**
       Determines whether a specific hardware button is supported for interaction.

       @param type Type of feature to check.
       @return true is supported, false otherwise.
       @since v2.0
    */
    public func hasButtonSupport(type : ICapabilitiesButton ) -> Bool? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "CapabilitiesBridge executing hasButtonSupport('\(type)').")
        }

        var result : Bool? = false
        if (self.delegate != nil) {
            result = self.delegate!.hasButtonSupport(type)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "CapabilitiesBridge executed 'hasButtonSupport' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "CapabilitiesBridge no delegate for 'hasButtonSupport'.")
            }
        }
        return result        
    }

    /**
       Determines whether a specific Communication capability is supported by
the device.

       @param type Type of feature to check.
       @return true if supported, false otherwise.
       @since v2.0
    */
    public func hasCommunicationSupport(type : ICapabilitiesCommunication ) -> Bool? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "CapabilitiesBridge executing hasCommunicationSupport('\(type)').")
        }

        var result : Bool? = false
        if (self.delegate != nil) {
            result = self.delegate!.hasCommunicationSupport(type)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "CapabilitiesBridge executed 'hasCommunicationSupport' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "CapabilitiesBridge no delegate for 'hasCommunicationSupport'.")
            }
        }
        return result        
    }

    /**
       Determines whether a specific Data capability is supported by the device.

       @param type Type of feature to check.
       @return true if supported, false otherwise.
       @since v2.0
    */
    public func hasDataSupport(type : ICapabilitiesData ) -> Bool? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "CapabilitiesBridge executing hasDataSupport('\(type)').")
        }

        var result : Bool? = false
        if (self.delegate != nil) {
            result = self.delegate!.hasDataSupport(type)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "CapabilitiesBridge executed 'hasDataSupport' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "CapabilitiesBridge no delegate for 'hasDataSupport'.")
            }
        }
        return result        
    }

    /**
       Determines whether a specific Media capability is supported by the
device.

       @param type Type of feature to check.
       @return true if supported, false otherwise.
       @since v2.0
    */
    public func hasMediaSupport(type : ICapabilitiesMedia ) -> Bool? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "CapabilitiesBridge executing hasMediaSupport('\(type)').")
        }

        var result : Bool? = false
        if (self.delegate != nil) {
            result = self.delegate!.hasMediaSupport(type)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "CapabilitiesBridge executed 'hasMediaSupport' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "CapabilitiesBridge no delegate for 'hasMediaSupport'.")
            }
        }
        return result        
    }

    /**
       Determines whether a specific Net capability is supported by the device.

       @param type Type of feature to check.
       @return true if supported, false otherwise.
       @since v2.0
    */
    public func hasNetSupport(type : ICapabilitiesNet ) -> Bool? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "CapabilitiesBridge executing hasNetSupport('\(type)').")
        }

        var result : Bool? = false
        if (self.delegate != nil) {
            result = self.delegate!.hasNetSupport(type)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "CapabilitiesBridge executed 'hasNetSupport' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "CapabilitiesBridge no delegate for 'hasNetSupport'.")
            }
        }
        return result        
    }

    /**
       Determines whether a specific Notification capability is supported by the
device.

       @param type Type of feature to check.
       @return true if supported, false otherwise.
       @since v2.0
    */
    public func hasNotificationSupport(type : ICapabilitiesNotification ) -> Bool? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "CapabilitiesBridge executing hasNotificationSupport('\(type)').")
        }

        var result : Bool? = false
        if (self.delegate != nil) {
            result = self.delegate!.hasNotificationSupport(type)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "CapabilitiesBridge executed 'hasNotificationSupport' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "CapabilitiesBridge no delegate for 'hasNotificationSupport'.")
            }
        }
        return result        
    }

    /**
       Determines whether the device/display supports a given orientation.

       @param orientation Orientation type.
       @return True if the given orientation is supported, false otherwise.
       @since v2.0.5
    */
    public func hasOrientationSupport(orientation : ICapabilitiesOrientation ) -> Bool? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "CapabilitiesBridge executing hasOrientationSupport('\(orientation)').")
        }

        var result : Bool? = false
        if (self.delegate != nil) {
            result = self.delegate!.hasOrientationSupport(orientation)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "CapabilitiesBridge executed 'hasOrientationSupport' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "CapabilitiesBridge no delegate for 'hasOrientationSupport'.")
            }
        }
        return result        
    }

    /**
       Determines whether a specific Sensor capability is supported by the
device.

       @param type Type of feature to check.
       @return true if supported, false otherwise.
       @since v2.0
    */
    public func hasSensorSupport(type : ICapabilitiesSensor ) -> Bool? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "CapabilitiesBridge executing hasSensorSupport('\(type)').")
        }

        var result : Bool? = false
        if (self.delegate != nil) {
            result = self.delegate!.hasSensorSupport(type)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "CapabilitiesBridge executed 'hasSensorSupport' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "CapabilitiesBridge no delegate for 'hasSensorSupport'.")
            }
        }
        return result        
    }

    /**
       Invokes the given method specified in the API request object.

       @param request APIRequest object containing method name and parameters.
       @return APIResponse with status code, message and JSON response or a JSON null string for void functions. Status code 200 is OK, all others are HTTP standard error conditions.
    */
    public override func invoke(request : APIRequest) -> APIResponse? {
        var response : APIResponse = APIResponse()
        var responseCode : Int32 = 200
        var responseMessage : String = "OK"
        var responseJSON : String? = "null"
        switch request.getMethodName()! {
            case "getOrientationDefault":
                var response0 : ICapabilitiesOrientation? = self.getOrientationDefault()
                if let response0 = response0 {
                    responseJSON = "{ \"value\": \"\(response0.toString())\" }"
                } else {
                    responseJSON = "{ \"value\": \"Unknown\" }"
                }
            case "getOrientationsSupported":
                var response1 : [ICapabilitiesOrientation]? = self.getOrientationsSupported()
                if let response1 = response1 {
                    var response1JSONArray : NSMutableString = NSMutableString()
                    response1JSONArray.appendString("[ ")
                    for (index, obj) in enumerate(response1) {
                        response1JSONArray.appendString("{ \"value\": \"\(obj.toString())\" }")
                        if index < response1.count-1 {
                            response1JSONArray.appendString(", ")
                        }
                    }
                    response1JSONArray.appendString(" ]")
                    responseJSON = response1JSONArray as String
                } else {
                    responseJSON = "[{ \"value\": \"Unknown\" }]"
                }
            case "hasButtonSupport":
                var type2 : ICapabilitiesButton? = ICapabilitiesButton.toEnum(JSONUtil.dictionifyJSON(request.getParameters()![0])["value"] as String!)
                var response2 : Bool? = self.hasButtonSupport(type2!)
                if let response2 = response2 {
                    responseJSON = "\(response2)"
                 } else {
                    responseJSON = "false"
                 }
            case "hasCommunicationSupport":
                var type3 : ICapabilitiesCommunication? = ICapabilitiesCommunication.toEnum(JSONUtil.dictionifyJSON(request.getParameters()![0])["value"] as String!)
                var response3 : Bool? = self.hasCommunicationSupport(type3!)
                if let response3 = response3 {
                    responseJSON = "\(response3)"
                 } else {
                    responseJSON = "false"
                 }
            case "hasDataSupport":
                var type4 : ICapabilitiesData? = ICapabilitiesData.toEnum(JSONUtil.dictionifyJSON(request.getParameters()![0])["value"] as String!)
                var response4 : Bool? = self.hasDataSupport(type4!)
                if let response4 = response4 {
                    responseJSON = "\(response4)"
                 } else {
                    responseJSON = "false"
                 }
            case "hasMediaSupport":
                var type5 : ICapabilitiesMedia? = ICapabilitiesMedia.toEnum(JSONUtil.dictionifyJSON(request.getParameters()![0])["value"] as String!)
                var response5 : Bool? = self.hasMediaSupport(type5!)
                if let response5 = response5 {
                    responseJSON = "\(response5)"
                 } else {
                    responseJSON = "false"
                 }
            case "hasNetSupport":
                var type6 : ICapabilitiesNet? = ICapabilitiesNet.toEnum(JSONUtil.dictionifyJSON(request.getParameters()![0])["value"] as String!)
                var response6 : Bool? = self.hasNetSupport(type6!)
                if let response6 = response6 {
                    responseJSON = "\(response6)"
                 } else {
                    responseJSON = "false"
                 }
            case "hasNotificationSupport":
                var type7 : ICapabilitiesNotification? = ICapabilitiesNotification.toEnum(JSONUtil.dictionifyJSON(request.getParameters()![0])["value"] as String!)
                var response7 : Bool? = self.hasNotificationSupport(type7!)
                if let response7 = response7 {
                    responseJSON = "\(response7)"
                 } else {
                    responseJSON = "false"
                 }
            case "hasOrientationSupport":
                var orientation8 : ICapabilitiesOrientation? = ICapabilitiesOrientation.toEnum(JSONUtil.dictionifyJSON(request.getParameters()![0])["value"] as String!)
                var response8 : Bool? = self.hasOrientationSupport(orientation8!)
                if let response8 = response8 {
                    responseJSON = "\(response8)"
                 } else {
                    responseJSON = "false"
                 }
            case "hasSensorSupport":
                var type9 : ICapabilitiesSensor? = ICapabilitiesSensor.toEnum(JSONUtil.dictionifyJSON(request.getParameters()![0])["value"] as String!)
                var response9 : Bool? = self.hasSensorSupport(type9!)
                if let response9 = response9 {
                    responseJSON = "\(response9)"
                 } else {
                    responseJSON = "false"
                 }
            default:
                // 404 - response null.
                responseCode = 404
                responseMessage = "CapabilitiesBridge does not provide the function '\(request.getMethodName()!)' Please check your client-side API version; should be API version >= v2.1.8."
        }
        response.setResponse(responseJSON!)
        response.setStatusCode(responseCode)
        response.setStatusMessage(responseMessage)
        return response
    }
}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
