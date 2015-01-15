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

    * @version v2.0.3

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Interface for Managing the File operations
   Auto-generated implementation of IFile specification.
*/
public class FileBridge : BaseDataBridge, IFile, APIBridge {

    /**
       API Delegate.
    */
    private var delegate : IFile? = nil

    /**
       Constructor with delegate.

       @param delegate The delegate implementing platform specific functions.
    */
    public init(delegate : IFile?) {
        super.init()
        self.delegate = delegate
    }
    /**
       Get the delegate implementation.
       @return IFile delegate that manages platform specific functions..
    */
    public final func getDelegate() -> IFile? {
        return self.delegate
    }
    /**
       Set the delegate implementation.

       @param delegate The delegate implementing platform specific functions.
    */
    public final func setDelegate(delegate : IFile) {
        self.delegate = delegate;
    }

    /**
       Determine whether the current file/folder can be read from.

       @param descriptor File descriptor of file or folder used for operation.
       @return True if the folder/file is readable, false otherwise.
       @since ARP1.0
    */
    public func canRead(descriptor : FileDescriptor ) -> Bool? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "FileBridge executing canRead({\(descriptor)}).")
        }

        var result : Bool? = false
        if (self.delegate != nil) {
            result = self.delegate!.canRead(descriptor)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "FileBridge executed 'canRead' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "FileBridge no delegate for 'canRead'.")
            }
        }
        return result        
    }

    /**
       Determine whether the current file/folder can be written to.

       @param descriptor File descriptor of file or folder used for operation.
       @return True if the folder/file is writable, false otherwise.
       @since ARP1.0
    */
    public func canWrite(descriptor : FileDescriptor ) -> Bool? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "FileBridge executing canWrite({\(descriptor)}).")
        }

        var result : Bool? = false
        if (self.delegate != nil) {
            result = self.delegate!.canWrite(descriptor)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "FileBridge executed 'canWrite' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "FileBridge no delegate for 'canWrite'.")
            }
        }
        return result        
    }

    /**
       Creates a file with the specified name.

       @param descriptor File descriptor of file or folder used for operation.
       @param callback   Result of the operation.
       @since ARP1.0
    */
    public func create(descriptor : FileDescriptor , callback : IFileResultCallback ) {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "FileBridge executing create({\(descriptor)},{\(callback)}).")
        }

        if (self.delegate != nil) {
            self.delegate!.create(descriptor, callback: callback)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "FileBridge executed 'create' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "FileBridge no delegate for 'create'.")
            }
        }
        
    }

    /**
       Deletes the given file or path. If the file is a directory and contains files and or subdirectories, these will be
deleted if the cascade parameter is set to true.

       @param descriptor File descriptor of file or folder used for operation.
       @param cascade    Whether to delete sub-files and sub-folders.
       @return True if files (and sub-files and folders) whether deleted.
       @since ARP1.0
    */
    public func delete(descriptor : FileDescriptor , cascade : Bool ) -> Bool? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "FileBridge executing delete({\(descriptor)},{\(cascade)}).")
        }

        var result : Bool? = false
        if (self.delegate != nil) {
            result = self.delegate!.delete(descriptor, cascade: cascade)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "FileBridge executed 'delete' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "FileBridge no delegate for 'delete'.")
            }
        }
        return result        
    }

    /**
       Check whether the file/path exists.

       @param descriptor File descriptor of file or folder used for operation.
       @return True if the file exists in the filesystem, false otherwise.
       @since ARP1.0
    */
    public func exists(descriptor : FileDescriptor ) -> Bool? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "FileBridge executing exists({\(descriptor)}).")
        }

        var result : Bool? = false
        if (self.delegate != nil) {
            result = self.delegate!.exists(descriptor)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "FileBridge executed 'exists' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "FileBridge no delegate for 'exists'.")
            }
        }
        return result        
    }

    /**
       Loads the content of the file.

       @param descriptor File descriptor of file or folder used for operation.
       @param callback   Result of the operation.
       @since ARP1.0
    */
    public func getContent(descriptor : FileDescriptor , callback : IFileDataLoadResultCallback ) {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "FileBridge executing getContent({\(descriptor)},{\(callback)}).")
        }

        if (self.delegate != nil) {
            self.delegate!.getContent(descriptor, callback: callback)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "FileBridge executed 'getContent' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "FileBridge no delegate for 'getContent'.")
            }
        }
        
    }

    /**
       Returns the file storage type of the file

       @param descriptor File descriptor of file or folder used for operation.
       @return Storage Type file
       @since ARP1.0
    */
    public func getFileStorageType(descriptor : FileDescriptor ) -> IFileSystemStorageType? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "FileBridge executing getFileStorageType({\(descriptor)}).")
        }

        var result : IFileSystemStorageType? = nil
        if (self.delegate != nil) {
            result = self.delegate!.getFileStorageType(descriptor)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "FileBridge executed 'getFileStorageType' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "FileBridge no delegate for 'getFileStorageType'.")
            }
        }
        return result!        
    }

    /**
       Returns the file type

       @param descriptor File descriptor of file or folder used for operation.
       @return Returns the file type of the file
       @since ARP1.0
    */
    public func getFileType(descriptor : FileDescriptor ) -> IFileSystemType? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "FileBridge executing getFileType({\(descriptor)}).")
        }

        var result : IFileSystemType? = nil
        if (self.delegate != nil) {
            result = self.delegate!.getFileType(descriptor)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "FileBridge executed 'getFileType' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "FileBridge no delegate for 'getFileType'.")
            }
        }
        return result!        
    }

    /**
       Returns the security type of the file

       @param descriptor File descriptor of file or folder used for operation.
       @return Security Level of the file
       @since ARP1.0
    */
    public func getSecurityType(descriptor : FileDescriptor ) -> IFileSystemSecurity? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "FileBridge executing getSecurityType({\(descriptor)}).")
        }

        var result : IFileSystemSecurity? = nil
        if (self.delegate != nil) {
            result = self.delegate!.getSecurityType(descriptor)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "FileBridge executed 'getSecurityType' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "FileBridge no delegate for 'getSecurityType'.")
            }
        }
        return result!        
    }

    /**
       Check whether this is a path of a file.

       @param descriptor File descriptor of file or folder used for operation.
       @return true if this is a path to a folder/directory, false if this is a path to a file.
       @since ARP1.0
    */
    public func isDirectory(descriptor : FileDescriptor ) -> Bool? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "FileBridge executing isDirectory({\(descriptor)}).")
        }

        var result : Bool? = false
        if (self.delegate != nil) {
            result = self.delegate!.isDirectory(descriptor)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "FileBridge executed 'isDirectory' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "FileBridge no delegate for 'isDirectory'.")
            }
        }
        return result        
    }

    /**
       List all the files contained within this file/path reference. If the reference is a file, it will not yield
any results.

       @param descriptor File descriptor of file or folder used for operation.
       @param callback   Result of operation.
       @since ARP1.0
    */
    public func listFiles(descriptor : FileDescriptor , callback : IFileListResultCallback ) {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "FileBridge executing listFiles({\(descriptor)},{\(callback)}).")
        }

        if (self.delegate != nil) {
            self.delegate!.listFiles(descriptor, callback: callback)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "FileBridge executed 'listFiles' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "FileBridge no delegate for 'listFiles'.")
            }
        }
        
    }

    /**
       List all the files matching the speficied regex filter within this file/path reference. If the reference
is a file, it will not yield any results.

       @param descriptor File descriptor of file or folder used for operation.
       @param regex      Filter (eg. *.jpg, *.png, Fil*) name string.
       @param callback   Result of operation.
       @since ARP1.0
    */
    public func listFilesForRegex(descriptor : FileDescriptor , regex : String , callback : IFileListResultCallback ) {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "FileBridge executing listFilesForRegex({\(descriptor)},{\(regex)},{\(callback)}).")
        }

        if (self.delegate != nil) {
            self.delegate!.listFilesForRegex(descriptor, regex: regex, callback: callback)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "FileBridge executed 'listFilesForRegex' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "FileBridge no delegate for 'listFilesForRegex'.")
            }
        }
        
    }

    /**
       Creates the parent path (or paths, if recursive) to the given file/path if it doesn't already exist.

       @param descriptor File descriptor of file or folder used for operation.
       @param recursive  Whether to create all parent path elements.
       @return True if the path was created, false otherwise (or it exists already).
       @since ARP1.0
    */
    public func mkDir(descriptor : FileDescriptor , recursive : Bool ) -> Bool? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "FileBridge executing mkDir({\(descriptor)},{\(recursive)}).")
        }

        var result : Bool? = false
        if (self.delegate != nil) {
            result = self.delegate!.mkDir(descriptor, recursive: recursive)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "FileBridge executed 'mkDir' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "FileBridge no delegate for 'mkDir'.")
            }
        }
        return result        
    }

    /**
       Moves the current file to the given file destination, optionally overwriting and creating the path to the
new destination file.

       @param source      File descriptor of file or folder used for operation as source.
       @param destination File descriptor of file or folder used for operation as destination.
       @param createPath  True to create the path if it does not already exist.
       @param callback    Result of the operation.
       @param overwrite   True to create the path if it does not already exist.
       @since ARP1.0
    */
    public func move(source : FileDescriptor , destination : FileDescriptor , createPath : Bool , overwrite : Bool , callback : IFileResultCallback ) {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "FileBridge executing move({\(source)},{\(destination)},{\(createPath)},{\(overwrite)},{\(callback)}).")
        }

        if (self.delegate != nil) {
            self.delegate!.move(source, destination: destination, createPath: createPath, overwrite: overwrite, callback: callback)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "FileBridge executed 'move' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "FileBridge no delegate for 'move'.")
            }
        }
        
    }

    /**
       Sets the content of the file.

       @param descriptor File descriptor of file or folder used for operation.
       @param content    Binary content to store in the file.
       @param callback   Result of the operation.
       @since ARP1.0
    */
    public func setContent(descriptor : FileDescriptor , content : [Byte] , callback : IFileDataStoreResultCallback ) {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "FileBridge executing setContent({\(descriptor)},{\(content)},{\(callback)}).")
        }

        if (self.delegate != nil) {
            self.delegate!.setContent(descriptor, content: content, callback: callback)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "FileBridge executed 'setContent' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "FileBridge no delegate for 'setContent'.")
            }
        }
        
    }

    /**
       Invokes the given method specified in the API request object.

       @param request APIRequest object containing method name and parameters.
       @return APIResponse with status code, message and JSON response or a JSON null string for void functions. Status code 200 is OK, all others are HTTP standard error conditions.
    */
    public override func invoke(request : APIRequest) -> APIResponse? {
        var response : APIResponse = APIResponse()
        var responseCode : Int = 200
        var responseMessage : String = "OK"
        var responseJSON : String? = "null"
        switch request.getMethodName()! {
            case "canRead":
                var descriptor0 : FileDescriptor? = FileDescriptor.Serializer.fromJSON(request.getParameters()![0])
                var response0 : Bool? = self.canRead(descriptor0!)
                if let response0 = response0 {
                    responseJSON = "\(response0)"
                 } else {
                    responseJSON = "false"
                 }
            case "canWrite":
                var descriptor1 : FileDescriptor? = FileDescriptor.Serializer.fromJSON(request.getParameters()![0])
                var response1 : Bool? = self.canWrite(descriptor1!)
                if let response1 = response1 {
                    responseJSON = "\(response1)"
                 } else {
                    responseJSON = "false"
                 }
            case "create":
                var descriptor2 : FileDescriptor? = FileDescriptor.Serializer.fromJSON(request.getParameters()![0])
                var callback2 : IFileResultCallback? =  FileResultCallbackImpl(id: request.getAsyncId()!)
                self.create(descriptor2!, callback: callback2!);
            case "delete":
                var descriptor3 : FileDescriptor? = FileDescriptor.Serializer.fromJSON(request.getParameters()![0])
                var cascade3 : Bool? = (request.getParameters()![1] as NSString).boolValue
                var response3 : Bool? = self.delete(descriptor3!, cascade: cascade3!)
                if let response3 = response3 {
                    responseJSON = "\(response3)"
                 } else {
                    responseJSON = "false"
                 }
            case "exists":
                var descriptor4 : FileDescriptor? = FileDescriptor.Serializer.fromJSON(request.getParameters()![0])
                var response4 : Bool? = self.exists(descriptor4!)
                if let response4 = response4 {
                    responseJSON = "\(response4)"
                 } else {
                    responseJSON = "false"
                 }
            case "getContent":
                var descriptor5 : FileDescriptor? = FileDescriptor.Serializer.fromJSON(request.getParameters()![0])
                var callback5 : IFileDataLoadResultCallback? =  FileDataLoadResultCallbackImpl(id: request.getAsyncId()!)
                self.getContent(descriptor5!, callback: callback5!);
            case "getFileStorageType":
                var descriptor6 : FileDescriptor? = FileDescriptor.Serializer.fromJSON(request.getParameters()![0])
                var response6 : IFileSystemStorageType? = self.getFileStorageType(descriptor6!)
                if let response6 = response6 {
                    responseJSON = "{ \"value\": \"\(response6.toString())\" }"
                } else {
                    responseJSON = "{ \"value\": \"Unknown\" }"
                }
            case "getFileType":
                var descriptor7 : FileDescriptor? = FileDescriptor.Serializer.fromJSON(request.getParameters()![0])
                var response7 : IFileSystemType? = self.getFileType(descriptor7!)
                if let response7 = response7 {
                    responseJSON = "{ \"value\": \"\(response7.toString())\" }"
                } else {
                    responseJSON = "{ \"value\": \"Unknown\" }"
                }
            case "getSecurityType":
                var descriptor8 : FileDescriptor? = FileDescriptor.Serializer.fromJSON(request.getParameters()![0])
                var response8 : IFileSystemSecurity? = self.getSecurityType(descriptor8!)
                if let response8 = response8 {
                    responseJSON = "{ \"value\": \"\(response8.toString())\" }"
                } else {
                    responseJSON = "{ \"value\": \"Unknown\" }"
                }
            case "isDirectory":
                var descriptor9 : FileDescriptor? = FileDescriptor.Serializer.fromJSON(request.getParameters()![0])
                var response9 : Bool? = self.isDirectory(descriptor9!)
                if let response9 = response9 {
                    responseJSON = "\(response9)"
                 } else {
                    responseJSON = "false"
                 }
            case "listFiles":
                var descriptor10 : FileDescriptor? = FileDescriptor.Serializer.fromJSON(request.getParameters()![0])
                var callback10 : IFileListResultCallback? =  FileListResultCallbackImpl(id: request.getAsyncId()!)
                self.listFiles(descriptor10!, callback: callback10!);
            case "listFilesForRegex":
                var descriptor11 : FileDescriptor? = FileDescriptor.Serializer.fromJSON(request.getParameters()![0])
                var regex11 : String? = JSONUtil.unescapeString(request.getParameters()![1])
                var callback11 : IFileListResultCallback? =  FileListResultCallbackImpl(id: request.getAsyncId()!)
                self.listFilesForRegex(descriptor11!, regex: regex11!, callback: callback11!);
            case "mkDir":
                var descriptor12 : FileDescriptor? = FileDescriptor.Serializer.fromJSON(request.getParameters()![0])
                var recursive12 : Bool? = (request.getParameters()![1] as NSString).boolValue
                var response12 : Bool? = self.mkDir(descriptor12!, recursive: recursive12!)
                if let response12 = response12 {
                    responseJSON = "\(response12)"
                 } else {
                    responseJSON = "false"
                 }
            case "move":
                var source13 : FileDescriptor? = FileDescriptor.Serializer.fromJSON(request.getParameters()![0])
                var destination13 : FileDescriptor? = FileDescriptor.Serializer.fromJSON(request.getParameters()![1])
                var createPath13 : Bool? = (request.getParameters()![2] as NSString).boolValue
                var overwrite13 : Bool? = (request.getParameters()![3] as NSString).boolValue
                var callback13 : IFileResultCallback? =  FileResultCallbackImpl(id: request.getAsyncId()!)
                self.move(source13!, destination: destination13!, createPath: createPath13!, overwrite: overwrite13!, callback: callback13!);
            case "setContent":
                var descriptor14 : FileDescriptor? = FileDescriptor.Serializer.fromJSON(request.getParameters()![0])
                var content14 : [Byte]? = [Byte]()
                var contentArray14 : [String] = JSONUtil.stringElementToArray(request.getParameters()![1])
                for contentElement14 in contentArray14 {
                    content14!.append(Byte((contentElement14 as NSString).intValue))
                }
                var callback14 : IFileDataStoreResultCallback? =  FileDataStoreResultCallbackImpl(id: request.getAsyncId()!)
                self.setContent(descriptor14!, content: content14!, callback: callback14!);
            default:
                // 404 - response null.
                responseCode = 404
                responseMessage = "FileBridge does not provide the function '\(request.getMethodName()!)' Please check your client-side API version; should be API version >= v2.0.3."
        }
        response.setResponse(JSONUtil.escapeString(responseJSON!))
        response.setStatusCode(responseCode)
        response.setStatusMessage(responseMessage)
        return response
    }
}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
