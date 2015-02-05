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
   Object representing a specific service, path, function and invocation method for accessing external services.

   @author Carlos Lozano Diez
   @since v2.0.6
   @version 1.0
*/
public class ServiceToken : APIBean {

    /**
       Http method to be used by the invocation - this is typically GET or POST albeit the platform may support
other invocation methods. This is also defined per function of each endpoint in the platform's XML file.
    */
    var invocationMethod : IServiceMethod?
    /**
       Name of the endpoint configured in the platform's services XML file. This is a reference to a specific schema,
host and port combination for a given service.
    */
    var endpointName : String?
    /**
       Name of the function configured in the platform's services XML file for a specific endpoint. This is a reference
to a relative path of a function published on a remote service.
    */
    var functionName : String?
    /**
       Name of the service configured in the platform's services XML file.
    */
    var serviceName : String?

    /**
       Default constructor.

       @since v2.0.6
    */
    public override init() {
        super.init()
    }

    /**
       Convenience constructor.

       @param serviceName      Name of the configured service.
       @param endpointName     Name of the endpoint configured for the service.
       @param functionName     Name of the function configured for the endpoint.
       @param invocationMethod Method type configured for the function.
       @since v2.0.6
    */
    public init(serviceName: String, endpointName: String, functionName: String, invocationMethod: IServiceMethod) {
        super.init()
        self.serviceName = serviceName
        self.endpointName = endpointName
        self.functionName = functionName
        self.invocationMethod = invocationMethod
    }

    /**
       Get token's invocation method type.

       @return Invocation method type.
       @since v2.0.6
    */
    public func getInvocationMethod() -> IServiceMethod? {
        return self.invocationMethod
    }

    /**
       Sets the invocation method type.

       @param invocationMethod Method type.
       @since v2.0.6
    */
    public func setInvocationMethod(invocationMethod: IServiceMethod) {
        self.invocationMethod = invocationMethod
    }

    /**
       Get token's endpoint name.

       @return Endpoint name.
       @since v2.0.6
    */
    public func getEndpointName() -> String? {
        return self.endpointName
    }

    /**
       Set the endpoint name.

       @param endpointName Endpoint name.
       @since v2.0.6
    */
    public func setEndpointName(endpointName: String) {
        self.endpointName = endpointName
    }

    /**
       Get token's function name.

       @return Function name.
       @since v2.0.6
    */
    public func getFunctionName() -> String? {
        return self.functionName
    }

    /**
       Sets the function name.

       @param functionName Function name.
       @since v2.0.6
    */
    public func setFunctionName(functionName: String) {
        self.functionName = functionName
    }

    /**
       Get token's service name.

       @return Service name.
       @since v2.0.6
    */
    public func getServiceName() -> String? {
        return self.serviceName
    }

    /**
       Sets token's service name.

       @param serviceName Service name.
       @since v2.0.6
    */
    public func setServiceName(serviceName: String) {
        self.serviceName = serviceName
    }


    /**
       JSON Serialization and deserialization support.
    */
    struct Serializer {
        static func fromJSON(json : String) -> ServiceToken {
            var data:NSData = json.dataUsingEncoding(NSUTF8StringEncoding)!
            var jsonError: NSError?
            let dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary
            return fromDictionary(dict)
        }

        static func fromDictionary(dict : NSDictionary) -> ServiceToken {
            var resultObject : ServiceToken = ServiceToken()

            if let value : AnyObject = dict.objectForKey("endpointName") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.endpointName = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("functionName") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.functionName = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("invocationMethod") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.invocationMethod = IServiceMethod.toEnum(((value as NSDictionary)["value"]) as NSString)
                }
            }

            if let value : AnyObject = dict.objectForKey("serviceName") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.serviceName = (value as String)
                }
            }

            return resultObject
        }

        static func toJSON(object: ServiceToken) -> String {
            var jsonString : NSMutableString = NSMutableString()
            // Start Object to JSON
            jsonString.appendString("{ ")

            // Fields.
            object.endpointName != nil ? jsonString.appendString("\"endpointName\": \"\(JSONUtil.escapeString(object.endpointName!))\", ") : jsonString.appendString("\"endpointName\": null, ")
            object.functionName != nil ? jsonString.appendString("\"functionName\": \"\(JSONUtil.escapeString(object.functionName!))\", ") : jsonString.appendString("\"functionName\": null, ")
            object.invocationMethod != nil ? jsonString.appendString("\"invocationMethod\": { \"value\": \"\(object.invocationMethod!.toString())\"}, ") : jsonString.appendString("\"invocationMethod\": null, ")
            object.serviceName != nil ? jsonString.appendString("\"serviceName\": \"\(JSONUtil.escapeString(object.serviceName!))\"") : jsonString.appendString("\"serviceName\": null")

            // End Object to JSON
            jsonString.appendString(" }")
            return jsonString
        }
    }
}

/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
