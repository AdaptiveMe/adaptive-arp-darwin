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
       @since ARP1.0
    */
    public func openExtenalBrowser(url : String ) -> Bool? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "BrowserBridge executing openExtenalBrowser({\(url)}).")
        }

        var result : Bool? = false
        if (self.delegate != nil) {
            result = self.delegate!.openExtenalBrowser(url)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "BrowserBridge executed 'openExtenalBrowser' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "BrowserBridge no delegate for 'openExtenalBrowser'.")
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
       @since ARP1.0
    */
    public func openInternalBrowser(url : String , title : String , backButtonText : String ) -> Bool? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "BrowserBridge executing openInternalBrowser({\(url)},{\(title)},{\(backButtonText)}).")
        }

        var result : Bool? = false
        if (self.delegate != nil) {
            result = self.delegate!.openInternalBrowser(url, title: title, backButtonText: backButtonText)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "BrowserBridge executed 'openInternalBrowser' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "BrowserBridge no delegate for 'openInternalBrowser'.")
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
       @since ARP1.0
    */
    public func openInternalBrowserModal(url : String , title : String , backButtonText : String ) -> Bool? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "BrowserBridge executing openInternalBrowserModal({\(url)},{\(title)},{\(backButtonText)}).")
        }

        var result : Bool? = false
        if (self.delegate != nil) {
            result = self.delegate!.openInternalBrowserModal(url, title: title, backButtonText: backButtonText)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "BrowserBridge executed 'openInternalBrowserModal' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "BrowserBridge no delegate for 'openInternalBrowserModal'.")
            }
        }
        return result        
    }

    /**
       Invokes the given method specified in the API request object.

       @param request APIRequest object containing method name and parameters.
       @return String with JSON response or a zero length string if the response is asynchronous or null if method not found.
    */
    public override func invoke(request : APIRequest) -> String? {
        var responseJSON : String? = ""
        switch request.getMethodName()! {
            case "openExtenalBrowser":
                var url0 : String? = request.getParameters()![0]
                var response0 : Bool? = self.openExtenalBrowser(url0!)
                responseJSON = nil //TODO - Serialize this.gson.toJson(response0);
            case "openInternalBrowser":
                var url1 : String? = request.getParameters()![0]
                var title1 : String? = request.getParameters()![1]
                var backButtonText1 : String? = request.getParameters()![2]
                var response1 : Bool? = self.openInternalBrowser(url1!, title: title1!, backButtonText: backButtonText1!)
                responseJSON = nil //TODO - Serialize this.gson.toJson(response1);
            case "openInternalBrowserModal":
                var url2 : String? = request.getParameters()![0]
                var title2 : String? = request.getParameters()![1]
                var backButtonText2 : String? = request.getParameters()![2]
                var response2 : Bool? = self.openInternalBrowserModal(url2!, title: title2!, backButtonText: backButtonText2!)
                responseJSON = nil //TODO - Serialize this.gson.toJson(response2);
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
