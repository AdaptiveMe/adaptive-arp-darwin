//
//  DeviceTest.swift
//  AdaptiveArpRtIos
//
//  Created by Administrator on 23/10/14.
//  Copyright (c) 2014 Carlos Lozano Diez. All rights reserved.
//

import UIKit
import XCTest

class DeviceTest: XCTestCase {
    
    var deviceImpl:DeviceImpl?
    
    let MSG_GETDEVICEINFO = "Check the log and the methods for further information"
    let MSG_GETLOCALECURRENT = "Check the log and the methods for further information"

    override func setUp() {
        super.setUp()
        
        deviceImpl = DeviceImpl()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetDeviceInfo() {
        XCTAssert(self.deviceImpl?.getDeviceInfo().getModel() != nil, MSG_GETDEVICEINFO)
    }
    
    func testGeLocaleCurrent() {
        XCTAssert(self.deviceImpl?.getLocaleCurrent().getLanguage() != nil, MSG_GETLOCALECURRENT)
    }
    
    // TODO: validate button listeners

}
