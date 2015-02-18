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

    * @version v2.1.8

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   General key/value holder class.

   @author Carlos Lozano Diez
   @since 2.0.6
   @version 1.0
*/
public class KeyValue : APIBean {

    /**
       Value of the key.
    */
    var keyData : String?
    /**
       Name of the key for the value.
    */
    var keyName : String?

    /**
       Default constructor.

       @since v2.0.6
    */
    public override init() {
        super.init()
    }

    /**
       Convenience constructor.

       @param keyName Name of the key.
       @param keyData Value of the key.
       @since v2.0.6
    */
    public init(keyName: String, keyData: String) {
        super.init()
        self.keyName = keyName
        self.keyData = keyData
    }

    /**
       Gets the value of the key.

       @return Value of the key.
       @since v2.0.6
    */
    public func getKeyData() -> String? {
        return self.keyData
    }

    /**
       Sets the value of the key.

       @param keyData Value of the key.
       @since v2.0.6
    */
    public func setKeyData(keyData: String) {
        self.keyData = keyData
    }

    /**
       Gets the name of the key.

       @return Key name.
       @since v2.0.6
    */
    public func getKeyName() -> String? {
        return self.keyName
    }

    /**
       Sets the name of the key.

       @param keyName Key name.
       @since v2.0.6
    */
    public func setKeyName(keyName: String) {
        self.keyName = keyName
    }


    /**
       JSON Serialization and deserialization support.
    */
    struct Serializer {
        static func fromJSON(json : String) -> KeyValue {
            var data:NSData = json.dataUsingEncoding(NSUTF8StringEncoding)!
            var jsonError: NSError?
            let dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary
            return fromDictionary(dict)
        }

        static func fromDictionary(dict : NSDictionary) -> KeyValue {
            var resultObject : KeyValue = KeyValue()

            if let value : AnyObject = dict.objectForKey("keyData") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.keyData = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("keyName") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.keyName = (value as String)
                }
            }

            return resultObject
        }

        static func toJSON(object: KeyValue) -> String {
            var jsonString : NSMutableString = NSMutableString()
            // Start Object to JSON
            jsonString.appendString("{ ")

            // Fields.
            object.keyData != nil ? jsonString.appendString("\"keyData\": \"\(JSONUtil.escapeString(object.keyData!))\", ") : jsonString.appendString("\"keyData\": null, ")
            object.keyName != nil ? jsonString.appendString("\"keyName\": \"\(JSONUtil.escapeString(object.keyName!))\"") : jsonString.appendString("\"keyName\": null")

            // End Object to JSON
            jsonString.appendString(" }")
            return jsonString
        }
    }
}

/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
