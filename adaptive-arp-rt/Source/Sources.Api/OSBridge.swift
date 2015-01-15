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

    * @version v2.0.3

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Interface for Managing the OS operations
   Auto-generated implementation of IOS specification.
*/
public class OSBridge : BaseSystemBridge, IOS, APIBridge {

    /**
       API Delegate.
    */
    private var delegate : IOS? = nil

    /**
       Constructor with delegate.

       @param delegate The delegate implementing platform specific functions.
    */
    public init(delegate : IOS?) {
        super.init()
        self.delegate = delegate
    }
    /**
       Get the delegate implementation.
       @return IOS delegate that manages platform specific functions..
    */
    public final func getDelegate() -> IOS? {
        return self.delegate
    }
    /**
       Set the delegate implementation.

       @param delegate The delegate implementing platform specific functions.
    */
    public final func setDelegate(delegate : IOS) {
        self.delegate = delegate;
    }

    /**
       Returns the OSInfo for the current operating system.

       @return OSInfo with name, version and vendor of the OS.
       @since ARP1.0
    */
    public func getOSInfo() -> OSInfo? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "OSBridge executing getOSInfo.")
        }

        var result : OSInfo? = nil
        if (self.delegate != nil) {
            result = self.delegate!.getOSInfo()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "OSBridge executed 'getOSInfo' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "OSBridge no delegate for 'getOSInfo'.")
            }
        }
        return result!        
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
            case "getOSInfo":
                var response0 : OSInfo? = self.getOSInfo()
                if let response0 = response0 {
                    responseJSON = OSInfo.Serializer.toJSON(response0)
                } else {
                    responseJSON = "null"
                }
            default:
                // 404 - response null.
                responseCode = 404
                responseMessage = "OSBridge does not provide the function '\(request.getMethodName()!)' Please check your client-side API version; should be API version >= v2.0.3."
        }
        response.setResponse(JSONUtil.escapeString(responseJSON!))
        response.setStatusCode(responseCode)
        response.setStatusMessage(responseMessage)
        return response
    }
}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
