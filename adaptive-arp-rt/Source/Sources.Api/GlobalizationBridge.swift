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

    * @version v2.0.2

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
       List of supported locales for the application

       @return List of locales
       @since ARP1.0
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
        return result!        
    }

    /**
       Gets the text/message corresponding to the given key and locale.

       @param key    to match text
       @param locale The locale object to get localized message, or the locale desciptor ("language" or "language-country" two-letters ISO codes.
       @return Localized text.
       @since ARP1.0
    */
    public func getResourceLiteral(key : String , locale : Locale ) -> String? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "GlobalizationBridge executing getResourceLiteral({\(key)},{\(locale)}).")
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
        return result!        
    }

    /**
       Gets the full application configured literals (key/message pairs) corresponding to the given locale.

       @param locale The locale object to get localized message, or the locale desciptor ("language" or "language-country" two-letters ISO codes.
       @return Localized texts in the form of an object.
       @since ARP1.0
    */
    public func getResourceLiterals(locale : Locale ) -> [KeyPair]? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "GlobalizationBridge executing getResourceLiterals({\(locale)}).")
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
        return result!        
    }

    /**
       Invokes the given method specified in the API request object.

       @param request APIRequest object containing method name and parameters.
       @return String with JSON response or a zero length string if the response is asynchronous or null if method not found.
    */
    public override func invoke(request : APIRequest) -> String? {
        var responseJSON : String? = ""
        switch request.getMethodName()! {
            case "getLocaleSupportedDescriptors":
                var response0 : [Locale]? = self.getLocaleSupportedDescriptors()
                if let response0 = response0 {
                    var response0JSONArray : NSMutableString = NSMutableString()
                    response0JSONArray.appendString("{[ ")
                    for (index, obj) in enumerate(response0) {
                        response0JSONArray.appendString(Locale.Serializer.toJSON(obj))
                        if index < response0.count-1 {
                            response0JSONArray.appendString(", ")
                        }
                    }
                    response0JSONArray.appendString(" ]}")
                    responseJSON = response0JSONArray as String
                } else {
                    responseJSON = "{ null }"
                }
            case "getResourceLiteral":
                var key1 : String? = request.getParameters()![0]
                var locale1 : Locale? = Locale.Serializer.fromJSON(request.getParameters()![1])
                var response1 : String? = self.getResourceLiteral(key1!, locale: locale1!)
                if let response1 = response1 {
                    responseJSON = "{ \"\(response1)\" }"
                } else {
                    responseJSON = "{ null }"
                }
            case "getResourceLiterals":
                var locale2 : Locale? = Locale.Serializer.fromJSON(request.getParameters()![0])
                var response2 : [KeyPair]? = self.getResourceLiterals(locale2!)
                if let response2 = response2 {
                    var response2JSONArray : NSMutableString = NSMutableString()
                    response2JSONArray.appendString("{[ ")
                    for (index, obj) in enumerate(response2) {
                        response2JSONArray.appendString(KeyPair.Serializer.toJSON(obj))
                        if index < response2.count-1 {
                            response2JSONArray.appendString(", ")
                        }
                    }
                    response2JSONArray.appendString(" ]}")
                    responseJSON = response2JSONArray as String
                } else {
                    responseJSON = "{ null }"
                }
            default:
                // 404 - response null.
                responseJSON = nil
        }
        return responseJSON
    }
}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
