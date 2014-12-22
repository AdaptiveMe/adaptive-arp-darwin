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

/*

/// MARK: The tests of Network Reachability are disabled because the asyncronous methods doesn't work fine with the XCTAssert method of the test cases

class NetworkReachabilityTest: XCTestCase {
    
    var networkReachabilityImpl:NetworkReachabilityImpl!
    var iNetworkReachabilityCallbackImpl:INetworkReachabilityCallbackImpl!
    
    override func setUp() {
        super.setUp()
        
        networkReachabilityImpl = NetworkReachabilityImpl()
        iNetworkReachabilityCallbackImpl = INetworkReachabilityCallbackImpl()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /// Test if the connection to network is reachable
    func testIsNetworkServiceReachable() {
        networkReachabilityImpl.isNetworkServiceReachable("https://www.fintonic.com/app/#advice/recommendations", callback: iNetworkReachabilityCallbackImpl)
    }
    
    /// Test if the connection to host is reachable
    func testIsNetworkReachable() {
        networkReachabilityImpl.isNetworkReachable("http://www.google.es/", callback: iNetworkReachabilityCallbackImpl)
    }
}

/// Dummy implementation of the callback in order to run the tests
class INetworkReachabilityCallbackImpl: NSObject, INetworkReachabilityCallback {
    
    func onError(error : INetworkReachabilityCallbackError) {
        XCTAssert(false, "ERROR: \(error.toString())")
    }
    
    func onResult(result : String) {
        XCTAssert(true, "")
    }
    
    func onWarning(result : String, warning : INetworkReachabilityCallbackWarning) {
        println("WARNING: \(warning.toString())")
        XCTAssert(true, "")
    }
    
    func toString() -> String? {
        return ""
    }
}*/