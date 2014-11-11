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
import AdaptiveArpImpl
import AdaptiveArpApi

class Session: XCTestCase {
    
    var sessionImpl:SessionImpl?

    override func setUp() {
        super.setUp()
        
        sessionImpl = SessionImpl()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testCookies() {
        
        var cookie1:Cookie = Cookie(name: "name", data: "value")
        var cookie2:Cookie = Cookie(name: "name", data: "value")
        
        // Set a cookie in the dictionary and check
        sessionImpl!.setCookie(cookie1)
        XCTAssertTrue(sessionImpl?.getCookies()!.count == 1, "")
        
        // Remove a cookie and check
        sessionImpl!.removeCookie(cookie1)
        XCTAssertTrue(sessionImpl?.getCookies()!.count == 0, "")
        
        // Set a bunch of cookies
        sessionImpl!.setCookies([cookie1, cookie2])
        XCTAssertTrue(sessionImpl?.getCookies()!.count == 2, "")
        
        // Remove a bunch of cookies
        sessionImpl!.removeCookies([cookie1, cookie2])
        XCTAssertTrue(sessionImpl?.getCookies()!.count == 0, "")
    }
    
    func testAttributes() {
        
        var attribute1 = (name: "name1", value: true)
        var attribute2 = (name: "name1", value: "value")
        var attribute3 = (name: "name2", value: 0)
        var attribute4 = (name: "name3", value: "value")
        
        // Set a attribute in the dictionary and check
        sessionImpl!.setAttribute(attribute1.name, value: attribute1.value)
        XCTAssertTrue(sessionImpl?.getAttributes()!.count == 1, "")
        
        // Check the duplicity of names
        sessionImpl!.setAttribute(attribute2.name, value: attribute2.value)
        XCTAssertTrue(sessionImpl?.getAttributes()!.count == 1, "")
        
        // Get attribute by name
        // TODO: change this by nil, when the return type of this method could be optional
        XCTAssertTrue(sessionImpl?.getAttribute(attribute2.name) as NSString != "", "")
        
        // Check the attributes names
        XCTAssertTrue(sessionImpl?.listAttributeNames()!.count == 1, "")
        
        // Remove one attribute and check
        sessionImpl!.removeAttribute(attribute2.name)
        XCTAssertTrue(sessionImpl?.getAttributes()!.count == 0, "")
        
        // Remove all the attributes and check
        sessionImpl!.setAttribute(attribute3.name, value: attribute3.value)
        sessionImpl!.setAttribute(attribute4.name, value: attribute4.value)
        sessionImpl!.removeAttributes()
        XCTAssertTrue(sessionImpl?.getAttributes()!.count == 0, "")
        
    }

}
