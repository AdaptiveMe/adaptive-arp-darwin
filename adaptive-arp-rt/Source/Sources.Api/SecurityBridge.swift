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

    * @version v2.0.6

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Interface for Managing the Security operations
   Auto-generated implementation of ISecurity specification.
*/
public class SecurityBridge : BaseSecurityBridge, ISecurity, APIBridge {

    /**
       API Delegate.
    */
    private var delegate : ISecurity? = nil

    /**
       Constructor with delegate.

       @param delegate The delegate implementing platform specific functions.
    */
    public init(delegate : ISecurity?) {
        super.init()
        self.delegate = delegate
    }
    /**
       Get the delegate implementation.
       @return ISecurity delegate that manages platform specific functions..
    */
    public final func getDelegate() -> ISecurity? {
        return self.delegate
    }
    /**
       Set the delegate implementation.

       @param delegate The delegate implementing platform specific functions.
    */
    public final func setDelegate(delegate : ISecurity) {
        self.delegate = delegate;
    }

    /**
       Deletes from the device internal storage the entry/entries containing the specified key names.

       @param keys             Array with the key names to delete.
       @param publicAccessName The name of the shared internal storage object (if needed).
       @param callback         callback to be executed upon function result.
       @since v2.0
    */
    public func deleteSecureKeyValuePairs(keys : [String] , publicAccessName : String , callback : ISecurityResultCallback ) {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "SecurityBridge executing deleteSecureKeyValuePairs('\(keys)','\(publicAccessName)','\(callback)').")
        }

        if (self.delegate != nil) {
            self.delegate!.deleteSecureKeyValuePairs(keys, publicAccessName: publicAccessName, callback: callback)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "SecurityBridge executed 'deleteSecureKeyValuePairs' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "SecurityBridge no delegate for 'deleteSecureKeyValuePairs'.")
            }
        }
        
    }

    /**
       Retrieves from the device internal storage the entry/entries containing the specified key names.

       @param keys             Array with the key names to retrieve.
       @param publicAccessName The name of the shared internal storage object (if needed).
       @param callback         callback to be executed upon function result.
       @since v2.0
    */
    public func getSecureKeyValuePairs(keys : [String] , publicAccessName : String , callback : ISecurityResultCallback ) {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "SecurityBridge executing getSecureKeyValuePairs('\(keys)','\(publicAccessName)','\(callback)').")
        }

        if (self.delegate != nil) {
            self.delegate!.getSecureKeyValuePairs(keys, publicAccessName: publicAccessName, callback: callback)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "SecurityBridge executed 'getSecureKeyValuePairs' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "SecurityBridge no delegate for 'getSecureKeyValuePairs'.")
            }
        }
        
    }

    /**
       Returns if the device has been modified in anyhow

       @return true if the device has been modified; false otherwise
       @since v2.0
    */
    public func isDeviceModified() -> Bool? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "SecurityBridge executing isDeviceModified.")
        }

        var result : Bool? = false
        if (self.delegate != nil) {
            result = self.delegate!.isDeviceModified()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "SecurityBridge executed 'isDeviceModified' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "SecurityBridge no delegate for 'isDeviceModified'.")
            }
        }
        return result        
    }

    /**
       Stores in the device internal storage the specified item/s.

       @param keyValues        Array containing the items to store on the device internal memory.
       @param publicAccessName The name of the shared internal storage object (if needed).
       @param callback         callback to be executed upon function result.
       @since v2.0
    */
    public func setSecureKeyValuePairs(keyValues : [SecureKeyPair] , publicAccessName : String , callback : ISecurityResultCallback ) {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "SecurityBridge executing setSecureKeyValuePairs('\(keyValues)','\(publicAccessName)','\(callback)').")
        }

        if (self.delegate != nil) {
            self.delegate!.setSecureKeyValuePairs(keyValues, publicAccessName: publicAccessName, callback: callback)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "SecurityBridge executed 'setSecureKeyValuePairs' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "SecurityBridge no delegate for 'setSecureKeyValuePairs'.")
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
            case "deleteSecureKeyValuePairs":
                var keys0 : [String]? = [String]()
                var keysArray0 : [String] = JSONUtil.stringElementToArray(request.getParameters()![0])
                for keysElement0 in keysArray0 {
                    keys0!.append(keysElement0)
                }
                var publicAccessName0 : String? = JSONUtil.unescapeString(request.getParameters()![1])
                var callback0 : ISecurityResultCallback? =  SecurityResultCallbackImpl(id: request.getAsyncId()!)
                self.deleteSecureKeyValuePairs(keys0!, publicAccessName: publicAccessName0!, callback: callback0!);
            case "getSecureKeyValuePairs":
                var keys1 : [String]? = [String]()
                var keysArray1 : [String] = JSONUtil.stringElementToArray(request.getParameters()![0])
                for keysElement1 in keysArray1 {
                    keys1!.append(keysElement1)
                }
                var publicAccessName1 : String? = JSONUtil.unescapeString(request.getParameters()![1])
                var callback1 : ISecurityResultCallback? =  SecurityResultCallbackImpl(id: request.getAsyncId()!)
                self.getSecureKeyValuePairs(keys1!, publicAccessName: publicAccessName1!, callback: callback1!);
            case "isDeviceModified":
                var response2 : Bool? = self.isDeviceModified()
                if let response2 = response2 {
                    responseJSON = "\(response2)"
                 } else {
                    responseJSON = "false"
                 }
            case "setSecureKeyValuePairs":
                var keyValues3 : [SecureKeyPair]? = [SecureKeyPair]()
                var keyValuesArray3 : [String] = JSONUtil.stringElementToArray(request.getParameters()![0])
                for keyValuesElement3 in keyValuesArray3 {
                    keyValues3!.append(SecureKeyPair.Serializer.fromJSON(keyValuesElement3))
                }
                var publicAccessName3 : String? = JSONUtil.unescapeString(request.getParameters()![1])
                var callback3 : ISecurityResultCallback? =  SecurityResultCallbackImpl(id: request.getAsyncId()!)
                self.setSecureKeyValuePairs(keyValues3!, publicAccessName: publicAccessName3!, callback: callback3!);
            default:
                // 404 - response null.
                responseCode = 404
                responseMessage = "SecurityBridge does not provide the function '\(request.getMethodName()!)' Please check your client-side API version; should be API version >= v2.0.6."
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
