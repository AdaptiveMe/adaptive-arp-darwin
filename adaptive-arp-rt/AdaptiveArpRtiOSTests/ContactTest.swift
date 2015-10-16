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

import XCTest
import AdaptiveArpApi

/**
*  Browser delegate tests class
*/
class ContactTest: XCTestCase {
    
    /// Callback for results
    var callback:ContactResultCallbackTest!
    
    /**
    Constructor.
    */
    override func setUp() {
        super.setUp()
        
        AppRegistryBridge.sharedInstance.getLoggingBridge().setDelegate(LoggingDelegate())
        AppRegistryBridge.sharedInstance.getPlatformContext().setDelegate(AppContextDelegate())
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().setDelegate(AppContextWebviewDelegate())
        AppRegistryBridge.sharedInstance.getContactBridge().setDelegate(ContactDelegate())
        
        callback = ContactResultCallbackTest(id: 0)
    }
    
    /**
    Test for getting one contact. This method obtains ALL THE INFORMATION for one contact
    */
    func testGetContact() {
        
        // MARK:  Maybe this contact (3) does not exist
        
        let cuuid:ContactUid = ContactUid(contactId: "3")
        AppRegistryBridge.sharedInstance.getContactBridge().getContact(cuuid, callback: callback)
    }
    
    /**
    Test for getting all the contacts. This method obtains ALL THE INFORMATION for the contacts
    */
    func testGetContacts() {
        
        AppRegistryBridge.sharedInstance.getContactBridge().getContacts(callback)
    }
    
    /**
    Test for Getting anly some information about the contacts.
    */
    func testGetContactsForFields() {
        
        var fields:[IContactFieldGroup] = [IContactFieldGroup]()
        fields.append(IContactFieldGroup.PersonalInfo)
        fields.append(IContactFieldGroup.ProfessionalInfo)
        
        AppRegistryBridge.sharedInstance.getContactBridge().getContactsForFields(callback, fields: fields)
    }

    /**
    Test for getting all the contacts with some constrains
    */
    func testGetContactsWithFilter() {
        
        var fields:[IContactFieldGroup] = [IContactFieldGroup]()
        fields.append(IContactFieldGroup.PersonalInfo)
        fields.append(IContactFieldGroup.ProfessionalInfo)
        
        var filters:[IContactFilter] = [IContactFilter]()
        filters.append(IContactFilter.HasPhone)
        filters.append(IContactFilter.HasEmail)
        filters.append(IContactFilter.HasAddress)
        
        AppRegistryBridge.sharedInstance.getContactBridge().getContactsWithFilter(callback, fields: fields, filter: filters)
    }
    
    /**
    Test for searching contacts
    */
    func testSearchContacts() {
        
        // MARK:  Maybe this contact (kate) does not exist
        
        AppRegistryBridge.sharedInstance.getContactBridge().searchContacts("kate", callback: callback)
    }
    
    /**
    Test for searching contacts with restriction
    */
    func testSearchContactsFilter() {
        
        var filters:[IContactFilter] = [IContactFilter]()
        filters.append(IContactFilter.HasPhone)
        filters.append(IContactFilter.HasEmail)
        filters.append(IContactFilter.HasAddress)
        
        // MARK:  Maybe this contact (david) does not exist
        
        AppRegistryBridge.sharedInstance.getContactBridge().searchContactsWithFilter("kate", callback: callback, filter: filters)
    }

}