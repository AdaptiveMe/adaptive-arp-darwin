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

    * @version v2.2.0

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Structure representing a HTML5 request to the native API.

   @author Carlos Lozano Diez
   @since v2.0
   @version 1.0
*/
public class APIRequest : NSObject {

    /**
       Identifier of API version of this request.
    */
    var apiVersion : String?
    /**
       Identifier of callback or listener for async operations.
    */
    var asyncId : Int64?
    /**
       String representing the bridge type to obtain.
    */
    var bridgeType : String?
    /**
       String representing the method name to call.
    */
    var methodName : String?
    /**
       Parameters of the request as JSON formatted strings.
    */
    var parameters : [String]?

    /**
       Default constructor

       @since v2.0
    */
    public override init() {
        super.init()
    }

    /**
       Constructor with method name. No parameters

       @param bridgeType Name of the bridge to be invoked.
       @param methodName Name of the method
       @since v2.0
    */
    public init(bridgeType: String, methodName: String) {
        super.init()
        self.bridgeType = bridgeType
        self.methodName = methodName
    }

    /**
       Constructor with all the parameters

       @param bridgeType Name of the bridge to be invoked.
       @param methodName Name of the method
       @param parameters Array of parameters as JSON formatted strings.
       @param asyncId    Id of callback or listener or zero if none for synchronous calls.
       @since v2.0
    */
    public init(bridgeType: String, methodName: String, parameters: [String], asyncId: Int64) {
        super.init()
        self.bridgeType = bridgeType
        self.methodName = methodName
        self.parameters = parameters
        self.asyncId = asyncId
    }

    /**
       Returns the request's API version. This should be the same or higher than the platform managing the
request.

       @return String with the API version of the request.
    */
    public func getApiVersion() -> String? {
        return self.apiVersion
    }

    /**
       Sets the request's API version. This should be the same or higher than the platform managing the
request.

       @param apiVersion String with the API version of the request.
    */
    public func setApiVersion(apiVersion: String) {
        self.apiVersion = apiVersion
    }

    /**
       Returns the callback or listener id assigned to this request OR zero if there is no associated callback or
listener.

       @return long with the unique id of the callback or listener, or zero if there is no associated async event.
    */
    public func getAsyncId() -> Int64? {
        return self.asyncId
    }

    /**
       Sets the callback or listener id to the request.

       @param asyncId The unique id of the callback or listener.
    */
    public func setAsyncId(asyncId: Int64) {
        self.asyncId = asyncId
    }

    /**
       Bridge Type Getter

       @return Bridge Type
       @since v2.0
    */
    public func getBridgeType() -> String? {
        return self.bridgeType
    }

    /**
       Bridge Type Setter

       @param bridgeType Bridge Type
       @since v2.0
    */
    public func setBridgeType(bridgeType: String) {
        self.bridgeType = bridgeType
    }

    /**
       Method name Getter

       @return Method name
       @since v2.0
    */
    public func getMethodName() -> String? {
        return self.methodName
    }

    /**
       Method name Setter

       @param methodName Method name
       @since v2.0
    */
    public func setMethodName(methodName: String) {
        self.methodName = methodName
    }

    /**
       Parameters Getter

       @return Parameters
       @since v2.0
    */
    public func getParameters() -> [String]? {
        return self.parameters
    }

    /**
       Parameters Setter

       @param parameters Parameters, JSON formatted strings of objects.
       @since v2.0
    */
    public func setParameters(parameters: [String]) {
        self.parameters = parameters
    }


    /**
       JSON Serialization and deserialization support.
    */
    struct Serializer {
        static func fromJSON(json : String) -> APIRequest {
            var data:NSData = json.dataUsingEncoding(NSUTF8StringEncoding)!
            var jsonError: NSError?
            let dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary
            return fromDictionary(dict)
        }

        static func fromDictionary(dict : NSDictionary) -> APIRequest {
            var resultObject : APIRequest = APIRequest()

            if let value : AnyObject = dict.objectForKey("apiVersion") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.apiVersion = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("asyncId") {
                if "\(value)" as NSString != "<null>" {
                    var numValue = value as? NSNumber
                    resultObject.asyncId = numValue?.longLongValue
                }
            }

            if let value : AnyObject = dict.objectForKey("bridgeType") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.bridgeType = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("methodName") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.methodName = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("parameters") {
                if "\(value)" as NSString != "<null>" {
                    var parameters : [String] = [String]()
                    for (var i = 0;i < (value as NSArray).count ; i++) {
                        parameters.append((value as NSArray)[i] as String)
                    }
                    resultObject.parameters = parameters
                }
            }

            return resultObject
        }

        static func toJSON(object: APIRequest) -> String {
            var jsonString : NSMutableString = NSMutableString()
            // Start Object to JSON
            jsonString.appendString("{ ")

            // Fields.
            object.apiVersion != nil ? jsonString.appendString("\"apiVersion\": \"\(JSONUtil.escapeString(object.apiVersion!))\", ") : jsonString.appendString("\"apiVersion\": null, ")
            object.asyncId != nil ? jsonString.appendString("\"asyncId\": \(object.asyncId!), ") : jsonString.appendString("\"asyncId\": null, ")
            object.bridgeType != nil ? jsonString.appendString("\"bridgeType\": \"\(JSONUtil.escapeString(object.bridgeType!))\", ") : jsonString.appendString("\"bridgeType\": null, ")
            object.methodName != nil ? jsonString.appendString("\"methodName\": \"\(JSONUtil.escapeString(object.methodName!))\", ") : jsonString.appendString("\"methodName\": null, ")
            if (object.parameters != nil) {
                // Start array of objects.
                jsonString.appendString("\"parameters\": [")

                for var i = 0; i < object.parameters!.count; i++ {
                    jsonString.appendString("\"\(JSONUtil.escapeString(object.parameters![i]))\"")
                    if (i < object.parameters!.count-1) {
                        jsonString.appendString(", ");
                    }
                }

                // End array of objects.
                jsonString.appendString("]");
            } else {
                jsonString.appendString("\"parameters\": null")
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
