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

    * @version v2.1.9

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Interface for Managing the Display operations
   Auto-generated implementation of IDisplay specification.
*/
public class DisplayBridge : BaseSystemBridge, IDisplay, APIBridge {

    /**
       API Delegate.
    */
    private var delegate : IDisplay? = nil

    /**
       Constructor with delegate.

       @param delegate The delegate implementing platform specific functions.
    */
    public init(delegate : IDisplay?) {
        super.init()
        self.delegate = delegate
    }
    /**
       Get the delegate implementation.
       @return IDisplay delegate that manages platform specific functions..
    */
    public final func getDelegate() -> IDisplay? {
        return self.delegate
    }
    /**
       Set the delegate implementation.

       @param delegate The delegate implementing platform specific functions.
    */
    public final func setDelegate(delegate : IDisplay) {
        self.delegate = delegate;
    }

    /**
       Add a listener to start receiving display orientation change events.

       @param listener Listener to add to receive orientation change events.
       @since v2.0.5
    */
    public func addDisplayOrientationListener(listener : IDisplayOrientationListener ) {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "DisplayBridge executing addDisplayOrientationListener('\(listener)').")
        }

        if (self.delegate != nil) {
            self.delegate!.addDisplayOrientationListener(listener)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "DisplayBridge executed 'addDisplayOrientationListener' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "DisplayBridge no delegate for 'addDisplayOrientationListener'.")
            }
        }
        
    }

    /**
       Returns the current orientation of the display. Please note that this may be different from the orientation
of the device. For device orientation, use the IDevice APIs.

       @return The current orientation of the display.
       @since v2.0.5
    */
    public func getOrientationCurrent() -> ICapabilitiesOrientation? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "DisplayBridge executing getOrientationCurrent.")
        }

        var result : ICapabilitiesOrientation? = nil
        if (self.delegate != nil) {
            result = self.delegate!.getOrientationCurrent()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "DisplayBridge executed 'getOrientationCurrent' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "DisplayBridge no delegate for 'getOrientationCurrent'.")
            }
        }
        return result        
    }

    /**
       Remove a listener to stop receiving display orientation change events.

       @param listener Listener to remove from receiving orientation change events.
       @since v2.0.5
    */
    public func removeDisplayOrientationListener(listener : IDisplayOrientationListener ) {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "DisplayBridge executing removeDisplayOrientationListener('\(listener)').")
        }

        if (self.delegate != nil) {
            self.delegate!.removeDisplayOrientationListener(listener)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "DisplayBridge executed 'removeDisplayOrientationListener' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "DisplayBridge no delegate for 'removeDisplayOrientationListener'.")
            }
        }
        
    }

    /**
       Remove all listeners receiving display orientation events.

       @since v2.0.5
    */
    public func removeDisplayOrientationListeners() {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "DisplayBridge executing removeDisplayOrientationListeners.")
        }

        if (self.delegate != nil) {
            self.delegate!.removeDisplayOrientationListeners()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "DisplayBridge executed 'removeDisplayOrientationListeners' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "DisplayBridge no delegate for 'removeDisplayOrientationListeners'.")
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
            case "addDisplayOrientationListener":
                var listener0 : IDisplayOrientationListener? =  DisplayOrientationListenerImpl(id: request.getAsyncId()!)
                self.addDisplayOrientationListener(listener0!);
            case "getOrientationCurrent":
                var response1 : ICapabilitiesOrientation? = self.getOrientationCurrent()
                if let response1 = response1 {
                    responseJSON = "{ \"value\": \"\(response1.toString())\" }"
                } else {
                    responseJSON = "{ \"value\": \"Unknown\" }"
                }
            case "removeDisplayOrientationListener":
                var listener2 : IDisplayOrientationListener? =  DisplayOrientationListenerImpl(id: request.getAsyncId()!)
                self.removeDisplayOrientationListener(listener2!);
            case "removeDisplayOrientationListeners":
                self.removeDisplayOrientationListeners();
            default:
                // 404 - response null.
                responseCode = 404
                responseMessage = "DisplayBridge does not provide the function '\(request.getMethodName()!)' Please check your client-side API version; should be API version >= v2.1.9."
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
