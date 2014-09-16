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
#if os(iOS)
    import UIKit
#elseif os(OSX)
    import Cocoa
#endif

public class BrowserImpl : IBrowser {
    
    /// Logging variable
    let logger : ILogging = LoggingImpl()
    
    #if os(iOS)
        var application:UIApplication
    #elseif os(OSX)
        var application:NSApplication
    #endif
    
    /**
    Class constructor
    */
    init() {
        
        #if os(iOS)
            application = AppContextImpl().getContext() as UIApplication
        #elseif os(OSX)
            application = AppContextImpl().getContext() as NSApplication
        #endif
        
    }
    
    /**
    Open a new window showing the url webpage with a title and a close button displaying the desired text
    
    :param: url        to open
    :param: title      of the new window
    :param: buttonText text of the close button
    
    :returns: true if the new window opens;false otherwise
    */
    public func openBrowser(url : String, title : String, buttonText : String) -> Bool {
        
        // TODO: use the title and the button text attibutes
        
        // Check if the string is empty
        if url.isEmpty {
            return false
        }
        
        // Open the browser with the url 
        application.openURL(NSURL(string: url)!)
        
        return true
    }
}
