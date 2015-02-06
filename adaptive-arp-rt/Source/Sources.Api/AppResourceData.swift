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

    * @version v2.1.5

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   This class represents a resource provided by the platform from the application's secure payload.

   @author Carlos Lozano Diez
   @since v2.1.3
   @version 1.0
*/
public class AppResourceData : NSObject {

    /**
       Marker to indicate whether the resource is cooked in some way (compressed, encrypted, etc.) If true, the
implementation must uncompress/unencrypt following the cookedType recipe specified by the payload.
    */
    var cooked : Bool?
    /**
       This is the length of the payload after cooking. In general, this length indicates the amount
of space saved with regard to the rawLength of the payload.
    */
    var cookedLength : Int64?
    /**
       If the data is cooked, this field should contain the recipe to return the cooked data to its original
uncompressed/unencrypted/etc format.
    */
    var cookedType : String?
    /**
       The payload data of the resource in ready to consume format.
    */
    var data : [Byte]?
    /**
       The id or path identifier of the resource.
    */
    var id : String?
    /**
       The raw length of the payload before any cooking occurred. This is equivalent to the size of the resource
after uncompressing and unencrypting.
    */
    var rawLength : Int64?
    /**
       The raw type of the payload - this is equivalent to the mimetype of the content.
    */
    var rawType : String?

    /**
       Default constructor.

       @since v2.1.3
    */
    public override init() {
        super.init()
    }

    /**
       Convenience constructor.

       @param id           The id or path of the resource retrieved.
       @param data         The payload data of the resource (uncooked).
       @param rawType      The raw type/mimetype of the resource.
       @param rawLength    The raw length/original length in bytes of the resource.
       @param cooked       True if the resource is cooked.
       @param cookedType   Type of recipe used for cooking.
       @param cookedLength The cooked length in bytes of the resource.
       @since v2.1.3
    */
    public init(id: String, data: [Byte], rawType: String, rawLength: Int64, cooked: Bool, cookedType: String, cookedLength: Int64) {
        super.init()
        self.id = id
        self.data = data
        self.rawType = rawType
        self.rawLength = rawLength
        self.cooked = cooked
        self.cookedType = cookedType
        self.cookedLength = cookedLength
    }

    /**
       Attribute to denote whether the payload of the resource is cooked.

       @return True if the resource is cooked, false otherwise.
       @since v2.1.3
    */
    public func getCooked() -> Bool? {
        return self.cooked
    }

    /**
       Attribute to denote whether the payload of the resource is cooked.

       @param cooked True if the resource is cooked, false otherwise.
       @since v2.1.3
    */
    public func setCooked(cooked: Bool) {
        self.cooked = cooked
    }

    /**
       The length in bytes of the payload after cooking.

       @return Length in bytes of cooked payload.
       @since v2.1.3
    */
    public func getCookedLength() -> Int64? {
        return self.cookedLength
    }

    /**
       The length in bytes of the payload after cooking.

       @param cookedLength Length in bytes of cooked payload.
       @since v2.1.3
    */
    public func setCookedLength(cookedLength: Int64) {
        self.cookedLength = cookedLength
    }

    /**
       If the resource is cooked, this will return the recipe used during cooking.

       @return The cooking recipe to reverse the cooking process.
       @since v2.1.3
    */
    public func getCookedType() -> String? {
        return self.cookedType
    }

    /**
       If the resource is cooked, the type of recipe used during cooking.

       @param cookedType The cooking recipe used during cooking.
       @since v2.1.3
    */
    public func setCookedType(cookedType: String) {
        self.cookedType = cookedType
    }

    /**
       Returns the payload of the resource.

       @return Binary payload of the resource.
       @since v2.1.3
    */
    public func getData() -> [Byte]? {
        return self.data
    }

    /**
       Sets the payload of the resource.

       @param data Binary payload of the resource.
       @since v2.1.3
    */
    public func setData(data: [Byte]) {
        self.data = data
    }

    /**
       Gets The id or path identifier of the resource.

       @return id The id or path identifier of the resource.
    */
    public func getId() -> String? {
        return self.id
    }

    /**
       Sets the id or path of the resource.

       @param id The id or path of the resource.
       @since v2.1.3
    */
    public func setId(id: String) {
        self.id = id
    }

