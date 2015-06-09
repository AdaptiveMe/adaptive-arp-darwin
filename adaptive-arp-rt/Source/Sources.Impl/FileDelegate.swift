/**
--| ADAPTIVE RUNTIME PLATFORM |----------------------------------------------------------------------------------------

(C) Copyright 2013-2015 Carlos Lozano Diez t/a Adaptive.me <http://adaptive.me>.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the
License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0 . Unless required by appli-
-cable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,  WITHOUT
WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the  License  for the specific language governing
permissions and limitations under the License.

Original author:

* Carlos Lozano Diez
<http://github.com/carloslozano>
<http://twitter.com/adaptivecoder>
<mailto:carlos@adaptive.me>

Contributors:

* Ferran Vila Conesa
<http://github.com/fnva>
<http://twitter.com/ferran_vila>
<mailto:ferran.vila.conesa@gmail.com>

* See source code files for contributors.

Release:

* @version v2.0.2

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation
import AdaptiveArpApi

/**
Interface for Managing the File operations
Auto-generated implementation of IFile specification.
*/
public class FileDelegate : BaseDataDelegate, IFile {
    
    /// Logger variable
    let logger : ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge()
    let loggerTag : String = "FileDelegate"
    
    /**
    Default Constructor.
    */
    public override init() {
        super.init()
    }
    
    /**
    Determine whether the current file/folder can be read from.
    
    @param descriptor File descriptor of file or folder used for operation.
    @return True if the folder/file is readable, false otherwise.
    @since ARP1.0
    */
    public func canRead(descriptor : FileDescriptor) -> Bool? {
        
        return NSFileManager.defaultManager().isReadableFileAtPath(descriptor.getPathAbsolute()!)
    }
    
    /**
    Determine whether the current file/folder can be written to.
    
    @param descriptor File descriptor of file or folder used for operation.
    @return True if the folder/file is writable, false otherwise.
    @since ARP1.0
    */
    public func canWrite(descriptor : FileDescriptor) -> Bool? {
        
        return NSFileManager.defaultManager().isWritableFileAtPath(descriptor.getPathAbsolute()!)
    }
    
