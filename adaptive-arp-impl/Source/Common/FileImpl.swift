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

import AdaptiveArpApi

public class FileImpl: IFile {
    
    /// MARK: in this class it is necessary to override the description method instead of importing the NSObject interface because this Interface define a method delete(sender:AnyObject) that conflict with the method delete(cascade:Bool) from IFile
    public var description : String { get {
        return getName()!
    }}
    
    public func canRead() -> Bool {
        return false
    }
    
    public func canWrite() -> Bool {
        return false
    }
    
    public func createWithPath(path : String, name : String, callback : IFileResultCallback) {
        
    }
    
    public func create(name : String, callback : IFileResultCallback) {
        
    }
    
    public func delete(cascade : Bool) -> Bool {
        return true
    }
    
    public func exists() -> Bool {
        return false
    }
    
    public func getContent(callback : IFileDataResultCallback) {
        
    }
    
    public func getDateCreated() -> Int64 {
        return 0
    }
    
    public func getDateModified() -> Int64 {
        return 0
    }
    
    public func getName() -> String? {
        return nil
    }
    
    public func getPath() -> String? {
        return nil
    }
    
    public func getSize() -> Int64 {
        return 0
    }
    
    public func isDirectory() -> Bool {
        return false
    }
    
    public func listFilesForRegex(regex : String, callback : IFileListResultCallback) {
        
    }
    
    public func listFiles(callback : IFileListResultCallback) {
        
    }
    
    public func mkDir() -> Bool {
        return false
    }
    
    public func mkDir(recursive : Bool) -> Bool {
        return false
    }
    
    public func move(newFile : IFile, createPath : Bool, callback : IFileResultCallback, overwrite : Bool) {
        
    }
    
    public func setContent(content : [Byte], callback : IFileDataResultCallback) {
        
    }
    
    public func toPath() -> IFilePath? {
        return nil
    }
    
    public func endsWithPath(other : IFilePath) -> Bool {
        return false
    }
    
    public func endsWith(other : String) -> Bool {
        return false
    }
    
    public func equalPath(other : IFilePath) -> Bool {
        return false
    }
    
    public func equals(other : String) -> Bool {
        return false
    }
    
    public func getFileName() -> IFilePath? {
        return nil
    }
    
    public func getFileSystem() -> IFileSystem? {
        return nil
    }
    
    public func getNameAtIndex(index : Int) -> String? {
        return ""
    }
    
    public func getNameCount() -> Int {
        return 0
    }
    
    public func getParent() -> IFilePath? {
        return nil
    }
    
    public func getRoot() -> IFilePath? {
        return nil
    }
    
    public func isAbsolute() -> Bool {
        return false
    }
    
    public func normalize() -> IFilePath? {
        return nil
    }
    
    public func relativize(other : IFilePath) -> IFilePath? {
        return nil
    }
    
    public func resolvePath(other : IFilePath) -> IFilePath? {
        return nil
    }
    
    public func resolveSiblingPath(other : IFilePath) -> IFilePath? {
        return nil
    }
    
    public func resolveSibling(other : String) -> IFilePath? {
        return nil
    }
    
    public func resolve(other : String) -> IFilePath? {
        return nil
    }
    
    public func startsWithPath(other : IFilePath) -> Bool {
        return false
    }
    
    public func startsWith(other : String) -> Bool {
        return false
    }
    
    public func toAbsolutePath() -> IFilePath? {
        return nil
    }
    
    public func toFile() -> IFile? {
        return nil
    }
    
    public func toString() -> String? {
        return ""
    }
    
    
}