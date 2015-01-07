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
   Interface for webview context management purposes
   Auto-generated implementation of IAppContextWebview specification.
*/
public class AppContextWebviewBridge : NSObject, IAppContextWebview {

    /**
       Group of API.
    */
    private var apiGroup : IAdaptiveRPGroup = IAdaptiveRPGroup.Kernel;

    public func getAPIGroup() -> IAdaptiveRPGroup {
        return self.apiGroup
    }

    /**
       API Delegate.
    */
    private var delegate : IAppContextWebview? = nil

    /**
       Constructor with delegate.

       @param delegate The delegate implementing platform specific functions.
    */
    public init(delegate : IAppContextWebview?) {
        super.init()
        self.delegate = delegate
    }
    /**
       Get the delegate implementation.
       @return IAppContextWebview delegate that manages platform specific functions..
    */
    public final func getDelegate() -> IAppContextWebview? {
        return self.delegate
    }
    /**
       Set the delegate implementation.

       @param delegate The delegate implementing platform specific functions.
    */
    public final func setDelegate(delegate : IAppContextWebview) {
        self.delegate = delegate;
    }

    /**
       Additional views may be added to an application - a separate activity - and if these will make calls to the
ARP methods, they must be registered by adding them to the context. When they are added to the context, ARP
methods are bound to the webview so that they're callable from the HTML application. The primary webview should
not be added using this method.

       @param webView Platform specific webview reference (WebView, UIWebView, WKWebView,etc.)
       @since ARP1.0
    */
    public func addWebview(webView : AnyObject ) {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup().toString(), message: "AppContextWebviewBridge executing addWebview({\(webView)}).")
        }

        if (self.delegate != nil) {
            self.delegate!.addWebview(webView)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup().toString(), message: "AppContextWebviewBridge executed 'addWebview' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup().toString(), message: "AppContextWebviewBridge no delegate for 'addWebview'.")
            }
        }
        
    }

    /**
       Evaluate the specified javascript on the main webview of the application.

       @param javaScriptText    The javascript expression to execute on the webview.
    */
    public func executeJavaScript(javaScriptText : String ) {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup().toString(), message: "AppContextWebviewBridge executing executeJavaScript({\(javaScriptText)}).")
        }

        if (self.delegate != nil) {
            self.delegate!.executeJavaScript(javaScriptText)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup().toString(), message: "AppContextWebviewBridge executed 'executeJavaScript' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup().toString(), message: "AppContextWebviewBridge no delegate for 'executeJavaScript'.")
            }
        }
        
    }

    /**
       Evaluate the specified javascript on the specified webview of the application.

       @param javaScriptText    The javascript expression to execute on the webview.
       @param webViewReference  The target webview on which to execute the expression.
    */
    public func executeJavaScript(javaScriptText : String , webViewReference : AnyObject ) {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup().toString(), message: "AppContextWebviewBridge executing executeJavaScript({\(javaScriptText)},{\(webViewReference)}).")
        }

        if (self.delegate != nil) {
            self.delegate!.executeJavaScript(javaScriptText, webViewReference: webViewReference)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup().toString(), message: "AppContextWebviewBridge executed 'executeJavaScript' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup().toString(), message: "AppContextWebviewBridge no delegate for 'executeJavaScript'.")
            }
        }
        
    }

    /**
       Returns a reference to the main application webview. This is the first application webview and can not be removed
with the removeWebview method. The object returned should be cast to the platform specific implementation
WebView, WKWebView, etc.

       @return Object representing the specific and primary webview instance of the application.
       @since ARP1.0
    */
    public func getWebviewPrimary() -> AnyObject? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup().toString(), message: "AppContextWebviewBridge executing getWebviewPrimary.")
        }

        var result : AnyObject? = nil
        if (self.delegate != nil) {
            result = self.delegate!.getWebviewPrimary()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup().toString(), message: "AppContextWebviewBridge executed 'getWebviewPrimary' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup().toString(), message: "AppContextWebviewBridge no delegate for 'getWebviewPrimary'.")
            }
        }
        return result!        
    }

    /**
       Returns an array of webviews currently managed by the context - composed of primary and the list of those added.
This method will always return at least one element; the primary webview.

       @return Array with all the Webview instances being managed by ARP.
       @since ARP1.0
    */
    public func getWebviews() -> [AnyObject]? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup().toString(), message: "AppContextWebviewBridge executing getWebviews.")
        }

        var result : [AnyObject]? = nil
        if (self.delegate != nil) {
            result = self.delegate!.getWebviews()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup().toString(), message: "AppContextWebviewBridge executed 'getWebviews' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup().toString(), message: "AppContextWebviewBridge no delegate for 'getWebviews'.")
            }
        }
        return result!        
    }

    /**
       When a webview is disposed - no longer in use from an external activity - the webview should be removed to unbind
ARP functions and release resources. The primary webview can not be removed.

       @param webView The instance of the webview to be removed from the binding.
       @since ARP1.0
    */
    public func removeWebview(webView : AnyObject ) {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup().toString(), message: "AppContextWebviewBridge executing removeWebview({\(webView)}).")
        }

        if (self.delegate != nil) {
            self.delegate!.removeWebview(webView)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup().toString(), message: "AppContextWebviewBridge executed 'removeWebview' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup().toString(), message: "AppContextWebviewBridge no delegate for 'removeWebview'.")
            }
        }
        
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
