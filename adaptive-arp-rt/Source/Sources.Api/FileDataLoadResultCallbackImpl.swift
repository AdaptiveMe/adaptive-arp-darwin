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

    * @version v2.2.0

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Interface for Managing the File loading callback responses
   Auto-generated implementation of IFileDataLoadResultCallback specification.
*/
public class FileDataLoadResultCallbackImpl : BaseCallbackImpl, IFileDataLoadResultCallback {

    /**
       Constructor with callback id.

       @param id  The id of the callback.
    */
    public override init(id : Int64) {
        super.init(id: id)
    }

    /**
       Error processing data retrieval/storage operation.

       @param error Error condition encountered.
       @since v2.0
    */
    public func onError(error : IFileDataLoadResultCallbackError) { 
        var param0 : String = "Adaptive.IFileDataLoadResultCallbackError.toObject(JSON.parse(\"{ \\\"value\\\": \\\"\(error.toString())\\\"}\"))"
        var callbackId : Int64 = -1
        if (getId() != nil) {
            callbackId = getId()!
        }
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("Adaptive.handleFileDataLoadResultCallbackError( \(callbackId), \(param0))")
    }

    /**
       Result of data retrieval operation.

       @param data Data loaded.
       @since v2.0
    */
    public func onResult(data : [Byte]) { 
        var param0Array : NSMutableString = NSMutableString()
        param0Array.appendString("[")
        for (index,obj) in enumerate(data) {
            param0Array.appendString("\(obj.value)")
            if index < data.count-1 {
                param0Array.appendString(", ")
            }
        }
        param0Array.appendString("]")
        var param0 : String = param0Array as String
        var callbackId : Int64 = -1
        if (getId() != nil) {
            callbackId = getId()!
        }
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("Adaptive.handleFileDataLoadResultCallbackResult( \(callbackId), \(param0))")
    }

    /**
       Result with warning of data retrieval/storage operation.

       @param data    File being loaded.
       @param warning Warning condition encountered.
       @since v2.0
    */
    public func onWarning(data : [Byte], warning : IFileDataLoadResultCallbackWarning) { 
        var param0Array : NSMutableString = NSMutableString()
        param0Array.appendString("[")
        for (index,obj) in enumerate(data) {
            param0Array.appendString("\(obj.value)")
            if index < data.count-1 {
                param0Array.appendString(", ")
            }
        }
        param0Array.appendString("]")
        var param0 : String = param0Array as String
        var param1 : String = "Adaptive.IFileDataLoadResultCallbackWarning.toObject(JSON.parse(\"{ \\\"value\\\": \\\"\(warning.toString())\\\"}\"))"
        var callbackId : Int64 = -1
        if (getId() != nil) {
            callbackId = getId()!
        }
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("Adaptive.handleFileDataLoadResultCallbackWarning( \(callbackId), \(param0), \(param1))")
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
