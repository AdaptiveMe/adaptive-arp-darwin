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

    * @version v2.0.8

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Interface for Managing the Logging operations
   Auto-generated implementation of ILogging specification.
*/
public class LoggingBridge : BaseUtilBridge, ILogging, APIBridge {

    /**
       API Delegate.
    */
    private var delegate : ILogging? = nil

    /**
       Constructor with delegate.

       @param delegate The delegate implementing platform specific functions.
    */
    public init(delegate : ILogging?) {
        super.init()
        self.delegate = delegate
    }
    /**
       Get the delegate implementation.
       @return ILogging delegate that manages platform specific functions..
    */
    public final func getDelegate() -> ILogging? {
        return self.delegate
    }
    /**
       Set the delegate implementation.

       @param delegate The delegate implementing platform specific functions.
    */
    public final func setDelegate(delegate : ILogging) {
        self.delegate = delegate;
    }

    /**
       Logs the given message, with the given log level if specified, to the standard platform/environment.

       @param level   Log level
       @param message Message to be logged
       @since v2.0
    */
    public func log(level : ILoggingLogLevel , message : String ) {
        if (self.delegate != nil) {
            self.delegate!.log(level, message: message)
        }
    }

    /**
       Logs the given message, with the given log level if specified, to the standard platform/environment.

       @param level    Log level
       @param category Category/tag name to identify/filter the log.
       @param message  Message to be logged
       @since v2.0
    */
    public func log(level : ILoggingLogLevel , category : String , message : String ) {
        if (self.delegate != nil) {
            self.delegate!.log(level, category: category, message: message)
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
            case "log_level_message":
                var level0 : ILoggingLogLevel? = ILoggingLogLevel.toEnum(JSONUtil.dictionifyJSON(request.getParameters()![0])["value"] as String!)
                var message0 : String? = JSONUtil.unescapeString(request.getParameters()![1])
                self.log(level0!, message: message0!);
            case "log_level_category_message":
                var level1 : ILoggingLogLevel? = ILoggingLogLevel.toEnum(JSONUtil.dictionifyJSON(request.getParameters()![0])["value"] as String!)
                var category1 : String? = JSONUtil.unescapeString(request.getParameters()![1])
                var message1 : String? = JSONUtil.unescapeString(request.getParameters()![2])
                self.log(level1!, category: category1!, message: message1!);
            default:
                // 404 - response null.
                responseCode = 404
                responseMessage = "LoggingBridge does not provide the function '\(request.getMethodName()!)' Please check your client-side API version; should be API version >= v2.0.8."
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
