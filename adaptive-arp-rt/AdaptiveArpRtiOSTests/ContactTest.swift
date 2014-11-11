//
//  ContactTest.swift
//  AdaptiveArpRtIos
//
//  Created by Administrator on 31/10/14.
//  Copyright (c) 2014 Carlos Lozano Diez. All rights reserved.
//

import UIKit
import XCTest
import AdaptiveArpImpl
import AdaptiveArpApi

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
        
        self.contactImpl.getContacts(self.iContactResultCallbackImpl, fields: fields)
    }
    
    func testGetContactsFieldsPerformance() {
        
        var fields:[IContactFieldGroup] = [IContactFieldGroup]()
        fields.append(IContactFieldGroup.PERSONAL_INFO)
        
        self.measureBlock() {
            self.contactImpl.getContacts(self.iContactResultCallbackImpl, fields: fields)
        }
    }
    
    func testGetContactsFieldsFilter() {
        
        var fields:[IContactFieldGroup] = [IContactFieldGroup]()
        fields.append(IContactFieldGroup.PERSONAL_INFO)
        
        var filters:[IContactFilter] = [IContactFilter]()
        filters.append(IContactFilter.HAS_PHONE)
        
        self.contactImpl.getContacts(self.iContactResultCallbackImpl, fields: fields, filter: filters)
    }
    
    func testGetContactsFieldsFilterPerformance() {
        
        var fields:[IContactFieldGroup] = [IContactFieldGroup]()
        fields.append(IContactFieldGroup.PERSONAL_INFO)
        
        var filters:[IContactFilter] = [IContactFilter]()
        filters.append(IContactFilter.HAS_PHONE)
        
        self.measureBlock() {
            self.contactImpl.getContacts(self.iContactResultCallbackImpl, fields: fields, filter: filters)
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
        
        self.contactImpl.searchContacts("kate", callback: self.iContactResultCallbackImpl, filter: filters)
    }
    
    func testSearchContactsFilterPerformance() {
        
        var filters:[IContactFilter] = [IContactFilter]()
        filters.append(IContactFilter.HAS_PHONE)
        
        self.measureBlock() {
            self.contactImpl.searchContacts("kate", callback: self.iContactResultCallbackImpl, filter: filters)
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
}
