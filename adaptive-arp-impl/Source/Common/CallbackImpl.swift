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

public class CallbackImpl: NSObject, IContactPhotoResultCallback, IContactResultCallback, IDatabaseResultCallback, IFileDataResultCallback, IFileListResultCallback, IFileResultCallback, IMessagingCallback, INetworkReachabilityCallback, ISecureKVResultCallback, IServiceResultCallback, ITableResultCallback {
    
    /// IBaseCallback
    public func toString() -> String? { return "" }
    
    /// IContactPhotoResultCallback
    public func onError(error : IContactPhotoResultCallbackError) { }
    public func onResult(contactPhoto : [Byte]) { }
    public func onWarning(contactPhoto : [Byte], warning : IContactPhotoResultCallbackWarning) { }
    
    /// IContactResultCallback
    public func onError(error : IContactResultCallbackError) { }
    public func onResult(contacts : [Contact]) { }
    public func onWarning(contacts : [Contact], warning : IContactResultCallbackWarning) { }
    
    /// IDatabaseResultCallback
    public func onError(error : IDatabaseResultCallbackError) {
        println("ERROR: \(error.toString())")
    }
    public func onResult(database : Database) {
        println("RESULT: \(database)")
    }
    public func onWarning(database : Database, warning : IDatabaseResultCallbackWarning) {
        println("WARNING: \(warning.toString()), \(database)")
    }
    
    /// IFileDataResultCallback
    public func onError(error : IFileDataResultCallbackError) { }
    public func onError(file : IFile, error : IFileDataResultCallbackError) { }
    public func onResult(file : IFile, data : [Byte]) { }
    public func onWarning(file : IFile, warning : IFileDataResultCallbackWarning) { }
    
    /// IFileListResultCallback
    public func onError(error : IFileListResultCallbackError) { }
    public func onError(file : IFile, error : IFileListResultCallbackError) { }
    public func onResult(files : [IFile]) { }
    public func onWarning(files : [IFile], warning : IFileListResultCallbackWarning) { }
    
    /// IFileResultCallback
    public func onError(error : IFileResultCallbackError) { }
    public func onError(file : IFile, error : IFileResultCallbackError) { }
    public func onResult(storageFile : IFile) { }
    public func onWarning(sourceFile : IFile, destinationFile : IFile, warning : IFileResultCallbackWarning) { }
    
    /// IMessagingCallback
    public func onError(error : IMessagingCallbackError) { }
    public func onResult(success : Bool) { }
    public func onWarning(success : Bool, warning : IMessagingCallbackWarning) { }
    
    /// INetworkReachabilityCallback
    public func onError(error : INetworkReachabilityCallbackError) { }
    public func onResult(result : String) { }
    public func onWarning(result : String, warning : INetworkReachabilityCallbackWarning) { }
    
    /// ISecureKVResultCallback
    public func onError(error : ISecureKVResultCallbackError) { }
    public func onResult(keyValues : [SecureKeyPair]) { }
    public func onWarning(keyValues : [SecureKeyPair], warning : ISecureKVResultCallbackWarning) { }
    
    /// IServiceResultCallback
    public func onError(error : IServiceResultCallbackError) { }
    public func onResult(response : ServiceResponse) { }
    public func onWarning(response : ServiceResponse, warning : IServiceResultCallbackWarning) { }
    
    /// ITableResultCallback
    public func onError(error : ITableResultCallbackError) { }
    public func onResult(table : Table) { }
    public func onWarning(table : Table, warning : ITableResultCallbackWarning) { }
}