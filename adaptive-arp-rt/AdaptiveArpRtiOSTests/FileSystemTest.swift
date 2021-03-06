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
*  FileSystem delegate tests class
*/
class FileSystemTest: XCTestCase {
    
    /**
    Constructor.
    */
    override func setUp() {
        super.setUp()
        
        AppRegistryBridge.sharedInstance.getLoggingBridge().setDelegate(LoggingDelegate())
        AppRegistryBridge.sharedInstance.getPlatformContext().setDelegate(AppContextDelegate())
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().setDelegate(AppContextWebviewDelegate())
        AppRegistryBridge.sharedInstance.getFileSystemBridge().setDelegate(FileSystemDelegate())
    }
    
    /**
    Test for obtaining the current display orientation
    */
    func testFileSystem() {
        XCTAssert(AppRegistryBridge.sharedInstance.getFileSystemBridge().getApplicationCacheFolder() != nil, "Error getting the cache folder. See log")
        XCTAssert(AppRegistryBridge.sharedInstance.getFileSystemBridge().getApplicationCloudFolder() != nil, "Error getting the cloud folder. See log")
        XCTAssert(AppRegistryBridge.sharedInstance.getFileSystemBridge().getApplicationDocumentsFolder() != nil, "Error getting the documents folder. See log")
        XCTAssert(AppRegistryBridge.sharedInstance.getFileSystemBridge().getApplicationFolder() != nil, "Error getting the application folder. See log")
        XCTAssert(AppRegistryBridge.sharedInstance.getFileSystemBridge().getApplicationProtectedFolder() != nil, "Error getting the protected folder. See log")
        XCTAssert(AppRegistryBridge.sharedInstance.getFileSystemBridge().getSystemExternalFolder() != nil, "Error getting the external folder. See log")        
        XCTAssert(AppRegistryBridge.sharedInstance.getFileSystemBridge().getSeparator() == "/", "Error getting the separator. See log")
    }

}
