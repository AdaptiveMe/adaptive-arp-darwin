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

class BrowserTest: XCTestCase {
    
    var browserImpl:BrowserImpl?
    
    let CORRECT_URL_1:String = "http://www.google.com"
    let EMPTY_URL:String = ""
    let WRONG_URL_1:String = "google"
    let WRONG_URL_2:String = "www.google.com"
    let WRONG_URL_3:String = "google.com"

    override func setUp() {
        super.setUp()
        
        browserImpl = BrowserImpl()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testOpenBrowser() {
        
        XCTAssertTrue(self.browserImpl!.openBrowser(CORRECT_URL_1, title : "", buttonText : ""), "")
        XCTAssertFalse(self.browserImpl!.openBrowser(EMPTY_URL, title : "", buttonText : ""), "")
        XCTAssertFalse(self.browserImpl!.openBrowser(WRONG_URL_1, title : "", buttonText : ""), "")
        XCTAssertFalse(self.browserImpl!.openBrowser(WRONG_URL_2, title : "", buttonText : ""), "")
        XCTAssertFalse(self.browserImpl!.openBrowser(WRONG_URL_3, title : "", buttonText : ""), "")
    }

    func testPerformanceOpenBrowser() {
        
        self.measureBlock() {
            var result = self.browserImpl!.openBrowser(self.CORRECT_URL_1, title : "", buttonText : "")
        }
    }

}
