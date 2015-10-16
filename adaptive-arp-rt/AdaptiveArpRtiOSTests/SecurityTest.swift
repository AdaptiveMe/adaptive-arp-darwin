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
import AdaptiveArpApi

/**
*  Security delegate tests class
*/
class SecurityTest: XCTestCase {
    
    /// Callback for results
    var callback:SecurityResultCallbackTest!
    
    // Secure key pairs for testing purposes
    var secureKeyPair1:SecureKeyPair = SecureKeyPair()
    var secureKeyPair2:SecureKeyPair = SecureKeyPair()
    
    /**
    Constructor.
    */
    override func setUp() {
        super.setUp()
        
        AppRegistryBridge.sharedInstance.getLoggingBridge().setDelegate(LoggingDelegate())
        AppRegistryBridge.sharedInstance.getPlatformContext().setDelegate(AppContextDelegate())
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().setDelegate(AppContextWebviewDelegate())
        AppRegistryBridge.sharedInstance.getSecurityBridge().setDelegate(SecurityDelegate())
        
        callback = SecurityResultCallbackTest(id: 0)
        
        secureKeyPair1.setSecureKey("name1")
        secureKeyPair1.setSecureData("value1")
        secureKeyPair2.setSecureKey("name2")
        secureKeyPair2.setSecureData("value2")
    }
    
    /**
    Test for testing the device modified method
    */
    func testDeviceModified() {
        
        // MARK: you can't test the device modified method in the simulator, skipping the tests...
        
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            
            // Simulator
            XCTAssert(true, "")
            
            #else
            
            XCTAssertFalse(AppRegistryBridge.sharedInstance.getSecurityBridge().isDeviceModified()!, "There is a problem with the test or the device is jailbroken.")
            
        #endif
    }
    
    /**
    Test for testing the operations againts the Secure Keychain environment
    */
    func testSecureKeyValuePairs () {
        
        // Store a SecureKeyPair
        AppRegistryBridge.sharedInstance.getSecurityBridge().setSecureKeyValuePairs([secureKeyPair1, secureKeyPair2], publicAccessName: "storage", callback: callback)
        
        // Get the value of SecureKeyPair
        AppRegistryBridge.sharedInstance.getSecurityBridge().getSecureKeyValuePairs([secureKeyPair1.getSecureKey()!, secureKeyPair2.getSecureKey()!], publicAccessName: "storage", callback: callback)
        
        // Delete a SecureKeyPair
        AppRegistryBridge.sharedInstance.getSecurityBridge().deleteSecureKeyValuePairs([secureKeyPair1.getSecureKey()!, secureKeyPair2.getSecureKey()!], publicAccessName: "storage", callback: callback)
    }
}