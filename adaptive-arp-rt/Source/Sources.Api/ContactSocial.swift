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
   Structure representing the social data elements of a contact.

   @author Francisco Javier Martin Bueno
   @since v2.0
   @version 1.0
*/
public class ContactSocial : APIBean {

    /**
       The social network
    */
    var socialNetwork : ContactSocialNetwork?
    /**
       The profileUrl
    */
    var profileUrl : String?

    /**
       Default constructor

       @since v2.0
    */
    public override init() {
        super.init()
    }

    /**
       Constructor used by the implementation

       @param socialNetwork of the profile
       @param profileUrl    of the user
       @since v2.0
    */
    public init(socialNetwork: ContactSocialNetwork, profileUrl: String) {
        super.init()
        self.socialNetwork = socialNetwork
        self.profileUrl = profileUrl
    }

    /**
       Returns the social network

       @return socialNetwork
       @since v2.0
    */
    public func getSocialNetwork() -> ContactSocialNetwork? {
        return self.socialNetwork
    }

    /**
       Set the social network

       @param socialNetwork of the profile
       @since v2.0
    */
    public func setSocialNetwork(socialNetwork: ContactSocialNetwork) {
        self.socialNetwork = socialNetwork
    }

    /**
       Returns the profile url of the user

       @return profileUrl
       @since v2.0
    */
    public func getProfileUrl() -> String? {
        return self.profileUrl
    }

    /**
       Set the profile url of the iser

       @param profileUrl of the user
       @since v2.0
    */
    public func setProfileUrl(profileUrl: String) {
        self.profileUrl = profileUrl
    }


    /**
       JSON Serialization and deserialization support.
    */
    struct Serializer {
        static func fromJSON(json : String) -> ContactSocial {
            var data:NSData = json.dataUsingEncoding(NSUTF8StringEncoding)!
            var jsonError: NSError?
            let dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary
            return fromDictionary(dict)
        }

        static func fromDictionary(dict : NSDictionary) -> ContactSocial {
            var resultObject : ContactSocial = ContactSocial()

            if let value : AnyObject = dict.objectForKey("profileUrl") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.profileUrl = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("socialNetwork") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.socialNetwork = ContactSocialNetwork.toEnum(((value as NSDictionary)["value"]) as NSString)
                }
            }

            return resultObject
        }

        static func toJSON(object: ContactSocial) -> String {
            var jsonString : NSMutableString = NSMutableString()
            // Start Object to JSON
            jsonString.appendString("{ ")

            // Fields.
            object.profileUrl != nil ? jsonString.appendString("\"profileUrl\": \"\(JSONUtil.escapeString(object.profileUrl!))\", ") : jsonString.appendString("\"profileUrl\": null, ")
            object.socialNetwork != nil ? jsonString.appendString("\"socialNetwork\": { \"value\": \"\(object.socialNetwork!.toString())\"}") : jsonString.appendString("\"socialNetwork\": null")

            // End Object to JSON
            jsonString.appendString(" }")
            return jsonString
        }
    }
}

/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
