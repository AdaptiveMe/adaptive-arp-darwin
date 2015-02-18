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
   Structure representing a JSON response to the HTML5 layer.

   @author Carlos Lozano Diez
   @since v2.0
   @version 1.0
*/
public class APIResponse : NSObject {

    /**
       String representing the JavaScript value or JSON object representation of the response.
    */
    var response : String?
    /**
       Status code of the response
    */
    var statusCode : Int32?
    /**
       Status message of the response
    */
    var statusMessage : String?

    /**
       Default constructor

       @since v2.0
    */
    public override init() {
        super.init()
    }

    /**
       Constructor with parameters.

       @param response   String representing the JavaScript value or JSON object representation of the response.
       @param statusCode Status code of the response (200 = OK, others are warning or error conditions).
       @since v2.0
    */
    public init(response: String, statusCode: Int32) {
        super.init()
        self.response = response
        self.statusCode = statusCode
    }

    /**
       Constructor with parameters.

       @param response      String representing the JavaScript value or JSON object representation of the response.
       @param statusCode    Status code of the response (200 = OK, others are warning or error conditions).
       @param statusMessage Status message of the response.
    */
    public init(response: String, statusCode: Int32, statusMessage: String) {
        super.init()
        self.response = response
        self.statusCode = statusCode
        self.statusMessage = statusMessage
    }

    /**
       Response getter

       @return String representing the JavaScript value or JSON object representation of the response.
       @since v2.0
    */
    public func getResponse() -> String? {
        return self.response
    }

    /**
       Response setter

       @param response String representing the JavaScript value or JSON object representation of the response.
    */
    public func setResponse(response: String) {
        self.response = response
    }

    /**
       Status code getter

       @return Status code of the response (200 = OK, others are warning or error conditions).
    */
    public func getStatusCode() -> Int32? {
        return self.statusCode
    }

    /**
       Status code setter

       @param statusCode Status code of the response  (200 = OK, others are warning or error conditions).
    */
    public func setStatusCode(statusCode: Int32) {
        self.statusCode = statusCode
    }

    /**
       Status message getter

       @return Status message of the response.
    */
    public func getStatusMessage() -> String? {
        return self.statusMessage
    }

    /**
       Status message setter.

       @param statusMessage Status message of the response
    */
    public func setStatusMessage(statusMessage: String) {
        self.statusMessage = statusMessage
    }


    /**
       JSON Serialization and deserialization support.
    */
    struct Serializer {
        static func fromJSON(json : String) -> APIResponse {
            var data:NSData = json.dataUsingEncoding(NSUTF8StringEncoding)!
            var jsonError: NSError?
            let dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary
            return fromDictionary(dict)
        }

        static func fromDictionary(dict : NSDictionary) -> APIResponse {
            var resultObject : APIResponse = APIResponse()

            if let value : AnyObject = dict.objectForKey("response") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.response = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("statusCode") {
                if "\(value)" as NSString != "<null>" {
                    var numValue = value as Int
                    resultObject.statusCode = Int32(numValue)
                }
            }

            if let value : AnyObject = dict.objectForKey("statusMessage") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.statusMessage = (value as String)
                }
            }

            return resultObject
        }

        static func toJSON(object: APIResponse) -> String {
            var jsonString : NSMutableString = NSMutableString()
            // Start Object to JSON
            jsonString.appendString("{ ")

            // Fields.
            object.response != nil ? jsonString.appendString("\"response\": \"\(JSONUtil.escapeString(object.response!))\", ") : jsonString.appendString("\"response\": null, ")
            object.statusCode != nil ? jsonString.appendString("\"statusCode\": \(object.statusCode!), ") : jsonString.appendString("\"statusCode\": null, ")
            object.statusMessage != nil ? jsonString.appendString("\"statusMessage\": \"\(JSONUtil.escapeString(object.statusMessage!))\"") : jsonString.appendString("\"statusMessage\": null")

            // End Object to JSON
            jsonString.appendString(" }")
            return jsonString
        }
    }
}

/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
