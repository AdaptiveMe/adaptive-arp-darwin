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

    * @version v2.1.5

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Interface for Managing the Globalization results
   Auto-generated implementation of IGlobalization specification.
*/
public class GlobalizationBridge : BaseApplicationBridge, IGlobalization, APIBridge {

    /**
       API Delegate.
    */
    private var delegate : IGlobalization? = nil

    /**
       Constructor with delegate.

       @param delegate The delegate implementing platform specific functions.
    */
    public init(delegate : IGlobalization?) {
        super.init()
        self.delegate = delegate
    }
    /**
       Get the delegate implementation.
       @return IGlobalization delegate that manages platform specific functions..
    */
    public final func getDelegate() -> IGlobalization? {
        return self.delegate
    }
    /**
       Set the delegate implementation.

       @param delegate The delegate implementing platform specific functions.
    */
    public final func setDelegate(delegate : IGlobalization) {
        self.delegate = delegate;
    }

    /**
       Returns the default locale of the application defined in the configuration file

       @return Default Locale of the application
       @since v2.0
    */
    public func getDefaultLocale() -> Locale? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "GlobalizationBridge executing getDefaultLocale.")
        }

        var result : Locale? = nil
        if (self.delegate != nil) {
            result = self.delegate!.getDefaultLocale()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "GlobalizationBridge executed 'getDefaultLocale' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "GlobalizationBridge no delegate for 'getDefaultLocale'.")
            }
        }
        return result        
    }

    /**
       List of supported locales for the application defined in the configuration file

       @return List of locales
       @since v2.0
    */
    public func getLocaleSupportedDescriptors() -> [Locale]? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "GlobalizationBridge executing getLocaleSupportedDescriptors.")
        }

        var result : [Locale]? = nil
        if (self.delegate != nil) {
            result = self.delegate!.getLocaleSupportedDescriptors()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "GlobalizationBridge executed 'getLocaleSupportedDescriptors' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "GlobalizationBridge no delegate for 'getLocaleSupportedDescriptors'.")
            }
        }
        return result        
    }

    /**
       Gets the text/message corresponding to the given key and locale.

       @param key    to match text
       @param locale The locale object to get localized message, or the locale desciptor ("language" or "language-country" two-letters ISO codes.
       @return Localized text.
       @since v2.0
    */
    public func getResourceLiteral(key : String , locale : Locale ) -> String? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "GlobalizationBridge executing getResourceLiteral('\(key)','\(locale)').")
        }

        var result : String? = nil
        if (self.delegate != nil) {
            result = self.delegate!.getResourceLiteral(key, locale: locale)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "GlobalizationBridge executed 'getResourceLiteral' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "GlobalizationBridge no delegate for 'getResourceLiteral'.")
            }
        }
        return result        
    }

    /**
       Gets the full application configured literals (key/message pairs) corresponding to the given locale.

       @param locale The locale object to get localized message, or the locale desciptor ("language" or "language-country" two-letters ISO codes.
       @return Localized texts in the form of an object.
       @since v2.0
    */
    public func getResourceLiterals(locale : Locale ) -> [KeyPair]? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "GlobalizationBridge executing getResourceLiterals('\(locale)').")
        }

        var result : [KeyPair]? = nil
        if (self.delegate != nil) {
            result = self.delegate!.getResourceLiterals(locale)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "GlobalizationBridge executed 'getResourceLiterals' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "GlobalizationBridge no delegate for 'getResourceLiterals'.")
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
            case "getDefaultLocale":
                var response0 : Locale? = self.getDefaultLocale()
                if let response0 = response0 {
                    responseJSON = Locale.Serializer.toJSON(response0)
                } else {
                    responseJSON = "null"
                }
            case "getLocaleSupportedDescriptors":
                var response1 : [Locale]? = self.getLocaleSupportedDescriptors()
                if let response1 = response1 {
                    var response1JSONArray : NSMutableString = NSMutableString()
                    response1JSONArray.appendString("[ ")
                    for (index, obj) in enumerate(response1) {
                        response1JSONArray.appendString(Locale.Serializer.toJSON(obj))
                        if index < response1.count-1 {
                            response1JSONArray.appendString(", ")
                        }
                    }
                    response1JSONArray.appendString(" ]")
                    responseJSON = response1JSONArray as String
                } else {
                    responseJSON = "null"
                }
            case "getResourceLiteral":
                var key2 : String? = JSONUtil.unescapeString(request.getParameters()![0])
                var locale2 : Locale? = Locale.Serializer.fromJSON(request.getParameters()![1])
                var response2 : String? = self.getResourceLiteral(key2!, locale: locale2!)
                if let response2 = response2 {
                    responseJSON = "\(response2)"
                } else {
                    responseJSON = "null"
                }
            case "getResourceLiterals":
                var locale3 : Locale? = Locale.Serializer.fromJSON(request.getParameters()![0])
                var response3 : [KeyPair]? = self.getResourceLiterals(locale3!)
                if let response3 = response3 {
                    var response3JSONArray : NSMutableString = NSMutableString()
                    response3JSONArray.appendString("[ ")
                    for (index, obj) in enumerate(response3) {
                        response3JSONArray.appendString(KeyPair.Serializer.toJSON(obj))
                        if index < response3.count-1 {
                            response3JSONArray.appendString(", ")
                        }
                    }
                    response3JSONArray.appendString(" ]")
                    responseJSON = response3JSONArray as String
                } else {
                    responseJSON = "null"
                }
            default:
                // 404 - response null.
                responseCode = 404
                responseMessage = "GlobalizationBridge does not provide the function '\(request.getMethodName()!)' Please check your client-side API version; should be API version >= v2.1.5."
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
