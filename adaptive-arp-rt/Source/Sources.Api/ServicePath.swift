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

    * @version v2.0.6

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Structure representing a service path for one endpoint

   @author fnva
   @since v2.0.4
   @version 1.0
*/
public class ServicePath : NSObject {

    /**
       Service endpoint type.
    */
    var type : IServiceType?
    /**
       The methods for calling a path.
    */
    var methods : [IServiceMethod]?
    /**
       The path for the endpoint.
    */
    var path : String?

    /**
       Default Constructor.

       @since v2.0.4
    */
    public override init() {
        super.init()
    }

    /**
       Constructor with parameters.

       @param path    The path for the endpoint
       @param methods The methods for calling a path
       @param type    Protocol type.
       @since v2.0.6
    */
    public init(path: String, methods: [IServiceMethod], type: IServiceType) {
        super.init()
        self.path = path
        self.methods = methods
        self.type = type
    }

    /**
       Gets the protocol for the path.

       @return Type of protocol.
       @since v2.0.6
    */
    public func getType() -> IServiceType? {
        return self.type
    }

    /**
       Sets the protocol for the path.

       @param type Type of protocol.
       @since v2.0.6
    */
    public func setType(type: IServiceType) {
        self.type = type
    }

    /**
       Endpoint's path methods setter

       @return Endpoint's path methods
       @since v2.0.4
    */
    public func getMethods() -> [IServiceMethod]? {
        return self.methods
    }

    /**
       Endpoint's path methods setter

       @param methods Endpoint's path methods
       @since v2.0.4
    */
    public func setMethods(methods: [IServiceMethod]) {
        self.methods = methods
    }

    /**
       Endpoint's Path Getter

       @return Endpoint's Path
       @since v2.0.4
    */
    public func getPath() -> String? {
        return self.path
    }

    /**
       Endpoint's path setter

       @param path Endpoint's path
       @since v2.0.4
    */
    public func setPath(path: String) {
        self.path = path
    }


    /**
       JSON Serialization and deserialization support.
    */
    struct Serializer {
        static func fromJSON(json : String) -> ServicePath {
            var data:NSData = json.dataUsingEncoding(NSUTF8StringEncoding)!
            var jsonError: NSError?
            let dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary
            return fromDictionary(dict)
        }

        static func fromDictionary(dict : NSDictionary) -> ServicePath {
            var resultObject : ServicePath = ServicePath()

            if let value : AnyObject = dict.objectForKey("methods") {
                if "\(value)" as NSString != "<null>" {
                    var methods : [IServiceMethod] = [IServiceMethod]()
                    for (var i = 0;i < (value as NSArray).count ; i++) {
                        methods.append(IServiceMethod.toEnum(((value as NSDictionary)["value"]) as NSString))
                    }
                    resultObject.methods = methods
                }
            }

            if let value : AnyObject = dict.objectForKey("path") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.path = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("type") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.type = IServiceType.toEnum(((value as NSDictionary)["value"]) as NSString)
                }
            }

            return resultObject
        }

        static func toJSON(object: ServicePath) -> String {
            var jsonString : NSMutableString = NSMutableString()
            // Start Object to JSON
            jsonString.appendString("{ ")

            // Fields.
            if (object.methods != nil) {
                // Start array of objects.
                jsonString.appendString("\"methods\": [")

                for var i = 0; i < object.methods!.count; i++ {
                    jsonString.appendString("{ \"value\": \"\(object.methods![i].toString())\" }")
                    if (i < object.methods!.count-1) {
                        jsonString.appendString(", ");
                    }
                }

                // End array of objects.
                jsonString.appendString("], ");
            } else {
                jsonString.appendString("\"methods\": null, ")
            }
            object.path != nil ? jsonString.appendString("\"path\": \"\(JSONUtil.escapeString(object.path!))\", ") : jsonString.appendString("\"path\": null, ")
            object.type != nil ? jsonString.appendString("\"type\": { \"value\": \"\(object.type!.toString())\"}") : jsonString.appendString("\"type\": null")

            // End Object to JSON
            jsonString.appendString(" }")
            return jsonString
        }
    }
}

/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
