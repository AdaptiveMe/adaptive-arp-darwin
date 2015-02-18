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

    * @version v2.1.7

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Represents a basic bean to store keyName pair values

   @author Ferran Vila Conesa
   @since v2.0
   @version 1.0
*/
public class KeyPair : APIBean {

    /**
       Key of the element
    */
    var keyName : String?
    /**
       Value of the element
    */
    var keyValue : String?

    /**
       Default Constructor

       @since v2.0
    */
    public override init() {
        super.init()
    }

    /**
       Constructor using fields

       @param keyName  Key of the element
       @param keyValue Value of the element
       @since v2.0
    */
    public init(keyName: String, keyValue: String) {
        super.init()
        self.keyName = keyName
        self.keyValue = keyValue
    }

    /**
       Returns the keyName of the element

       @return Key of the element
       @since v2.0
    */
    public func getKeyName() -> String? {
        return self.keyName
    }

    /**
       Sets the keyName of the element

       @param keyName Key of the element
       @since v2.0
    */
    public func setKeyName(keyName: String) {
        self.keyName = keyName
    }

    /**
       Returns the keyValue of the element

       @return Value of the element
       @since v2.0
    */
    public func getKeyValue() -> String? {
        return self.keyValue
    }

    /**
       Sets the keyValue of the element

       @param keyValue Value of the element
       @since v2.0
    */
    public func setKeyValue(keyValue: String) {
        self.keyValue = keyValue
    }


    /**
       JSON Serialization and deserialization support.
    */
    struct Serializer {
        static func fromJSON(json : String) -> KeyPair {
            var data:NSData = json.dataUsingEncoding(NSUTF8StringEncoding)!
            var jsonError: NSError?
            let dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary
            return fromDictionary(dict)
        }

        static func fromDictionary(dict : NSDictionary) -> KeyPair {
            var resultObject : KeyPair = KeyPair()

            if let value : AnyObject = dict.objectForKey("keyName") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.keyName = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("keyValue") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.keyValue = (value as String)
                }
            }

            return resultObject
        }

        static func toJSON(object: KeyPair) -> String {
            var jsonString : NSMutableString = NSMutableString()
            // Start Object to JSON
            jsonString.appendString("{ ")

            // Fields.
            object.keyName != nil ? jsonString.appendString("\"keyName\": \"\(JSONUtil.escapeString(object.keyName!))\", ") : jsonString.appendString("\"keyName\": null, ")
            object.keyValue != nil ? jsonString.appendString("\"keyValue\": \"\(JSONUtil.escapeString(object.keyValue!))\"") : jsonString.appendString("\"keyValue\": null")

            // End Object to JSON
            jsonString.appendString(" }")
            return jsonString
        }
    }
}

/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
