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
#if os(iOS)
    import UIKit
#endif
#if os(OSX)
    import AppKit
#endif

/**
   Interface for Managing the browser operations
   Auto-generated implementation of IBrowser specification.
*/
public class BrowserDelegate : BaseUIDelegate, IBrowser {

    /// Logger variable
    let logger : ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge()
    let loggerTag : String = "BrowserDelegate"
    
    /// Application variable
    #if os(iOS)
        var application:UIApplication? = nil
    #endif
    #if os(OSX)
        var workspace:NSWorkspace? = nil
    #endif

    /**
       Default Constructor.
    */
    public override init() {
        super.init()
        #if os(iOS)
            self.application = (AppRegistryBridge.sharedInstance.getPlatformContext().getContext() as UIApplication)
        #endif
        #if os(OSX)
            self.workspace = NSWorkspace.sharedWorkspace()
        #endif
    }

    /**
       Method for opening a URL like a link in the native default browser

       @param url Url to open
       @return The result of the operation
       @since ARP1.0
    */
    public func openExtenalBrowser(url : String) -> Bool? {
        
        if checkURl(url) {
            #if os(iOS)
                let result: Bool =  application!.openURL(NSURL(string: url)!)
            #endif
            #if os(OSX)
                let result: Bool =  workspace!.openURL(NSURL(string: url)!)
            #endif
            if !result {
                logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "It is not posible to open the url")
                return false
            } else {
                return true
            }
        } else {
            return false
        }
    }

    /**
       Method for opening a browser embedded into the application

       @param url            Url to open
       @param title          Title of the Navigation bar
       @param backButtonText Title of the Back button bar
       @return The result of the operation
       @since ARP1.0
    */
    public func openInternalBrowser(url : String, title : String, backButtonText : String) -> Bool? {
        
        #if os(iOS)
            
            if checkURl(url) {
                if (BaseViewController.ViewCurrent.getView() != nil) {
                    return (BaseViewController.ViewCurrent.getView()! as BaseViewController).showInternalBrowser(title, backLabel: backButtonText, url: NSURL(string: url)!, showNavBar: true, showAnimated: true, modal: false)
                } else {
                    return false
                }
            } else {
                return false
            }
            
        #endif
        #if os(OSX)
            
            // TODO: implement this part when the OSX part has a Base View Controller
            return false
            
        #endif
    }

    /**
       Method for opening a browser embedded into the application in a modal window

       @param url            Url to open
       @param title          Title of the Navigation bar
       @param backButtonText Title of the Back button bar
       @return The result of the operation
       @since ARP1.0
    */
    public func openInternalBrowserModal(url : String, title : String, backButtonText : String) -> Bool? {
        
        #if os(iOS)
            
            if checkURl(url) {
                if (BaseViewController.ViewCurrent.getView() != nil) {
                    return (BaseViewController.ViewCurrent.getView()! as BaseViewController).showInternalBrowser(title, backLabel: backButtonText, url: NSURL(string: url)!, showNavBar: true, showAnimated: true, modal: true)
                } else {
                    return false
                }
            } else {
                return false
            }
            
        #endif
        #if os(OSX)
            
            // TODO: implement this part when the OSX part has a Base View Controller
            return false
            
        #endif
    }

    /**
       Private method to check if an application is able to open an url

       @param url  Url to check
       @return The result of the operation
    */
    private func checkURl(url: String) -> Bool {
        // Check if the string is empty
        if url.isEmpty {
            return false
        }
        // Check the correct format of the number
        if !Utils.validateUrl(url) {
            
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "The url: \(url) has an incorrect format")
            return false
        }
        let url: NSURL = NSURL(string: url)!
        
        #if os(iOS)
            
            // Check if it is possible to open the url
            if !application!.canOpenURL(url) {
                
                logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "The application cannot open this type of url: \(url)")
                return false
            }
            
        #endif
        #if os(OSX)
            // There is no way to determine if an osx app can open a url
        #endif
        
        return true
    }
}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
