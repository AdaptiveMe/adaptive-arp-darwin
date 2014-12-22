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
   Structure representing the data elements of a contact.

   @author Francisco Javier Martin Bueno
   @since ARP1.0
   @version 1.0
*/
public class Contact : ContactUid {

     /**
        The adresses from the contact
     */
     var contactAddresses : [ContactAddress]?
     /**
        The emails from the contact
     */
     var contactEmails : [ContactEmail]?
     /**
        The phones from the contact
     */
     var contactPhones : [ContactPhone]?
     /**
        The social network info from the contact
     */
     var contactSocials : [ContactSocial]?
     /**
        The aditional tags from the contact
     */
     var contactTags : [ContactTag]?
     /**
        The websites from the contact
     */
     var contactWebsites : [ContactWebsite]?
     /**
        The personal info from the contact
     */
     var personalInfo : ContactPersonalInfo?
     /**
        The professional info from the contact
     */
     var professionalInfo : ContactProfessionalInfo?

     /**
        Default Constructor

        @since ARP1.0
     */
     public override init() {
          super.init()
     }

     /**
        Constructor used by implementation to set the Contact.

        @param contactId of the Contact
        @since ARP1.0
     */
     public override init(contactId: String) {
          super.init(contactId: contactId)
     }

     /**
        Constructor with all the fields

        @param contactId        Identifier of the contact
        @param personalInfo     Personal Information
        @param professionalInfo Professional Information
        @param contactAddresses Addresses of the contact
        @param contactPhones    Phones of the contact
        @param contactEmails    Emails of the contact
        @param contactWebsites  Websites of the contact
        @param contactSocials   Social Networks of the contact
        @param contactTags      Tags of the contact
        @since ARP1.0
     */
     public init(contactId: String, personalInfo: ContactPersonalInfo, professionalInfo: ContactProfessionalInfo, contactAddresses: [ContactAddress], contactPhones: [ContactPhone], contactEmails: [ContactEmail], contactWebsites: [ContactWebsite], contactSocials: [ContactSocial], contactTags: [ContactTag]) {
          super.init(contactId: contactId)
          self.personalInfo = personalInfo
          self.professionalInfo = professionalInfo
          self.contactAddresses = contactAddresses
          self.contactPhones = contactPhones
          self.contactEmails = contactEmails
          self.contactWebsites = contactWebsites
          self.contactSocials = contactSocials
          self.contactTags = contactTags
     }

     /**
        Returns all the addresses of the Contact

        @return ContactAddress[]
        @since ARP1.0
     */
     public func getContactAddresses() -> [ContactAddress]? {
          return self.contactAddresses
     }

     /**
        Set the addresses of the Contact

        @param contactAddresses Addresses of the contact
        @since ARP1.0
     */
     public func setContactAddresses(contactAddresses: [ContactAddress]) {
          self.contactAddresses = contactAddresses
     }

     /**
        Returns all the emails of the Contact

        @return ContactEmail[]
        @since ARP1.0
     */
     public func getContactEmails() -> [ContactEmail]? {
          return self.contactEmails
     }

     /**
        Set the emails of the Contact

        @param contactEmails Emails of the contact
        @since ARP1.0
     */
     public func setContactEmails(contactEmails: [ContactEmail]) {
          self.contactEmails = contactEmails
     }

     /**
        Returns all the phones of the Contact

        @return ContactPhone[]
        @since ARP1.0
     */
     public func getContactPhones() -> [ContactPhone]? {
          return self.contactPhones
     }

     /**
        Set the phones of the Contact

        @param contactPhones Phones of the contact
        @since ARP1.0
     */
     public func setContactPhones(contactPhones: [ContactPhone]) {
          self.contactPhones = contactPhones
     }

     /**
        Returns all the social network info of the Contact

        @return ContactSocial[]
        @since ARP1.0
     */
     public func getContactSocials() -> [ContactSocial]? {
          return self.contactSocials
     }

     /**
        Set the social network info of the Contact

        @param contactSocials Social Networks of the contact
        @since ARP1.0
     */
     public func setContactSocials(contactSocials: [ContactSocial]) {
          self.contactSocials = contactSocials
     }

     /**
        Returns the additional tags of the Contact

        @return ContactTag[]
        @since ARP1.0
     */
     public func getContactTags() -> [ContactTag]? {
          return self.contactTags
     }

     /**
        Set the additional tags of the Contact

        @param contactTags Tags of the contact
        @since ARP1.0
     */
     public func setContactTags(contactTags: [ContactTag]) {
          self.contactTags = contactTags
     }

