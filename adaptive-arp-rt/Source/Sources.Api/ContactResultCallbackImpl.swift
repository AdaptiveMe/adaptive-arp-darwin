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

    * @version v2.1.3

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Interface for Managing the Contact operations
   Auto-generated implementation of IContactResultCallback specification.
*/
public class ContactResultCallbackImpl : BaseCallbackImpl, IContactResultCallback {

    /**
       Constructor with callback id.

       @param id  The id of the callback.
    */
    public override init(id : Int64) {
        super.init(id: id)
    }

    /**
       This method is called on Error

       @param error returned by the platform
       @since v2.0
    */
    public func onError(error : IContactResultCallbackError) { 
        var param0 : String = "Adaptive.IContactResultCallbackError.toObject(JSON.parse(\"{ \"value\": \"\(error.toString())\"}\"))"
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("Adaptive.handleContactResultCallbackError( \"\(getId())\", \(param0))")
    }

    /**
       This method is called on Result

       @param contacts returned by the platform
       @since v2.0
    */
    public func onResult(contacts : [Contact]) { 
        var param0Array : NSMutableString = NSMutableString()
        param0Array.appendString("[")
        for (index,obj) in enumerate(contacts) {
            param0Array.appendString("Adaptive.Contact.toObject(JSON.parse(\"\(JSONUtil.escapeString(Contact.Serializer.toJSON(obj)))\"))")
            if index < contacts.count-1 {
                param0Array.appendString(", ")
            }
        }
        param0Array.appendString("]")
        var param0 : String = param0Array as String
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("Adaptive.handleContactResultCallbackResult( \"\(getId())\", \(param0))")
    }

    /**
       This method is called on Warning

       @param contacts returned by the platform
       @param warning  returned by the platform
       @since v2.0
    */
    public func onWarning(contacts : [Contact], warning : IContactResultCallbackWarning) { 
        var param0Array : NSMutableString = NSMutableString()
        param0Array.appendString("[")
        for (index,obj) in enumerate(contacts) {
            param0Array.appendString("Adaptive.Contact.toObject(JSON.parse(\"\(JSONUtil.escapeString(Contact.Serializer.toJSON(obj)))\"))")
            if index < contacts.count-1 {
                param0Array.appendString(", ")
            }
        }
        param0Array.appendString("]")
        var param0 : String = param0Array as String
        var param1 : String = "Adaptive.IContactResultCallbackWarning.toObject(JSON.parse(\"{ \"value\": \"\(warning.toString())\"}\"))"
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("Adaptive.handleContactResultCallbackWarning( \"\(getId())\", \(param0), \(param1))")
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
