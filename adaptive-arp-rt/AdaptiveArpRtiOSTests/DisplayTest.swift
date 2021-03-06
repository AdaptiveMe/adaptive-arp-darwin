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
*  Display delegate tests class
*/
class DisplayTest: XCTestCase {
    
    /**
    Constructor.
    */
    override func setUp() {
        super.setUp()
        
        AppRegistryBridge.sharedInstance.getLoggingBridge().setDelegate(LoggingDelegate())
        AppRegistryBridge.sharedInstance.getPlatformContext().setDelegate(AppContextDelegate())
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().setDelegate(AppContextWebviewDelegate())
        AppRegistryBridge.sharedInstance.getDisplayBridge().setDelegate(DisplayDelegate())
    }
        
    /**
    Test for obtaining the current display orientation
    */
    func testGetOrientationCurrent() {
        XCTAssert(AppRegistryBridge.sharedInstance.getDisplayBridge().getOrientationCurrent() != nil, "Error getting the current display orientation. See log")
    }
    
    /**
    Tests for managing display orientation listeners
    */
    func testDisplayOrientationListener() {
        
        // Create a void listener in order to test the method implementation
        let listener = DisplayOrientationListenerImpl(id: 0)
        
        AppRegistryBridge.sharedInstance.getDisplayBridge().addDisplayOrientationListener(listener)
        AppRegistryBridge.sharedInstance.getDisplayBridge().removeDisplayOrientationListener(listener)
        AppRegistryBridge.sharedInstance.getDisplayBridge().removeDisplayOrientationListeners()
    }
}
