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

    * @version v2.1.3

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Structure representing the professional info data elements of a contact.

   @author Francisco Javier Martin Bueno
   @since v2.0
   @version 1.0
*/
public class ContactProfessionalInfo : APIBean {

    /**
       The company of the job
    */
    var company : String?
    /**
       The job description
    */
    var jobDescription : String?
    /**
       The job title
    */
    var jobTitle : String?

    /**
       Default constructor

       @since v2.0
    */
    public override init() {
        super.init()
    }

    /**
       Constructor used by implementation to set the ContactProfessionalInfo.

       @param jobTitle       The job title
       @param jobDescription The job description
       @param company        The company of the job
       @since v2.0
    */
    public init(jobTitle: String, jobDescription: String, company: String) {
        super.init()
        self.jobTitle = jobTitle
        self.jobDescription = jobDescription
        self.company = company
    }

    /**
       Returns the company of the job

       @return company
       @since v2.0
    */
    public func getCompany() -> String? {
        return self.company
    }

    /**
       Set the company of the job

       @param company The company of the job
       @since v2.0
    */
    public func setCompany(company: String) {
        self.company = company
    }

    /**
       Returns the description of the job

       @return description
       @since v2.0
    */
    public func getJobDescription() -> String? {
        return self.jobDescription
    }

    /**
       Set the description of the job

       @param jobDescription The job description
       @since v2.0
    */
    public func setJobDescription(jobDescription: String) {
        self.jobDescription = jobDescription
    }

    /**
       Returns the title of the job

       @return title
       @since v2.0
    */
    public func getJobTitle() -> String? {
        return self.jobTitle
    }

    /**
       Set the title of the job

       @param jobTitle The job title
       @since v2.0
    */
    public func setJobTitle(jobTitle: String) {
        self.jobTitle = jobTitle
    }


    /**
       JSON Serialization and deserialization support.
    */
    struct Serializer {
        static func fromJSON(json : String) -> ContactProfessionalInfo {
            var data:NSData = json.dataUsingEncoding(NSUTF8StringEncoding)!
            var jsonError: NSError?
            let dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary
            return fromDictionary(dict)
        }

        static func fromDictionary(dict : NSDictionary) -> ContactProfessionalInfo {
            var resultObject : ContactProfessionalInfo = ContactProfessionalInfo()

            if let value : AnyObject = dict.objectForKey("company") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.company = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("jobDescription") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.jobDescription = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("jobTitle") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.jobTitle = (value as String)
                }
            }

            return resultObject
        }

        static func toJSON(object: ContactProfessionalInfo) -> String {
            var jsonString : NSMutableString = NSMutableString()
            // Start Object to JSON
            jsonString.appendString("{ ")

            // Fields.
            object.company != nil ? jsonString.appendString("\"company\": \"\(JSONUtil.escapeString(object.company!))\", ") : jsonString.appendString("\"company\": null, ")
            object.jobDescription != nil ? jsonString.appendString("\"jobDescription\": \"\(JSONUtil.escapeString(object.jobDescription!))\", ") : jsonString.appendString("\"jobDescription\": null, ")
            object.jobTitle != nil ? jsonString.appendString("\"jobTitle\": \"\(JSONUtil.escapeString(object.jobTitle!))\"") : jsonString.appendString("\"jobTitle\": null")

            // End Object to JSON
            jsonString.appendString(" }")
            return jsonString
        }
    }
}

/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
