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
*  Capabilities delegate tests class
*/
class CapabilitiesTest: XCTestCase {
    
    /**
    Constructor.
    */
    override func setUp() {
        super.setUp()
        
        AppRegistryBridge.sharedInstance.getLoggingBridge().setDelegate(LoggingDelegate())
        AppRegistryBridge.sharedInstance.getPlatformContext().setDelegate(AppContextDelegate())
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().setDelegate(AppContextWebviewDelegate())
        AppRegistryBridge.sharedInstance.getCapabilitiesBridge().setDelegate(CapabilitiesDelegate())
    }
    
    /**
    Method for testing the playstream method
    */
    func testCapabilitiesSupport(){
        
        XCTAssertTrue(AppRegistryBridge.sharedInstance.getCapabilitiesBridge().hasButtonSupport(ICapabilitiesButton.BackButton) != nil, "There is a problem abtaining the capabilities")
        XCTAssertTrue(AppRegistryBridge.sharedInstance.getCapabilitiesBridge().hasCommunicationSupport(ICapabilitiesCommunication.Calendar) != nil, "There is a problem abtaining the capabilities")
        XCTAssertTrue(AppRegistryBridge.sharedInstance.getCapabilitiesBridge().hasDataSupport(ICapabilitiesData.Database) != nil, "There is a problem abtaining the capabilities")
        XCTAssertTrue(AppRegistryBridge.sharedInstance.getCapabilitiesBridge().hasMediaSupport(ICapabilitiesMedia.AudioPlayback) != nil, "There is a problem abtaining the capabilities")
        XCTAssertTrue(AppRegistryBridge.sharedInstance.getCapabilitiesBridge().hasNetSupport(ICapabilitiesNet.GSM) != nil, "There is a problem abtaining the capabilities")
        XCTAssertTrue(AppRegistryBridge.sharedInstance.getCapabilitiesBridge().hasNotificationSupport(ICapabilitiesNotification.Alarm) != nil, "There is a problem abtaining the capabilities")
        XCTAssertTrue(AppRegistryBridge.sharedInstance.getCapabilitiesBridge().hasSensorSupport(ICapabilitiesSensor.Accelerometer) != nil, "There is a problem abtaining the capabilities")
        XCTAssertTrue(AppRegistryBridge.sharedInstance.getCapabilitiesBridge().hasOrientationSupport(ICapabilitiesOrientation.PortraitUp) != nil, "There is a problem abtaining the capabilities")
        XCTAssertTrue(AppRegistryBridge.sharedInstance.getCapabilitiesBridge().getOrientationDefault() != nil, "There is a problem abtaining the capabilities")
        XCTAssertTrue(AppRegistryBridge.sharedInstance.getCapabilitiesBridge().getOrientationsSupported()?.count > 0, "There is a problem abtaining the capabilities")
    }
}
