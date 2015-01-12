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
   Interface for Managing the Security result callback
   Auto-generated implementation of ISecurityResultCallback specification.
*/
public class SecurityResultCallbackImpl : BaseCallbackImpl, ISecurityResultCallback {

    /**
       Constructor with callback id.

       @param id  The id of the callback.
    */
    public override init(id : Int) {
        super.init(id: id)
    }

    /**
       No data received - error condition, not authorized .

       @param error Error values
       @since ARP1.0
    */
    public func onError(error : ISecurityResultCallbackError) { 
        var responseJS : NSMutableString = NSMutableString()
        responseJS.appendString("JSON.parse(\"")
        responseJS.appendString("{ \"value\": \"\(error.toString())\" }")
        responseJS.appendString("\")")
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("Adaptive.handleSecurityResultCallbackError( \"\(getId())\", \(responseJS as String))")
    }

    /**
       Correct data received.

       @param keyValues key and values
       @since ARP1.0
    */
    public func onResult(keyValues : [SecureKeyPair]) { 
        var responseJS : NSMutableString = NSMutableString()
        responseJS.appendString("JSON.parse(\"")
        responseJS.appendString("{[")
        for (index,obj) in enumerate(keyValues) {
            responseJS.appendString(SecureKeyPair.Serializer.toJSON(obj))
            if index < keyValues.count-1 {
                responseJS.appendString(", ")
            }
        }
        responseJS.appendString("]}")
        responseJS.appendString("\")")
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("Adaptive.handleSecurityResultCallbackResult( \"\(getId())\", \(responseJS as String))")
    }

    /**
       Data received with warning - ie Found entries with existing key and values have been overriden

       @param keyValues key and values
       @param warning   Warning values
       @since ARP1.0
    */
    public func onWarning(keyValues : [SecureKeyPair], warning : ISecurityResultCallbackWarning) { 
        var responseJS : NSMutableString = NSMutableString()
        responseJS.appendString("JSON.parse(\"")
        responseJS.appendString("{[")
        for (index,obj) in enumerate(keyValues) {
            responseJS.appendString(SecureKeyPair.Serializer.toJSON(obj))
            if index < keyValues.count-1 {
                responseJS.appendString(", ")
            }
        }
        responseJS.appendString("]}")
        responseJS.appendString("\")")
        responseJS.appendString(", ")
        responseJS.appendString("JSON.parse(\"")
        responseJS.appendString("{ \"value\": \"\(warning.toString())\" }")
        responseJS.appendString("\")")
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("Adaptive.handleSecurityResultCallbackWarning( \"\(getId())\", \(responseJS as String))")
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
