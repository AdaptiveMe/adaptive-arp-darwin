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
   Interface for Managing the Telephony operations
   Auto-generated implementation of ITelephony specification.
*/
public class TelephonyBridge : BaseCommunicationBridge, ITelephony, APIBridge {

    /**
       API Delegate.
    */
    private var delegate : ITelephony? = nil

    /**
       Constructor with delegate.

       @param delegate The delegate implementing platform specific functions.
    */
    public init(delegate : ITelephony?) {
        super.init()
        self.delegate = delegate
    }
    /**
       Get the delegate implementation.
       @return ITelephony delegate that manages platform specific functions..
    */
    public final func getDelegate() -> ITelephony? {
        return self.delegate
    }
    /**
       Set the delegate implementation.

       @param delegate The delegate implementing platform specific functions.
    */
    public final func setDelegate(delegate : ITelephony) {
        self.delegate = delegate;
    }

    /**
       Invoke a phone call

       @param number to call
       @return Status of the call
       @since v2.0
    */
    public func call(number : String ) -> ITelephonyStatus? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "TelephonyBridge executing call('\(number)').")
        }

        var result : ITelephonyStatus? = nil
        if (self.delegate != nil) {
            result = self.delegate!.call(number)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "TelephonyBridge executed 'call' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "TelephonyBridge no delegate for 'call'.")
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
            case "call":
                var number0 : String? = JSONUtil.unescapeString(request.getParameters()![0])
                var response0 : ITelephonyStatus? = self.call(number0!)
                if let response0 = response0 {
                    responseJSON = "{ \"value\": \"\(response0.toString())\" }"
                } else {
                    responseJSON = "{ \"value\": \"Unknown\" }"
                }
            default:
                // 404 - response null.
                responseCode = 404
                responseMessage = "TelephonyBridge does not provide the function '\(request.getMethodName()!)' Please check your client-side API version; should be API version >= v2.0.6."
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
