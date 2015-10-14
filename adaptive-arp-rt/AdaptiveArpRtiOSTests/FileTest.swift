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
*  File delegate tests class
*/
class FileTest: XCTestCase {
    
    var fileResultCallback:IFileResultCallback!
    var fileDataStoreResultCallback:IFileDataStoreResultCallback!
    var fileDataLoadResultCallback:IFileDataLoadResultCallback!
    var fileListResultCallback:IFileListResultCallback!
    
    /**
    Constructor.
    */
    override func setUp() {
        super.setUp()
        
        AppRegistryBridge.sharedInstance.getLoggingBridge().setDelegate(LoggingDelegate())
        AppRegistryBridge.sharedInstance.getPlatformContext().setDelegate(AppContextDelegate())
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().setDelegate(AppContextWebviewDelegate())
        AppRegistryBridge.sharedInstance.getFileBridge().setDelegate(FileDelegate())
        AppRegistryBridge.sharedInstance.getFileSystemBridge().setDelegate(FileSystemDelegate())
        
        fileResultCallback = FileResultCallbackTest(id: 0)
        fileDataStoreResultCallback = FileDataStoreResultCallbackTest(id: 0)
        fileDataLoadResultCallback = FileDataLoadResultCallbackTest(id: 0)
        fileListResultCallback = FileListResultCallbackTest(id: 0)
    }
    
    /**
    Test for obtaining the current display orientation
    */
    func testFileSystem() {
        
        let date = NSDate()
        let timestamp:Int64 = Int64(date.timeIntervalSince1970*1000)
        
        // Folder properties
        let folder:FileDescriptor = FileDescriptor()
        folder.setName("test")
        folder.setPath(AppRegistryBridge.sharedInstance.getFileSystemBridge().getApplicationDocumentsFolder()!.getPathAbsolute()!)
        folder.setPathAbsolute(folder.getPath()! + "/" + folder.getName()!)
        folder.setSize(0)
        folder.setDateCreated(timestamp)
        folder.setDateModified(timestamp)
        
        // File properties
        let file:FileDescriptor = FileDescriptor()
        file.setPath(folder.getPathAbsolute()!)
        file.setName("test.txt")
        file.setPathAbsolute(file.getPath()! + "/" + file.getName()!)
        file.setSize(0)
        file.setDateCreated(timestamp)
        file.setDateModified(timestamp)
        
        // Create DIR
        XCTAssertTrue(AppRegistryBridge.sharedInstance.getFileBridge().mkDir(folder, recursive: true)!, "There is a problem creating the folder. See log")
        XCTAssertTrue(AppRegistryBridge.sharedInstance.getFileBridge().isDirectory(folder)!, "The type of the folder is not a directory. See log")
        
        // Create FILE
        AppRegistryBridge.sharedInstance.getFileBridge().create(file, callback: fileResultCallback)
        XCTAssertTrue(AppRegistryBridge.sharedInstance.getFileBridge().exists(file)!, "There file is not successfully created. See log")
        
        // Rename FILE
        let file2:FileDescriptor = AppRegistryBridge.sharedInstance.getFileSystemBridge().createFileDescriptor(file, name: "test3.txt")!
        AppRegistryBridge.sharedInstance.getFileBridge().move(file, destination: file2, createPath: false, overwrite: true, callback: fileResultCallback)
        XCTAssertTrue(AppRegistryBridge.sharedInstance.getFileBridge().exists(file2)!, "There file is not successfully moved. See log")
        
        // Set&Get Content FILE
        AppRegistryBridge.sharedInstance.getFileBridge().setContent(file2, content: [UInt8(0xFF), UInt8(0xD9)], callback: fileDataStoreResultCallback)
        AppRegistryBridge.sharedInstance.getFileBridge().getContent(file2, callback: fileDataLoadResultCallback)
        
        // Get FILE properties
        XCTAssertEqual(AppRegistryBridge.sharedInstance.getFileBridge().getFileStorageType(file2)!, IFileSystemStorageType.Application, "The file storage file is not correct")
        XCTAssertEqual(AppRegistryBridge.sharedInstance.getFileBridge().getFileType(file2)!, IFileSystemType.File, "The file type is not correct")
        XCTAssertEqual(AppRegistryBridge.sharedInstance.getFileBridge().getFileType(folder)!, IFileSystemType.Directory, "The file type is not correct")
        XCTAssertEqual(AppRegistryBridge.sharedInstance.getFileBridge().getSecurityType(file2)!, IFileSystemSecurity.Protected, "The file security type is not correct")
        
        // List Files
        AppRegistryBridge.sharedInstance.getFileBridge().listFiles(folder, callback: fileListResultCallback)        
        
        // Delete FILE
        XCTAssertTrue(AppRegistryBridge.sharedInstance.getFileBridge().delete(file2, cascade: true)!, "There is a problem deleting the file the file. See log")
        XCTAssertFalse(AppRegistryBridge.sharedInstance.getFileBridge().exists(file2)!, "There file is not successfully deleted. See log")
        
        // Delete DIR
        XCTAssertTrue(AppRegistryBridge.sharedInstance.getFileBridge().delete(folder, cascade: true)!, "There is a problem deleting the folder. See log")
        XCTAssertFalse(AppRegistryBridge.sharedInstance.getFileBridge().exists(folder)!, "There folder is not successfully deleted. See log")
    }

}
