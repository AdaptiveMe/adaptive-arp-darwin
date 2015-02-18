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

    * @version v2.1.9

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Structure representing a remote or local service access end-point.

   @author Aryslan
   @since v2.0
   @version 1.0
*/
public class ServiceEndpoint : NSObject {

    /**
       Type of validation to be performed for SSL hosts.
    */
    var validationType : IServiceCertificateValidation?
    /**
       The remote service hostURI URI (alias or IP) composed of scheme://hostURI:port (http://hostURI:8080).
    */
    var hostURI : String?
    /**
       The remote service paths (to be added to the hostURI and port url).
    */
    var paths : [ServicePath]?

    /**
       Default Constructor

       @since v2.0
    */
    public override init() {
        super.init()
    }

    /**
       Constructor with parameters

       @param hostURI Remote service hostURI
       @param paths   Remote service Paths
       @since v2.0.6
    */
    public init(hostURI: String, paths: [ServicePath]) {
        super.init()
        self.hostURI = hostURI
        self.paths = paths
    }

    /**
       Gets the validation type for the certificate of a SSL host.

       @return Type of validation.
       @since v2.0.6
    */
    public func getValidationType() -> IServiceCertificateValidation? {
        return self.validationType
    }

    /**
       Sets the validation type for the certificate of a SSL host.

       @param validationType Type of validation.
       @since v2.0.6
    */
    public func setValidationType(validationType: IServiceCertificateValidation) {
        self.validationType = validationType
    }

    /**
       Returns the Remote service hostURI

       @return Remote service hostURI
       @since v2.0
    */
    public func getHostURI() -> String? {
        return self.hostURI
    }

    /**
       Set the Remote service hostURI

       @param hostURI Remote service hostURI
       @since v2.0
    */
    public func setHostURI(hostURI: String) {
        self.hostURI = hostURI
    }

    /**
       Returns the Remote service Paths

       @return Remote service Paths
       @since v2.0
    */
    public func getPaths() -> [ServicePath]? {
        return self.paths
    }

    /**
       Set the Remote service Paths

       @param paths Remote service Paths
       @since v2.0
    */
    public func setPaths(paths: [ServicePath]) {
        self.paths = paths
    }


    /**
       JSON Serialization and deserialization support.
    */
    struct Serializer {
        static func fromJSON(json : String) -> ServiceEndpoint {
            var data:NSData = json.dataUsingEncoding(NSUTF8StringEncoding)!
            var jsonError: NSError?
            let dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary
            return fromDictionary(dict)
        }

        static func fromDictionary(dict : NSDictionary) -> ServiceEndpoint {
            var resultObject : ServiceEndpoint = ServiceEndpoint()

            if let value : AnyObject = dict.objectForKey("hostURI") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.hostURI = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("paths") {
                if "\(value)" as NSString != "<null>" {
                    var paths : [ServicePath] = [ServicePath]()
                    for (var i = 0;i < (value as NSArray).count ; i++) {
                        paths.append(ServicePath.Serializer.fromDictionary((value as NSArray)[i] as NSDictionary))
                    }
                    resultObject.paths = paths
                }
            }

            if let value : AnyObject = dict.objectForKey("validationType") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.validationType = IServiceCertificateValidation.toEnum(((value as NSDictionary)["value"]) as NSString)
                }
            }

            return resultObject
        }

        static func toJSON(object: ServiceEndpoint) -> String {
            var jsonString : NSMutableString = NSMutableString()
            // Start Object to JSON
            jsonString.appendString("{ ")

            // Fields.
            object.hostURI != nil ? jsonString.appendString("\"hostURI\": \"\(JSONUtil.escapeString(object.hostURI!))\", ") : jsonString.appendString("\"hostURI\": null, ")
            if (object.paths != nil) {
                // Start array of objects.
                jsonString.appendString("\"paths\": [")

                for var i = 0; i < object.paths!.count; i++ {
                    jsonString.appendString(ServicePath.Serializer.toJSON(object.paths![i]))
                    if (i < object.paths!.count-1) {
                        jsonString.appendString(", ");
                    }
                }

                // End array of objects.
                jsonString.appendString("], ");
            } else {
                jsonString.appendString("\"paths\": null, ")
            }
            object.validationType != nil ? jsonString.appendString("\"validationType\": { \"value\": \"\(object.validationType!.toString())\"}") : jsonString.appendString("\"validationType\": null")

            // End Object to JSON
            jsonString.appendString(" }")
            return jsonString
        }
    }
}

/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
