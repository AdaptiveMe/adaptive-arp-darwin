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

public class FileSystemImpl: IFileSystem {
    
    public var description : String { get {
        return ""
    }}

    public func create(path : IFilePath, name : String, callback : IFileResultCallback) {
        
    }
    
    public func create(path : String, name : String, callback : IFileResultCallback) {
        
    }
    
    public func create(name : String, callback : IFileResultCallback) {
        
    }
    
    public func getApplicationCacheFolder() -> IFilePath? {
        return nil
    }
    
    public func getApplicationDocumentsFolder() -> IFilePath? {
        return nil
    }
    
    public func getApplicationFolder() -> IFilePath? {
        return nil
    }
    
    public func getPath(file : IFile) -> String? {
        return nil
    }
    
    public func getPath(path : IFilePath) -> String? {
        return nil
    }
    
    public func getSeparator() -> Character {
        return "a"
    }
    
    public func isSameFile(source : IFile, dest : IFile) -> Bool {
        return false
    }
    
    public func isSamePath(source : IFilePath, dest : IFilePath) -> Bool {
        return false
    }
    
    public func toPath(path : IFile) -> IFilePath? {
        return nil
    }
    
}
