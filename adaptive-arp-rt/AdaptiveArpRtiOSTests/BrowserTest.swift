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
import AdaptiveArpApi

/**
*  Browser delegate tests class
*/
class BrowserTest: XCTestCase {
    
    // TODO
    
    /**
    Constructor.
    */
    override func setUp() {
        super.setUp()
        
        AppRegistryBridge.sharedInstance.getLoggingBridge().setDelegate(LoggingDelegate())
        AppRegistryBridge.sharedInstance.getPlatformContext().setDelegate(AppContextDelegate())
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().setDelegate(AppContextWebviewDelegate())
        AppRegistryBridge.sharedInstance.getBrowserBridge().setDelegate(BrowserDelegate())
    }
    
    /**
    Test for openning an external Browser
    */
    func testOpenExtenalBrowser() {
        XCTAssertTrue(AppRegistryBridge.sharedInstance.getBrowserBridge().openExtenalBrowser("http://www.google.com")!)
        
        // MARK: Is not possible to test the open internal methods with an assert because
        // in the tests there are no viewcontrollers so the methods fails
        AppRegistryBridge.sharedInstance.getBrowserBridge().openInternalBrowser("http://www.google.com", title: "Title", backButtonText: "Back")
        AppRegistryBridge.sharedInstance.getBrowserBridge().openInternalBrowserModal("http://www.google.com", title: "Title", backButtonText: "Back")
    }

}
