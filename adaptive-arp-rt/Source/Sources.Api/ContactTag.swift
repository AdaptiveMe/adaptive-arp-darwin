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
   Structure representing the assigned tags data elements of a contact.

   @author Francisco Javier Martin Bueno
   @since ARP1.0
   @version 1.0
*/
public class ContactTag : APIBean {

     /**
        The name of the Tag
     */
     var name : String?
     /**
        The value of the Tag
     */
     var value : String?

     /**
        Default constructor

        @since ARP1.0
     */
     public override init() {
          super.init()
     }

     /**
        Constructor used by the implementation

        @param value Value of the tag
        @param name  Name of the tag
        @since ARP1.0
     */
     public init(name: String, value: String) {
          super.init()
          self.name = name
          self.value = value
     }

     /**
        Returns the name of the Tag

        @return name
        @since ARP1.0
     */
     public func getName() -> String? {
          return self.name
     }

     /**
        Set the name of the Tag

        @param name Name of the tag
        @since ARP1.0
     */
     public func setName(name: String) {
          self.name = name
     }

     /**
        Returns the value of the Tag

        @return value
        @since ARP1.0
     */
     public func getValue() -> String? {
          return self.value
     }

     /**
        Set the value of the Tag

        @param value Value of the tag
        @since ARP1.0
     */
     public func setValue(value: String) {
          self.value = value
     }


     /**
        JSON Serialization and deserialization support.
     */
     struct Serializer {
          static func fromJSON(json : String) -> ContactTag {
               var data:NSData = json.dataUsingEncoding(NSUTF8StringEncoding)!
               var jsonError: NSError?
               let dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary
               return fromDictionary(dict)
          }

          static func fromDictionary(dict : NSDictionary) -> ContactTag {
               var resultObject : ContactTag = ContactTag()

               if let value : AnyObject = dict.objectForKey("name") {
                    if value as NSString != "<null>" {
                         resultObject.name = (value as String)
                    }
               }

               if let value : AnyObject = dict.objectForKey("value") {
                    if value as NSString != "<null>" {
                         resultObject.value = (value as String)
                    }
               }

               return resultObject
          }

          static func toJSON(object: ContactTag) -> String {
               var jsonString : NSMutableString = NSMutableString()
               // Start Object to JSON
               jsonString.appendString("{ ")

               // Fields.
               object.name != nil ? jsonString.appendString("\"name\": \"\(object.name!)\", ") : jsonString.appendString("\"name\": null, ")
               object.value != nil ? jsonString.appendString("\"value\": \"\(object.value!)\"") : jsonString.appendString("\"value\": null")

               // End Object to JSON
               jsonString.appendString(" }")
               return jsonString
          }
     }
}

/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
