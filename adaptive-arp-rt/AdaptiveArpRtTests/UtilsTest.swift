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
import XCTest

let logger:ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge()
let loggerTag:String = "TESTING"

/**
*  Contacts callback test implementation. For testing purposes only
*/
class ContactResultCallbackTest: BaseCallbackImpl, IContactResultCallback {
    
    /**
    Contacts callback error function implementation
    
    :param: error Error produced
    */
    func onError(error : IContactResultCallbackError) {
        logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "Error obtaining contacts: \(error)")
        XCTAssert(false, "Error obtaining contacts: \(error)")
    }
    
    /**
    Contacts callback result function implementation
    
    :param: contacts List of contacts
    */
    func onResult(contacts : [Contact]) {
        
        logger.log(ILoggingLogLevel.INFO, category: loggerTag, message: "Number of contacts: \(contacts.count)")
        
        for contact:Contact in contacts {
            logger.log(ILoggingLogLevel.INFO, category: loggerTag, message: " -> Contact Information: \(contact.getContactId()!) - \(contact.getPersonalInfo()!.getName()!) \(contact.getPersonalInfo()!.getLastName()!) [\(contact.getProfessionalInfo()?.getCompany())]")
        }
        XCTAssert(true, "")
    }
    
    /**
    Contacts callback warning function implementation
    
    :param: contacts List of contacts
    :param: warning  Warning description
    */
    func onWarning(contacts : [Contact], warning : IContactResultCallbackWarning) {
        
        logger.log(ILoggingLogLevel.WARN, category: loggerTag, message: "Warning: \(warning.toString())")
        logger.log(ILoggingLogLevel.WARN, category: loggerTag, message: "Number of contacts: \(contacts.count)")
        for contact:Contact in contacts {
            logger.log(ILoggingLogLevel.INFO, category: loggerTag, message: " -> Contact Information: \(contact.getContactId()!) - \(contact.getPersonalInfo()!.getName()!) \(contact.getPersonalInfo()!.getLastName()!) [\(contact.getProfessionalInfo()?.getCompany())]")
        }
        XCTAssert(true, "")
    }
}