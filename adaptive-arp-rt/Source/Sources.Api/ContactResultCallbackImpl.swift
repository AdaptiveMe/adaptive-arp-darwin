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
   Interface for Managing the Contact operations
   Auto-generated implementation of IContactResultCallback specification.
*/
public class ContactResultCallbackImpl : BaseCallbackImpl, IContactResultCallback {

    /**
       Constructor with callback id.

       @param id  The id of the callback.
    */
    public override init(id : Int) {
        super.init(id: id)
    }

    /**
       This method is called on Error

       @param error returned by the platform
       @since ARP1.0
    */
    public func onError(error : IContactResultCallbackError) { 
        var responseJS : NSMutableString = NSMutableString()
        responseJS.appendString("JSON.parse(\"")
        responseJS.appendString("{ \"value\": \"\(error.toString())\" }")
        responseJS.appendString("\")")
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("handleContactResultCallbackError( \"\(getId())\", \(responseJS as String))")
    }

    /**
       This method is called on Result

       @param contacts returned by the platform
       @since ARP1.0
    */
    public func onResult(contacts : [Contact]) { 
        var responseJS : NSMutableString = NSMutableString()
        responseJS.appendString("JSON.parse(\"")
        responseJS.appendString("{[")
        for (index,obj) in enumerate(contacts) {
            responseJS.appendString(Contact.Serializer.toJSON(obj))
            if index < contacts.count-1 {
                responseJS.appendString(", ")
            }
        }
        responseJS.appendString("]}")
        responseJS.appendString("\")")
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("handleContactResultCallbackResult( \"\(getId())\", \(responseJS as String))")
    }

    /**
       This method is called on Warning

       @param contacts returned by the platform
       @param warning  returned by the platform
       @since ARP1.0
    */
    public func onWarning(contacts : [Contact], warning : IContactResultCallbackWarning) { 
        var responseJS : NSMutableString = NSMutableString()
        responseJS.appendString("JSON.parse(\"")
        responseJS.appendString("{[")
        for (index,obj) in enumerate(contacts) {
            responseJS.appendString(Contact.Serializer.toJSON(obj))
            if index < contacts.count-1 {
                responseJS.appendString(", ")
            }
        }
        responseJS.appendString("]}")
        responseJS.appendString("\")")
        responseJS.appendString(", ")
        responseJS.appendString("JSON.parse(\"")
        responseJS.appendString("{ \"value\": \"\(warning.toString())\" }")
        responseJS.appendString("\")")
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("handleContactResultCallbackWarning( \"\(getId())\", \(responseJS as String))")
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