    /**
       Gets the resource payload's original length.

       @return Original length of the resource in bytes before cooking.
       @since v2.1.3
    */
    public func getRawLength() -> Int64? {
        return self.rawLength
    }

    /**
       Sets the resource payload's original length.

       @param rawLength Original length of the resource in bytes before cooking.
       @since v2.1.3
    */
    public func setRawLength(rawLength: Int64) {
        self.rawLength = rawLength
    }

    /**
       Gets the resource's raw type or mimetype.

       @return Resource's type or mimetype.
       @since v2.1.3
    */
    public func getRawType() -> String? {
        return self.rawType
    }

    /**
       Sets the resource's raw type or mimetype.

       @param rawType Resource's type or mimetype.
       @since v2.1.3
    */
    public func setRawType(rawType: String) {
        self.rawType = rawType
    }


    /**
       JSON Serialization and deserialization support.
    */
    struct Serializer {
        static func fromJSON(json : String) -> AppResourceData {
            var data:NSData = json.dataUsingEncoding(NSUTF8StringEncoding)!
            var jsonError: NSError?
            let dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary
            return fromDictionary(dict)
        }

        static func fromDictionary(dict : NSDictionary) -> AppResourceData {
            var resultObject : AppResourceData = AppResourceData()

            if let value : AnyObject = dict.objectForKey("cooked") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.cooked = (value as Bool)
                }
            }

            if let value : AnyObject = dict.objectForKey("cookedLength") {
                if "\(value)" as NSString != "<null>" {
                    var numValue = value as? NSNumber
                    resultObject.cookedLength = numValue?.longLongValue
                }
            }

            if let value : AnyObject = dict.objectForKey("cookedType") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.cookedType = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("data") {
                if "\(value)" as NSString != "<null>" {
                    var data : [Byte] = [Byte](count: (value as NSArray).count, repeatedValue: 0)
                    var dataData : NSData = (value as NSData)
                    dataData.getBytes(&data, length: (value as NSArray).count * sizeof(UInt8))
                    resultObject.data = data
                }
            }

            if let value : AnyObject = dict.objectForKey("id") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.id = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("rawLength") {
                if "\(value)" as NSString != "<null>" {
                    var numValue = value as? NSNumber
                    resultObject.rawLength = numValue?.longLongValue
                }
            }

            if let value : AnyObject = dict.objectForKey("rawType") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.rawType = (value as String)
                }
            }

            return resultObject
        }

        static func toJSON(object: AppResourceData) -> String {
            var jsonString : NSMutableString = NSMutableString()
            // Start Object to JSON
            jsonString.appendString("{ ")

            // Fields.
            object.cooked != nil ? jsonString.appendString("\"cooked\": \(object.cooked!), ") : jsonString.appendString("\"cooked\": null, ")
            object.cookedLength != nil ? jsonString.appendString("\"cookedLength\": \(object.cookedLength!), ") : jsonString.appendString("\"cookedLength\": null, ")
            object.cookedType != nil ? jsonString.appendString("\"cookedType\": \"\(JSONUtil.escapeString(object.cookedType!))\", ") : jsonString.appendString("\"cookedType\": null, ")
            if (object.data != nil) {
                // Start array of objects.
                jsonString.appendString("\"data\": [")

                for var i = 0; i < object.data!.count; i++ {
                    jsonString.appendString("\(object.data![i])")
                    if (i < object.data!.count-1) {
                        jsonString.appendString(", ");
                    }
                }

                // End array of objects.
                jsonString.appendString("], ");
            } else {
                jsonString.appendString("\"data\": null, ")
            }
            object.id != nil ? jsonString.appendString("\"id\": \"\(JSONUtil.escapeString(object.id!))\", ") : jsonString.appendString("\"id\": null, ")
            object.rawLength != nil ? jsonString.appendString("\"rawLength\": \(object.rawLength!), ") : jsonString.appendString("\"rawLength\": null, ")
            object.rawType != nil ? jsonString.appendString("\"rawType\": \"\(JSONUtil.escapeString(object.rawType!))\"") : jsonString.appendString("\"rawType\": null")

            // End Object to JSON
            jsonString.appendString(" }")
            return jsonString
        }
    }
}

/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