     /**
        Returns all the websites of the Contact

        @return ContactWebsite[]
        @since ARP1.0
     */
     public func getContactWebsites() -> [ContactWebsite]? {
          return self.contactWebsites
     }

     /**
        Set the websites of the Contact

        @param contactWebsites Websites of the contact
        @since ARP1.0
     */
     public func setContactWebsites(contactWebsites: [ContactWebsite]) {
          self.contactWebsites = contactWebsites
     }

     /**
        Returns the personal info of the Contact

        @return ContactPersonalInfo of the Contact
        @since ARP1.0
     */
     public func getPersonalInfo() -> ContactPersonalInfo? {
          return self.personalInfo
     }

     /**
        Set the personal info of the Contact

        @param personalInfo Personal Information
        @since ARP1.0
     */
     public func setPersonalInfo(personalInfo: ContactPersonalInfo) {
          self.personalInfo = personalInfo
     }

     /**
        Returns the professional info of the Contact

        @return Array of personal info
        @since ARP1.0
     */
     public func getProfessionalInfo() -> ContactProfessionalInfo? {
          return self.professionalInfo
     }

     /**
        Set the professional info of the Contact

        @param professionalInfo Professional Information
        @since ARP1.0
     */
     public func setProfessionalInfo(professionalInfo: ContactProfessionalInfo) {
          self.professionalInfo = professionalInfo
     }


     /**
        JSON Serialization and deserialization support.
     */
     struct Serializer {
          static func fromJSON(json : String) -> Contact {
               var data:NSData = json.dataUsingEncoding(NSUTF8StringEncoding)!
               var jsonError: NSError?
               let dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary
               return fromDictionary(dict)
          }

          static func fromDictionary(dict : NSDictionary) -> Contact {
               var resultObject : Contact = Contact()

               if let value : AnyObject = dict.objectForKey("contactAddresses") {
                    if value as NSString != "<null>" {
                         var contactAddresses : [ContactAddress] = [ContactAddress]()
                         for (var i = 0;i < (value as NSArray).count ; i++) {
                              contactAddresses.append(ContactAddress.Serializer.fromDictionary((value as NSArray)[i] as NSDictionary))
                         }
                         resultObject.contactAddresses = contactAddresses
                    }
               }

               if let value : AnyObject = dict.objectForKey("contactEmails") {
                    if value as NSString != "<null>" {
                         var contactEmails : [ContactEmail] = [ContactEmail]()
                         for (var i = 0;i < (value as NSArray).count ; i++) {
                              contactEmails.append(ContactEmail.Serializer.fromDictionary((value as NSArray)[i] as NSDictionary))
                         }
                         resultObject.contactEmails = contactEmails
                    }
               }

               if let value : AnyObject = dict.objectForKey("contactId") {
                    if value as NSString != "<null>" {
                         resultObject.contactId = (value as String)
                    }
               }

               if let value : AnyObject = dict.objectForKey("contactPhones") {
                    if value as NSString != "<null>" {
                         var contactPhones : [ContactPhone] = [ContactPhone]()
                         for (var i = 0;i < (value as NSArray).count ; i++) {
                              contactPhones.append(ContactPhone.Serializer.fromDictionary((value as NSArray)[i] as NSDictionary))
                         }
                         resultObject.contactPhones = contactPhones
                    }
               }

               if let value : AnyObject = dict.objectForKey("contactSocials") {
                    if value as NSString != "<null>" {
                         var contactSocials : [ContactSocial] = [ContactSocial]()
                         for (var i = 0;i < (value as NSArray).count ; i++) {
                              contactSocials.append(ContactSocial.Serializer.fromDictionary((value as NSArray)[i] as NSDictionary))
                         }
                         resultObject.contactSocials = contactSocials
                    }
               }

               if let value : AnyObject = dict.objectForKey("contactTags") {
                    if value as NSString != "<null>" {
                         var contactTags : [ContactTag] = [ContactTag]()
                         for (var i = 0;i < (value as NSArray).count ; i++) {
                              contactTags.append(ContactTag.Serializer.fromDictionary((value as NSArray)[i] as NSDictionary))
                         }
                         resultObject.contactTags = contactTags
                    }
               }

               if let value : AnyObject = dict.objectForKey("contactWebsites") {
                    if value as NSString != "<null>" {
                         var contactWebsites : [ContactWebsite] = [ContactWebsite]()
                         for (var i = 0;i < (value as NSArray).count ; i++) {
                              contactWebsites.append(ContactWebsite.Serializer.fromDictionary((value as NSArray)[i] as NSDictionary))
                         }
                         resultObject.contactWebsites = contactWebsites
                    }
               }

               if let value : AnyObject = dict.objectForKey("personalInfo") {
                    if value as NSString != "<null>" {
                         resultObject.personalInfo = ContactPersonalInfo.Serializer.fromDictionary(value as NSDictionary)
                    }
               }

               if let value : AnyObject = dict.objectForKey("professionalInfo") {
                    if value as NSString != "<null>" {
                         resultObject.professionalInfo = ContactProfessionalInfo.Serializer.fromDictionary(value as NSDictionary)
                    }
               }

               return resultObject
          }

