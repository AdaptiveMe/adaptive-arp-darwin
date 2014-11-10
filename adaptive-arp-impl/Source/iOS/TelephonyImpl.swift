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
import UIKit
import AdaptiveArpApi

public class TelephonyImpl : NSObject, ITelephony {
    
    /// Logging variable
    let logger : ILogging = LoggingImpl()
    
    var application:UIApplication
    
    /**
    Class constructor
    */
    override init() {
        
        application = AppContextImpl().getContext() as UIApplication
    }
    
    /**
    Invoke a phone call
    
    :param: number number to call
    
    :returns: Status of the call
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func call(number : String) -> ITelephonyStatus {
        
        // Check the correct format of the number
        if !Utils.isPhoneNumberCorrect(number) {
            
            logger.log(ILoggingLogLevel.ERROR, category: "TelephonyImpl", message: "The number: \(number) has an incorrect format")
            return ITelephonyStatus.Failed
        }
        
        let url: NSURL = NSURL(string: "tel://\(number)")!
        
        // Check if it is possible to open the url
        if !application.canOpenURL(url) {
            
            logger.log(ILoggingLogLevel.ERROR, category: "TelephonyImpl", message: "The url: \(url) is not possible to open by the application")
            return ITelephonyStatus.Failed
        }
        
        // Make the call
        let result: Bool =  application.openURL(url)
        
        if !result {
            logger.log(ILoggingLogLevel.ERROR, category: "TelephonyImpl", message: "It is not posible to make the call")
        }
        
        return result ? ITelephonyStatus.Dialing : ITelephonyStatus.Failed
    }
}