//
//  ContactTest.swift
//  AdaptiveArpRtIos
//
//  Created by Administrator on 31/10/14.
//  Copyright (c) 2014 Carlos Lozano Diez. All rights reserved.
//

import UIKit
import XCTest
import AdaptiveArpImpliOS
import AdaptiveArpApiiOS

class ContactTest: XCTestCase {
    
    var contactImpl:ContactImpl!
    
    // Create a callback
    var iContactResultCallbackImpl:IContactResultCallbackImpl!
    
    override func setUp() {
        super.setUp()
        
        contactImpl = ContactImpl()
        iContactResultCallbackImpl = IContactResultCallbackImpl()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testGetAllContacts() {
        
        contactImpl.getContacts(iContactResultCallbackImpl)
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
            XCTAssert(true, "contact: \(contact.description)")
        }
    }
    func onWarning(contacts : [Contact], warning : IContactResultCallbackWarning) {
        
        println("Number of contacts: \(contacts.count)")
        
        for contact:Contact in contacts {
            XCTAssert(true, "contact: \(contact.description), message: \(warning)")
        }
    }
    func toString() -> String? {
        return ""
    }
}
