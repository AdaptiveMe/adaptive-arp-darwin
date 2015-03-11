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

/**
*  Browser delegate tests class
*/
class MessagingTest: XCTestCase {
    
    /// Callback for results
    var callback:MessagingResultCallbackTest!
    
    /**
    Constructor.
    */
    override func setUp() {
        super.setUp()
        
        AppRegistryBridge.sharedInstance.getLoggingBridge().setDelegate(LoggingDelegate())
        AppRegistryBridge.sharedInstance.getPlatformContext().setDelegate(AppContextDelegate())
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().setDelegate(AppContextWebviewDelegate())
        AppRegistryBridge.sharedInstance.getMessagingBridge().setDelegate(MessagingDelegate())
        
        callback = MessagingResultCallbackTest(id: 0)
    }
    
    /**
    Method to test the send SMS functionality
    */
    func testSendSMS(){
        
        // MARK: you can't simulate messaging events in the Iphone Simulator for Xcode, skipping the test...
        
        if UIDevice.currentDevice().model == "iPhone Simulator" {
            
            XCTAssert(true, "")
            
        } else {
            
            AppRegistryBridge.sharedInstance.getMessagingBridge().sendSMS("123456789", text: "I want to send this text by SMS :)", callback: callback)
            
        }
        
        
    }
}