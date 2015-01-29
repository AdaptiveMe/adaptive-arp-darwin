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
   Interface defining methods about the acceleration sensor
   Auto-generated implementation of IAcceleration specification.
*/
public class AccelerationBridge : BaseSensorBridge, IAcceleration, APIBridge {

    /**
       API Delegate.
    */
    private var delegate : IAcceleration? = nil

    /**
       Constructor with delegate.

       @param delegate The delegate implementing platform specific functions.
    */
    public init(delegate : IAcceleration?) {
        super.init()
        self.delegate = delegate
    }
    /**
       Get the delegate implementation.
       @return IAcceleration delegate that manages platform specific functions..
    */
    public final func getDelegate() -> IAcceleration? {
        return self.delegate
    }
    /**
       Set the delegate implementation.

       @param delegate The delegate implementing platform specific functions.
    */
    public final func setDelegate(delegate : IAcceleration) {
        self.delegate = delegate;
    }

    /**
       Register a new listener that will receive acceleration events.

       @param listener to be registered.
       @since v2.0
    */
    public func addAccelerationListener(listener : IAccelerationListener ) {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AccelerationBridge executing addAccelerationListener('\(listener)').")
        }

        if (self.delegate != nil) {
            self.delegate!.addAccelerationListener(listener)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AccelerationBridge executed 'addAccelerationListener' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AccelerationBridge no delegate for 'addAccelerationListener'.")
            }
        }
        
    }

    /**
       De-registers an existing listener from receiving acceleration events.

       @param listener to be registered.
       @since v2.0
    */
    public func removeAccelerationListener(listener : IAccelerationListener ) {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AccelerationBridge executing removeAccelerationListener('\(listener)').")
        }

        if (self.delegate != nil) {
            self.delegate!.removeAccelerationListener(listener)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AccelerationBridge executed 'removeAccelerationListener' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AccelerationBridge no delegate for 'removeAccelerationListener'.")
            }
        }
        
    }

    /**
       Removed all existing listeners from receiving acceleration events.

       @since v2.0
    */
    public func removeAccelerationListeners() {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AccelerationBridge executing removeAccelerationListeners.")
        }

        if (self.delegate != nil) {
            self.delegate!.removeAccelerationListeners()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AccelerationBridge executed 'removeAccelerationListeners' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AccelerationBridge no delegate for 'removeAccelerationListeners'.")
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
        var responseCode : Int = 200
        var responseMessage : String = "OK"
        var responseJSON : String? = "null"
        switch request.getMethodName()! {
            case "addAccelerationListener":
                var listener0 : IAccelerationListener? =  AccelerationListenerImpl(id: request.getAsyncId()!)
                self.addAccelerationListener(listener0!);
            case "removeAccelerationListener":
                var listener1 : IAccelerationListener? =  AccelerationListenerImpl(id: request.getAsyncId()!)
                self.removeAccelerationListener(listener1!);
            case "removeAccelerationListeners":
                self.removeAccelerationListeners();
            default:
                // 404 - response null.
                responseCode = 404
                responseMessage = "AccelerationBridge does not provide the function '\(request.getMethodName()!)' Please check your client-side API version; should be API version >= v2.1.1."
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