    /**
    Creates a file with the specified name.
    
    @param descriptor File descriptor of file or folder used for operation.
    @param callback Result of the operation.
    @since ARP1.0
    */
    public func create(descriptor : FileDescriptor, callback : IFileResultCallback) {
        
        if !self.exists(descriptor)! {
            
            if NSFileManager.defaultManager().createFileAtPath(descriptor.getPathAbsolute()!, contents: nil, attributes: nil) {
                callback.onResult(descriptor)
            } else {
                logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "It's not possible to create the file.")
                callback.onError(IFileResultCallbackError.Unauthorized)
            }
            
        } else {
            logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The file alredy exists.")
            callback.onError(IFileResultCallbackError.FileExists)
        }
        
    }
    
    /**
    Deletes the given file or path. If the file is a directory and contains files and or subdirectories, these will be
    deleted if the cascade parameter is set to true.
    
    @param descriptor File descriptor of file or folder used for operation.
    @param cascade Whether to delete sub-files and sub-folders.
    @return True if files (and sub-files and folders) whether deleted.
    @since ARP1.0
    */
    public func delete(descriptor : FileDescriptor, cascade : Bool) -> Bool? {
        
        if NSFileManager.defaultManager().isDeletableFileAtPath(descriptor.getPathAbsolute()!) {
            
            logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "It's a file.")
            
            var error:NSError?
            let ok:Bool = NSFileManager.defaultManager().removeItemAtPath(descriptor.getPathAbsolute()!, error: &error)
            
            if let error = error {
                logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "There is an error deleting the file: \(error)")
                return false
                
            } else {
                
                if ok {
                    return true
                } else {
                    logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "There is an error deleting the file.")
                    return false
                }
            }
            
        } else {
            logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The path: \(descriptor.getPathAbsolute()) is not deletable.")
            return false
        }
    }
    
    /**
    Check whether the file/path exists.
    
    @param descriptor File descriptor of file or folder used for operation.
    @return True if the file exists in the filesystem, false otherwise.
    @since ARP1.0
    */
    public func exists(descriptor : FileDescriptor) -> Bool? {
        
        return NSFileManager.defaultManager().fileExistsAtPath(descriptor.getPathAbsolute()!)
    }
    
    /**
    Loads the content of the file.
    
    @param descriptor File descriptor of file or folder used for operation.
    @param callback Result of the operation.
    @since ARP1.0
    */
    public func getContent(descriptor : FileDescriptor, callback : IFileDataLoadResultCallback) {
        
        if self.exists(descriptor)! {
            
            if let data = NSFileManager.defaultManager().contentsAtPath(descriptor.getPathAbsolute()!) {
                
                let count = data.length / sizeof(UInt8)
                var array = [UInt8](count: count, repeatedValue: 0)
                data.getBytes(&array, length:count * sizeof(UInt8))
                
                callback.onResult(array)
                
            } else {
                logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "There is a problem opening the file.")
                callback.onError(IFileDataLoadResultCallbackError.Unauthorized)
            }
            
        } else {
            logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The file not exists.")
            callback.onError(IFileDataLoadResultCallbackError.InexistentFile)
        }
    }
    
    /**
    Returns the file storage type of the file
    
    @param descriptor File descriptor of file or folder used for operation.
    @return Storage Type file
    @since ARP1.0
    */
    public func getFileStorageType(descriptor : FileDescriptor) -> IFileSystemStorageType? {
        
        var delegate:IFileSystem = AppRegistryBridge.sharedInstance.getFileSystemBridge().getDelegate()!
        
        if descriptor.getPathAbsolute()!.rangesOfString(delegate.getApplicationFolder()!.getPathAbsolute()!).startIndex > -1 {
            return IFileSystemStorageType.Application
        } else if descriptor.getPathAbsolute()!.rangesOfString(delegate.getApplicationCacheFolder()!.getPathAbsolute()!).startIndex > -1  {
            return IFileSystemStorageType.Cache
        } else if descriptor.getPathAbsolute()!.rangesOfString(delegate.getApplicationCloudFolder()!.getPathAbsolute()!).startIndex > -1  {
            return IFileSystemStorageType.Cloud
        } else if descriptor.getPathAbsolute()!.rangesOfString(delegate.getApplicationDocumentsFolder()!.getPathAbsolute()!).startIndex > -1  {
            return IFileSystemStorageType.Document
        } else if descriptor.getPathAbsolute()!.rangesOfString(delegate.getSystemExternalFolder()!.getPathAbsolute()!).startIndex > -1  {
            return IFileSystemStorageType.External
        } else if descriptor.getPathAbsolute()!.rangesOfString(delegate.getApplicationProtectedFolder()!.getPathAbsolute()!).startIndex > -1  {
            return IFileSystemStorageType.Protected
        } else {
            return IFileSystemStorageType.Unknown
        }
    }
    
    /**
    Returns the file type
    
    @param descriptor File descriptor of file or folder used for operation.
    @return Returns the file type of the file
    @since ARP1.0
    */
    public func getFileType(descriptor : FileDescriptor) -> IFileSystemType? {
        
        if self.exists(descriptor)! {
            
            if self.isDirectory(descriptor)! {
                return IFileSystemType.Directory
            } else {
                return IFileSystemType.File
            }
            
        } else {
            logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The file not exists.")
            return IFileSystemType.Unknown
        }
    }
    
    /**
    Returns the security type of the file
    
    @param descriptor File descriptor of file or folder used for operation.
    @return Security Level of the file
    @since ARP1.0
    */
    public func getSecurityType(descriptor : FileDescriptor) -> IFileSystemSecurity? {
        
        var delegate:IFileSystem = AppRegistryBridge.sharedInstance.getFileSystemBridge().getDelegate()!
        
        if descriptor.getPathAbsolute()!.rangesOfString(delegate.getApplicationProtectedFolder()!.getPathAbsolute()!).startIndex > -1  {
            return IFileSystemSecurity.Protected
        } else {
            return IFileSystemSecurity.Default
        }
    }
    
    /**
    Check whether this is a path of a file.
    
    @param descriptor File descriptor of file or folder used for operation.
    @return true if this is a path to a folder/directory, false if this is a path to a file.
    @since ARP1.0
    */
    public func isDirectory(descriptor : FileDescriptor) -> Bool? {
        
        var isDir : ObjCBool = false
        if NSFileManager.defaultManager().fileExistsAtPath(descriptor.getPathAbsolute()!, isDirectory:&isDir) {
            if isDir {
                return true
            } else {
                return false
            }
        } else {
            logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The file not exists.")
            return false
        }
    }
    
    /**
    List all the files contained within this file/path reference. If the reference is a file, it will not yield
    any results.
    
    @param descriptor File descriptor of file or folder used for operation.
    @param callback Result of operation.
    @since ARP1.0
    */
    public func listFiles(descriptor : FileDescriptor, callback : IFileListResultCallback) {
        
        self.listFilesForRegex(descriptor, regex: "*", callback: callback)
    }
    
    /**
    List all the files matching the speficied regex filter within this file/path reference. If the reference
    is a file, it will not yield any results.
    
    @param descriptor File descriptor of file or folder used for operation.
    @param regex    Filter (eg. *.jpg, *.png, Fil*) name string.
    @param callback Result of operation.
    @since ARP1.0
    */
    public func listFilesForRegex(descriptor : FileDescriptor, regex : String, callback : IFileListResultCallback) {
        
        if self.isDirectory(descriptor)! {
            
            if let directoryContents =  NSFileManager.defaultManager().contentsOfDirectoryAtPath(descriptor.getPathAbsolute()!, error: nil) {
                logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Directory contents: \(directoryContents)")
                
                var result:[FileDescriptor] = [FileDescriptor]()
                for value in directoryContents {
                    
                    logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "File: \(value)")
                    
                    // Regex
                    if regex == "*" || Utils.validateRegexp(value as! String, regexp: regex) {
                    
                        var file:FileDescriptor = FileDescriptor()
                        file.setPath(value as! String)
                    
                        result.append(file)
                    }
                }
                
                callback.onResult(result)
                
            } else {
                logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "There is a problem obtaining the contents of the directory: \(descriptor.getPathAbsolute()!)")
                callback.onError(IFileListResultCallbackError.InexistentFile)
            }
            
            
        } else {
            logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The directory is a file.")
            callback.onError(IFileListResultCallbackError.InexistentFile)
        }
    }
    
    /**
    Creates the parent path (or paths, if recursive) to the given file/path if it doesn't already exist.
    
    @param descriptor File descriptor of file or folder used for operation.
    @param recursive Whether to create all parent path elements.
    @return True if the path was created, false otherwise (or it exists already).
    @since ARP1.0
    */
    public func mkDir(descriptor : FileDescriptor, recursive : Bool) -> Bool? {
        
        if !self.exists(descriptor)! {
        
            var error:NSError?
            var ok:Bool = NSFileManager.defaultManager().createDirectoryAtPath(descriptor.getPathAbsolute()! + "/" + descriptor.getName()!, withIntermediateDirectories: recursive, attributes: nil, error: &error)
            
            if let error = error {
                logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "There is an error creating the the directory: \(error)")
                return false
            } else {
                if ok {
                    return true
                } else {
                    logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "There is an error creating the the directory.")
                    return false
                }
            }
            
        } else {
            logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The directory alredy exists.")
            return false
        }
    }
    
    /**
    Moves the current file to the given file destination, optionally overwriting and creating the path to the
    new destination file.
    
    @param source File descriptor of file or folder used for operation as source.
    @param destination File descriptor of file or folder used for operation as destination.
    @param createPath True to create the path if it does not already exist.
    @param callback   Result of the operation.
    @param overwrite  True to create the path if it does not already exist.
    @since ARP1.0
    */
    public func move(source : FileDescriptor, destination : FileDescriptor, createPath : Bool, overwrite : Bool, callback : IFileResultCallback) {
        
        
        if self.exists(source)! {
            
            // source exists
            
            var destinationPath:FileDescriptor = AppRegistryBridge.sharedInstance.getFileSystemBridge().createFileDescriptor(destination, name: "")!
            
            if !self.exists(destinationPath)! && createPath {
                
                if createPath {
                    
                    // Destination doesn't exist, but create
                    logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Destination doesn't exists and the create path is enabled")
                    
                    if !self.mkDir(destinationPath, recursive: createPath)! {
                        logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Is not possible to create the destination path.")
                        callback.onError(IFileResultCallbackError.Unknown)
                        return
                    }
                    
                } else {
                    
                    // Destination doesn't exist and not created
                    logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Destination doesn't exist and the createpath is not enabled.")
                    callback.onError(IFileResultCallbackError.Unauthorized)
                    return
                }
                
            
            } else {
                
                // Destination alredy exists
                logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Destination exists, moving the element")
                
            }
            
            // Copy the file            
            
            var error:NSError?
            var ok:Bool = NSFileManager.defaultManager().moveItemAtPath(source.getPathAbsolute()!, toPath: destination.getPathAbsolute()!, error: &error)
            
            if let error = error {
                logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "There is an error moving the item \(source.getPathAbsolute()!) at the specified path: \(destination.getPathAbsolute()!): \(error)")
                callback.onError(IFileResultCallbackError.Unknown)
            } else {
                if ok {
                    logger.log(ILoggingLogLevel.Info, category: loggerTag, message: "Item \(source.getPathAbsolute()!) moved to: \(destination.getPathAbsolute()!) successfully! ")
                    callback.onResult(destination)
                } else {
                    logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "There is an error moving the item \(source.getPathAbsolute()!) at the specified path: \(destination.getPathAbsolute()!)")
                    callback.onError(IFileResultCallbackError.Unknown)
                }
            }
            
            
        } else {
            
            // source doesn't exist
            
            logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The source file doesn't exist.")
            callback.onError(IFileResultCallbackError.SourceInexistent)
        }
    }
    
    
    
    /**
    Sets the content of the file.
    
    @param descriptor File descriptor of file or folder used for operation.
    @param content  Binary content to store in the file.
    @param callback Result of the operation.
    @since ARP1.0
    */
    public func setContent(descriptor : FileDescriptor, content : [UInt8], callback : IFileDataStoreResultCallback) {
        
        if self.exists(descriptor)! {
            
            var data:NSData = NSData(bytes: content, length: content.count)
            
            if NSFileManager.defaultManager().createFileAtPath(descriptor.getPathAbsolute()!, contents: data, attributes: nil) {
                callback.onResult(descriptor)
            } else {
                logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "It's not possible to set the content of the file")
                callback.onError(IFileDataStoreResultCallbackError.Unauthorized)
            }
            
        } else {
            logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The destination file doesn't exist")
            callback.onError(IFileDataStoreResultCallbackError.InexistentFile)
        }
    }
    
}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
