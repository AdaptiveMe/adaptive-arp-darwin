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
   Interface for Managing the File result operations
   Auto-generated implementation of IFileListResultCallback specification.
*/
public class FileListResultCallbackImpl : BaseCallbackImpl, IFileListResultCallback {

    /**
       Constructor with callback id.

       @param id  The id of the callback.
    */
    public override init(id : Int) {
        super.init(id: id)
    }

    /**
       On error result of a file operation.

       @param error Error processing the request.
       @since ARP1.0
    */
    public func onError(error : IFileListResultCallbackError) { 
        var param0 : String = "Adaptive.IFileListResultCallbackError.toObject(JSON.parse(\"{ \"value\": \"\(error.toString())\"}\"))"
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("Adaptive.handleFileListResultCallbackError( \"\(getId())\", \(param0))")
    }

    /**
       On correct result of a file operation.

       @param files Array of resulting files/folders.
       @since ARP1.0
    */
    public func onResult(files : [FileDescriptor]) { 
        var param0Array : NSMutableString = NSMutableString()
        param0Array.appendString("[")
        for (index,obj) in enumerate(files) {
            param0Array.appendString("Adaptive.FileDescriptor.toObject(JSON.parse(\"\(FileDescriptor.Serializer.toJSON(obj))\"))")
            if index < files.count-1 {
                param0Array.appendString(", ")
            }
        }
        param0Array.appendString("]")
        var param0 : String = param0Array as String
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("Adaptive.handleFileListResultCallbackResult( \"\(getId())\", \(param0))")
    }

    /**
       On partial result of a file operation, containing a warning.

       @param files   Array of resulting files/folders.
       @param warning Warning condition encountered.
       @since ARP1.0
    */
    public func onWarning(files : [FileDescriptor], warning : IFileListResultCallbackWarning) { 
        var param0Array : NSMutableString = NSMutableString()
        param0Array.appendString("[")
        for (index,obj) in enumerate(files) {
            param0Array.appendString("Adaptive.FileDescriptor.toObject(JSON.parse(\"\(FileDescriptor.Serializer.toJSON(obj))\"))")
            if index < files.count-1 {
                param0Array.appendString(", ")
            }
        }
        param0Array.appendString("]")
        var param0 : String = param0Array as String
        var param1 : String = "Adaptive.IFileListResultCallbackWarning.toObject(JSON.parse(\"{ \"value\": \"\(warning.toString())\"}\"))"
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("Adaptive.handleFileListResultCallbackWarning( \"\(getId())\", \(param0), \(param1))")
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
