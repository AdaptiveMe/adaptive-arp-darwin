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
*  Device delegate tests class
*/
class DeviceTest: XCTestCase {
    
    /**
    Constructor.
    */
    override func setUp() {
        super.setUp()
        
        AppRegistryBridge.sharedInstance.getLoggingBridge().setDelegate(LoggingDelegate())
        AppRegistryBridge.sharedInstance.getPlatformContext().setDelegate(AppContextDelegate())
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().setDelegate(AppContextWebviewDelegate())
        AppRegistryBridge.sharedInstance.getDeviceBridge().setDelegate(DeviceDelegate())
    }
    
    /**
    Test to try the method get device info
    */
    func testGetDeviceInfo() {
        XCTAssert(AppRegistryBridge.sharedInstance.getDeviceBridge().getDeviceInfo() != nil, "Error getting the device information. See log")
    }
    
    /**
    Test for obtaining the current locale
    */
    func testGetLocaleCurrent() {
        XCTAssert(AppRegistryBridge.sharedInstance.getDeviceBridge().getLocaleCurrent() != nil, "Error getting the current locale. See log")
    }
    
    /**
    Test for obtaining the current orientation
    */
    func testGetOrientationCurrent() {
        XCTAssert(AppRegistryBridge.sharedInstance.getDeviceBridge().getOrientationCurrent() != nil, "Error getting the current orientation. See log")
    }
    
    /**
    Tests for managing device orientation listeners
    */
    func testDeviceOrientationListener() {
        
        // Create a void listener in order to test the method implementation
        let listener = DeviceOrientationListenerImpl(id: 0)
        
        AppRegistryBridge.sharedInstance.getDeviceBridge().addDeviceOrientationListener(listener)
        AppRegistryBridge.sharedInstance.getDeviceBridge().removeDeviceOrientationListener(listener)
        AppRegistryBridge.sharedInstance.getDeviceBridge().removeDeviceOrientationListeners()
    }
    
    /**
    Tests for managing device button listeners
    */
    func testButtonListener() {
        
        // Create a void listener in order to test the method implementation
        let listener = ButtonListenerImpl(id: 0)
        
        AppRegistryBridge.sharedInstance.getDeviceBridge().addButtonListener(listener)
        AppRegistryBridge.sharedInstance.getDeviceBridge().removeButtonListener(listener)
        AppRegistryBridge.sharedInstance.getDeviceBridge().removeButtonListeners()
        
    }

}
