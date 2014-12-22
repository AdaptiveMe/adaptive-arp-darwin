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

import UIKit
import XCTest

class ContactTest: XCTestCase {
    
    var contactImpl:ContactImpl!
    
    // Create a callback
    var iContactResultCallbackImpl:IContactResultCallbackImpl!
    var iContactPhotoResultCallbackImpl:IContactPhotoResultCallbackImpl!
    
    override func setUp() {
        super.setUp()
        
        contactImpl = ContactImpl()
        iContactResultCallbackImpl = IContactResultCallbackImpl()
        iContactPhotoResultCallbackImpl = IContactPhotoResultCallbackImpl()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetAllContacts() {
        
        self.contactImpl.getContacts(self.iContactResultCallbackImpl)
    }
    
    func testGetAllContactsPerformance() {
        
        self.measureBlock() {
            self.contactImpl.getContacts(self.iContactResultCallbackImpl)
        }
    }
    
    func testGetContact() {
        
        // MARK: maybe this identifier does not exist
        var contactUid:ContactUid = ContactUid()
        contactUid.setContactId("3")
        
        self.contactImpl.getContact(contactUid, callback: self.iContactResultCallbackImpl)
    }
    
    func testGetContactPerformance() {
        
        // MARK: maybe this identifier does not exist
        var contactUid:ContactUid = ContactUid()
        contactUid.setContactId("3")
        
        self.measureBlock() {
            self.contactImpl.getContact(contactUid, callback: self.iContactResultCallbackImpl)
        }
    }
    
    func testGetContactsFields() {
        
        var fields:[IContactFieldGroup] = [IContactFieldGroup]()
        fields.append(IContactFieldGroup.PERSONAL_INFO)
        
        self.contactImpl.getContactsForFields(self.iContactResultCallbackImpl, fields: fields)
    }
    
    func testGetContactsFieldsPerformance() {
        
        var fields:[IContactFieldGroup] = [IContactFieldGroup]()
        fields.append(IContactFieldGroup.PERSONAL_INFO)
        
        self.measureBlock() {
            self.contactImpl.getContactsForFields(self.iContactResultCallbackImpl, fields: fields)
        }
    }
    
    func testGetContactsFieldsFilter() {
        
        var fields:[IContactFieldGroup] = [IContactFieldGroup]()
        fields.append(IContactFieldGroup.PERSONAL_INFO)
        
        var filters:[IContactFilter] = [IContactFilter]()
        filters.append(IContactFilter.HAS_PHONE)
        
        self.contactImpl.getContactsWithFilter(self.iContactResultCallbackImpl, fields: fields, filter: filters)
    }
    
    func testGetContactsFieldsFilterPerformance() {
        
        var fields:[IContactFieldGroup] = [IContactFieldGroup]()
        fields.append(IContactFieldGroup.PERSONAL_INFO)
        
        var filters:[IContactFilter] = [IContactFilter]()
        filters.append(IContactFilter.HAS_PHONE)
        
        self.measureBlock() {
            self.contactImpl.getContactsWithFilter(self.iContactResultCallbackImpl, fields: fields, filter: filters)
        }
    }
    
    func testSearchContacts() {
        
        self.contactImpl.searchContacts("kate", callback: self.iContactResultCallbackImpl)
    }
    
    func testSearchContactsPerformance() {
        
        self.measureBlock() {
            self.contactImpl.searchContacts("kate", callback: self.iContactResultCallbackImpl)
        }
    }
    
    func testSearchContactsFilter() {
        
        var filters:[IContactFilter] = [IContactFilter]()
        filters.append(IContactFilter.HAS_PHONE)
        
        self.contactImpl.searchContactsWithFilter("kate", callback: self.iContactResultCallbackImpl, filter: filters)
    }
    
    func testSearchContactsFilterPerformance() {
        
        var filters:[IContactFilter] = [IContactFilter]()
        filters.append(IContactFilter.HAS_PHONE)
        
        self.measureBlock() {
            self.contactImpl.searchContactsWithFilter("kate", callback: self.iContactResultCallbackImpl, filter: filters)
        }
    }
    
    func testGetContactPhoto() {
        
        // MARK: maybe this identifier does not exist
        var contactUid:ContactUid = ContactUid()
        contactUid.setContactId("3")
        
        self.contactImpl.getContactPhoto(contactUid, callback: self.iContactPhotoResultCallbackImpl)
    }
    
    func testGetContactPhotoPerformance() {
        
        // MARK: maybe this identifier does not exist
        var contactUid:ContactUid = ContactUid()
        contactUid.setContactId("3")
        
        self.measureBlock() {
            self.contactImpl.getContactPhoto(contactUid, callback: self.iContactPhotoResultCallbackImpl)
        }
    }

}

/// Dummy implementation of the callback in order to run the tests
class IContactResultCallbackImpl: NSObject, IContactResultCallback {
    
    func onError(error : IContactResultCallbackError) {
        XCTAssert(false, "\(error)")
    }
    func onResult(contacts : [Contact]) {
        
        println("Number of contacts: \(contacts.count)")
        
        for contact:Contact in contacts {
            println(contact.description)
            XCTAssert(true, "contact: \(contact.description)")
        }
    }
    func onWarning(contacts : [Contact], warning : IContactResultCallbackWarning) {
        
        println("Number of contacts: \(contacts.count)")
        
        for contact:Contact in contacts {
            println(contact.description)
            XCTAssert(true, "contact: \(contact.description), message: \(warning)")
        }
    }
    func toString() -> String? {
        return ""
    }
    func getId() -> Int64 {return 0}
}

/// Dummy implementation of the callback in order to run the tests
class IContactPhotoResultCallbackImpl: NSObject, IContactPhotoResultCallback {
    
    var contactImpl:ContactImpl = ContactImpl()
    
    func onError(error : IContactPhotoResultCallbackError) {
        XCTAssert(false, "\(error)")
    }
    func onResult(contactPhoto : [Byte]) {
        
        // MARK: maybe this identifier does not exist
        var contactUid:ContactUid = ContactUid()
        contactUid.setContactId("1")
        
        XCTAssert(self.contactImpl.setContactPhoto(contactUid, pngImage: contactPhoto), "Error setting the image")
    }
    func onWarning(contactPhoto : [Byte], warning : IContactPhotoResultCallbackWarning) {
        
        //println("bytes: \(contactPhoto)")
        XCTAssert(true, "message: \(warning)")
    }
    func toString() -> String? {
        return ""
    }
    func getId() -> Int64 {return 0}
}