          static func toJSON(object: Contact) -> String {
               var jsonString : NSMutableString = NSMutableString()
               // Start Object to JSON
               jsonString.appendString("{ ")

               // Fields.
               if (object.contactAddresses != nil) {
                    // Start array of objects.
                    jsonString.appendString("\"contactAddresses\": [");

                    for var i = 0; i < object.contactAddresses!.count; i++ {
                         jsonString.appendString(ContactAddress.Serializer.toJSON(object.contactAddresses![i]))
                         if (i < object.contactAddresses!.count-1) {
                              jsonString.appendString(", ");
                         }
                    }

                    // End array of objects.
                    jsonString.appendString("], ");
               } else {
                    jsonString.appendString("\"contactAddresses\": null, ")
               }
               if (object.contactEmails != nil) {
                    // Start array of objects.
                    jsonString.appendString("\"contactEmails\": [");

                    for var i = 0; i < object.contactEmails!.count; i++ {
                         jsonString.appendString(ContactEmail.Serializer.toJSON(object.contactEmails![i]))
                         if (i < object.contactEmails!.count-1) {
                              jsonString.appendString(", ");
                         }
                    }

                    // End array of objects.
                    jsonString.appendString("], ");
               } else {
                    jsonString.appendString("\"contactEmails\": null, ")
               }
               object.contactId != nil ? jsonString.appendString("\"contactId\": \"\(object.contactId!)\", ") : jsonString.appendString("\"contactId\": null, ")
               if (object.contactPhones != nil) {
                    // Start array of objects.
                    jsonString.appendString("\"contactPhones\": [");

                    for var i = 0; i < object.contactPhones!.count; i++ {
                         jsonString.appendString(ContactPhone.Serializer.toJSON(object.contactPhones![i]))
                         if (i < object.contactPhones!.count-1) {
                              jsonString.appendString(", ");
                         }
                    }

                    // End array of objects.
                    jsonString.appendString("], ");
               } else {
                    jsonString.appendString("\"contactPhones\": null, ")
               }
               if (object.contactSocials != nil) {
                    // Start array of objects.
                    jsonString.appendString("\"contactSocials\": [");

                    for var i = 0; i < object.contactSocials!.count; i++ {
                         jsonString.appendString(ContactSocial.Serializer.toJSON(object.contactSocials![i]))
                         if (i < object.contactSocials!.count-1) {
                              jsonString.appendString(", ");
                         }
                    }

                    // End array of objects.
                    jsonString.appendString("], ");
               } else {
                    jsonString.appendString("\"contactSocials\": null, ")
               }
               if (object.contactTags != nil) {
                    // Start array of objects.
                    jsonString.appendString("\"contactTags\": [");

                    for var i = 0; i < object.contactTags!.count; i++ {
                         jsonString.appendString(ContactTag.Serializer.toJSON(object.contactTags![i]))
                         if (i < object.contactTags!.count-1) {
                              jsonString.appendString(", ");
                         }
                    }

                    // End array of objects.
                    jsonString.appendString("], ");
               } else {
                    jsonString.appendString("\"contactTags\": null, ")
               }
               if (object.contactWebsites != nil) {
                    // Start array of objects.
                    jsonString.appendString("\"contactWebsites\": [");

                    for var i = 0; i < object.contactWebsites!.count; i++ {
                         jsonString.appendString(ContactWebsite.Serializer.toJSON(object.contactWebsites![i]))
                         if (i < object.contactWebsites!.count-1) {
                              jsonString.appendString(", ");
                         }
                    }

                    // End array of objects.
                    jsonString.appendString("], ");
               } else {
                    jsonString.appendString("\"contactWebsites\": null, ")
               }
               object.personalInfo != nil ? jsonString.appendString("\"personalInfo\": \(ContactPersonalInfo.Serializer.toJSON(object.personalInfo!)), ") : jsonString.appendString("\"personalInfo\": null, ")
               object.professionalInfo != nil ? jsonString.appendString("\"professionalInfo\": \(ContactProfessionalInfo.Serializer.toJSON(object.professionalInfo!))") : jsonString.appendString("\"professionalInfo\": null")

               // End Object to JSON
               jsonString.appendString(" }")
               return jsonString
          }
     }
}

/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
