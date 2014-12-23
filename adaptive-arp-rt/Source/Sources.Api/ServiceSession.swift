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

    * @version v2.0.2

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Represents a session object for HTTP request and responses

   @author Ferran Vila Conesa
   @since ARP1.0
   @version 1.0
*/
public class ServiceSession : NSObject {

    /**
       The attributes of the response
    */
    var attributes : [String]?
    /**
       The cookies of the response
    */
    var cookies : [ServiceCookie]?

    /**
       Default constructor

       @since ARP1.0
    */
    public override init() {
        super.init()
    }

    /**
       Constructor with fields

       @param cookies    The cookies of the response
       @param attributes Attributes of the response
       @since ARP1.0
    */
    public init(cookies: [ServiceCookie], attributes: [String]) {
        super.init()
        self.cookies = cookies
        self.attributes = attributes
    }

    /**
       Gets the attributes of the response

       @return Attributes of the response
       @since ARP1.0
    */
    public func getAttributes() -> [String]? {
        return self.attributes
    }

    /**
       Sets the attributes for the response

       @param attributes Attributes of the response
       @since ARP1.0
    */
    public func setAttributes(attributes: [String]) {
        self.attributes = attributes
    }

    /**
       Returns the cookies of the response

       @return The cookies of the response
       @since ARP1.0
    */
    public func getCookies() -> [ServiceCookie]? {
        return self.cookies
    }

    /**
       Sets the cookies of the response

       @param cookies The cookies of the response
       @since ARP1.0
    */
    public func setCookies(cookies: [ServiceCookie]) {
        self.cookies = cookies
    }


    /**
       JSON Serialization and deserialization support.
    */
    struct Serializer {
        static func fromJSON(json : String) -> ServiceSession {
            var data:NSData = json.dataUsingEncoding(NSUTF8StringEncoding)!
            var jsonError: NSError?
            let dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary
            return fromDictionary(dict)
        }

        static func fromDictionary(dict : NSDictionary) -> ServiceSession {
            var resultObject : ServiceSession = ServiceSession()

            if let value : AnyObject = dict.objectForKey("attributes") {
                if "\(value)" as NSString != "<null>" {
                    var attributes : [String] = [String]()
                    for (var i = 0;i < (value as NSArray).count ; i++) {
                        attributes.append((value as NSArray)[i] as String)
                    }
                    resultObject.attributes = attributes
                }
            }

            if let value : AnyObject = dict.objectForKey("cookies") {
                if "\(value)" as NSString != "<null>" {
                    var cookies : [ServiceCookie] = [ServiceCookie]()
                    for (var i = 0;i < (value as NSArray).count ; i++) {
                        cookies.append(ServiceCookie.Serializer.fromDictionary((value as NSArray)[i] as NSDictionary))
                    }
                    resultObject.cookies = cookies
                }
            }

            return resultObject
        }

        static func toJSON(object: ServiceSession) -> String {
            var jsonString : NSMutableString = NSMutableString()
            // Start Object to JSON
            jsonString.appendString("{ ")

            // Fields.
            if (object.attributes != nil) {
                // Start array of objects.
                jsonString.appendString("\"attributes\": [");

                for var i = 0; i < object.attributes!.count; i++ {
                    jsonString.appendString("\"\(JSONUtil.escapeString(object.attributes![i]))\"");
                    if (i < object.attributes!.count-1) {
                        jsonString.appendString(", ");
                    }
                }

                // End array of objects.
                jsonString.appendString("], ");
            } else {
                jsonString.appendString("\"attributes\": null, ")
            }
            if (object.cookies != nil) {
                // Start array of objects.
                jsonString.appendString("\"cookies\": [");

                for var i = 0; i < object.cookies!.count; i++ {
                    jsonString.appendString(ServiceCookie.Serializer.toJSON(object.cookies![i]))
                    if (i < object.cookies!.count-1) {
                        jsonString.appendString(", ");
                    }
                }

                // End array of objects.
                jsonString.appendString("]");
            } else {
                jsonString.appendString("\"cookies\": null")
            }

            // End Object to JSON
            jsonString.appendString(" }")
            return jsonString
        }
    }
}

/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
