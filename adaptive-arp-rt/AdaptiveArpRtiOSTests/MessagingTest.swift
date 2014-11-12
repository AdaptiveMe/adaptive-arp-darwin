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
import AdaptiveArpImpl
import AdaptiveArpApi

class MessagingTest: XCTestCase {
    
    var messagingImpl:MessagingImpl!
    var iMessagingCallbackImpl:IMessagingCallbackImpl!

    override func setUp() {
        super.setUp()
        
        messagingImpl = MessagingImpl()
        iMessagingCallbackImpl = IMessagingCallbackImpl()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    /// Test for sending an sms
    func testSendSMS() {
        messagingImpl.sendSMS("123456789", text: "I want to send this text by SMS :)", callback: iMessagingCallbackImpl)
    }

    /// Test for sending an email
    func testSendEmail() {
        var email:Email = Email(toRecipients: [EmailAddress(address: "fnva@gft.com")], subject: "Test from Adaptive Messaging API", messageBody: "This text goes throw the Adaptive API of Messaging")
        
        messagingImpl.sendEmail(email, callback: iMessagingCallbackImpl)
    }

}

/// Dummy implementation of the callback in order to run the tests
class IMessagingCallbackImpl: NSObject, IMessagingCallback {
    
    func onError(error : IMessagingCallbackError) {
        XCTAssert(false, "ERROR: \(error.toString())")
    }
    
    func onResult(success : Bool) {
        XCTAssert(success, "")
    }
    
    func onWarning(success : Bool, warning : IMessagingCallbackWarning) {
        
        println("WARNING: \(warning.toString())")
        XCTAssert(success, "")
    }
    
    func toString() -> String? {
        return ""
    }
}
