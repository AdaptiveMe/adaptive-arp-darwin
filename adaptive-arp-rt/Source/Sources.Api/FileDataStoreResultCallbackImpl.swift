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

    * @version v2.0.4

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Interface for Managing the File store operations callback
   Auto-generated implementation of IFileDataStoreResultCallback specification.
*/
public class FileDataStoreResultCallbackImpl : BaseCallbackImpl, IFileDataStoreResultCallback {

    /**
       Constructor with callback id.

       @param id  The id of the callback.
    */
    public override init(id : Int) {
        super.init(id: id)
    }

    /**
       Error processing data retrieval/storage operation.

       @param error Error condition encountered.
       @since ARP1.0
    */
    public func onError(error : IFileDataStoreResultCallbackError) { 
        var param0 : String = "Adaptive.IFileDataStoreResultCallbackError.toObject(JSON.parse(\"{ \"value\": \"\(error.toString())\"}\"))"
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("Adaptive.handleFileDataStoreResultCallbackError( \"\(getId())\", \(param0))")
    }

    /**
       Result of data storage operation.

       @param file File reference to stored data.
       @since ARP1.0
    */
    public func onResult(file : FileDescriptor) { 
        var param0 : String = "Adaptive.FileDescriptor.toObject(JSON.parse(\"\(JSONUtil.escapeString(FileDescriptor.Serializer.toJSON(file)))\"))"
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("Adaptive.handleFileDataStoreResultCallbackResult( \"\(getId())\", \(param0))")
    }

    /**
       Result with warning of data retrieval/storage operation.

       @param file    File being loaded/stored.
       @param warning Warning condition encountered.
       @since ARP1.0
    */
    public func onWarning(file : FileDescriptor, warning : IFileDataStoreResultCallbackWarning) { 
        var param0 : String = "Adaptive.FileDescriptor.toObject(JSON.parse(\"\(JSONUtil.escapeString(FileDescriptor.Serializer.toJSON(file)))\"))"
        var param1 : String = "Adaptive.IFileDataStoreResultCallbackWarning.toObject(JSON.parse(\"{ \"value\": \"\(warning.toString())\"}\"))"
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("Adaptive.handleFileDataStoreResultCallbackWarning( \"\(getId())\", \(param0), \(param1))")
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
