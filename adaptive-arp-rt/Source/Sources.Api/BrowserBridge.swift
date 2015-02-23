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
   Interface for Managing the browser operations
   Auto-generated implementation of IBrowser specification.
*/
public class BrowserBridge : BaseUIBridge, IBrowser, APIBridge {

    /**
       API Delegate.
    */
    private var delegate : IBrowser? = nil

    /**
       Constructor with delegate.

       @param delegate The delegate implementing platform specific functions.
    */
    public init(delegate : IBrowser?) {
        super.init()
        self.delegate = delegate
    }
    /**
       Get the delegate implementation.
       @return IBrowser delegate that manages platform specific functions..
    */
    public final func getDelegate() -> IBrowser? {
        return self.delegate
    }
    /**
       Set the delegate implementation.

       @param delegate The delegate implementing platform specific functions.
    */
    public final func setDelegate(delegate : IBrowser) {
        self.delegate = delegate;
    }

    /**
       Method for opening a URL like a link in the native default browser

       @param url Url to open
       @return The result of the operation
       @since v2.0
    */
    public func openExtenalBrowser(url : String ) -> Bool? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.Debug, category: getAPIGroup()!.toString(), message: "BrowserBridge executing openExtenalBrowser('\(url)').")
        }

        var result : Bool? = false
        if (self.delegate != nil) {
            result = self.delegate!.openExtenalBrowser(url)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.Debug, category: getAPIGroup()!.toString(), message: "BrowserBridge executed 'openExtenalBrowser' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.Error, category: getAPIGroup()!.toString(), message: "BrowserBridge no delegate for 'openExtenalBrowser'.")
            }
        }
        return result        
    }

    /**
       Method for opening a browser embedded into the application

       @param url            Url to open
       @param title          Title of the Navigation bar
       @param backButtonText Title of the Back button bar
       @return The result of the operation
       @since v2.0
    */
    public func openInternalBrowser(url : String , title : String , backButtonText : String ) -> Bool? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.Debug, category: getAPIGroup()!.toString(), message: "BrowserBridge executing openInternalBrowser('\(url)','\(title)','\(backButtonText)').")
        }

        var result : Bool? = false
        if (self.delegate != nil) {
            result = self.delegate!.openInternalBrowser(url, title: title, backButtonText: backButtonText)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.Debug, category: getAPIGroup()!.toString(), message: "BrowserBridge executed 'openInternalBrowser' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.Error, category: getAPIGroup()!.toString(), message: "BrowserBridge no delegate for 'openInternalBrowser'.")
            }
        }
        return result        
    }

    /**
       Method for opening a browser embedded into the application in a modal window

       @param url            Url to open
       @param title          Title of the Navigation bar
       @param backButtonText Title of the Back button bar
       @return The result of the operation
       @since v2.0
    */
    public func openInternalBrowserModal(url : String , title : String , backButtonText : String ) -> Bool? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.Debug, category: getAPIGroup()!.toString(), message: "BrowserBridge executing openInternalBrowserModal('\(url)','\(title)','\(backButtonText)').")
        }

        var result : Bool? = false
        if (self.delegate != nil) {
            result = self.delegate!.openInternalBrowserModal(url, title: title, backButtonText: backButtonText)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.Debug, category: getAPIGroup()!.toString(), message: "BrowserBridge executed 'openInternalBrowserModal' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.Error, category: getAPIGroup()!.toString(), message: "BrowserBridge no delegate for 'openInternalBrowserModal'.")
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
            case "openExtenalBrowser":
                var url0 : String? = JSONUtil.unescapeString(request.getParameters()![0])
                var response0 : Bool? = self.openExtenalBrowser(url0!)
                if let response0 = response0 {
                    responseJSON = "\(response0)"
                 } else {
                    responseJSON = "false"
                 }
            case "openInternalBrowser":
                var url1 : String? = JSONUtil.unescapeString(request.getParameters()![0])
                var title1 : String? = JSONUtil.unescapeString(request.getParameters()![1])
                var backButtonText1 : String? = JSONUtil.unescapeString(request.getParameters()![2])
                var response1 : Bool? = self.openInternalBrowser(url1!, title: title1!, backButtonText: backButtonText1!)
                if let response1 = response1 {
                    responseJSON = "\(response1)"
                 } else {
                    responseJSON = "false"
                 }
            case "openInternalBrowserModal":
                var url2 : String? = JSONUtil.unescapeString(request.getParameters()![0])
                var title2 : String? = JSONUtil.unescapeString(request.getParameters()![1])
                var backButtonText2 : String? = JSONUtil.unescapeString(request.getParameters()![2])
                var response2 : Bool? = self.openInternalBrowserModal(url2!, title: title2!, backButtonText: backButtonText2!)
                if let response2 = response2 {
                    responseJSON = "\(response2)"
                 } else {
                    responseJSON = "false"
                 }
            default:
                // 404 - response null.
                responseCode = 404
                responseMessage = "BrowserBridge does not provide the function '\(request.getMethodName()!)' Please check your client-side API version; should be API version >= v2.2.0."
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
