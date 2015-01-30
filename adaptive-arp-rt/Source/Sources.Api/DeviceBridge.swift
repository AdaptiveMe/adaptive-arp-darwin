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

    * @version v2.1.1

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Interface for Managing the Device operations
   Auto-generated implementation of IDevice specification.
*/
public class DeviceBridge : BaseSystemBridge, IDevice, APIBridge {

    /**
       API Delegate.
    */
    private var delegate : IDevice? = nil

    /**
       Constructor with delegate.

       @param delegate The delegate implementing platform specific functions.
    */
    public init(delegate : IDevice?) {
        super.init()
        self.delegate = delegate
    }
    /**
       Get the delegate implementation.
       @return IDevice delegate that manages platform specific functions..
    */
    public final func getDelegate() -> IDevice? {
        return self.delegate
    }
    /**
       Set the delegate implementation.

       @param delegate The delegate implementing platform specific functions.
    */
    public final func setDelegate(delegate : IDevice) {
        self.delegate = delegate;
    }

    /**
       Register a new listener that will receive button events.

       @param listener to be registered.
       @since v2.0
    */
    public func addButtonListener(listener : IButtonListener ) {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "DeviceBridge executing addButtonListener('\(listener)').")
        }

        if (self.delegate != nil) {
            self.delegate!.addButtonListener(listener)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "DeviceBridge executed 'addButtonListener' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "DeviceBridge no delegate for 'addButtonListener'.")
            }
        }
        
    }

    /**
       Add a listener to start receiving device orientation change events.

       @param listener Listener to add to receive orientation change events.
       @since v2.0.5
    */
    public func addDeviceOrientationListener(listener : IDeviceOrientationListener ) {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "DeviceBridge executing addDeviceOrientationListener('\(listener)').")
        }

        if (self.delegate != nil) {
            self.delegate!.addDeviceOrientationListener(listener)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "DeviceBridge executed 'addDeviceOrientationListener' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "DeviceBridge no delegate for 'addDeviceOrientationListener'.")
            }
        }
        
    }

    /**
       Returns the device information for the current device executing the runtime.

       @return DeviceInfo for the current device.
       @since v2.0
    */
    public func getDeviceInfo() -> DeviceInfo? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "DeviceBridge executing getDeviceInfo.")
        }

        var result : DeviceInfo? = nil
        if (self.delegate != nil) {
            result = self.delegate!.getDeviceInfo()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "DeviceBridge executed 'getDeviceInfo' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "DeviceBridge no delegate for 'getDeviceInfo'.")
            }
        }
        return result!        
    }

    /**
       Gets the current Locale for the device.

       @return The current Locale information.
       @since v2.0
    */
    public func getLocaleCurrent() -> Locale? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "DeviceBridge executing getLocaleCurrent.")
        }

        var result : Locale? = nil
        if (self.delegate != nil) {
            result = self.delegate!.getLocaleCurrent()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "DeviceBridge executed 'getLocaleCurrent' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "DeviceBridge no delegate for 'getLocaleCurrent'.")
            }
        }
        return result!        
    }

    /**
       Returns the current orientation of the device. Please note that this may be different from the orientation
of the display. For display orientation, use the IDisplay APIs.

       @return The current orientation of the device.
       @since v2.0.5
    */
    public func getOrientationCurrent() -> ICapabilitiesOrientation? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "DeviceBridge executing getOrientationCurrent.")
        }

        var result : ICapabilitiesOrientation? = nil
        if (self.delegate != nil) {
            result = self.delegate!.getOrientationCurrent()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "DeviceBridge executed 'getOrientationCurrent' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "DeviceBridge no delegate for 'getOrientationCurrent'.")
            }
        }
        return result!        
    }

    /**
       De-registers an existing listener from receiving button events.

       @param listener to be removed.
       @since v2.0
    */
    public func removeButtonListener(listener : IButtonListener ) {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "DeviceBridge executing removeButtonListener('\(listener)').")
        }

        if (self.delegate != nil) {
            self.delegate!.removeButtonListener(listener)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "DeviceBridge executed 'removeButtonListener' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "DeviceBridge no delegate for 'removeButtonListener'.")
            }
        }
        
    }

    /**
       Removed all existing listeners from receiving button events.

       @since v2.0
    */
    public func removeButtonListeners() {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "DeviceBridge executing removeButtonListeners.")
        }

        if (self.delegate != nil) {
            self.delegate!.removeButtonListeners()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "DeviceBridge executed 'removeButtonListeners' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "DeviceBridge no delegate for 'removeButtonListeners'.")
            }
        }
        
    }

    /**
       Remove a listener to stop receiving device orientation change events.

       @param listener Listener to remove from receiving orientation change events.
       @since v2.0.5
    */
    public func removeDeviceOrientationListener(listener : IDeviceOrientationListener ) {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "DeviceBridge executing removeDeviceOrientationListener('\(listener)').")
        }

        if (self.delegate != nil) {
            self.delegate!.removeDeviceOrientationListener(listener)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "DeviceBridge executed 'removeDeviceOrientationListener' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "DeviceBridge no delegate for 'removeDeviceOrientationListener'.")
            }
        }
        
    }

    /**
       Remove all listeners receiving device orientation events.

       @since v2.0.5
    */
    public func removeDeviceOrientationListeners() {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "DeviceBridge executing removeDeviceOrientationListeners.")
        }

        if (self.delegate != nil) {
            self.delegate!.removeDeviceOrientationListeners()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "DeviceBridge executed 'removeDeviceOrientationListeners' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "DeviceBridge no delegate for 'removeDeviceOrientationListeners'.")
            }
        }
        
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
            case "addButtonListener":
                var listener0 : IButtonListener? =  ButtonListenerImpl(id: request.getAsyncId()!)
                self.addButtonListener(listener0!);
            case "addDeviceOrientationListener":
                var listener1 : IDeviceOrientationListener? =  DeviceOrientationListenerImpl(id: request.getAsyncId()!)
                self.addDeviceOrientationListener(listener1!);
            case "getDeviceInfo":
                var response2 : DeviceInfo? = self.getDeviceInfo()
                if let response2 = response2 {
                    responseJSON = DeviceInfo.Serializer.toJSON(response2)
                } else {
                    responseJSON = "null"
                }
            case "getLocaleCurrent":
                var response3 : Locale? = self.getLocaleCurrent()
                if let response3 = response3 {
                    responseJSON = Locale.Serializer.toJSON(response3)
                } else {
                    responseJSON = "null"
                }
            case "getOrientationCurrent":
                var response4 : ICapabilitiesOrientation? = self.getOrientationCurrent()
                if let response4 = response4 {
                    responseJSON = "{ \"value\": \"\(response4.toString())\" }"
                } else {
                    responseJSON = "{ \"value\": \"Unknown\" }"
                }
            case "removeButtonListener":
                var listener5 : IButtonListener? =  ButtonListenerImpl(id: request.getAsyncId()!)
                self.removeButtonListener(listener5!);
            case "removeButtonListeners":
                self.removeButtonListeners();
            case "removeDeviceOrientationListener":
                var listener7 : IDeviceOrientationListener? =  DeviceOrientationListenerImpl(id: request.getAsyncId()!)
                self.removeDeviceOrientationListener(listener7!);
            case "removeDeviceOrientationListeners":
                self.removeDeviceOrientationListeners();
            default:
                // 404 - response null.
                responseCode = 404
                responseMessage = "DeviceBridge does not provide the function '\(request.getMethodName()!)' Please check your client-side API version; should be API version >= v2.1.1."
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
