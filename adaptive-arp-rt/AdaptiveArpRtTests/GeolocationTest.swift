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

class GeolocationTest: XCTestCase {
    
    var iGeolocation:IGeolocation!
    var listener:GeolocationListenerImpl!
    
    override func setUp() {
        super.setUp()
        
        iGeolocation = GeolocationImpl()
        listener = GeolocationListenerImpl()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /// Test Geolocation
    func testGeolocation() {
        
        iGeolocation.addGeolocationListener(listener)
        iGeolocation.removeGeolocationListener(listener)
        iGeolocation.removeGeolocationListeners()
    }
}

public class GeolocationListenerImpl:NSObject,IGeolocationListener {
    
    public func onError(error : IGeolocationListenerError) {
        XCTAssert(false, "ERROR: \(error.toString())")
    }
    public func onResult(geolocation : Geolocation) {
        NSLog("RESULT: latitude: \(geolocation.getLatitude()), longitude: \(geolocation.getLongitude()), altitude: \(geolocation.getAltitude()), precisionx: \(geolocation.getXDoP()), precisiony: \(geolocation.getYDoP())")
        XCTAssert(true, "")
    }
    public func onWarning(geolocation : Geolocation, warning : IGeolocationListenerWarning) {
        NSLog("WARNING: \(warning.toString())")
        NSLog("RESULT: latitude: \(geolocation.getLatitude()), longitude: \(geolocation.getLongitude()), altitude: \(geolocation.getAltitude()), precisionx: \(geolocation.getXDoP()), precisiony: \(geolocation.getYDoP())")
        XCTAssert(true, "")
    }
    public func toString() -> String? {
        return "listener"
    }
    public func getId() -> Int64 {
        return 0
    }
}