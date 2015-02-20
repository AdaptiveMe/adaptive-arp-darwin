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


class SecurityTest: XCTestCase {
    
    /*var securityImpl:SecurityImpl?
    var secureKeyPair1:SecureKeyPair = SecureKeyPair()
    var secureKeyPair2:SecureKeyPair = SecureKeyPair()
    
    // Create a callback
    var iSecureKVResultCallbackImpl:ISecureKVResultCallbackImpl = ISecureKVResultCallbackImpl()

    override func setUp() {
        super.setUp()
        
        securityImpl = SecurityImpl()
        
        // Create a secure key pair
        secureKeyPair1.setSecureKey("name1")
        secureKeyPair1.setSecureData("value1")
        
        // Create a secure key pair
        secureKeyPair2.setSecureKey("name2")
        secureKeyPair2.setSecureData("value2")
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testDeviceModified() {
        
        // MARK: this test supose that the device is not jailbroken
        
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            // Simulator
        #else
            // Device
            XCTAssertFalse(securityImpl!.isDeviceModified(), "This test supose that the device or emulator is not jailbroken")
        #endif
    }

    func testPerformanceDeviceModified() {
        
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            // Simulator
        #else
            // Device
            self.measureBlock() {
                var result = self.securityImpl!.isDeviceModified()
            }
        #endif
        
    }
    
    func testSecureKeyValuePairs () {
        
        // Store a SecureKeyPair
        securityImpl!.setSecureKeyValuePairs([secureKeyPair1, secureKeyPair2], publicAccessName: "storage", callback: iSecureKVResultCallbackImpl)
        
        // Get the value of SecureKeyPair
        securityImpl!.getSecureKeyValuePairs([secureKeyPair1.getSecureKey()!, secureKeyPair2.getSecureKey()!], publicAccessName: "storage", callback: iSecureKVResultCallbackImpl)
        
        // Delete a SecureKeyPair
        securityImpl!.deleteSecureKeyValuePairs([secureKeyPair1.getSecureKey()!, secureKeyPair2.getSecureKey()!], publicAccessName: "storage", callback: iSecureKVResultCallbackImpl)
    }*/
}
/*
/// Dummy implementation of the callback in order to run the tests
class ISecureKVResultCallbackImpl: NSObject, ISecureKVResultCallback {
    
    func onError(error : ISecureKVResultCallbackError) {
        XCTAssert(false, "\(error)")
    }
    func onResult(keyValues : [SecureKeyPair]) {
        
        for pair:SecureKeyPair in keyValues {
            XCTAssert(true, "key: \(pair.getSecureKey()), value: \(pair.getSecureData())")
        }
    }
    func onWarning(keyValues : [SecureKeyPair], warning : ISecureKVResultCallbackWarning) {
        
        for pair:SecureKeyPair in keyValues {
            XCTAssert(true, "key: \(pair.getSecureKey()), value: \(pair.getSecureData()), message: \(warning)")
        }
    }
    func toString() -> String? {
        return ""
    }
    func getId() -> Int64 {return 0}
}*/
