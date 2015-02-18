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

    * @version v2.1.6

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Structure representing the binary attachment data.

   @author Francisco Javier Martin Bueno
   @since v2.0
   @version 1.0
*/
public class EmailAttachmentData : APIBean {

    /**
       The raw data for the current file attachment (byte array)
    */
    var data : [Byte]?
    /**
       The name of the current file attachment
    */
    var fileName : String?
    /**
       The mime type of the current attachment
    */
    var mimeType : String?
    /**
       The relative path where the contents for the attachment file could be located.
    */
    var referenceUrl : String?
    /**
       The data size (in bytes) of the current file attachment
    */
    var size : Int64?

    /**
       Default Constructor

       @since v2.0
    */
    public override init() {
        super.init()
    }

    /**
       Constructor with fields

       @param data         raw data of the file attachment
       @param size         size of the file attachment
       @param fileName     name of the file attachment
       @param mimeType     mime type of the file attachment
       @param referenceUrl relative url of the file attachment
       @since v2.0
    */
    public init(data: [Byte], size: Int64, fileName: String, mimeType: String, referenceUrl: String) {
        super.init()
        self.data = data
        self.size = size
        self.fileName = fileName
        self.mimeType = mimeType
        self.referenceUrl = referenceUrl
    }

    /**
       Returns the raw data in byte[]

       @return data Octet-binary content of the attachment payload.
       @since v2.0
    */
    public func getData() -> [Byte]? {
        return self.data
    }

    /**
       Set the data of the attachment as a byte[]

       @param data Sets the octet-binary content of the attachment.
       @since v2.0
    */
    public func setData(data: [Byte]) {
        self.data = data
    }

    /**
       Returns the filename of the attachment

       @return fileName Name of the attachment.
       @since v2.0
    */
    public func getFileName() -> String? {
        return self.fileName
    }

    /**
       Set the name of the file attachment

       @param fileName Name of the attachment.
       @since v2.0
    */
    public func setFileName(fileName: String) {
        self.fileName = fileName
    }

    /**
       Returns the mime type of the attachment

       @return mimeType
       @since v2.0
    */
    public func getMimeType() -> String? {
        return self.mimeType
    }

    /**
       Set the mime type of the attachment

       @param mimeType Mime-type of the attachment.
       @since v2.0
    */
    public func setMimeType(mimeType: String) {
        self.mimeType = mimeType
    }

    /**
       Returns the absolute url of the file attachment

       @return referenceUrl Absolute URL of the file attachment for either file:// or http:// access.
       @since v2.0
    */
    public func getReferenceUrl() -> String? {
        return self.referenceUrl
    }

    /**
       Set the absolute url of the attachment

       @param referenceUrl Absolute URL of the file attachment for either file:// or http:// access.
       @since v2.0
    */
    public func setReferenceUrl(referenceUrl: String) {
        self.referenceUrl = referenceUrl
    }

    /**
       Returns the size of the attachment as a long

       @return size Length in bytes of the octet-binary content.
       @since v2.0
    */
    public func getSize() -> Int64? {
        return self.size
    }

    /**
       Set the size of the attachment as a long

       @param size Length in bytes of the octet-binary content ( should be same as data array length.)
       @since v2.0
    */
    public func setSize(size: Int64) {
        self.size = size
    }


    /**
       JSON Serialization and deserialization support.
    */
    struct Serializer {
        static func fromJSON(json : String) -> EmailAttachmentData {
            var data:NSData = json.dataUsingEncoding(NSUTF8StringEncoding)!
            var jsonError: NSError?
            let dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary
            return fromDictionary(dict)
        }

        static func fromDictionary(dict : NSDictionary) -> EmailAttachmentData {
            var resultObject : EmailAttachmentData = EmailAttachmentData()

            if let value : AnyObject = dict.objectForKey("data") {
                if "\(value)" as NSString != "<null>" {
                    var data : [Byte] = [Byte](count: (value as NSArray).count, repeatedValue: 0)
                    var dataData : NSData = (value as NSData)
                    dataData.getBytes(&data, length: (value as NSArray).count * sizeof(UInt8))
                    resultObject.data = data
                }
            }

            if let value : AnyObject = dict.objectForKey("fileName") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.fileName = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("mimeType") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.mimeType = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("referenceUrl") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.referenceUrl = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("size") {
                if "\(value)" as NSString != "<null>" {
                    var numValue = value as? NSNumber
                    resultObject.size = numValue?.longLongValue
                }
            }

            return resultObject
        }

        static func toJSON(object: EmailAttachmentData) -> String {
            var jsonString : NSMutableString = NSMutableString()
            // Start Object to JSON
            jsonString.appendString("{ ")

            // Fields.
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
            object.fileName != nil ? jsonString.appendString("\"fileName\": \"\(JSONUtil.escapeString(object.fileName!))\", ") : jsonString.appendString("\"fileName\": null, ")
            object.mimeType != nil ? jsonString.appendString("\"mimeType\": \"\(JSONUtil.escapeString(object.mimeType!))\", ") : jsonString.appendString("\"mimeType\": null, ")
            object.referenceUrl != nil ? jsonString.appendString("\"referenceUrl\": \"\(JSONUtil.escapeString(object.referenceUrl!))\", ") : jsonString.appendString("\"referenceUrl\": null, ")
            object.size != nil ? jsonString.appendString("\"size\": \(object.size!)") : jsonString.appendString("\"size\": null")

            // End Object to JSON
            jsonString.appendString(" }")
            return jsonString
        }
    }
}

/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
