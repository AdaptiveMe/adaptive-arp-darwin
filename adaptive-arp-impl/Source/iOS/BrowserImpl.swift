/*
* =| ADAPTIVE RUNTIME PLATFORM |=======================================================================================
*
* (C) Copyright 2013-2014 Carlos Lozano Diez t/a Adaptive.me <http://adaptive.me>.
*
* Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with
* the License. You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
* an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the
* specific language governing permissions and limitations under the License.
*
* Original author:
*
*     * Carlos Lozano Diez
*                 <http://github.com/carloslozano>
*                 <http://twitter.com/adaptivecoder>
*                 <mailto:carlos@adaptive.me>
*
* Contributors:
*
*     * Ferran Vila Conesa
*                 <http://github.com/fnva>
*                 <http://twitter.com/ferran_vila>
*                 <mailto:ferran.vila.conesa@gmail.com>
*
* =====================================================================================================================
*/

import Foundation
import AdaptiveArpApi
import UIKit

public class BrowserImpl : NSObject, IBrowser {
    
    /// Logging variable
    let logger : ILogging = LoggingImpl()
    let loggerTag : String = "BrowserImpl"
    
    var application:UIApplication
    
    /**
    Class constructor
    */
    override public init() {
        
        application = (AppRegistryImpl.sharedInstance.getPlatformContext()! as AppContextImpl).getContext() as UIApplication
    }
    public func openBrowser(url : String, title : String, buttonText : String) -> Bool {
        return self.openBrowser(url, title: title, buttonText: buttonText, showNavBar: true)
    }
    
    public func openBrowser(url : String, title : String, buttonText : String, showNavBar : Bool) -> Bool {
        return self.openBrowser(url, title: title, buttonText: buttonText, showNavBar: showNavBar, showAnimated: true)
    }
    /**
    Open a new window showing the url webpage with a title and a close button displaying the desired text
    
    :param: url        to open
    :param: title      of the new window
    :param: buttonText text of the close button
    
    :returns: true if the new window opens;false otherwise
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func openBrowser(url : String, title : String, buttonText : String, showNavBar : Bool, showAnimated: Bool) -> Bool {
        
        // TODO: use the title and the button text attibutes
        // TODO: check if the browser has to be embedded into a webview inside the application
        
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
        
        // Check if it is possible to open the url
        if !application.canOpenURL(url) {
            
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "The url: \(url) is not possible to open by the application")
            return false
        }
        
        // Make the call - open external browser
        /*
        let result: Bool =  application.openURL(url)
        if !result {
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "It is not posible to open the url")
            return false
        }
        */
        if (BaseViewController.ViewCurrent.getView() != nil) {
            return (BaseViewController.ViewCurrent.getView()! as BaseViewController).showInternalBrowser(title, backLabel: buttonText, url: url, showNavBar: showNavBar, showAnimated: showAnimated)
        } else {
            return false
        }
    }
}
