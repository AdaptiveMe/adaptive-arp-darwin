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

    * @version v2.1.4

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Structure representing the data elements of an email.

   @author Francisco Javier Martin Bueno
   @since v2.0
   @version 1.0
*/
public class Email : APIBean {

    /**
       Array of Email Blind Carbon Copy recipients
    */
    var bccRecipients : [EmailAddress]?
    /**
       Array of Email Carbon Copy recipients
    */
    var ccRecipients : [EmailAddress]?
    /**
       Array of attatchments
    */
    var emailAttachmentData : [EmailAttachmentData]?
    /**
       Message body
    */
    var messageBody : String?
    /**
       Message body mime type
    */
    var messageBodyMimeType : String?
    /**
       Subject of the email
    */
    var subject : String?
    /**
       Array of Email recipients
    */
    var toRecipients : [EmailAddress]?

    /**
       Default constructor

       @since v2.0
    */
    public override init() {
        super.init()
    }

    /**
       Constructor used by the implementation

       @param toRecipients        array of recipients
       @param ccRecipients        array of cc recipients
       @param bccRecipients       array of bcc recipients
       @param emailAttachmentData array of attatchments
       @param messageBody         body of the email
       @param messageBodyMimeType mime type of the body
       @param subject             of the email
       @since v2.0
    */
    public init(toRecipients: [EmailAddress], ccRecipients: [EmailAddress], bccRecipients: [EmailAddress], emailAttachmentData: [EmailAttachmentData], messageBody: String, messageBodyMimeType: String, subject: String) {
        super.init()
        self.toRecipients = toRecipients
        self.ccRecipients = ccRecipients
        self.bccRecipients = bccRecipients
        self.emailAttachmentData = emailAttachmentData
        self.messageBody = messageBody
        self.messageBodyMimeType = messageBodyMimeType
        self.subject = subject
    }

    /**
       Constructor used by the implementation

       @param toRecipients array of recipients
       @param subject      of the email
       @param messageBody  body of the email
       @since v2.0
    */
    public init(toRecipients: [EmailAddress], subject: String, messageBody: String) {
        super.init()
        self.toRecipients = toRecipients
        self.subject = subject
        self.messageBody = messageBody
    }

    /**
       Returns the array of recipients

       @return bccRecipients array of bcc recipients
       @since v2.0
    */
    public func getBccRecipients() -> [EmailAddress]? {
        return self.bccRecipients
    }

    /**
       Set the array of recipients

       @param bccRecipients array of bcc recipients
       @since v2.0
    */
    public func setBccRecipients(bccRecipients: [EmailAddress]) {
        self.bccRecipients = bccRecipients
    }

    /**
       Returns the array of recipients

       @return ccRecipients array of cc recipients
       @since v2.0
    */
    public func getCcRecipients() -> [EmailAddress]? {
        return self.ccRecipients
    }

    /**
       Set the array of recipients

       @param ccRecipients array of cc recipients
       @since v2.0
    */
    public func setCcRecipients(ccRecipients: [EmailAddress]) {
        self.ccRecipients = ccRecipients
    }

    /**
       Returns an array of attachments

       @return emailAttachmentData array with the email attachments
       @since v2.0
    */
    public func getEmailAttachmentData() -> [EmailAttachmentData]? {
        return self.emailAttachmentData
    }

    /**
       Set the email attachment data array

       @param emailAttachmentData array of email attatchments
       @since v2.0
    */
    public func setEmailAttachmentData(emailAttachmentData: [EmailAttachmentData]) {
        self.emailAttachmentData = emailAttachmentData
    }

    /**
       Returns the message body of the email

       @return message Body string of the email
       @since v2.0
    */
    public func getMessageBody() -> String? {
        return self.messageBody
    }

    /**
       Set the message body of the email

       @param messageBody message body of the email
       @since v2.0
    */
    public func setMessageBody(messageBody: String) {
        self.messageBody = messageBody
    }

    /**
       Returns the myme type of the message body

       @return mime type string of the message boddy
       @since v2.0
    */
    public func getMessageBodyMimeType() -> String? {
        return self.messageBodyMimeType
    }

    /**
       Set the mime type for the message body

       @param messageBodyMimeType type of the body message
       @since v2.0
    */
    public func setMessageBodyMimeType(messageBodyMimeType: String) {
        self.messageBodyMimeType = messageBodyMimeType
    }

    /**
       Returns the subject of the email

       @return subject string of the email
       @since v2.0
    */
    public func getSubject() -> String? {
        return self.subject
    }

    /**
       Set the subject of the email

       @param subject of the email
       @since v2.0
    */
    public func setSubject(subject: String) {
        self.subject = subject
    }

    /**
       Returns the array of recipients

       @return toRecipients array of recipients
       @since v2.0
    */
    public func getToRecipients() -> [EmailAddress]? {
        return self.toRecipients
    }

    /**
       Set the array of recipients

       @param toRecipients array of recipients
       @since v2.0
    */
    public func setToRecipients(toRecipients: [EmailAddress]) {
        self.toRecipients = toRecipients
    }


    /**
       JSON Serialization and deserialization support.
    */
    struct Serializer {
        static func fromJSON(json : String) -> Email {
            var data:NSData = json.dataUsingEncoding(NSUTF8StringEncoding)!
            var jsonError: NSError?
            let dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary
            return fromDictionary(dict)
        }

