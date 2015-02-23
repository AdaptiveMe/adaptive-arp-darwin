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

    * @version v2.2.0

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Interface for Managing the Network status
   Auto-generated implementation of INetworkStatus specification.
*/
public class NetworkStatusBridge : BaseCommunicationBridge, INetworkStatus, APIBridge {

    /**
       API Delegate.
    */
    private var delegate : INetworkStatus? = nil

    /**
       Constructor with delegate.

       @param delegate The delegate implementing platform specific functions.
    */
    public init(delegate : INetworkStatus?) {
        super.init()
        self.delegate = delegate
    }
    /**
       Get the delegate implementation.
       @return INetworkStatus delegate that manages platform specific functions..
    */
    public final func getDelegate() -> INetworkStatus? {
        return self.delegate
    }
    /**
       Set the delegate implementation.

       @param delegate The delegate implementing platform specific functions.
    */
    public final func setDelegate(delegate : INetworkStatus) {
        self.delegate = delegate;
    }

    /**
       Add the listener for network status changes of the app

       @param listener Listener with the result
       @since v2.0
    */
    public func addNetworkStatusListener(listener : INetworkStatusListener ) {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.Debug, category: getAPIGroup()!.toString(), message: "NetworkStatusBridge executing addNetworkStatusListener('\(listener)').")
        }

        if (self.delegate != nil) {
            self.delegate!.addNetworkStatusListener(listener)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.Debug, category: getAPIGroup()!.toString(), message: "NetworkStatusBridge executed 'addNetworkStatusListener' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.Error, category: getAPIGroup()!.toString(), message: "NetworkStatusBridge no delegate for 'addNetworkStatusListener'.")
            }
        }
        
    }

    /**
       Un-registers an existing listener from receiving network status events.

       @param listener Listener with the result
       @since v2.0
    */
    public func removeNetworkStatusListener(listener : INetworkStatusListener ) {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.Debug, category: getAPIGroup()!.toString(), message: "NetworkStatusBridge executing removeNetworkStatusListener('\(listener)').")
        }

        if (self.delegate != nil) {
            self.delegate!.removeNetworkStatusListener(listener)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.Debug, category: getAPIGroup()!.toString(), message: "NetworkStatusBridge executed 'removeNetworkStatusListener' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.Error, category: getAPIGroup()!.toString(), message: "NetworkStatusBridge no delegate for 'removeNetworkStatusListener'.")
            }
        }
        
    }

    /**
       Removes all existing listeners from receiving network status events.

       @since v2.0
    */
    public func removeNetworkStatusListeners() {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.Debug, category: getAPIGroup()!.toString(), message: "NetworkStatusBridge executing removeNetworkStatusListeners.")
        }

        if (self.delegate != nil) {
            self.delegate!.removeNetworkStatusListeners()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.Debug, category: getAPIGroup()!.toString(), message: "NetworkStatusBridge executed 'removeNetworkStatusListeners' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.Error, category: getAPIGroup()!.toString(), message: "NetworkStatusBridge no delegate for 'removeNetworkStatusListeners'.")
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
            case "addNetworkStatusListener":
                var listener0 : INetworkStatusListener? =  NetworkStatusListenerImpl(id: request.getAsyncId()!)
                self.addNetworkStatusListener(listener0!);
            case "removeNetworkStatusListener":
                var listener1 : INetworkStatusListener? =  NetworkStatusListenerImpl(id: request.getAsyncId()!)
                self.removeNetworkStatusListener(listener1!);
            case "removeNetworkStatusListeners":
                self.removeNetworkStatusListeners();
            default:
                // 404 - response null.
                responseCode = 404
                responseMessage = "NetworkStatusBridge does not provide the function '\(request.getMethodName()!)' Please check your client-side API version; should be API version >= v2.2.0."
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
