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
   Interface for Managing the Telephony operations
   Auto-generated implementation of ITelephony specification.
*/
public class TelephonyDelegate : BaseCommunicationDelegate, ITelephony {
    
    /// Logger variable
    let logger : ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge()
    let loggerTag : String = "TelephonyDelegate"
    
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
       Invoke a phone call

       @param number to call
       @return Status of the call
       @since ARP1.0
    */
    public func call(number : String) -> ITelephonyStatus {
        
        // Check the correct format of the number
        if !Utils.isPhoneNumberCorrect(number) {
            
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "The number: \(number) has an incorrect format")
            return ITelephonyStatus.Failed
        }
        
        let url: NSURL = NSURL(string: "tel://\(number)")!
        
        #if os(iOS)
            // Check if it is possible to open the url
            if !application!.canOpenURL(url) {
                
                logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "The url: \(url) is not possible to open by the application")
                return ITelephonyStatus.Failed
            }
        #endif
        #if os(OSX)
            
            // TODO: implement this for OSX
            
        #endif
        
        var result: Bool = false
        
        #if os(iOS)
            // Make the call
            result =  application!.openURL(url)
            
            if !result {
                logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "It is not posible to make the call")
                return ITelephonyStatus.Failed
            } else {
                
                return ITelephonyStatus.Dialing
            }
        #endif
        #if os(OSX)
            
            // TODO: implement this for OSX
            
            return ITelephonyStatus.Failed
            
        #endif
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
