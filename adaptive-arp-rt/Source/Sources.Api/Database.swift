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

    * @version v2.1.1

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Structure representing a database reference.

   @author Ferran Vila Conesa
   @since v2.0
   @version 1.0
*/
public class Database : APIBean {

    /**
       Indicates if database was created or needs to be created as Compressed.
    */
    var compress : Bool?
    /**
       Database Name (name of the .db local file).
    */
    var name : String?

    /**
       Default constructor

       @since v2.0
    */
    public override init() {
        super.init()
    }

    /**
       Default constructor. The compress param is setted to false.

       @param name Name of the table.
       @since v2.0
    */
    public init(name: String) {
        super.init()
        self.name = name
    }

    /**
       Constructor using fields.

       @param name     Name of the DatabaseTable.
       @param compress Compression enabled.
       @since v2.0
    */
    public init(name: String, compress: Bool) {
        super.init()
        self.name = name
        self.compress = compress
    }

    /**
       Returns if the table is compressed

       @return Compression enabled
       @since v2.0
    */
    public func getCompress() -> Bool? {
        return self.compress
    }

    /**
       Sets if the table is compressed or not.

       @param compress Compression enabled
       @since v2.0
    */
    public func setCompress(compress: Bool) {
        self.compress = compress
    }

    /**
       Returns the name.

       @return The name of the table.
       @since v2.0
    */
    public func getName() -> String? {
        return self.name
    }

    /**
       Sets the name of the table.

       @param name The name of the table.
       @since v2.0
    */
    public func setName(name: String) {
        self.name = name
    }


    /**
       JSON Serialization and deserialization support.
    */
    struct Serializer {
        static func fromJSON(json : String) -> Database {
            var data:NSData = json.dataUsingEncoding(NSUTF8StringEncoding)!
            var jsonError: NSError?
            let dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary
            return fromDictionary(dict)
        }

        static func fromDictionary(dict : NSDictionary) -> Database {
            var resultObject : Database = Database()

            if let value : AnyObject = dict.objectForKey("compress") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.compress = (value as Bool)
                }
            }

            if let value : AnyObject = dict.objectForKey("name") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.name = (value as String)
                }
            }

            return resultObject
        }

        static func toJSON(object: Database) -> String {
            var jsonString : NSMutableString = NSMutableString()
            // Start Object to JSON
            jsonString.appendString("{ ")

            // Fields.
            object.compress != nil ? jsonString.appendString("\"compress\": \(object.compress!), ") : jsonString.appendString("\"compress\": null, ")
            object.name != nil ? jsonString.appendString("\"name\": \"\(JSONUtil.escapeString(object.name!))\"") : jsonString.appendString("\"name\": null")

            // End Object to JSON
            jsonString.appendString(" }")
            return jsonString
        }
    }
}

/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
