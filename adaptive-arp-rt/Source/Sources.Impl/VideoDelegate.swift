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

/**
   Interface for Managing the Video operations
   Auto-generated implementation of IVideo specification.
*/
public class VideoDelegate : BaseMediaDelegate, IVideo {

    
    /// Logger variable
    let logger : ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge()
    let loggerTag : String = "VideoDelegate"
    
    #if os(iOS)
    /// Application variable
    var application:UIApplication? = nil
    #endif
    
    /**
       Default Constructor.
    */
    public override init() {
        super.init()
        #if os(iOS)
            self.application = (AppRegistryBridge.sharedInstance.getPlatformContext().getContext() as UIApplication)
        #endif
    }

    /**
       Play url video stream

       @param url of the video
       @since ARP1.0
    */
    public func playStream(url : String) {
        
        if checkURl(url) {
            if (BaseViewController.ViewCurrent.getView() != nil) {
                #if os(iOS)
                    (BaseViewController.ViewCurrent.getView()! as BaseViewController).showInternalMedia(NSURL(string: url)!, showAnimated: true)
                #endif
                
            } else {
                logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "The current View Controller has no presented view")
            }
        }
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
            // There is no way to check the url validity for OSX
        #endif
        
        return true
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