        static func fromDictionary(dict : NSDictionary) -> Email {
            var resultObject : Email = Email()

            if let value : AnyObject = dict.objectForKey("bccRecipients") {
                if "\(value)" as NSString != "<null>" {
                    var bccRecipients : [EmailAddress] = [EmailAddress]()
                    for (var i = 0;i < (value as NSArray).count ; i++) {
                        bccRecipients.append(EmailAddress.Serializer.fromDictionary((value as NSArray)[i] as NSDictionary))
                    }
                    resultObject.bccRecipients = bccRecipients
                }
            }

            if let value : AnyObject = dict.objectForKey("ccRecipients") {
                if "\(value)" as NSString != "<null>" {
                    var ccRecipients : [EmailAddress] = [EmailAddress]()
                    for (var i = 0;i < (value as NSArray).count ; i++) {
                        ccRecipients.append(EmailAddress.Serializer.fromDictionary((value as NSArray)[i] as NSDictionary))
                    }
                    resultObject.ccRecipients = ccRecipients
                }
            }

            if let value : AnyObject = dict.objectForKey("emailAttachmentData") {
                if "\(value)" as NSString != "<null>" {
                    var emailAttachmentData : [EmailAttachmentData] = [EmailAttachmentData]()
                    for (var i = 0;i < (value as NSArray).count ; i++) {
                        emailAttachmentData.append(EmailAttachmentData.Serializer.fromDictionary((value as NSArray)[i] as NSDictionary))
                    }
                    resultObject.emailAttachmentData = emailAttachmentData
                }
            }

            if let value : AnyObject = dict.objectForKey("messageBody") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.messageBody = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("messageBodyMimeType") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.messageBodyMimeType = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("subject") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.subject = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("toRecipients") {
                if "\(value)" as NSString != "<null>" {
                    var toRecipients : [EmailAddress] = [EmailAddress]()
                    for (var i = 0;i < (value as NSArray).count ; i++) {
                        toRecipients.append(EmailAddress.Serializer.fromDictionary((value as NSArray)[i] as NSDictionary))
                    }
                    resultObject.toRecipients = toRecipients
                }
            }

            return resultObject
        }

        static func toJSON(object: Email) -> String {
            var jsonString : NSMutableString = NSMutableString()
            // Start Object to JSON
            jsonString.appendString("{ ")

            // Fields.
            if (object.bccRecipients != nil) {
                // Start array of objects.
                jsonString.appendString("\"bccRecipients\": [")

                for var i = 0; i < object.bccRecipients!.count; i++ {
                    jsonString.appendString(EmailAddress.Serializer.toJSON(object.bccRecipients![i]))
                    if (i < object.bccRecipients!.count-1) {
                        jsonString.appendString(", ");
                    }
                }

                // End array of objects.
                jsonString.appendString("], ");
            } else {
                jsonString.appendString("\"bccRecipients\": null, ")
            }
            if (object.ccRecipients != nil) {
                // Start array of objects.
                jsonString.appendString("\"ccRecipients\": [")

                for var i = 0; i < object.ccRecipients!.count; i++ {
                    jsonString.appendString(EmailAddress.Serializer.toJSON(object.ccRecipients![i]))
                    if (i < object.ccRecipients!.count-1) {
                        jsonString.appendString(", ");
                    }
                }

                // End array of objects.
                jsonString.appendString("], ");
            } else {
                jsonString.appendString("\"ccRecipients\": null, ")
            }
            if (object.emailAttachmentData != nil) {
                // Start array of objects.
                jsonString.appendString("\"emailAttachmentData\": [")

                for var i = 0; i < object.emailAttachmentData!.count; i++ {
                    jsonString.appendString(EmailAttachmentData.Serializer.toJSON(object.emailAttachmentData![i]))
                    if (i < object.emailAttachmentData!.count-1) {
                        jsonString.appendString(", ");
                    }
                }

                // End array of objects.
                jsonString.appendString("], ");
            } else {
                jsonString.appendString("\"emailAttachmentData\": null, ")
            }
            object.messageBody != nil ? jsonString.appendString("\"messageBody\": \"\(JSONUtil.escapeString(object.messageBody!))\", ") : jsonString.appendString("\"messageBody\": null, ")
            object.messageBodyMimeType != nil ? jsonString.appendString("\"messageBodyMimeType\": \"\(JSONUtil.escapeString(object.messageBodyMimeType!))\", ") : jsonString.appendString("\"messageBodyMimeType\": null, ")
            object.subject != nil ? jsonString.appendString("\"subject\": \"\(JSONUtil.escapeString(object.subject!))\", ") : jsonString.appendString("\"subject\": null, ")
            if (object.toRecipients != nil) {
                // Start array of objects.
                jsonString.appendString("\"toRecipients\": [")

                for var i = 0; i < object.toRecipients!.count; i++ {
                    jsonString.appendString(EmailAddress.Serializer.toJSON(object.toRecipients![i]))
                    if (i < object.toRecipients!.count-1) {
                        jsonString.appendString(", ");
                    }
                }

                // End array of objects.
                jsonString.appendString("]");
            } else {
                jsonString.appendString("\"toRecipients\": null")
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
