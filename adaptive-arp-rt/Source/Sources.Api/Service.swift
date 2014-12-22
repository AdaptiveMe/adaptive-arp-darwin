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

/**
   Represents an instance of a service.

   @author Aryslan
   @since ARP1.0
   @version 1.0
*/
public class Service : APIBean {

     /**
        The method used
     */
     var method : IServiceMethod?
     /**
        The type of the service
     */
     var type : IServiceType?
     /**
        The service name
     */
     var name : String?
     /**
        Endpoint of the service
     */
     var serviceEndpoint : ServiceEndpoint?

     /**
        Default constructor

        @since ARP1.0
     */
     public override init() {
          super.init()
     }

     /**
        Constructor used by the implementation

        @param serviceEndpoint Endpoint of the service
        @param name            Name of the service
        @param method          Method of the service
        @param type            Type of the service
        @since ARP1.0
     */
     public init(serviceEndpoint: ServiceEndpoint, name: String, method: IServiceMethod, type: IServiceType) {
          super.init()
          self.serviceEndpoint = serviceEndpoint
          self.name = name
          self.method = method
          self.type = type
     }

     /**
        Returns the method

        @return method
        @since ARP1.0
     */
     public func getMethod() -> IServiceMethod? {
          return self.method
     }

     /**
        Set the method

        @param method Method of the service
        @since ARP1.0
     */
     public func setMethod(method: IServiceMethod) {
          self.method = method
     }

     /**
        Returns the type

        @return type
        @since ARP1.0
     */
     public func getType() -> IServiceType? {
          return self.type
     }

     /**
        Set the type

        @param type Type of the service
        @since ARP1.0
     */
     public func setType(type: IServiceType) {
          self.type = type
     }

     /**
        Returns the name

        @return name
        @since ARP1.0
     */
     public func getName() -> String? {
          return self.name
     }

     /**
        Set the name

        @param name Name of the service
        @since ARP1.0
     */
     public func setName(name: String) {
          self.name = name
     }

     /**
        Returns the serviceEndpoint

        @return serviceEndpoint
        @since ARP1.0
     */
     public func getServiceEndpoint() -> ServiceEndpoint? {
          return self.serviceEndpoint
     }

     /**
        Set the serviceEndpoint

        @param serviceEndpoint Endpoint of the service
        @since ARP1.0
     */
     public func setServiceEndpoint(serviceEndpoint: ServiceEndpoint) {
          self.serviceEndpoint = serviceEndpoint
     }


     /**
        JSON Serialization and deserialization support.
     */
     struct Serializer {
          static func fromJSON(json : String) -> Service {
               var data:NSData = json.dataUsingEncoding(NSUTF8StringEncoding)!
               var jsonError: NSError?
               let dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary
               return fromDictionary(dict)
          }

          static func fromDictionary(dict : NSDictionary) -> Service {
               var resultObject : Service = Service()

               if let value : AnyObject = dict.objectForKey("method") {
                    if value as NSString != "<null>" {
                         resultObject.method = IServiceMethod.toEnum(((value as NSDictionary)["value"]) as NSString)
                    }
               }

               if let value : AnyObject = dict.objectForKey("name") {
                    if value as NSString != "<null>" {
                         resultObject.name = (value as String)
                    }
               }

               if let value : AnyObject = dict.objectForKey("serviceEndpoint") {
                    if value as NSString != "<null>" {
                         resultObject.serviceEndpoint = ServiceEndpoint.Serializer.fromDictionary(value as NSDictionary)
                    }
               }

               if let value : AnyObject = dict.objectForKey("type") {
                    if value as NSString != "<null>" {
                         resultObject.type = IServiceType.toEnum(((value as NSDictionary)["value"]) as NSString)
                    }
               }

               return resultObject
          }

          static func toJSON(object: Service) -> String {
               var jsonString : NSMutableString = NSMutableString()
               // Start Object to JSON
               jsonString.appendString("{ ")

               // Fields.
               object.method != nil ? jsonString.appendString("\"method\": { \"value\": \"\(object.method!.toString())\"}, ") : jsonString.appendString("\"method\": null, ")
               object.name != nil ? jsonString.appendString("\"name\": \"\(object.name!)\", ") : jsonString.appendString("\"name\": null, ")
               object.serviceEndpoint != nil ? jsonString.appendString("\"serviceEndpoint\": \(ServiceEndpoint.Serializer.toJSON(object.serviceEndpoint!)), ") : jsonString.appendString("\"serviceEndpoint\": null, ")
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
