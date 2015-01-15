var __extends = this.__extends || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    __.prototype = b.prototype;
    d.prototype = new __();
};
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

    * @version v2.0.3

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/
var Adaptive;
(function (Adaptive) {
    /**
       Global unique id for listeners and callbacks.
    */
    Adaptive.registeredCounter = 0;
    /**
       Base url for for http/https JSON requests.
    */
    Adaptive.bridgePath = "https://adaptiveapp";
    var Dictionary = (function () {
        function Dictionary(init) {
            this._keys = new Array();
            this._values = new Array();
            for (var x = 0; x < init.length; x++) {
                this[init[x].key] = init[x].value;
                this._keys.push(init[x].key);
                this._values.push(init[x].value);
            }
        }
        Dictionary.prototype.add = function (key, value) {
            this[key] = value;
            this._keys.push(key);
            this._values.push(value);
        };
        Dictionary.prototype.remove = function (key) {
            var index = this._keys.indexOf(key, 0);
            this._keys.splice(index, 1);
            this._values.splice(index, 1);
            delete this[key];
        };
        Dictionary.prototype.keys = function () {
            return this._keys;
        };
        Dictionary.prototype.values = function () {
            return this._values;
        };
        Dictionary.prototype.containsKey = function (key) {
            if (typeof this[key] === "undefined") {
                return false;
            }
            return true;
        };
        Dictionary.prototype.toLookup = function () {
            return this;
        };
        return Dictionary;
    })();
    Adaptive.Dictionary = Dictionary;
    /**
       Structure representing a native response to the HTML5

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    var APIBean = (function () {
        /**
           Default constructor

           @since ARP1.0
        */
        function APIBean() {
        }
        /**
           Convert JSON parsed object to typed equivalent.
        */
        APIBean.toObject = function (object) {
            var result = new APIBean();
            return result;
        };
        return APIBean;
    })();
    Adaptive.APIBean = APIBean;
    /**
       Structure representing a HTML5 request to the native API.

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    var APIRequest = (function () {
        /**
           Constructor with all the parameters

           @param bridgeType Name of the bridge to be invoked.
           @param methodName Name of the method
           @param parameters Array of parameters as JSON formatted strings.
           @param asyncId    Id of callback or listener or zero if none for synchronous calls.
           @since ARP1.0
        */
        function APIRequest(bridgeType, methodName, parameters, asyncId) {
            this.bridgeType = bridgeType;
            this.methodName = methodName;
            this.parameters = parameters;
            this.asyncId = asyncId;
        }
        /**
           Returns the callback or listener id assigned to this request OR zero if there is no associated callback or
listener.

           @return long with the unique id of the callback or listener, or zero if there is no associated async event.
        */
        APIRequest.prototype.getAsyncId = function () {
            return this.asyncId;
        };
        /**
           Sets the callback or listener id to the request.

           @param asyncId The unique id of the callback or listener.
        */
        APIRequest.prototype.setAsyncId = function (asyncId) {
            this.asyncId = asyncId;
        };
        /**
           Bridge Type Getter

           @return Bridge Type
           @since ARP1.0
        */
        APIRequest.prototype.getBridgeType = function () {
            return this.bridgeType;
        };
        /**
           Bridge Type Setter

           @param bridgeType Bridge Type
           @since ARP1.0
        */
        APIRequest.prototype.setBridgeType = function (bridgeType) {
            this.bridgeType = bridgeType;
        };
        /**
           Method name Getter

           @return Method name
           @since ARP1.0
        */
        APIRequest.prototype.getMethodName = function () {
            return this.methodName;
        };
        /**
           Method name Setter

           @param methodName Method name
           @since ARP1.0
        */
        APIRequest.prototype.setMethodName = function (methodName) {
            this.methodName = methodName;
        };
        /**
           Parameters Getter

           @return Parameters
           @since ARP1.0
        */
        APIRequest.prototype.getParameters = function () {
            return this.parameters;
        };
        /**
           Parameters Setter

           @param parameters Parameters, JSON formatted strings of objects.
           @since ARP1.0
        */
        APIRequest.prototype.setParameters = function (parameters) {
            this.parameters = parameters;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        APIRequest.toObject = function (object) {
            var result = new APIRequest(null, null, null, null);
            // Assign values to bean fields.
            result.bridgeType = object.bridgeType;
            result.methodName = object.methodName;
            result.parameters = new Array();
            for (var __value__ in object.parameters) {
                result.parameters.push(__value__);
            }
            result.asyncId = object.asyncId;
            return result;
        };
        return APIRequest;
    })();
    Adaptive.APIRequest = APIRequest;
    /**
       Structure representing a JSON response to the HTML5 layer.

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    var APIResponse = (function () {
        /**
           Constructor with parameters.

           @param response      String representing the JavaScript value or JSON object representation of the response.
           @param statusCode    Status code of the response (200 = OK, others are warning or error conditions).
           @param statusMessage Status message of the response.
        */
        function APIResponse(response, statusCode, statusMessage) {
            this.response = response;
            this.statusCode = statusCode;
            this.statusMessage = statusMessage;
        }
        /**
           Response getter

           @return String representing the JavaScript value or JSON object representation of the response.
           @since ARP1.0
        */
        APIResponse.prototype.getResponse = function () {
            return this.response;
        };
        /**
           Response setter

           @param response String representing the JavaScript value or JSON object representation of the response.
        */
        APIResponse.prototype.setResponse = function (response) {
            this.response = response;
        };
        /**
           Status code getter

           @return Status code of the response (200 = OK, others are warning or error conditions).
        */
        APIResponse.prototype.getStatusCode = function () {
            return this.statusCode;
        };
        /**
           Status code setter

           @param statusCode Status code of the response  (200 = OK, others are warning or error conditions).
        */
        APIResponse.prototype.setStatusCode = function (statusCode) {
            this.statusCode = statusCode;
        };
        /**
           Status message getter

           @return Status message of the response.
        */
        APIResponse.prototype.getStatusMessage = function () {
            return this.statusMessage;
        };
        /**
           Status message setter.

           @param statusMessage Status message of the response
        */
        APIResponse.prototype.setStatusMessage = function (statusMessage) {
            this.statusMessage = statusMessage;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        APIResponse.toObject = function (object) {
            var result = new APIResponse(null, null, null);
            // Assign values to bean fields.
            result.response = object.response;
            result.statusCode = object.statusCode;
            result.statusMessage = object.statusMessage;
            return result;
        };
        return APIResponse;
    })();
    Adaptive.APIResponse = APIResponse;
    /**
       Structure representing the data of a single acceleration reading.

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    var Acceleration = (function (_super) {
        __extends(Acceleration, _super);
        /**
           Constructor with fields

           @param x         X Coordinate
           @param y         Y Coordinate
           @param z         Z Coordinate
           @param timestamp Timestamp
           @since ARP1.0
        */
        function Acceleration(x, y, z, timestamp) {
            _super.call(this);
            this.x = x;
            this.y = y;
            this.z = z;
            this.timestamp = timestamp;
        }
        /**
           Timestamp Getter

           @return Timestamp
           @since ARP1.0
        */
        Acceleration.prototype.getTimestamp = function () {
            return this.timestamp;
        };
        /**
           Timestamp Setter

           @param timestamp Timestamp
           @since ARP1.0
        */
        Acceleration.prototype.setTimestamp = function (timestamp) {
            this.timestamp = timestamp;
        };
        /**
           X Coordinate Getter

           @return X-axis component of the acceleration.
           @since ARP1.0
        */
        Acceleration.prototype.getX = function () {
            return this.x;
        };
        /**
           X Coordinate Setter

           @param x X-axis component of the acceleration.
           @since ARP1.0
        */
        Acceleration.prototype.setX = function (x) {
            this.x = x;
        };
        /**
           Y Coordinate Getter

           @return Y-axis component of the acceleration.
           @since ARP1.0
        */
        Acceleration.prototype.getY = function () {
            return this.y;
        };
        /**
           Y Coordinate Setter

           @param y Y-axis component of the acceleration.
           @since ARP1.0
        */
        Acceleration.prototype.setY = function (y) {
            this.y = y;
        };
        /**
           Z Coordinate Getter

           @return Z-axis component of the acceleration.
           @since ARP1.0
        */
        Acceleration.prototype.getZ = function () {
            return this.z;
        };
        /**
           Z Coordinate Setter

           @param z Z Coordinate
           @since ARP1.0
        */
        Acceleration.prototype.setZ = function (z) {
            this.z = z;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        Acceleration.toObject = function (object) {
            var result = new Acceleration(null, null, null, null);
            // Assign values to bean fields.
            result.x = object.x;
            result.y = object.y;
            result.z = object.z;
            result.timestamp = object.timestamp;
            return result;
        };
        return Acceleration;
    })(APIBean);
    Adaptive.Acceleration = Acceleration;
    /**
       Structure representing the a physical or logical button on a device.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    var Button = (function (_super) {
        __extends(Button, _super);
        /**
           Constructor with fields

           @param type Button type.
           @since ARP1.0
        */
        function Button(type) {
            _super.call(this);
            this.type = type;
        }
        /**
           Returns the button type

           @return type Button type.
           @since ARP1.0
        */
        Button.prototype.getType = function () {
            return this.type;
        };
        /**
           Setter for the button type

           @param type Button Type
           @since ARP1.0
        */
        Button.prototype.setType = function (type) {
            this.type = type;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        Button.toObject = function (object) {
            var result = new Button(null);
            // Assign values to bean fields.
            result.type = ICapabilitiesButton.toObject(object.type);
            return result;
        };
        return Button;
    })(APIBean);
    Adaptive.Button = Button;
    /**
       Structure representing the address data elements of a contact.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    var ContactAddress = (function (_super) {
        __extends(ContactAddress, _super);
        /**
           Constructor with fields

           @param address Address data.
           @param type    Address type.
           @since ARP1.0
        */
        function ContactAddress(address, type) {
            _super.call(this);
            this.address = address;
            this.type = type;
        }
        /**
           Returns the type of the address

           @return AddressType Address type.
           @since ARP1.0
        */
        ContactAddress.prototype.getType = function () {
            return this.type;
        };
        /**
           Set the address type

           @param type Address type.
           @since ARP1.0
        */
        ContactAddress.prototype.setType = function (type) {
            this.type = type;
        };
        /**
           Returns the Contact address

           @return address Address data.
           @since ARP1.0
        */
        ContactAddress.prototype.getAddress = function () {
            return this.address;
        };
        /**
           Set the address of the Contact

           @param address Address data.
           @since ARP1.0
        */
        ContactAddress.prototype.setAddress = function (address) {
            this.address = address;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        ContactAddress.toObject = function (object) {
            var result = new ContactAddress(null, null);
            // Assign values to bean fields.
            result.address = object.address;
            result.type = ContactAddressType.toObject(object.type);
            return result;
        };
        return ContactAddress;
    })(APIBean);
    Adaptive.ContactAddress = ContactAddress;
    /**
       Structure representing the email data elements of a contact.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    var ContactEmail = (function (_super) {
        __extends(ContactEmail, _super);
        /**
           Constructor used by the implementation

           @param type    Type of the email
           @param primary Is email primary
           @param email   Email of the contact
           @since ARP1.0
        */
        function ContactEmail(type, primary, email) {
            _super.call(this);
            this.type = type;
            this.primary = primary;
            this.email = email;
        }
        /**
           Returns the type of the email

           @return EmailType
           @since ARP1.0
        */
        ContactEmail.prototype.getType = function () {
            return this.type;
        };
        /**
           Set the type of the email

           @param type Type of the email
           @since ARP1.0
        */
        ContactEmail.prototype.setType = function (type) {
            this.type = type;
        };
        /**
           Returns the email of the Contact

           @return email
           @since ARP1.0
        */
        ContactEmail.prototype.getEmail = function () {
            return this.email;
        };
        /**
           Set the email of the Contact

           @param email Email of the contact
           @since ARP1.0
        */
        ContactEmail.prototype.setEmail = function (email) {
            this.email = email;
        };
        /**
           Returns if the email is primary

           @return true if the email is primary; false otherwise
           @since ARP1.0
        */
        ContactEmail.prototype.getPrimary = function () {
            return this.primary;
        };
        /**
           Set if the email

           @param primary true if the email is primary; false otherwise
           @since ARP1.0
        */
        ContactEmail.prototype.setPrimary = function (primary) {
            this.primary = primary;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        ContactEmail.toObject = function (object) {
            var result = new ContactEmail(null, null, null);
            // Assign values to bean fields.
            result.type = ContactEmailType.toObject(object.type);
            result.primary = object.primary;
            result.email = object.email;
            return result;
        };
        return ContactEmail;
    })(APIBean);
    Adaptive.ContactEmail = ContactEmail;
    /**
       Structure representing the personal info data elements of a contact.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    var ContactPersonalInfo = (function (_super) {
        __extends(ContactPersonalInfo, _super);
        /**
           The Constructor used by the implementation

           @param name       of the Contact
           @param middleName of the Contact
           @param lastName   of the Contact
           @param title      of the Contact
           @since ARP1.0
        */
        function ContactPersonalInfo(name, middleName, lastName, title) {
            _super.call(this);
            this.name = name;
            this.middleName = middleName;
            this.lastName = lastName;
            this.title = title;
        }
        /**
           Returns the title of the Contact

           @return Title
           @since ARP1.0
        */
        ContactPersonalInfo.prototype.getTitle = function () {
            return this.title;
        };
        /**
           Set the Title of the Contact

           @param title of the Contact
           @since ARP1.0
        */
        ContactPersonalInfo.prototype.setTitle = function (title) {
            this.title = title;
        };
        /**
           Returns the last name of the Contact

           @return lastName
           @since ARP1.0
        */
        ContactPersonalInfo.prototype.getLastName = function () {
            return this.lastName;
        };
        /**
           Set the last name of the Contact

           @param lastName of the Contact
           @since ARP1.0
        */
        ContactPersonalInfo.prototype.setLastName = function (lastName) {
            this.lastName = lastName;
        };
        /**
           Returns the middle name of the Contact

           @return middelName
           @since ARP1.0
        */
        ContactPersonalInfo.prototype.getMiddleName = function () {
            return this.middleName;
        };
        /**
           Set the middle name of the Contact

           @param middleName of the Contact
           @since ARP1.0
        */
        ContactPersonalInfo.prototype.setMiddleName = function (middleName) {
            this.middleName = middleName;
        };
        /**
           Returns the name of the Contact

           @return name
           @since ARP1.0
        */
        ContactPersonalInfo.prototype.getName = function () {
            return this.name;
        };
        /**
           Set the name of the Contact

           @param name of the Contact
           @since ARP1.0
        */
        ContactPersonalInfo.prototype.setName = function (name) {
            this.name = name;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        ContactPersonalInfo.toObject = function (object) {
            var result = new ContactPersonalInfo(null, null, null, null);
            // Assign values to bean fields.
            result.name = object.name;
            result.middleName = object.middleName;
            result.lastName = object.lastName;
            result.title = ContactPersonalInfoTitle.toObject(object.title);
            return result;
        };
        return ContactPersonalInfo;
    })(APIBean);
    Adaptive.ContactPersonalInfo = ContactPersonalInfo;
    /**
       Structure representing the phone data elements of a contact.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    var ContactPhone = (function (_super) {
        __extends(ContactPhone, _super);
        /**
           Constructor used by implementation to set the contact Phone

           @param phone     Phone number
           @param phoneType Type of Phone number
           @since ARP1.0
        */
        function ContactPhone(phone, phoneType) {
            _super.call(this);
            this.phone = phone;
            this.phoneType = phoneType;
        }
        /**
           Returns the phone phoneType

           @return phoneType
           @since ARP1.0
        */
        ContactPhone.prototype.getPhoneType = function () {
            return this.phoneType;
        };
        /**
           Set the phoneType of the phone number

           @param phoneType Type of Phone number
           @since ARP1.0
        */
        ContactPhone.prototype.setPhoneType = function (phoneType) {
            this.phoneType = phoneType;
        };
        /**
           Returns the phone number

           @return phone number
           @since ARP1.0
        */
        ContactPhone.prototype.getPhone = function () {
            return this.phone;
        };
        /**
           Set the phone number

           @param phone number
           @since ARP1.0
        */
        ContactPhone.prototype.setPhone = function (phone) {
            this.phone = phone;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        ContactPhone.toObject = function (object) {
            var result = new ContactPhone(null, null);
            // Assign values to bean fields.
            result.phone = object.phone;
            result.phoneType = ContactPhoneType.toObject(object.phoneType);
            return result;
        };
        return ContactPhone;
    })(APIBean);
    Adaptive.ContactPhone = ContactPhone;
    /**
       Structure representing the professional info data elements of a contact.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    var ContactProfessionalInfo = (function (_super) {
        __extends(ContactProfessionalInfo, _super);
        /**
           Constructor used by implementation to set the ContactProfessionalInfo.

           @param jobTitle       The job title
           @param jobDescription The job description
           @param company        The company of the job
           @since ARP1.0
        */
        function ContactProfessionalInfo(jobTitle, jobDescription, company) {
            _super.call(this);
            this.jobTitle = jobTitle;
            this.jobDescription = jobDescription;
            this.company = company;
        }
        /**
           Returns the company of the job

           @return company
           @since ARP1.0
        */
        ContactProfessionalInfo.prototype.getCompany = function () {
            return this.company;
        };
        /**
           Set the company of the job

           @param company The company of the job
           @since ARP1.0
        */
        ContactProfessionalInfo.prototype.setCompany = function (company) {
            this.company = company;
        };
        /**
           Returns the description of the job

           @return description
           @since ARP1.0
        */
        ContactProfessionalInfo.prototype.getJobDescription = function () {
            return this.jobDescription;
        };
        /**
           Set the description of the job

           @param jobDescription The job description
           @since ARP1.0
        */
        ContactProfessionalInfo.prototype.setJobDescription = function (jobDescription) {
            this.jobDescription = jobDescription;
        };
        /**
           Returns the title of the job

           @return title
           @since ARP1.0
        */
        ContactProfessionalInfo.prototype.getJobTitle = function () {
            return this.jobTitle;
        };
        /**
           Set the title of the job

           @param jobTitle The job title
           @since ARP1.0
        */
        ContactProfessionalInfo.prototype.setJobTitle = function (jobTitle) {
            this.jobTitle = jobTitle;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        ContactProfessionalInfo.toObject = function (object) {
            var result = new ContactProfessionalInfo(null, null, null);
            // Assign values to bean fields.
            result.company = object.company;
            result.jobTitle = object.jobTitle;
            result.jobDescription = object.jobDescription;
            return result;
        };
        return ContactProfessionalInfo;
    })(APIBean);
    Adaptive.ContactProfessionalInfo = ContactProfessionalInfo;
    /**
       Structure representing the social data elements of a contact.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    var ContactSocial = (function (_super) {
        __extends(ContactSocial, _super);
        /**
           Constructor used by the implementation

           @param socialNetwork of the profile
           @param profileUrl    of the user
           @since ARP1.0
        */
        function ContactSocial(socialNetwork, profileUrl) {
            _super.call(this);
            this.socialNetwork = socialNetwork;
            this.profileUrl = profileUrl;
        }
        /**
           Returns the social network

           @return socialNetwork
           @since ARP1.0
        */
        ContactSocial.prototype.getSocialNetwork = function () {
            return this.socialNetwork;
        };
        /**
           Set the social network

           @param socialNetwork of the profile
           @since ARP1.0
        */
        ContactSocial.prototype.setSocialNetwork = function (socialNetwork) {
            this.socialNetwork = socialNetwork;
        };
        /**
           Returns the profile url of the user

           @return profileUrl
           @since ARP1.0
        */
        ContactSocial.prototype.getProfileUrl = function () {
            return this.profileUrl;
        };
        /**
           Set the profile url of the iser

           @param profileUrl of the user
           @since ARP1.0
        */
        ContactSocial.prototype.setProfileUrl = function (profileUrl) {
            this.profileUrl = profileUrl;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        ContactSocial.toObject = function (object) {
            var result = new ContactSocial(null, null);
            // Assign values to bean fields.
            result.socialNetwork = ContactSocialNetwork.toObject(object.socialNetwork);
            result.profileUrl = object.profileUrl;
            return result;
        };
        return ContactSocial;
    })(APIBean);
    Adaptive.ContactSocial = ContactSocial;
    /**
       Structure representing the assigned tags data elements of a contact.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    var ContactTag = (function (_super) {
        __extends(ContactTag, _super);
        /**
           Constructor used by the implementation

           @param tagValue Value of the tag
           @param tagName  Name of the tag
           @since ARP1.0
        */
        function ContactTag(tagName, tagValue) {
            _super.call(this);
            this.tagName = tagName;
            this.tagValue = tagValue;
        }
        /**
           Returns the tagName of the Tag

           @return tagName
           @since ARP1.0
        */
        ContactTag.prototype.getTagName = function () {
            return this.tagName;
        };
        /**
           Set the tagName of the Tag

           @param tagName Name of the tag
           @since ARP1.0
        */
        ContactTag.prototype.setTagName = function (tagName) {
            this.tagName = tagName;
        };
        /**
           Returns the tagValue of the Tag

           @return tagValue
           @since ARP1.0
        */
        ContactTag.prototype.getTagValue = function () {
            return this.tagValue;
        };
        /**
           Set the tagValue of the Tag

           @param tagValue Value of the tag
           @since ARP1.0
        */
        ContactTag.prototype.setTagValue = function (tagValue) {
            this.tagValue = tagValue;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        ContactTag.toObject = function (object) {
            var result = new ContactTag(null, null);
            // Assign values to bean fields.
            result.tagName = object.tagName;
            result.tagValue = object.tagValue;
            return result;
        };
        return ContactTag;
    })(APIBean);
    Adaptive.ContactTag = ContactTag;
    /**
       Structure representing the internal unique identifier data elements of a contact.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    var ContactUid = (function (_super) {
        __extends(ContactUid, _super);
        /**
           Constructor used by implementation to set the Contact id.

           @param contactId Internal unique contact id.
           @since ARP1.0
        */
        function ContactUid(contactId) {
            _super.call(this);
            this.contactId = contactId;
        }
        /**
           Returns the contact id

           @return Contactid Internal unique contact id.
           @since ARP1.0
        */
        ContactUid.prototype.getContactId = function () {
            return this.contactId;
        };
        /**
           Set the id of the Contact

           @param contactId Internal unique contact id.
           @since ARP1.0
        */
        ContactUid.prototype.setContactId = function (contactId) {
            this.contactId = contactId;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        ContactUid.toObject = function (object) {
            var result = new ContactUid(null);
            // Assign values to bean fields.
            result.contactId = object.contactId;
            return result;
        };
        return ContactUid;
    })(APIBean);
    Adaptive.ContactUid = ContactUid;
    /**
       Structure representing the website data elements of a contact.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    var ContactWebsite = (function (_super) {
        __extends(ContactWebsite, _super);
        /**
           Constructor used by the implementation

           @param url Url of the website
           @since ARP1.0
        */
        function ContactWebsite(url) {
            _super.call(this);
            this.url = url;
        }
        /**
           Returns the url of the website

           @return website url
           @since ARP1.0
        */
        ContactWebsite.prototype.getUrl = function () {
            return this.url;
        };
        /**
           Set the url of the website

           @param url Url of the website
           @since ARP1.0
        */
        ContactWebsite.prototype.setUrl = function (url) {
            this.url = url;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        ContactWebsite.toObject = function (object) {
            var result = new ContactWebsite(null);
            // Assign values to bean fields.
            result.url = object.url;
            return result;
        };
        return ContactWebsite;
    })(APIBean);
    Adaptive.ContactWebsite = ContactWebsite;
    /**
       Structure representing a database reference.

       @author Ferran Vila Conesa
       @since ARP1.0
       @version 1.0
    */
    var Database = (function (_super) {
        __extends(Database, _super);
        /**
           Constructor using fields.

           @param name     Name of the DatabaseTable.
           @param compress Compression enabled.
           @since ARP1.0
        */
        function Database(name, compress) {
            _super.call(this);
            this.name = name;
            this.compress = compress;
        }
        /**
           Returns if the table is compressed

           @return Compression enabled
           @since ARP1.0
        */
        Database.prototype.getCompress = function () {
            return this.compress;
        };
        /**
           Sets if the table is compressed or not.

           @param compress Compression enabled
           @since ARP1.0
        */
        Database.prototype.setCompress = function (compress) {
            this.compress = compress;
        };
        /**
           Returns the name.

           @return The name of the table.
           @since ARP1.0
        */
        Database.prototype.getName = function () {
            return this.name;
        };
        /**
           Sets the name of the table.

           @param name The name of the table.
           @since ARP1.0
        */
        Database.prototype.setName = function (name) {
            this.name = name;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        Database.toObject = function (object) {
            var result = new Database(null, null);
            // Assign values to bean fields.
            result.name = object.name;
            result.compress = object.compress;
            return result;
        };
        return Database;
    })(APIBean);
    Adaptive.Database = Database;
    /**
       Structure representing the column specification of a data column.

       @author Ferran Vila Conesa
       @since ARP1.0
       @version 1.0
    */
    var DatabaseColumn = (function (_super) {
        __extends(DatabaseColumn, _super);
        /**
           Constructor with fields

           @param name Name of the column
           @since ARP1.0
        */
        function DatabaseColumn(name) {
            _super.call(this);
            this.name = name;
        }
        /**
           Returns the name of the column.

           @return The name of the column.
           @since ARP1.0
        */
        DatabaseColumn.prototype.getName = function () {
            return this.name;
        };
        /**
           Sets the name of the column.

           @param name The name of the column.
           @since ARP1.0
        */
        DatabaseColumn.prototype.setName = function (name) {
            this.name = name;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        DatabaseColumn.toObject = function (object) {
            var result = new DatabaseColumn(null);
            // Assign values to bean fields.
            result.name = object.name;
            return result;
        };
        return DatabaseColumn;
    })(APIBean);
    Adaptive.DatabaseColumn = DatabaseColumn;
    /**
       Structure representing a row for a data table.

       @author Ferran Vila Conesa
       @since ARP1.0
       @version 1.0
    */
    var DatabaseRow = (function (_super) {
        __extends(DatabaseRow, _super);
        /**
           Constructor for implementation using.

           @param values The values of the row
           @since ARP1.0
        */
        function DatabaseRow(values) {
            _super.call(this);
            this.values = values;
        }
        /**
           Returns the values of the row.

           @return The values of the row.
           @since ARP1.0
        */
        DatabaseRow.prototype.getValues = function () {
            return this.values;
        };
        /**
           Sets the values of the row.

           @param values The values of the row.
           @since ARP1.0
        */
        DatabaseRow.prototype.setValues = function (values) {
            this.values = values;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        DatabaseRow.toObject = function (object) {
            var result = new DatabaseRow(null);
            // Assign values to bean fields.
            result.values = new Array();
            for (var __value__ in object.values) {
                result.values.push(__value__);
            }
            return result;
        };
        return DatabaseRow;
    })(APIBean);
    Adaptive.DatabaseRow = DatabaseRow;
    /**
       Represents a data table composed of databaseColumns and databaseRows.

       @author Ferran Vila Conesa
       @since ARP1.0
       @version 1.0
    */
    var DatabaseTable = (function (_super) {
        __extends(DatabaseTable, _super);
        /**
           Constructor using fields

           @param name            The name of the table
           @param columnCount     The number of databaseColumns
           @param rowCount        The number of databaseRows
           @param databaseColumns The databaseColumns of the table
           @param databaseRows    The databaseRows of the table
           @since ARP1.0
        */
        function DatabaseTable(name, columnCount, rowCount, databaseColumns, databaseRows) {
            _super.call(this);
            this.name = name;
            this.columnCount = columnCount;
            this.rowCount = rowCount;
            this.databaseColumns = databaseColumns;
            this.databaseRows = databaseRows;
        }
        /**
           Get the number of databaseColumns

           @return The number of databaseColumns
           @since ARP1.0
        */
        DatabaseTable.prototype.getColumnCount = function () {
            return this.columnCount;
        };
        /**
           Sets the number of databaseColumns

           @param columnCount The number of databaseColumns
           @since ARP1.0
        */
        DatabaseTable.prototype.setColumnCount = function (columnCount) {
            this.columnCount = columnCount;
        };
        /**
           Get the databaseColumns

           @return The databaseColumns
           @since ARP1.0
        */
        DatabaseTable.prototype.getDatabaseColumns = function () {
            return this.databaseColumns;
        };
        /**
           Sets the databaseColumns of the table

           @param databaseColumns The databaseColumns of the table
           @since ARP1.0
        */
        DatabaseTable.prototype.setDatabaseColumns = function (databaseColumns) {
            this.databaseColumns = databaseColumns;
        };
        /**
           Get the databaseRows of the table

           @return The databaseRows of the table
           @since ARP1.0
        */
        DatabaseTable.prototype.getDatabaseRows = function () {
            return this.databaseRows;
        };
        /**
           Sets the databaseRows of the table

           @param databaseRows The databaseRows of the table
           @since ARP1.0
        */
        DatabaseTable.prototype.setDatabaseRows = function (databaseRows) {
            this.databaseRows = databaseRows;
        };
        /**
           Returns the name of the table

           @return The name of the table
           @since ARP1.0
        */
        DatabaseTable.prototype.getName = function () {
            return this.name;
        };
        /**
           Sets the name of the table

           @param name The name of the table
           @since ARP1.0
        */
        DatabaseTable.prototype.setName = function (name) {
            this.name = name;
        };
        /**
           Get the number of databaseRows

           @return The number of databaseRows
           @since ARP1.0
        */
        DatabaseTable.prototype.getRowCount = function () {
            return this.rowCount;
        };
        /**
           Sets the number of databaseRows

           @param rowCount The number of databaseRows
           @since ARP1.0
        */
        DatabaseTable.prototype.setRowCount = function (rowCount) {
            this.rowCount = rowCount;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        DatabaseTable.toObject = function (object) {
            var result = new DatabaseTable(null, null, null, null, null);
            // Assign values to bean fields.
            result.name = object.name;
            result.columnCount = object.columnCount;
            result.rowCount = object.rowCount;
            result.databaseColumns = new Array();
            for (var __value__ in object.databaseColumns) {
                result.databaseColumns.push(DatabaseColumn.toObject(__value__));
            }
            result.databaseRows = new Array();
            for (var __value__ in object.databaseRows) {
                result.databaseRows.push(DatabaseRow.toObject(__value__));
            }
            return result;
        };
        return DatabaseTable;
    })(APIBean);
    Adaptive.DatabaseTable = DatabaseTable;
    /**
       Structure representing the basic device information.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    var DeviceInfo = (function (_super) {
        __extends(DeviceInfo, _super);
        /**
           Constructor for the implementation of the platform.

           @param name   or brand of the device.
           @param model  of the device.
           @param vendor of the device.
           @param uuid   unique* identifier (* platform dependent).
           @since ARP1.0
        */
        function DeviceInfo(name, model, vendor, uuid) {
            _super.call(this);
            this.name = name;
            this.model = model;
            this.vendor = vendor;
            this.uuid = uuid;
        }
        /**
           Returns the model of the device.

           @return String with the model of the device.
           @since ARP1.0
        */
        DeviceInfo.prototype.getModel = function () {
            return this.model;
        };
        /**
           Sets Model of device - equivalent to device release or version.

           @param model Model of device - equivalent to device release or version.
        */
        DeviceInfo.prototype.setModel = function (model) {
            this.model = model;
        };
        /**
           Returns the name of the device.

           @return String with device name.
           @since ARP1.0
        */
        DeviceInfo.prototype.getName = function () {
            return this.name;
        };
        /**
           Sets Name of device - equivalent to brand.

           @param name Name of device - equivalent to brand.
        */
        DeviceInfo.prototype.setName = function (name) {
            this.name = name;
        };
        /**
           Returns the platform dependent UUID of the device.

           @return String with the 128-bit device identifier.
           @since ARP1.0
        */
        DeviceInfo.prototype.getUuid = function () {
            return this.uuid;
        };
        /**
           Sets Device identifier - this may not be unique for a device. It may depend on the platform implementation and may
be unique for a specific instance of an application on a specific device.

           @param uuid Device identifier - this may not be unique for a device. It may depend on the platform implementation and may
be unique for a specific instance of an application on a specific device.
        */
        DeviceInfo.prototype.setUuid = function (uuid) {
            this.uuid = uuid;
        };
        /**
           Returns the vendor of the device.

           @return String with the vendor name.
           @since ARP1.0
        */
        DeviceInfo.prototype.getVendor = function () {
            return this.vendor;
        };
        /**
           Sets Vendor of the device hardware.

           @param vendor Vendor of the device hardware.
        */
        DeviceInfo.prototype.setVendor = function (vendor) {
            this.vendor = vendor;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        DeviceInfo.toObject = function (object) {
            var result = new DeviceInfo(null, null, null, null);
            // Assign values to bean fields.
            result.name = object.name;
            result.model = object.model;
            result.vendor = object.vendor;
            result.uuid = object.uuid;
            return result;
        };
        return DeviceInfo;
    })(APIBean);
    Adaptive.DeviceInfo = DeviceInfo;
    /**
       Structure representing the data elements of an email.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    var Email = (function (_super) {
        __extends(Email, _super);
        /**
           Constructor used by the implementation

           @param toRecipients        array of recipients
           @param ccRecipients        array of cc recipients
           @param bccRecipients       array of bcc recipients
           @param emailAttachmentData array of attatchments
           @param messageBody         body of the email
           @param messageBodyMimeType mime type of the body
           @param subject             of the email
           @since ARP1.0
        */
        function Email(toRecipients, ccRecipients, bccRecipients, emailAttachmentData, messageBody, messageBodyMimeType, subject) {
            _super.call(this);
            this.toRecipients = toRecipients;
            this.ccRecipients = ccRecipients;
            this.bccRecipients = bccRecipients;
            this.emailAttachmentData = emailAttachmentData;
            this.messageBody = messageBody;
            this.messageBodyMimeType = messageBodyMimeType;
            this.subject = subject;
        }
        /**
           Returns the array of recipients

           @return bccRecipients array of bcc recipients
           @since ARP1.0
        */
        Email.prototype.getBccRecipients = function () {
            return this.bccRecipients;
        };
        /**
           Set the array of recipients

           @param bccRecipients array of bcc recipients
           @since ARP1.0
        */
        Email.prototype.setBccRecipients = function (bccRecipients) {
            this.bccRecipients = bccRecipients;
        };
        /**
           Returns the array of recipients

           @return ccRecipients array of cc recipients
           @since ARP1.0
        */
        Email.prototype.getCcRecipients = function () {
            return this.ccRecipients;
        };
        /**
           Set the array of recipients

           @param ccRecipients array of cc recipients
           @since ARP1.0
        */
        Email.prototype.setCcRecipients = function (ccRecipients) {
            this.ccRecipients = ccRecipients;
        };
        /**
           Returns an array of attachments

           @return emailAttachmentData array with the email attachments
           @since ARP1.0
        */
        Email.prototype.getEmailAttachmentData = function () {
            return this.emailAttachmentData;
        };
        /**
           Set the email attachment data array

           @param emailAttachmentData array of email attatchments
           @since ARP1.0
        */
        Email.prototype.setEmailAttachmentData = function (emailAttachmentData) {
            this.emailAttachmentData = emailAttachmentData;
        };
        /**
           Returns the message body of the email

           @return message Body string of the email
           @since ARP1.0
        */
        Email.prototype.getMessageBody = function () {
            return this.messageBody;
        };
        /**
           Set the message body of the email

           @param messageBody message body of the email
           @since ARP1.0
        */
        Email.prototype.setMessageBody = function (messageBody) {
            this.messageBody = messageBody;
        };
        /**
           Returns the myme type of the message body

           @return mime type string of the message boddy
           @since ARP1.0
        */
        Email.prototype.getMessageBodyMimeType = function () {
            return this.messageBodyMimeType;
        };
        /**
           Set the mime type for the message body

           @param messageBodyMimeType type of the body message
           @since ARP1.0
        */
        Email.prototype.setMessageBodyMimeType = function (messageBodyMimeType) {
            this.messageBodyMimeType = messageBodyMimeType;
        };
        /**
           Returns the subject of the email

           @return subject string of the email
           @since ARP1.0
        */
        Email.prototype.getSubject = function () {
            return this.subject;
        };
        /**
           Set the subject of the email

           @param subject of the email
           @since ARP1.0
        */
        Email.prototype.setSubject = function (subject) {
            this.subject = subject;
        };
        /**
           Returns the array of recipients

           @return toRecipients array of recipients
           @since ARP1.0
        */
        Email.prototype.getToRecipients = function () {
            return this.toRecipients;
        };
        /**
           Set the array of recipients

           @param toRecipients array of recipients
           @since ARP1.0
        */
        Email.prototype.setToRecipients = function (toRecipients) {
            this.toRecipients = toRecipients;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        Email.toObject = function (object) {
            var result = new Email(null, null, null, null, null, null, null);
            // Assign values to bean fields.
            result.toRecipients = new Array();
            for (var __value__ in object.toRecipients) {
                result.toRecipients.push(EmailAddress.toObject(__value__));
            }
            result.ccRecipients = new Array();
            for (var __value__ in object.ccRecipients) {
                result.ccRecipients.push(EmailAddress.toObject(__value__));
            }
            result.bccRecipients = new Array();
            for (var __value__ in object.bccRecipients) {
                result.bccRecipients.push(EmailAddress.toObject(__value__));
            }
            result.emailAttachmentData = new Array();
            for (var __value__ in object.emailAttachmentData) {
                result.emailAttachmentData.push(EmailAttachmentData.toObject(__value__));
            }
            result.messageBody = object.messageBody;
            result.messageBodyMimeType = object.messageBodyMimeType;
            result.subject = object.subject;
            return result;
        };
        return Email;
    })(APIBean);
    Adaptive.Email = Email;
    /**
       Structure representing the data elements of an email addressee.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    var EmailAddress = (function (_super) {
        __extends(EmailAddress, _super);
        /**
           Constructor used by implementation

           @param address of the Email
           @since ARP1.0
        */
        function EmailAddress(address) {
            _super.call(this);
            this.address = address;
        }
        /**
           Returns the email address

           @return address of the Email
           @since ARP1.0
        */
        EmailAddress.prototype.getAddress = function () {
            return this.address;
        };
        /**
           Set the Email address

           @param address of the Email
           @since ARP1.0
        */
        EmailAddress.prototype.setAddress = function (address) {
            this.address = address;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        EmailAddress.toObject = function (object) {
            var result = new EmailAddress(null);
            // Assign values to bean fields.
            result.address = object.address;
            return result;
        };
        return EmailAddress;
    })(APIBean);
    Adaptive.EmailAddress = EmailAddress;
    /**
       Structure representing the binary attachment data.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    var EmailAttachmentData = (function (_super) {
        __extends(EmailAttachmentData, _super);
        /**
           Constructor with fields

           @param data         raw data of the file attachment
           @param size         size of the file attachment
           @param fileName     name of the file attachment
           @param mimeType     mime type of the file attachment
           @param referenceUrl relative url of the file attachment
           @since ARP1.0
        */
        function EmailAttachmentData(data, size, fileName, mimeType, referenceUrl) {
            _super.call(this);
            this.data = data;
            this.size = size;
            this.fileName = fileName;
            this.mimeType = mimeType;
            this.referenceUrl = referenceUrl;
        }
        /**
           Returns the raw data in byte[]

           @return data Octet-binary content of the attachment payload.
           @since ARP1.0
        */
        EmailAttachmentData.prototype.getData = function () {
            return this.data;
        };
        /**
           Set the data of the attachment as a byte[]

           @param data Sets the octet-binary content of the attachment.
           @since ARP1.0
        */
        EmailAttachmentData.prototype.setData = function (data) {
            this.data = data;
        };
        /**
           Returns the filename of the attachment

           @return fileName Name of the attachment.
           @since ARP1.0
        */
        EmailAttachmentData.prototype.getFileName = function () {
            return this.fileName;
        };
        /**
           Set the name of the file attachment

           @param fileName Name of the attachment.
           @since ARP1.0
        */
        EmailAttachmentData.prototype.setFileName = function (fileName) {
            this.fileName = fileName;
        };
        /**
           Returns the mime type of the attachment

           @return mimeType
           @since ARP1.0
        */
        EmailAttachmentData.prototype.getMimeType = function () {
            return this.mimeType;
        };
        /**
           Set the mime type of the attachment

           @param mimeType Mime-type of the attachment.
           @since ARP1.0
        */
        EmailAttachmentData.prototype.setMimeType = function (mimeType) {
            this.mimeType = mimeType;
        };
        /**
           Returns the absolute url of the file attachment

           @return referenceUrl Absolute URL of the file attachment for either file:// or http:// access.
           @since ARP1.0
        */
        EmailAttachmentData.prototype.getReferenceUrl = function () {
            return this.referenceUrl;
        };
        /**
           Set the absolute url of the attachment

           @param referenceUrl Absolute URL of the file attachment for either file:// or http:// access.
           @since ARP1.0
        */
        EmailAttachmentData.prototype.setReferenceUrl = function (referenceUrl) {
            this.referenceUrl = referenceUrl;
        };
        /**
           Returns the size of the attachment as a long

           @return size Length in bytes of the octet-binary content.
           @since ARP1.0
        */
        EmailAttachmentData.prototype.getSize = function () {
            return this.size;
        };
        /**
           Set the size of the attachment as a long

           @param size Length in bytes of the octet-binary content ( should be same as data array length.)
           @since ARP1.0
        */
        EmailAttachmentData.prototype.setSize = function (size) {
            this.size = size;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        EmailAttachmentData.toObject = function (object) {
            var result = new EmailAttachmentData(null, null, null, null, null);
            // Assign values to bean fields.
            result.data = new Array();
            for (var __value__ in object.data) {
                result.data.push(__value__);
            }
            result.size = object.size;
            result.fileName = object.fileName;
            result.mimeType = object.mimeType;
            result.referenceUrl = object.referenceUrl;
            return result;
        };
        return EmailAttachmentData;
    })(APIBean);
    Adaptive.EmailAttachmentData = EmailAttachmentData;
    /**
       Implementation of FileDescriptor bean.

       @author Carlos Lozano Diez
       @since 1.0
       @version 1.0
    */
    var FileDescriptor = (function (_super) {
        __extends(FileDescriptor, _super);
        /**
           Default constructor.
        */
        function FileDescriptor() {
            _super.call(this);
        }
        /**
           Returns the milliseconds passed since 1/1/1970 since the file was created.

           @return Timestamp in milliseconds.
           @since ARP1.0
        */
        FileDescriptor.prototype.getDateCreated = function () {
            return this.dateCreated;
        };
        /**
           Sets the creation timestamp in milliseconds. Used internally.

           @param dateCreated Timestamp of file creation or -1 if the file or folder doesn't exist.
        */
        FileDescriptor.prototype.setDateCreated = function (dateCreated) {
            this.dateCreated = dateCreated;
        };
        /**
           Returns the milliseconds passed since 1/1/1970 since the file was modified.

           @return Timestamp in milliseconds.
           @since ARP1.0
        */
        FileDescriptor.prototype.getDateModified = function () {
            return this.dateModified;
        };
        /**
           Sets the file or folder modification timestamp in milliseconds. Used internally.

           @param dateModified Timestamp of file modification or -1 if the file or folder doesn't exist.
        */
        FileDescriptor.prototype.setDateModified = function (dateModified) {
            this.dateModified = dateModified;
        };
        /**
           Returns the name of the file if the reference is a file or the last path element of the folder.

           @return The name of the file.
           @since ARP1.0
        */
        FileDescriptor.prototype.getName = function () {
            return this.name;
        };
        /**
           Sets the name of the file. Used internally.

           @param name Name of the file or last folder path element.
        */
        FileDescriptor.prototype.setName = function (name) {
            this.name = name;
        };
        /**
           Returns the path element of the file or folder (excluding the last path element if it's a directory).

           @return The path to the file.
           @since ARP1.0
        */
        FileDescriptor.prototype.getPath = function () {
            return this.path;
        };
        /**
           Sets the path of the file or folder. Used internally.

           @param path The path element of the file or folder.
        */
        FileDescriptor.prototype.setPath = function (path) {
            this.path = path;
        };
        /**
           Returns the resolved absolute path elements of the file and/or folders (including the last path element).

           @return The absolute path to the file.
           @since ARP1.0
        */
        FileDescriptor.prototype.getPathAbsolute = function () {
            return this.pathAbsolute;
        };
        /**
           Sets the absolute path of the file or folder. Used internally.

           @param pathAbsolute String with the absolute path of file or folder.
        */
        FileDescriptor.prototype.setPathAbsolute = function (pathAbsolute) {
            this.pathAbsolute = pathAbsolute;
        };
        /**
           Returns the size in bytes of the file or -1 if the reference is a folder.

           @return Size in bytes of file.
           @since ARP1.0
        */
        FileDescriptor.prototype.getSize = function () {
            return this.size;
        };
        /**
           Sets the file size in bytes of the file. If the file is a folder, this will be 0. If the file
doesn't exist, this will be -1. Used internally.

           @param size The size in bytes of the file.
        */
        FileDescriptor.prototype.setSize = function (size) {
            this.size = size;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        FileDescriptor.toObject = function (object) {
            var result = new FileDescriptor();
            // Assign values to bean fields.
            result.name = object.name;
            result.path = object.path;
            result.pathAbsolute = object.pathAbsolute;
            result.dateCreated = object.dateCreated;
            result.dateModified = object.dateModified;
            result.size = object.size;
            return result;
        };
        return FileDescriptor;
    })(APIBean);
    Adaptive.FileDescriptor = FileDescriptor;
    /**
       Structure representing the data a single geolocation reading.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    var Geolocation = (function (_super) {
        __extends(Geolocation, _super);
        /**
           Constructor with parameters

           @param latitude  Latitude of the measurement
           @param longitude Longitude of the measurement
           @param altitude  Altitude of the measurement
           @param xDoP      Dilution of precision on the X measurement
           @param yDoP      Dilution of precision on the Y measurement
           @param timestamp Timestamp of the measurement
           @since ARP1.0
        */
        function Geolocation(latitude, longitude, altitude, xDoP, yDoP, timestamp) {
            _super.call(this);
            this.latitude = latitude;
            this.longitude = longitude;
            this.altitude = altitude;
            this.xDoP = xDoP;
            this.yDoP = yDoP;
            this.timestamp = timestamp;
        }
        /**
           Returns altitude in meters

           @return Altitude of the measurement
           @since ARP1.0
        */
        Geolocation.prototype.getAltitude = function () {
            return this.altitude;
        };
        /**
           Set altitude in meters

           @param altitude Altitude of the measurement
           @since ARP1.0
        */
        Geolocation.prototype.setAltitude = function (altitude) {
            this.altitude = altitude;
        };
        /**
           Returns the latitude in degrees

           @return Latitude of the measurement
           @since ARP1.0
        */
        Geolocation.prototype.getLatitude = function () {
            return this.latitude;
        };
        /**
           Set the latitude in degrees

           @param latitude Latitude of the measurement
           @since ARP1.0
        */
        Geolocation.prototype.setLatitude = function (latitude) {
            this.latitude = latitude;
        };
        /**
           Returns the longitude in degrees

           @return Longitude of the measurement
           @since ARP1.0
        */
        Geolocation.prototype.getLongitude = function () {
            return this.longitude;
        };
        /**
           Returns the latitude in degrees

           @param longitude Longitude of the measurement
           @since ARP1.0
        */
        Geolocation.prototype.setLongitude = function (longitude) {
            this.longitude = longitude;
        };
        /**
           Timestamp Getter

           @return Timestamp
           @since ARP1.0
        */
        Geolocation.prototype.getTimestamp = function () {
            return this.timestamp;
        };
        /**
           Timestamp Setter

           @param timestamp Timestamp
           @since ARP1.0
        */
        Geolocation.prototype.setTimestamp = function (timestamp) {
            this.timestamp = timestamp;
        };
        /**
           Gets Dilution of precision on the X measurement. Measured in meters.

           @return xDoP Dilution of precision on the X measurement. Measured in meters.
        */
        Geolocation.prototype.getXDoP = function () {
            return this.xDoP;
        };
        /**
           Sets Dilution of precision on the X measurement. Measured in meters.

           @param xDoP Dilution of precision on the X measurement. Measured in meters.
        */
        Geolocation.prototype.setXDoP = function (xDoP) {
            this.xDoP = xDoP;
        };
        /**
           Gets Dilution of precision on the Y measurement. Measured in meters.

           @return yDoP Dilution of precision on the Y measurement. Measured in meters.
        */
        Geolocation.prototype.getYDoP = function () {
            return this.yDoP;
        };
        /**
           Sets Dilution of precision on the Y measurement. Measured in meters.

           @param yDoP Dilution of precision on the Y measurement. Measured in meters.
        */
        Geolocation.prototype.setYDoP = function (yDoP) {
            this.yDoP = yDoP;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        Geolocation.toObject = function (object) {
            var result = new Geolocation(null, null, null, null, null, null);
            // Assign values to bean fields.
            result.latitude = object.latitude;
            result.longitude = object.longitude;
            result.altitude = object.altitude;
            result.xDoP = object.xDoP;
            result.yDoP = object.yDoP;
            result.timestamp = object.timestamp;
            return result;
        };
        return Geolocation;
    })(APIBean);
    Adaptive.Geolocation = Geolocation;
    /**
       Represents a basic bean to store keyName pair values

       @author Ferran Vila Conesa
       @since ARP1.0
       @version 1.0
    */
    var KeyPair = (function (_super) {
        __extends(KeyPair, _super);
        /**
           Constructor using fields

           @param keyName  Key of the element
           @param keyValue Value of the element
           @since ARP1.0
        */
        function KeyPair(keyName, keyValue) {
            _super.call(this);
            this.keyName = keyName;
            this.keyValue = keyValue;
        }
        /**
           Returns the keyName of the element

           @return Key of the element
           @since ARP1.0
        */
        KeyPair.prototype.getKeyName = function () {
            return this.keyName;
        };
        /**
           Sets the keyName of the element

           @param keyName Key of the element
           @since ARP1.0
        */
        KeyPair.prototype.setKeyName = function (keyName) {
            this.keyName = keyName;
        };
        /**
           Returns the keyValue of the element

           @return Value of the element
           @since ARP1.0
        */
        KeyPair.prototype.getKeyValue = function () {
            return this.keyValue;
        };
        /**
           Sets the keyValue of the element

           @param keyValue Value of the element
           @since ARP1.0
        */
        KeyPair.prototype.setKeyValue = function (keyValue) {
            this.keyValue = keyValue;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        KeyPair.toObject = function (object) {
            var result = new KeyPair(null, null);
            // Assign values to bean fields.
            result.keyName = object.keyName;
            result.keyValue = object.keyValue;
            return result;
        };
        return KeyPair;
    })(APIBean);
    Adaptive.KeyPair = KeyPair;
    /**
       Represents a specific application life-cycle stage.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    var Lifecycle = (function (_super) {
        __extends(Lifecycle, _super);
        /**
           Constructor used by the implementation

           @param state of the app
           @since ARP1.0
        */
        function Lifecycle(state) {
            _super.call(this);
            this.state = state;
        }
        /**
           Returns the state of the application

           @return state of the app
           @since ARP1.0
        */
        Lifecycle.prototype.getState = function () {
            return this.state;
        };
        /**
           Set the State of the application

           @param state of the app
           @since ARP1.0
        */
        Lifecycle.prototype.setState = function (state) {
            this.state = state;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        Lifecycle.toObject = function (object) {
            var result = new Lifecycle(null);
            // Assign values to bean fields.
            result.state = LifecycleState.toObject(object.state);
            return result;
        };
        return Lifecycle;
    })(APIBean);
    Adaptive.Lifecycle = Lifecycle;
    /**
       Represents a specific user or system locate.

       @author Aryslan
       @since ARP1.0
       @version 1.0
    */
    var Locale = (function (_super) {
        __extends(Locale, _super);
        /**
           Constructor used by the implementation

           @param country  Country of the Locale
           @param language Language of the Locale
           @since ARP1.0
        */
        function Locale(language, country) {
            _super.call(this);
            this.language = language;
            this.country = country;
        }
        /**
           Returns the country code

           @return country code
           @since ARP1.0
        */
        Locale.prototype.getCountry = function () {
            return this.country;
        };
        /**
           Set the country code

           @param country code
           @since ARP1.0
        */
        Locale.prototype.setCountry = function (country) {
            this.country = country;
        };
        /**
           Returns the language code

           @return language code
           @since ARP1.0
        */
        Locale.prototype.getLanguage = function () {
            return this.language;
        };
        /**
           Set the language code

           @param language code
           @since ARP1.0
        */
        Locale.prototype.setLanguage = function (language) {
            this.language = language;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        Locale.toObject = function (object) {
            var result = new Locale(null, null);
            // Assign values to bean fields.
            result.country = object.country;
            result.language = object.language;
            return result;
        };
        return Locale;
    })(APIBean);
    Adaptive.Locale = Locale;
    /**
       Represents the basic information about the operating system.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    var OSInfo = (function (_super) {
        __extends(OSInfo, _super);
        /**
           Constructor used by implementation to set the OS information.

           @param name    of the OS.
           @param version of the OS.
           @param vendor  of the OS.
           @since ARP1.0
        */
        function OSInfo(name, version, vendor) {
            _super.call(this);
            this.name = name;
            this.version = version;
            this.vendor = vendor;
        }
        /**
           Returns the name of the operating system.

           @return OS name.
           @since ARP1.0
        */
        OSInfo.prototype.getName = function () {
            return this.name;
        };
        /**
           Sets The name of the operating system.

           @param name The name of the operating system.
        */
        OSInfo.prototype.setName = function (name) {
            this.name = name;
        };
        /**
           Returns the vendor of the operating system.

           @return OS vendor.
           @since ARP1.0
        */
        OSInfo.prototype.getVendor = function () {
            return this.vendor;
        };
        /**
           Sets The vendor of the operating system.

           @param vendor The vendor of the operating system.
        */
        OSInfo.prototype.setVendor = function (vendor) {
            this.vendor = vendor;
        };
        /**
           Returns the version of the operating system.

           @return OS version.
           @since ARP1.0
        */
        OSInfo.prototype.getVersion = function () {
            return this.version;
        };
        /**
           Sets The version/identifier of the operating system.

           @param version The version/identifier of the operating system.
        */
        OSInfo.prototype.setVersion = function (version) {
            this.version = version;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        OSInfo.toObject = function (object) {
            var result = new OSInfo(null, null, null);
            // Assign values to bean fields.
            result.name = IOSType.toObject(object.name);
            result.version = object.version;
            result.vendor = object.vendor;
            return result;
        };
        return OSInfo;
    })(APIBean);
    Adaptive.OSInfo = OSInfo;
    /**
       Represents a single secureKey-value pair.

       @author Aryslan
       @since ARP1.0
       @version 1.0
    */
    var SecureKeyPair = (function (_super) {
        __extends(SecureKeyPair, _super);
        /**
           Constructor with parameters

           @param secureKey  name of the keypair
           @param secureData value of the keypair
           @since ARP1.0
        */
        function SecureKeyPair(secureKey, secureData) {
            _super.call(this);
            this.secureKey = secureKey;
            this.secureData = secureData;
        }
        /**
           Returns the object value

           @return Value.
           @since ARP 1.0
        */
        SecureKeyPair.prototype.getSecureData = function () {
            return this.secureData;
        };
        /**
           Sets the value for this object

           @param secureData value to set.
           @since ARP 1.0
        */
        SecureKeyPair.prototype.setSecureData = function (secureData) {
            this.secureData = secureData;
        };
        /**
           Returns the object secureKey name.

           @return Key name.
           @since ARP 1.0
        */
        SecureKeyPair.prototype.getSecureKey = function () {
            return this.secureKey;
        };
        /**
           Sets the secureKey name for this object.

           @param secureKey Key name.
           @since ARP 1.0
        */
        SecureKeyPair.prototype.setSecureKey = function (secureKey) {
            this.secureKey = secureKey;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        SecureKeyPair.toObject = function (object) {
            var result = new SecureKeyPair(null, null);
            // Assign values to bean fields.
            result.secureKey = object.secureKey;
            result.secureData = object.secureData;
            return result;
        };
        return SecureKeyPair;
    })(APIBean);
    Adaptive.SecureKeyPair = SecureKeyPair;
    /**
       Represents an instance of a service.

       @author Aryslan
       @since ARP1.0
       @version 1.0
    */
    var Service = (function (_super) {
        __extends(Service, _super);
        /**
           Constructor used by the implementation

           @param serviceEndpoint Endpoint of the service
           @param name            Name of the service
           @param method          Method of the service
           @param type            Type of the service
           @since ARP1.0
        */
        function Service(serviceEndpoint, name, method, type) {
            _super.call(this);
            this.serviceEndpoint = serviceEndpoint;
            this.name = name;
            this.method = method;
            this.type = type;
        }
        /**
           Returns the method

           @return method
           @since ARP1.0
        */
        Service.prototype.getMethod = function () {
            return this.method;
        };
        /**
           Set the method

           @param method Method of the service
           @since ARP1.0
        */
        Service.prototype.setMethod = function (method) {
            this.method = method;
        };
        /**
           Returns the type

           @return type
           @since ARP1.0
        */
        Service.prototype.getType = function () {
            return this.type;
        };
        /**
           Set the type

           @param type Type of the service
           @since ARP1.0
        */
        Service.prototype.setType = function (type) {
            this.type = type;
        };
        /**
           Returns the name

           @return name
           @since ARP1.0
        */
        Service.prototype.getName = function () {
            return this.name;
        };
        /**
           Set the name

           @param name Name of the service
           @since ARP1.0
        */
        Service.prototype.setName = function (name) {
            this.name = name;
        };
        /**
           Returns the serviceEndpoint

           @return serviceEndpoint
           @since ARP1.0
        */
        Service.prototype.getServiceEndpoint = function () {
            return this.serviceEndpoint;
        };
        /**
           Set the serviceEndpoint

           @param serviceEndpoint Endpoint of the service
           @since ARP1.0
        */
        Service.prototype.setServiceEndpoint = function (serviceEndpoint) {
            this.serviceEndpoint = serviceEndpoint;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        Service.toObject = function (object) {
            var result = new Service(null, null, null, null);
            // Assign values to bean fields.
            result.serviceEndpoint = ServiceEndpoint.toObject(object.serviceEndpoint);
            result.name = object.name;
            result.method = IServiceMethod.toObject(object.method);
            result.type = IServiceType.toObject(object.type);
            return result;
        };
        return Service;
    })(APIBean);
    Adaptive.Service = Service;
    /**
       Structure representing the cookieValue of a http cookie.

       @author Aryslan
       @since ARP1.0
       @version 1.0
    */
    var ServiceCookie = (function (_super) {
        __extends(ServiceCookie, _super);
        /**
           Contructor with fields

           @param cookieName  Name of the cookie
           @param cookieValue Value of the cookie
           @param domain      Domain of the cookie
           @param path        Path of the cookie
           @param scheme      Scheme of the cookie
           @param secure      Privacy of the cookie
           @param expiry      Expiration date of the cookie
           @param creation    Creation date of the cookie
           @since ARP1.0
        */
        function ServiceCookie(cookieName, cookieValue, domain, path, scheme, secure, expiry, creation) {
            _super.call(this);
            this.cookieName = cookieName;
            this.cookieValue = cookieValue;
            this.domain = domain;
            this.path = path;
            this.scheme = scheme;
            this.secure = secure;
            this.expiry = expiry;
            this.creation = creation;
        }
        /**
           Returns the cookie cookieName

           @return cookieName Name of the cookie
           @since ARP1.0
        */
        ServiceCookie.prototype.getCookieName = function () {
            return this.cookieName;
        };
        /**
           Set the cookie cookieName

           @param cookieName Name of the cookie
           @since ARP1.0
        */
        ServiceCookie.prototype.setCookieName = function (cookieName) {
            this.cookieName = cookieName;
        };
        /**
           Returns the cookie cookieValue

           @return Value of the cookie
           @since ARP1.0
        */
        ServiceCookie.prototype.getCookieValue = function () {
            return this.cookieValue;
        };
        /**
           Set the cookie cookieValue

           @param cookieValue Value of the cookie
           @since ARP1.0
        */
        ServiceCookie.prototype.setCookieValue = function (cookieValue) {
            this.cookieValue = cookieValue;
        };
        /**
           Returns the creation date

           @return Creation date of the cookie
           @since ARP1.0
        */
        ServiceCookie.prototype.getCreation = function () {
            return this.creation;
        };
        /**
           Sets the creation date

           @param creation Creation date of the cookie
           @since ARP1.0
        */
        ServiceCookie.prototype.setCreation = function (creation) {
            this.creation = creation;
        };
        /**
           Returns the domain

           @return domain
           @since ARP1.0
        */
        ServiceCookie.prototype.getDomain = function () {
            return this.domain;
        };
        /**
           Set the domain

           @param domain Domain of the cookie
           @since ARP1.0
        */
        ServiceCookie.prototype.setDomain = function (domain) {
            this.domain = domain;
        };
        /**
           Returns the expiration date in milis

           @return expiry
           @since ARP1.0
        */
        ServiceCookie.prototype.getExpiry = function () {
            return this.expiry;
        };
        /**
           Set the expiration date in milis

           @param expiry Expiration date of the cookie
           @since ARP1.0
        */
        ServiceCookie.prototype.setExpiry = function (expiry) {
            this.expiry = expiry;
        };
        /**
           Returns the path

           @return path
           @since ARP1.0
        */
        ServiceCookie.prototype.getPath = function () {
            return this.path;
        };
        /**
           Set the path

           @param path Path of the cookie
           @since ARP1.0
        */
        ServiceCookie.prototype.setPath = function (path) {
            this.path = path;
        };
        /**
           Returns the scheme

           @return scheme
           @since ARP1.0
        */
        ServiceCookie.prototype.getScheme = function () {
            return this.scheme;
        };
        /**
           Set the scheme

           @param scheme Scheme of the cookie
           @since ARP1.0
        */
        ServiceCookie.prototype.setScheme = function (scheme) {
            this.scheme = scheme;
        };
        /**
           Returns whether the cookie is secure or not

           @return true if the cookie is secure; false otherwise
           @since ARP1.0
        */
        ServiceCookie.prototype.getSecure = function () {
            return this.secure;
        };
        /**
           Set whether the cookie is secure or not

           @param secure Privacy of the cookie
           @since ARP1.0
        */
        ServiceCookie.prototype.setSecure = function (secure) {
            this.secure = secure;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        ServiceCookie.toObject = function (object) {
            var result = new ServiceCookie(null, null, null, null, null, null, null, null);
            // Assign values to bean fields.
            result.cookieName = object.cookieName;
            result.cookieValue = object.cookieValue;
            result.domain = object.domain;
            result.path = object.path;
            result.scheme = object.scheme;
            result.secure = object.secure;
            result.expiry = object.expiry;
            result.creation = object.creation;
            return result;
        };
        return ServiceCookie;
    })(APIBean);
    Adaptive.ServiceCookie = ServiceCookie;
    /**
       Structure representing a remote or local service access end-point.

       @author Aryslan
       @since ARP1.0
       @version 1.0
    */
    var ServiceEndpoint = (function (_super) {
        __extends(ServiceEndpoint, _super);
        /**
           Constructor with parameters

           @param host   Remote service host
           @param path   Remote service Path
           @param port   Remote service Port
           @param proxy  Proxy url "http://IP_ADDRESS:PORT_NUMBER"
           @param scheme Remote service scheme
           @since ARP1.0
        */
        function ServiceEndpoint(host, path, port, proxy, scheme) {
            _super.call(this);
            this.host = host;
            this.path = path;
            this.port = port;
            this.proxy = proxy;
            this.scheme = scheme;
        }
        /**
           Returns the Remote service host

           @return Remote service host
           @since ARP1.0
        */
        ServiceEndpoint.prototype.getHost = function () {
            return this.host;
        };
        /**
           Set the Remote service host

           @param host Remote service host
           @since ARP1.0
        */
        ServiceEndpoint.prototype.setHost = function (host) {
            this.host = host;
        };
        /**
           Returns the Remote service Path

           @return Remote service Path
           @since ARP1.0
        */
        ServiceEndpoint.prototype.getPath = function () {
            return this.path;
        };
        /**
           Set the Remote service Path

           @param path Remote service Path
           @since ARP1.0
        */
        ServiceEndpoint.prototype.setPath = function (path) {
            this.path = path;
        };
        /**
           Returns the Remote service Port

           @return Remote service Port
           @since ARP1.0
        */
        ServiceEndpoint.prototype.getPort = function () {
            return this.port;
        };
        /**
           Set the Remote service Port

           @param port Remote service Port
           @since ARP1.0
        */
        ServiceEndpoint.prototype.setPort = function (port) {
            this.port = port;
        };
        /**
           Return the Proxy url

           @return Proxy url
           @since ARP1.0
        */
        ServiceEndpoint.prototype.getProxy = function () {
            return this.proxy;
        };
        /**
           Set the Proxy url

           @param proxy Proxy url
           @since ARP1.0
        */
        ServiceEndpoint.prototype.setProxy = function (proxy) {
            this.proxy = proxy;
        };
        /**
           Returns the Remote service scheme

           @return Remote service scheme
           @since ARP1.0
        */
        ServiceEndpoint.prototype.getScheme = function () {
            return this.scheme;
        };
        /**
           Set the Remote service scheme

           @param scheme Remote service scheme
           @since ARP1.0
        */
        ServiceEndpoint.prototype.setScheme = function (scheme) {
            this.scheme = scheme;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        ServiceEndpoint.toObject = function (object) {
            var result = new ServiceEndpoint(null, null, null, null, null);
            // Assign values to bean fields.
            result.host = object.host;
            result.path = object.path;
            result.port = object.port;
            result.proxy = object.proxy;
            result.scheme = object.scheme;
            return result;
        };
        return ServiceEndpoint;
    })(APIBean);
    Adaptive.ServiceEndpoint = ServiceEndpoint;
    /**
       Structure representing the data of a http request or response header.

       @author Aryslan
       @since ARP1.0
       @version 1.0
    */
    var ServiceHeader = (function (_super) {
        __extends(ServiceHeader, _super);
        /**
           Constructor with fields

           @param name Name of the header
           @param data Value of the header
           @since ARP1.0
        */
        function ServiceHeader(name, data) {
            _super.call(this);
            this.name = name;
            this.data = data;
        }
        /**
           Returns the header value

           @return ServiceHeader value
           @since ARP1.0
        */
        ServiceHeader.prototype.getData = function () {
            return this.data;
        };
        /**
           Set the header value

           @param data ServiceHeader value
           @since ARP1.0
        */
        ServiceHeader.prototype.setData = function (data) {
            this.data = data;
        };
        /**
           Returns the header name

           @return ServiceHeader name
           @since ARP1.0
        */
        ServiceHeader.prototype.getName = function () {
            return this.name;
        };
        /**
           Set the header name

           @param name Name of the header
           @since ARP1.0
        */
        ServiceHeader.prototype.setName = function (name) {
            this.name = name;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        ServiceHeader.toObject = function (object) {
            var result = new ServiceHeader(null, null);
            // Assign values to bean fields.
            result.name = object.name;
            result.data = object.data;
            return result;
        };
        return ServiceHeader;
    })(APIBean);
    Adaptive.ServiceHeader = ServiceHeader;
    /**
       Represents a local or remote service request.

       @author Aryslan
       @since ARP1.0
       @version 1.0
    */
    var ServiceRequest = (function (_super) {
        __extends(ServiceRequest, _super);
        /**
           Contructor used by the implementation

           @param content             Request/Response data content (plain text)
           @param contentType         The request/response content type (MIME TYPE).
           @param contentEncoding     Encoding of the binary payload - by default assumed to be UTF8.
           @param contentLength       The length in bytes for the Content field.
           @param contentBinary       The byte[] representing the Content field.
           @param contentBinaryLength The length in bytes for the binary Content.
           @param serviceHeaders      The serviceHeaders array (name,value pairs) to be included on the I/O service request.
           @param method              The request method
           @param protocolVersion     The HTTP procotol version to be used for this request.
           @param serviceSession      The element service session
           @since ARP1.0
        */
        function ServiceRequest(content, contentType, contentEncoding, contentLength, contentBinary, contentBinaryLength, serviceHeaders, method, protocolVersion, serviceSession) {
            _super.call(this);
            this.content = content;
            this.contentType = contentType;
            this.contentEncoding = contentEncoding;
            this.contentLength = contentLength;
            this.contentBinary = contentBinary;
            this.contentBinaryLength = contentBinaryLength;
            this.serviceHeaders = serviceHeaders;
            this.method = method;
            this.protocolVersion = protocolVersion;
            this.serviceSession = serviceSession;
        }
        /**
           Returns the protocol version

           @return protocolVersion enum
           @since ARP1.0
        */
        ServiceRequest.prototype.getProtocolVersion = function () {
            return this.protocolVersion;
        };
        /**
           Set the protocol version

           @param protocolVersion The HTTP procotol version to be used for this request.
           @since ARP1.0
        */
        ServiceRequest.prototype.setProtocolVersion = function (protocolVersion) {
            this.protocolVersion = protocolVersion;
        };
        /**
           Returns the content

           @return content
           @since ARP1.0
        */
        ServiceRequest.prototype.getContent = function () {
            return this.content;
        };
        /**
           Set the content

           @param content Request/Response data content (plain text)
           @since ARP1.0
        */
        ServiceRequest.prototype.setContent = function (content) {
            this.content = content;
        };
        /**
           Returns the byte[] of the content

           @return contentBinary
           @since ARP1.0
        */
        ServiceRequest.prototype.getContentBinary = function () {
            return this.contentBinary;
        };
        /**
           Set the byte[] of the content

           @param contentBinary The byte[] representing the Content field.
           @since ARP1.0
        */
        ServiceRequest.prototype.setContentBinary = function (contentBinary) {
            this.contentBinary = contentBinary;
        };
        /**
           Retrusn the binary content length

           @return contentBinaryLength
           @since ARP1.0
        */
        ServiceRequest.prototype.getContentBinaryLength = function () {
            return this.contentBinaryLength;
        };
        /**
           Set the binary content length

           @param contentBinaryLength The length in bytes for the binary Content.
           @since ARP1.0
        */
        ServiceRequest.prototype.setContentBinaryLength = function (contentBinaryLength) {
            this.contentBinaryLength = contentBinaryLength;
        };
        /**
           Returns the content encoding

           @return contentEncoding
           @since ARP1.0
        */
        ServiceRequest.prototype.getContentEncoding = function () {
            return this.contentEncoding;
        };
        /**
           Set the content encoding

           @param contentEncoding Encoding of the binary payload - by default assumed to be UTF8.
           @since ARP1.0
        */
        ServiceRequest.prototype.setContentEncoding = function (contentEncoding) {
            this.contentEncoding = contentEncoding;
        };
        /**
           Returns the content length

           @return contentLength
           @since ARP1.0
        */
        ServiceRequest.prototype.getContentLength = function () {
            return this.contentLength;
        };
        /**
           Set the content length

           @param contentLength The length in bytes for the Content field.
           @since ARP1.0
        */
        ServiceRequest.prototype.setContentLength = function (contentLength) {
            this.contentLength = contentLength;
        };
        /**
           Returns the content type

           @return contentType
           @since ARP1.0
        */
        ServiceRequest.prototype.getContentType = function () {
            return this.contentType;
        };
        /**
           Set the content type

           @param contentType The request/response content type (MIME TYPE).
           @since ARP1.0
        */
        ServiceRequest.prototype.setContentType = function (contentType) {
            this.contentType = contentType;
        };
        /**
           Returns the method

           @return method
           @since ARP1.0
        */
        ServiceRequest.prototype.getMethod = function () {
            return this.method;
        };
        /**
           Set the method

           @param method The request method
           @since ARP1.0
        */
        ServiceRequest.prototype.setMethod = function (method) {
            this.method = method;
        };
        /**
           Returns the array of ServiceHeader

           @return serviceHeaders
           @since ARP1.0
        */
        ServiceRequest.prototype.getServiceHeaders = function () {
            return this.serviceHeaders;
        };
        /**
           Set the array of ServiceHeader

           @param serviceHeaders The serviceHeaders array (name,value pairs) to be included on the I/O service request.
           @since ARP1.0
        */
        ServiceRequest.prototype.setServiceHeaders = function (serviceHeaders) {
            this.serviceHeaders = serviceHeaders;
        };
        /**
           Getter for service session

           @return The element service session
           @since ARP1.0
        */
        ServiceRequest.prototype.getServiceSession = function () {
            return this.serviceSession;
        };
        /**
           Setter for service session

           @param serviceSession The element service session
           @since ARP1.0
        */
        ServiceRequest.prototype.setServiceSession = function (serviceSession) {
            this.serviceSession = serviceSession;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        ServiceRequest.toObject = function (object) {
            var result = new ServiceRequest(null, null, null, null, null, null, null, null, null, null);
            // Assign values to bean fields.
            result.content = object.content;
            result.contentType = object.contentType;
            result.contentEncoding = object.contentEncoding;
            result.contentLength = object.contentLength;
            result.contentBinary = new Array();
            for (var __value__ in object.contentBinary) {
                result.contentBinary.push(__value__);
            }
            result.contentBinaryLength = object.contentBinaryLength;
            result.serviceHeaders = new Array();
            for (var __value__ in object.serviceHeaders) {
                result.serviceHeaders.push(ServiceHeader.toObject(__value__));
            }
            result.method = object.method;
            result.protocolVersion = IServiceProtocolVersion.toObject(object.protocolVersion);
            result.serviceSession = ServiceSession.toObject(object.serviceSession);
            return result;
        };
        return ServiceRequest;
    })(APIBean);
    Adaptive.ServiceRequest = ServiceRequest;
    /**
       Represents a local or remote service response.

       @author Aryslan
       @since ARP1.0
       @version 1.0
    */
    var ServiceResponse = (function (_super) {
        __extends(ServiceResponse, _super);
        /**
           Constructor with fields

           @param content             Request/Response data content (plain text).
           @param contentType         The request/response content type (MIME TYPE).
           @param contentEncoding     Encoding of the binary payload - by default assumed to be UTF8.
           @param contentLength       The length in bytes for the Content field.
           @param contentBinary       The byte[] representing the binary Content.
           @param contentBinaryLength The length in bytes for the binary Content.
           @param serviceHeaders      The serviceHeaders array (name,value pairs) to be included on the I/O service request.
           @param serviceSession      Information about the session
           @since ARP1.0
        */
        function ServiceResponse(content, contentType, contentEncoding, contentLength, contentBinary, contentBinaryLength, serviceHeaders, serviceSession) {
            _super.call(this);
            this.content = content;
            this.contentType = contentType;
            this.contentEncoding = contentEncoding;
            this.contentLength = contentLength;
            this.contentBinary = contentBinary;
            this.contentBinaryLength = contentBinaryLength;
            this.serviceHeaders = serviceHeaders;
            this.serviceSession = serviceSession;
        }
        /**
           Returns the content

           @return content
           @since ARP1.0
        */
        ServiceResponse.prototype.getContent = function () {
            return this.content;
        };
        /**
           Set the content

           @param content Request/Response data content (plain text).
           @since ARP1.0
        */
        ServiceResponse.prototype.setContent = function (content) {
            this.content = content;
        };
        /**
           Returns the binary content

           @return contentBinary
           @since ARP1.0
        */
        ServiceResponse.prototype.getContentBinary = function () {
            return this.contentBinary;
        };
        /**
           Set the binary content

           @param contentBinary The byte[] representing the binary Content.
           @since ARP1.0
        */
        ServiceResponse.prototype.setContentBinary = function (contentBinary) {
            this.contentBinary = contentBinary;
        };
        /**
           Returns the binary content length

           @return contentBinaryLength
           @since ARP1.0
        */
        ServiceResponse.prototype.getContentBinaryLength = function () {
            return this.contentBinaryLength;
        };
        /**
           Set the binary content length

           @param contentBinaryLength The length in bytes for the binary Content.
           @since ARP1.0
        */
        ServiceResponse.prototype.setContentBinaryLength = function (contentBinaryLength) {
            this.contentBinaryLength = contentBinaryLength;
        };
        /**
           Returns the content encoding

           @return contentEncoding
           @since ARP1.0
        */
        ServiceResponse.prototype.getContentEncoding = function () {
            return this.contentEncoding;
        };
        /**
           Set the content encoding

           @param contentEncoding Encoding of the binary payload - by default assumed to be UTF8.
           @since ARP1.0
        */
        ServiceResponse.prototype.setContentEncoding = function (contentEncoding) {
            this.contentEncoding = contentEncoding;
        };
        /**
           Returns the content length

           @return contentLength
           @since ARP1.0
        */
        ServiceResponse.prototype.getContentLength = function () {
            return this.contentLength;
        };
        /**
           Set the content length

           @param contentLength The length in bytes for the Content field.
           @since ARP1.0
        */
        ServiceResponse.prototype.setContentLength = function (contentLength) {
            this.contentLength = contentLength;
        };
        /**
           Returns the content type

           @return contentType
           @since ARP1.0
        */
        ServiceResponse.prototype.getContentType = function () {
            return this.contentType;
        };
        /**
           Set the content type

           @param contentType The request/response content type (MIME TYPE).
           @since ARP1.0
        */
        ServiceResponse.prototype.setContentType = function (contentType) {
            this.contentType = contentType;
        };
        /**
           Returns the array of ServiceHeader

           @return serviceHeaders
           @since ARP1.0
        */
        ServiceResponse.prototype.getServiceHeaders = function () {
            return this.serviceHeaders;
        };
        /**
           Set the array of ServiceHeader

           @param serviceHeaders The serviceHeaders array (name,value pairs) to be included on the I/O service request.
           @since ARP1.0
        */
        ServiceResponse.prototype.setServiceHeaders = function (serviceHeaders) {
            this.serviceHeaders = serviceHeaders;
        };
        /**
           Getter for service session

           @return The element service session
           @since ARP1.0
        */
        ServiceResponse.prototype.getServiceSession = function () {
            return this.serviceSession;
        };
        /**
           Setter for service session

           @param serviceSession The element service session
           @since ARP1.0
        */
        ServiceResponse.prototype.setServiceSession = function (serviceSession) {
            this.serviceSession = serviceSession;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        ServiceResponse.toObject = function (object) {
            var result = new ServiceResponse(null, null, null, null, null, null, null, null);
            // Assign values to bean fields.
            result.content = object.content;
            result.contentType = object.contentType;
            result.contentEncoding = object.contentEncoding;
            result.contentLength = object.contentLength;
            result.contentBinary = new Array();
            for (var __value__ in object.contentBinary) {
                result.contentBinary.push(__value__);
            }
            result.contentBinaryLength = object.contentBinaryLength;
            result.serviceHeaders = new Array();
            for (var __value__ in object.serviceHeaders) {
                result.serviceHeaders.push(ServiceHeader.toObject(__value__));
            }
            result.serviceSession = ServiceSession.toObject(object.serviceSession);
            return result;
        };
        return ServiceResponse;
    })(APIBean);
    Adaptive.ServiceResponse = ServiceResponse;
    /**
       Represents a session object for HTTP request and responses

       @author Ferran Vila Conesa
       @since ARP1.0
       @version 1.0
    */
    var ServiceSession = (function (_super) {
        __extends(ServiceSession, _super);
        /**
           Constructor with fields

           @param cookies    The cookies of the response
           @param attributes Attributes of the response
           @since ARP1.0
        */
        function ServiceSession(cookies, attributes) {
            _super.call(this);
            this.cookies = cookies;
            this.attributes = attributes;
        }
        /**
           Gets the attributes of the response

           @return Attributes of the response
           @since ARP1.0
        */
        ServiceSession.prototype.getAttributes = function () {
            return this.attributes;
        };
        /**
           Sets the attributes for the response

           @param attributes Attributes of the response
           @since ARP1.0
        */
        ServiceSession.prototype.setAttributes = function (attributes) {
            this.attributes = attributes;
        };
        /**
           Returns the cookies of the response

           @return The cookies of the response
           @since ARP1.0
        */
        ServiceSession.prototype.getCookies = function () {
            return this.cookies;
        };
        /**
           Sets the cookies of the response

           @param cookies The cookies of the response
           @since ARP1.0
        */
        ServiceSession.prototype.setCookies = function (cookies) {
            this.cookies = cookies;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        ServiceSession.toObject = function (object) {
            var result = new ServiceSession(null, null);
            // Assign values to bean fields.
            result.cookies = new Array();
            for (var __value__ in object.cookies) {
                result.cookies.push(ServiceCookie.toObject(__value__));
            }
            result.attributes = new Array();
            for (var __value__ in object.attributes) {
                result.attributes.push(__value__);
            }
            return result;
        };
        return ServiceSession;
    })(APIBean);
    Adaptive.ServiceSession = ServiceSession;
    /**
       Structure representing the data elements of a contact.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    var Contact = (function (_super) {
        __extends(Contact, _super);
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
        function Contact(contactId, personalInfo, professionalInfo, contactAddresses, contactPhones, contactEmails, contactWebsites, contactSocials, contactTags) {
            _super.call(this, contactId);
            this.personalInfo = personalInfo;
            this.professionalInfo = professionalInfo;
            this.contactAddresses = contactAddresses;
            this.contactPhones = contactPhones;
            this.contactEmails = contactEmails;
            this.contactWebsites = contactWebsites;
            this.contactSocials = contactSocials;
            this.contactTags = contactTags;
        }
        /**
           Returns all the addresses of the Contact

           @return ContactAddress[]
           @since ARP1.0
        */
        Contact.prototype.getContactAddresses = function () {
            return this.contactAddresses;
        };
        /**
           Set the addresses of the Contact

           @param contactAddresses Addresses of the contact
           @since ARP1.0
        */
        Contact.prototype.setContactAddresses = function (contactAddresses) {
            this.contactAddresses = contactAddresses;
        };
        /**
           Returns all the emails of the Contact

           @return ContactEmail[]
           @since ARP1.0
        */
        Contact.prototype.getContactEmails = function () {
            return this.contactEmails;
        };
        /**
           Set the emails of the Contact

           @param contactEmails Emails of the contact
           @since ARP1.0
        */
        Contact.prototype.setContactEmails = function (contactEmails) {
            this.contactEmails = contactEmails;
        };
        /**
           Returns all the phones of the Contact

           @return ContactPhone[]
           @since ARP1.0
        */
        Contact.prototype.getContactPhones = function () {
            return this.contactPhones;
        };
        /**
           Set the phones of the Contact

           @param contactPhones Phones of the contact
           @since ARP1.0
        */
        Contact.prototype.setContactPhones = function (contactPhones) {
            this.contactPhones = contactPhones;
        };
        /**
           Returns all the social network info of the Contact

           @return ContactSocial[]
           @since ARP1.0
        */
        Contact.prototype.getContactSocials = function () {
            return this.contactSocials;
        };
        /**
           Set the social network info of the Contact

           @param contactSocials Social Networks of the contact
           @since ARP1.0
        */
        Contact.prototype.setContactSocials = function (contactSocials) {
            this.contactSocials = contactSocials;
        };
        /**
           Returns the additional tags of the Contact

           @return ContactTag[]
           @since ARP1.0
        */
        Contact.prototype.getContactTags = function () {
            return this.contactTags;
        };
        /**
           Set the additional tags of the Contact

           @param contactTags Tags of the contact
           @since ARP1.0
        */
        Contact.prototype.setContactTags = function (contactTags) {
            this.contactTags = contactTags;
        };
        /**
           Returns all the websites of the Contact

           @return ContactWebsite[]
           @since ARP1.0
        */
        Contact.prototype.getContactWebsites = function () {
            return this.contactWebsites;
        };
        /**
           Set the websites of the Contact

           @param contactWebsites Websites of the contact
           @since ARP1.0
        */
        Contact.prototype.setContactWebsites = function (contactWebsites) {
            this.contactWebsites = contactWebsites;
        };
        /**
           Returns the personal info of the Contact

           @return ContactPersonalInfo of the Contact
           @since ARP1.0
        */
        Contact.prototype.getPersonalInfo = function () {
            return this.personalInfo;
        };
        /**
           Set the personal info of the Contact

           @param personalInfo Personal Information
           @since ARP1.0
        */
        Contact.prototype.setPersonalInfo = function (personalInfo) {
            this.personalInfo = personalInfo;
        };
        /**
           Returns the professional info of the Contact

           @return Array of personal info
           @since ARP1.0
        */
        Contact.prototype.getProfessionalInfo = function () {
            return this.professionalInfo;
        };
        /**
           Set the professional info of the Contact

           @param professionalInfo Professional Information
           @since ARP1.0
        */
        Contact.prototype.setProfessionalInfo = function (professionalInfo) {
            this.professionalInfo = professionalInfo;
        };
        /**
           Convert JSON parsed object to typed equivalent.
        */
        Contact.toObject = function (object) {
            var result = new Contact(null, null, null, null, null, null, null, null, null);
            // Assign values to parent bean fields.
            result.contactId = object.contactId;
            // Assign values to bean fields.
            result.personalInfo = ContactPersonalInfo.toObject(object.personalInfo);
            result.professionalInfo = ContactProfessionalInfo.toObject(object.professionalInfo);
            result.contactAddresses = new Array();
            for (var __value__ in object.contactAddresses) {
                result.contactAddresses.push(ContactAddress.toObject(__value__));
            }
            result.contactPhones = new Array();
            for (var __value__ in object.contactPhones) {
                result.contactPhones.push(ContactPhone.toObject(__value__));
            }
            result.contactEmails = new Array();
            for (var __value__ in object.contactEmails) {
                result.contactEmails.push(ContactEmail.toObject(__value__));
            }
            result.contactWebsites = new Array();
            for (var __value__ in object.contactWebsites) {
                result.contactWebsites.push(ContactWebsite.toObject(__value__));
            }
            result.contactSocials = new Array();
            for (var __value__ in object.contactSocials) {
                result.contactSocials.push(ContactSocial.toObject(__value__));
            }
            result.contactTags = new Array();
            for (var __value__ in object.contactTags) {
                result.contactTags.push(ContactTag.toObject(__value__));
            }
            return result;
        };
        return Contact;
    })(ContactUid);
    Adaptive.Contact = Contact;
    var BaseListener = (function () {
        /**
           Constructor with listener id.

           @param id  The id of the listener.
        */
        function BaseListener(id) {
            this.id = id;
            this.apiGroup = IAdaptiveRPGroup.Application;
        }
        /**
           Get the listener id.
           @return long with the identifier of the listener.
        */
        BaseListener.prototype.getId = function () {
            return this.id;
        };
        /**
           Return the API group for the given interface.
        */
        BaseListener.prototype.getAPIGroup = function () {
            return this.apiGroup;
        };
        /**
           Return the API version for the given interface.
        */
        BaseListener.prototype.getAPIVersion = function () {
            return "v2.0.3";
        };
        return BaseListener;
    })();
    Adaptive.BaseListener = BaseListener;
    /**
       AccelerationListener control dictionary.
    */
    Adaptive.registeredAccelerationListener = new Dictionary([]);
    /**
       AccelerationListener global listener handlers.
    */
    function handleAccelerationListenerError(id, error) {
        var listener = Adaptive.registeredAccelerationListener["" + id];
        if (typeof listener === 'undefined' || listener == null) {
            console.error("ERROR: No listener with id " + id + " registered in registeredAccelerationListener dictionary.");
        }
        else {
            listener.onError(error);
        }
    }
    Adaptive.handleAccelerationListenerError = handleAccelerationListenerError;
    function handleAccelerationListenerResult(id, acceleration) {
        var listener = Adaptive.registeredAccelerationListener["" + id];
        if (typeof listener === 'undefined' || listener == null) {
            console.error("ERROR: No listener with id " + id + " registered in registeredAccelerationListener dictionary.");
        }
        else {
            listener.onResult(acceleration);
        }
    }
    Adaptive.handleAccelerationListenerResult = handleAccelerationListenerResult;
    function handleAccelerationListenerWarning(id, acceleration, warning) {
        var listener = Adaptive.registeredAccelerationListener["" + id];
        if (typeof listener === 'undefined' || listener == null) {
            console.error("ERROR: No listener with id " + id + " registered in registeredAccelerationListener dictionary.");
        }
        else {
            listener.onWarning(acceleration, warning);
        }
    }
    Adaptive.handleAccelerationListenerWarning = handleAccelerationListenerWarning;
    var AccelerationListener = (function (_super) {
        __extends(AccelerationListener, _super);
        /**
           Constructor with anonymous handler functions for listener.

           @param onErrorFunction Function receiving parameters of type: IAccelerationListenerError
           @param onResultFunction Function receiving parameters of type: Acceleration
           @param onWarningFunction Function receiving parameters of type: Acceleration, IAccelerationListenerWarning
        */
        function AccelerationListener(onErrorFunction, onResultFunction, onWarningFunction) {
            _super.call(this, ++Adaptive.registeredCounter);
            if (onErrorFunction == null) {
                console.error("ERROR: AccelerationListener onErrorFunction is not defined.");
            }
            else {
                this.onErrorFunction = onErrorFunction;
            }
            if (onResultFunction == null) {
                console.error("ERROR: AccelerationListener onResultFunction is not defined.");
            }
            else {
                this.onResultFunction = onResultFunction;
            }
            if (onWarningFunction == null) {
                console.error("ERROR: AccelerationListener onWarningFunction is not defined.");
            }
            else {
                this.onWarningFunction = onWarningFunction;
            }
        }
        /**
           No data received - error condition, not authorized or hardware not available. This will be reported once for the
listener and subsequently, the listener will be deactivated and removed from the internal list of listeners.

           @param error Error fired
           @since ARP1.0
        */
        AccelerationListener.prototype.onError = function (error) {
            if (typeof this.onErrorFunction === 'undefined' || this.onErrorFunction == null) {
                console.warn("WARNING: AccelerationListener contains a null reference to onErrorFunction.");
            }
            else {
                this.onErrorFunction(error);
            }
        };
        /**
           Correct data received.

           @param acceleration Acceleration received
           @since ARP1.0
        */
        AccelerationListener.prototype.onResult = function (acceleration) {
            if (typeof this.onResultFunction === 'undefined' || this.onResultFunction == null) {
                console.warn("WARNING: AccelerationListener contains a null reference to onResultFunction.");
            }
            else {
                this.onResultFunction(acceleration);
            }
        };
        /**
           Data received with warning - ie. Needs calibration.

           @param acceleration Acceleration received
           @param warning      Warning fired
           @since ARP1.0
        */
        AccelerationListener.prototype.onWarning = function (acceleration, warning) {
            if (typeof this.onWarningFunction === 'undefined' || this.onWarningFunction == null) {
                console.warn("WARNING: AccelerationListener contains a null reference to onWarningFunction.");
            }
            else {
                this.onWarningFunction(acceleration, warning);
            }
        };
        return AccelerationListener;
    })(BaseListener);
    Adaptive.AccelerationListener = AccelerationListener;
    /**
       ButtonListener control dictionary.
    */
    Adaptive.registeredButtonListener = new Dictionary([]);
    /**
       ButtonListener global listener handlers.
    */
    function handleButtonListenerError(id, error) {
        var listener = Adaptive.registeredButtonListener["" + id];
        if (typeof listener === 'undefined' || listener == null) {
            console.error("ERROR: No listener with id " + id + " registered in registeredButtonListener dictionary.");
        }
        else {
            listener.onError(error);
        }
    }
    Adaptive.handleButtonListenerError = handleButtonListenerError;
    function handleButtonListenerResult(id, button) {
        var listener = Adaptive.registeredButtonListener["" + id];
        if (typeof listener === 'undefined' || listener == null) {
            console.error("ERROR: No listener with id " + id + " registered in registeredButtonListener dictionary.");
        }
        else {
            listener.onResult(button);
        }
    }
    Adaptive.handleButtonListenerResult = handleButtonListenerResult;
    function handleButtonListenerWarning(id, button, warning) {
        var listener = Adaptive.registeredButtonListener["" + id];
        if (typeof listener === 'undefined' || listener == null) {
            console.error("ERROR: No listener with id " + id + " registered in registeredButtonListener dictionary.");
        }
        else {
            listener.onWarning(button, warning);
        }
    }
    Adaptive.handleButtonListenerWarning = handleButtonListenerWarning;
    var ButtonListener = (function (_super) {
        __extends(ButtonListener, _super);
        /**
           Constructor with anonymous handler functions for listener.

           @param onErrorFunction Function receiving parameters of type: IButtonListenerError
           @param onResultFunction Function receiving parameters of type: Button
           @param onWarningFunction Function receiving parameters of type: Button, IButtonListenerWarning
        */
        function ButtonListener(onErrorFunction, onResultFunction, onWarningFunction) {
            _super.call(this, ++Adaptive.registeredCounter);
            if (onErrorFunction == null) {
                console.error("ERROR: ButtonListener onErrorFunction is not defined.");
            }
            else {
                this.onErrorFunction = onErrorFunction;
            }
            if (onResultFunction == null) {
                console.error("ERROR: ButtonListener onResultFunction is not defined.");
            }
            else {
                this.onResultFunction = onResultFunction;
            }
            if (onWarningFunction == null) {
                console.error("ERROR: ButtonListener onWarningFunction is not defined.");
            }
            else {
                this.onWarningFunction = onWarningFunction;
            }
        }
        /**
           No data received

           @param error occurred
           @since ARP1.0
        */
        ButtonListener.prototype.onError = function (error) {
            if (typeof this.onErrorFunction === 'undefined' || this.onErrorFunction == null) {
                console.warn("WARNING: ButtonListener contains a null reference to onErrorFunction.");
            }
            else {
                this.onErrorFunction(error);
            }
        };
        /**
           Called on button pressed

           @param button pressed
           @since ARP1.0
        */
        ButtonListener.prototype.onResult = function (button) {
            if (typeof this.onResultFunction === 'undefined' || this.onResultFunction == null) {
                console.warn("WARNING: ButtonListener contains a null reference to onResultFunction.");
            }
            else {
                this.onResultFunction(button);
            }
        };
        /**
           Data received with warning

           @param button  pressed
           @param warning happened
           @since ARP1.0
        */
        ButtonListener.prototype.onWarning = function (button, warning) {
            if (typeof this.onWarningFunction === 'undefined' || this.onWarningFunction == null) {
                console.warn("WARNING: ButtonListener contains a null reference to onWarningFunction.");
            }
            else {
                this.onWarningFunction(button, warning);
            }
        };
        return ButtonListener;
    })(BaseListener);
    Adaptive.ButtonListener = ButtonListener;
    /**
       GeolocationListener control dictionary.
    */
    Adaptive.registeredGeolocationListener = new Dictionary([]);
    /**
       GeolocationListener global listener handlers.
    */
    function handleGeolocationListenerError(id, error) {
        var listener = Adaptive.registeredGeolocationListener["" + id];
        if (typeof listener === 'undefined' || listener == null) {
            console.error("ERROR: No listener with id " + id + " registered in registeredGeolocationListener dictionary.");
        }
        else {
            listener.onError(error);
        }
    }
    Adaptive.handleGeolocationListenerError = handleGeolocationListenerError;
    function handleGeolocationListenerResult(id, geolocation) {
        var listener = Adaptive.registeredGeolocationListener["" + id];
        if (typeof listener === 'undefined' || listener == null) {
            console.error("ERROR: No listener with id " + id + " registered in registeredGeolocationListener dictionary.");
        }
        else {
            listener.onResult(geolocation);
        }
    }
    Adaptive.handleGeolocationListenerResult = handleGeolocationListenerResult;
    function handleGeolocationListenerWarning(id, geolocation, warning) {
        var listener = Adaptive.registeredGeolocationListener["" + id];
        if (typeof listener === 'undefined' || listener == null) {
            console.error("ERROR: No listener with id " + id + " registered in registeredGeolocationListener dictionary.");
        }
        else {
            listener.onWarning(geolocation, warning);
        }
    }
    Adaptive.handleGeolocationListenerWarning = handleGeolocationListenerWarning;
    var GeolocationListener = (function (_super) {
        __extends(GeolocationListener, _super);
        /**
           Constructor with anonymous handler functions for listener.

           @param onErrorFunction Function receiving parameters of type: IGeolocationListenerError
           @param onResultFunction Function receiving parameters of type: Geolocation
           @param onWarningFunction Function receiving parameters of type: Geolocation, IGeolocationListenerWarning
        */
        function GeolocationListener(onErrorFunction, onResultFunction, onWarningFunction) {
            _super.call(this, ++Adaptive.registeredCounter);
            if (onErrorFunction == null) {
                console.error("ERROR: GeolocationListener onErrorFunction is not defined.");
            }
            else {
                this.onErrorFunction = onErrorFunction;
            }
            if (onResultFunction == null) {
                console.error("ERROR: GeolocationListener onResultFunction is not defined.");
            }
            else {
                this.onResultFunction = onResultFunction;
            }
            if (onWarningFunction == null) {
                console.error("ERROR: GeolocationListener onWarningFunction is not defined.");
            }
            else {
                this.onWarningFunction = onWarningFunction;
            }
        }
        /**
           No data received - error condition, not authorized or hardware not available.

           @param error Type of error encountered during reading.
           @since ARP1.0
        */
        GeolocationListener.prototype.onError = function (error) {
            if (typeof this.onErrorFunction === 'undefined' || this.onErrorFunction == null) {
                console.warn("WARNING: GeolocationListener contains a null reference to onErrorFunction.");
            }
            else {
                this.onErrorFunction(error);
            }
        };
        /**
           Correct data received.

           @param geolocation Geolocation Bean
           @since ARP1.0
        */
        GeolocationListener.prototype.onResult = function (geolocation) {
            if (typeof this.onResultFunction === 'undefined' || this.onResultFunction == null) {
                console.warn("WARNING: GeolocationListener contains a null reference to onResultFunction.");
            }
            else {
                this.onResultFunction(geolocation);
            }
        };
        /**
           Data received with warning - ie. HighDoP

           @param geolocation Geolocation Bean
           @param warning     Type of warning encountered during reading.
           @since ARP1.0
        */
        GeolocationListener.prototype.onWarning = function (geolocation, warning) {
            if (typeof this.onWarningFunction === 'undefined' || this.onWarningFunction == null) {
                console.warn("WARNING: GeolocationListener contains a null reference to onWarningFunction.");
            }
            else {
                this.onWarningFunction(geolocation, warning);
            }
        };
        return GeolocationListener;
    })(BaseListener);
    Adaptive.GeolocationListener = GeolocationListener;
    /**
       LifecycleListener control dictionary.
    */
    Adaptive.registeredLifecycleListener = new Dictionary([]);
    /**
       LifecycleListener global listener handlers.
    */
    function handleLifecycleListenerError(id, error) {
        var listener = Adaptive.registeredLifecycleListener["" + id];
        if (typeof listener === 'undefined' || listener == null) {
            console.error("ERROR: No listener with id " + id + " registered in registeredLifecycleListener dictionary.");
        }
        else {
            listener.onError(error);
        }
    }
    Adaptive.handleLifecycleListenerError = handleLifecycleListenerError;
    function handleLifecycleListenerResult(id, lifecycle) {
        var listener = Adaptive.registeredLifecycleListener["" + id];
        if (typeof listener === 'undefined' || listener == null) {
            console.error("ERROR: No listener with id " + id + " registered in registeredLifecycleListener dictionary.");
        }
        else {
            listener.onResult(lifecycle);
        }
    }
    Adaptive.handleLifecycleListenerResult = handleLifecycleListenerResult;
    function handleLifecycleListenerWarning(id, lifecycle, warning) {
        var listener = Adaptive.registeredLifecycleListener["" + id];
        if (typeof listener === 'undefined' || listener == null) {
            console.error("ERROR: No listener with id " + id + " registered in registeredLifecycleListener dictionary.");
        }
        else {
            listener.onWarning(lifecycle, warning);
        }
    }
    Adaptive.handleLifecycleListenerWarning = handleLifecycleListenerWarning;
    var LifecycleListener = (function (_super) {
        __extends(LifecycleListener, _super);
        /**
           Constructor with anonymous handler functions for listener.

           @param onErrorFunction Function receiving parameters of type: ILifecycleListenerError
           @param onResultFunction Function receiving parameters of type: Lifecycle
           @param onWarningFunction Function receiving parameters of type: Lifecycle, ILifecycleListenerWarning
        */
        function LifecycleListener(onErrorFunction, onResultFunction, onWarningFunction) {
            _super.call(this, ++Adaptive.registeredCounter);
            if (onErrorFunction == null) {
                console.error("ERROR: LifecycleListener onErrorFunction is not defined.");
            }
            else {
                this.onErrorFunction = onErrorFunction;
            }
            if (onResultFunction == null) {
                console.error("ERROR: LifecycleListener onResultFunction is not defined.");
            }
            else {
                this.onResultFunction = onResultFunction;
            }
            if (onWarningFunction == null) {
                console.error("ERROR: LifecycleListener onWarningFunction is not defined.");
            }
            else {
                this.onWarningFunction = onWarningFunction;
            }
        }
        /**
           No data received - error condition, not authorized or hardware not available.

           @param error Type of error encountered during reading.
           @since ARP1.0
        */
        LifecycleListener.prototype.onError = function (error) {
            if (typeof this.onErrorFunction === 'undefined' || this.onErrorFunction == null) {
                console.warn("WARNING: LifecycleListener contains a null reference to onErrorFunction.");
            }
            else {
                this.onErrorFunction(error);
            }
        };
        /**
           Called when lifecycle changes somehow.

           @param lifecycle Lifecycle element
           @since ARP1.0
        */
        LifecycleListener.prototype.onResult = function (lifecycle) {
            if (typeof this.onResultFunction === 'undefined' || this.onResultFunction == null) {
                console.warn("WARNING: LifecycleListener contains a null reference to onResultFunction.");
            }
            else {
                this.onResultFunction(lifecycle);
            }
        };
        /**
           Data received with warning

           @param lifecycle Lifecycle element
           @param warning   Type of warning encountered during reading.
           @since ARP1.0
        */
        LifecycleListener.prototype.onWarning = function (lifecycle, warning) {
            if (typeof this.onWarningFunction === 'undefined' || this.onWarningFunction == null) {
                console.warn("WARNING: LifecycleListener contains a null reference to onWarningFunction.");
            }
            else {
                this.onWarningFunction(lifecycle, warning);
            }
        };
        return LifecycleListener;
    })(BaseListener);
    Adaptive.LifecycleListener = LifecycleListener;
    /**
       NetworkStatusListener control dictionary.
    */
    Adaptive.registeredNetworkStatusListener = new Dictionary([]);
    /**
       NetworkStatusListener global listener handlers.
    */
    function handleNetworkStatusListenerError(id, error) {
        var listener = Adaptive.registeredNetworkStatusListener["" + id];
        if (typeof listener === 'undefined' || listener == null) {
            console.error("ERROR: No listener with id " + id + " registered in registeredNetworkStatusListener dictionary.");
        }
        else {
            listener.onError(error);
        }
    }
    Adaptive.handleNetworkStatusListenerError = handleNetworkStatusListenerError;
    function handleNetworkStatusListenerResult(id, network) {
        var listener = Adaptive.registeredNetworkStatusListener["" + id];
        if (typeof listener === 'undefined' || listener == null) {
            console.error("ERROR: No listener with id " + id + " registered in registeredNetworkStatusListener dictionary.");
        }
        else {
            listener.onResult(network);
        }
    }
    Adaptive.handleNetworkStatusListenerResult = handleNetworkStatusListenerResult;
    function handleNetworkStatusListenerWarning(id, network, warning) {
        var listener = Adaptive.registeredNetworkStatusListener["" + id];
        if (typeof listener === 'undefined' || listener == null) {
            console.error("ERROR: No listener with id " + id + " registered in registeredNetworkStatusListener dictionary.");
        }
        else {
            listener.onWarning(network, warning);
        }
    }
    Adaptive.handleNetworkStatusListenerWarning = handleNetworkStatusListenerWarning;
    var NetworkStatusListener = (function (_super) {
        __extends(NetworkStatusListener, _super);
        /**
           Constructor with anonymous handler functions for listener.

           @param onErrorFunction Function receiving parameters of type: INetworkStatusListenerError
           @param onResultFunction Function receiving parameters of type: ICapabilitiesNet
           @param onWarningFunction Function receiving parameters of type: ICapabilitiesNet, INetworkStatusListenerWarning
        */
        function NetworkStatusListener(onErrorFunction, onResultFunction, onWarningFunction) {
            _super.call(this, ++Adaptive.registeredCounter);
            if (onErrorFunction == null) {
                console.error("ERROR: NetworkStatusListener onErrorFunction is not defined.");
            }
            else {
                this.onErrorFunction = onErrorFunction;
            }
            if (onResultFunction == null) {
                console.error("ERROR: NetworkStatusListener onResultFunction is not defined.");
            }
            else {
                this.onResultFunction = onResultFunction;
            }
            if (onWarningFunction == null) {
                console.error("ERROR: NetworkStatusListener onWarningFunction is not defined.");
            }
            else {
                this.onWarningFunction = onWarningFunction;
            }
        }
        /**
           No data received - error condition, not authorized or hardware not available.

           @param error Type of error encountered during reading.
           @since ARP1.0
        */
        NetworkStatusListener.prototype.onError = function (error) {
            if (typeof this.onErrorFunction === 'undefined' || this.onErrorFunction == null) {
                console.warn("WARNING: NetworkStatusListener contains a null reference to onErrorFunction.");
            }
            else {
                this.onErrorFunction(error);
            }
        };
        /**
           Called when network connection changes somehow.

           @param network Change to this network.
           @since ARP1.0
        */
        NetworkStatusListener.prototype.onResult = function (network) {
            if (typeof this.onResultFunction === 'undefined' || this.onResultFunction == null) {
                console.warn("WARNING: NetworkStatusListener contains a null reference to onResultFunction.");
            }
            else {
                this.onResultFunction(network);
            }
        };
        /**
           Status received with warning

           @param network Change to this network.
           @param warning Type of warning encountered during reading.
           @since ARP1.0
        */
        NetworkStatusListener.prototype.onWarning = function (network, warning) {
            if (typeof this.onWarningFunction === 'undefined' || this.onWarningFunction == null) {
                console.warn("WARNING: NetworkStatusListener contains a null reference to onWarningFunction.");
            }
            else {
                this.onWarningFunction(network, warning);
            }
        };
        return NetworkStatusListener;
    })(BaseListener);
    Adaptive.NetworkStatusListener = NetworkStatusListener;
    var BaseCallback = (function () {
        /**
           Constructor with callback id.

           @param id  The id of the callback.
        */
        function BaseCallback(id) {
            this.id = id;
            this.apiGroup = IAdaptiveRPGroup.Application;
        }
        /**
           Get the listener id.
           @return long with the identifier of the callback.
        */
        BaseCallback.prototype.getId = function () {
            return this.id;
        };
        /**
           Return the API group for the given interface.
        */
        BaseCallback.prototype.getAPIGroup = function () {
            return this.apiGroup;
        };
        /**
           Return the API version for the given interface.
        */
        BaseCallback.prototype.getAPIVersion = function () {
            return "v2.0.3";
        };
        return BaseCallback;
    })();
    Adaptive.BaseCallback = BaseCallback;
    /**
       ContactPhotoResultCallback control dictionary.
    */
    Adaptive.registeredContactPhotoResultCallback = new Dictionary([]);
    /**
       ContactPhotoResultCallback global callback handlers.
    */
    function handleContactPhotoResultCallbackError(id, error) {
        var callback = Adaptive.registeredContactPhotoResultCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredContactPhotoResultCallback dictionary.");
        }
        else {
            Adaptive.registeredContactPhotoResultCallback.remove("" + id);
            callback.onError(error);
        }
    }
    Adaptive.handleContactPhotoResultCallbackError = handleContactPhotoResultCallbackError;
    function handleContactPhotoResultCallbackResult(id, contactPhoto) {
        var callback = Adaptive.registeredContactPhotoResultCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredContactPhotoResultCallback dictionary.");
        }
        else {
            Adaptive.registeredContactPhotoResultCallback.remove("" + id);
            callback.onResult(contactPhoto);
        }
    }
    Adaptive.handleContactPhotoResultCallbackResult = handleContactPhotoResultCallbackResult;
    function handleContactPhotoResultCallbackWarning(id, contactPhoto, warning) {
        var callback = Adaptive.registeredContactPhotoResultCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredContactPhotoResultCallback dictionary.");
        }
        else {
            Adaptive.registeredContactPhotoResultCallback.remove("" + id);
            callback.onWarning(contactPhoto, warning);
        }
    }
    Adaptive.handleContactPhotoResultCallbackWarning = handleContactPhotoResultCallbackWarning;
    var ContactPhotoResultCallback = (function (_super) {
        __extends(ContactPhotoResultCallback, _super);
        /**
           Constructor with anonymous handler functions for callback.

           @param onErrorFunction Function receiving parameters of type: IContactPhotoResultCallbackError
           @param onResultFunction Function receiving parameters of type: Array<number>
           @param onWarningFunction Function receiving parameters of type: Array<number>, IContactPhotoResultCallbackWarning
        */
        function ContactPhotoResultCallback(onErrorFunction, onResultFunction, onWarningFunction) {
            _super.call(this, ++Adaptive.registeredCounter);
            if (onErrorFunction == null) {
                console.error("ERROR: ContactPhotoResultCallback onErrorFunction is not defined.");
            }
            else {
                this.onErrorFunction = onErrorFunction;
            }
            if (onResultFunction == null) {
                console.error("ERROR: ContactPhotoResultCallback onResultFunction is not defined.");
            }
            else {
                this.onResultFunction = onResultFunction;
            }
            if (onWarningFunction == null) {
                console.error("ERROR: ContactPhotoResultCallback onWarningFunction is not defined.");
            }
            else {
                this.onWarningFunction = onWarningFunction;
            }
        }
        /**
           This method is called on Error

           @param error returned by the platform
           @since ARP1.0
        */
        ContactPhotoResultCallback.prototype.onError = function (error) {
            if (typeof this.onErrorFunction === 'undefined' || this.onErrorFunction == null) {
                console.warn("WARNING: ContactPhotoResultCallback contains a null reference to onErrorFunction.");
            }
            else {
                this.onErrorFunction(error);
            }
        };
        /**
           This method is called on Result

           @param contactPhoto returned by the platform
           @since ARP1.0
        */
        ContactPhotoResultCallback.prototype.onResult = function (contactPhoto) {
            if (typeof this.onResultFunction === 'undefined' || this.onResultFunction == null) {
                console.warn("WARNING: ContactPhotoResultCallback contains a null reference to onResultFunction.");
            }
            else {
                this.onResultFunction(contactPhoto);
            }
        };
        /**
           This method is called on Warning

           @param contactPhoto returned by the platform
           @param warning      returned by the platform
           @since ARP1.0
        */
        ContactPhotoResultCallback.prototype.onWarning = function (contactPhoto, warning) {
            if (typeof this.onWarningFunction === 'undefined' || this.onWarningFunction == null) {
                console.warn("WARNING: ContactPhotoResultCallback contains a null reference to onWarningFunction.");
            }
            else {
                this.onWarningFunction(contactPhoto, warning);
            }
        };
        return ContactPhotoResultCallback;
    })(BaseCallback);
    Adaptive.ContactPhotoResultCallback = ContactPhotoResultCallback;
    /**
       ContactResultCallback control dictionary.
    */
    Adaptive.registeredContactResultCallback = new Dictionary([]);
    /**
       ContactResultCallback global callback handlers.
    */
    function handleContactResultCallbackError(id, error) {
        var callback = Adaptive.registeredContactResultCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredContactResultCallback dictionary.");
        }
        else {
            Adaptive.registeredContactResultCallback.remove("" + id);
            callback.onError(error);
        }
    }
    Adaptive.handleContactResultCallbackError = handleContactResultCallbackError;
    function handleContactResultCallbackResult(id, contacts) {
        var callback = Adaptive.registeredContactResultCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredContactResultCallback dictionary.");
        }
        else {
            Adaptive.registeredContactResultCallback.remove("" + id);
            callback.onResult(contacts);
        }
    }
    Adaptive.handleContactResultCallbackResult = handleContactResultCallbackResult;
    function handleContactResultCallbackWarning(id, contacts, warning) {
        var callback = Adaptive.registeredContactResultCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredContactResultCallback dictionary.");
        }
        else {
            Adaptive.registeredContactResultCallback.remove("" + id);
            callback.onWarning(contacts, warning);
        }
    }
    Adaptive.handleContactResultCallbackWarning = handleContactResultCallbackWarning;
    var ContactResultCallback = (function (_super) {
        __extends(ContactResultCallback, _super);
        /**
           Constructor with anonymous handler functions for callback.

           @param onErrorFunction Function receiving parameters of type: IContactResultCallbackError
           @param onResultFunction Function receiving parameters of type: Array<Contact>
           @param onWarningFunction Function receiving parameters of type: Array<Contact>, IContactResultCallbackWarning
        */
        function ContactResultCallback(onErrorFunction, onResultFunction, onWarningFunction) {
            _super.call(this, ++Adaptive.registeredCounter);
            if (onErrorFunction == null) {
                console.error("ERROR: ContactResultCallback onErrorFunction is not defined.");
            }
            else {
                this.onErrorFunction = onErrorFunction;
            }
            if (onResultFunction == null) {
                console.error("ERROR: ContactResultCallback onResultFunction is not defined.");
            }
            else {
                this.onResultFunction = onResultFunction;
            }
            if (onWarningFunction == null) {
                console.error("ERROR: ContactResultCallback onWarningFunction is not defined.");
            }
            else {
                this.onWarningFunction = onWarningFunction;
            }
        }
        /**
           This method is called on Error

           @param error returned by the platform
           @since ARP1.0
        */
        ContactResultCallback.prototype.onError = function (error) {
            if (typeof this.onErrorFunction === 'undefined' || this.onErrorFunction == null) {
                console.warn("WARNING: ContactResultCallback contains a null reference to onErrorFunction.");
            }
            else {
                this.onErrorFunction(error);
            }
        };
        /**
           This method is called on Result

           @param contacts returned by the platform
           @since ARP1.0
        */
        ContactResultCallback.prototype.onResult = function (contacts) {
            if (typeof this.onResultFunction === 'undefined' || this.onResultFunction == null) {
                console.warn("WARNING: ContactResultCallback contains a null reference to onResultFunction.");
            }
            else {
                this.onResultFunction(contacts);
            }
        };
        /**
           This method is called on Warning

           @param contacts returned by the platform
           @param warning  returned by the platform
           @since ARP1.0
        */
        ContactResultCallback.prototype.onWarning = function (contacts, warning) {
            if (typeof this.onWarningFunction === 'undefined' || this.onWarningFunction == null) {
                console.warn("WARNING: ContactResultCallback contains a null reference to onWarningFunction.");
            }
            else {
                this.onWarningFunction(contacts, warning);
            }
        };
        return ContactResultCallback;
    })(BaseCallback);
    Adaptive.ContactResultCallback = ContactResultCallback;
    /**
       DatabaseResultCallback control dictionary.
    */
    Adaptive.registeredDatabaseResultCallback = new Dictionary([]);
    /**
       DatabaseResultCallback global callback handlers.
    */
    function handleDatabaseResultCallbackError(id, error) {
        var callback = Adaptive.registeredDatabaseResultCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredDatabaseResultCallback dictionary.");
        }
        else {
            Adaptive.registeredDatabaseResultCallback.remove("" + id);
            callback.onError(error);
        }
    }
    Adaptive.handleDatabaseResultCallbackError = handleDatabaseResultCallbackError;
    function handleDatabaseResultCallbackResult(id, database) {
        var callback = Adaptive.registeredDatabaseResultCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredDatabaseResultCallback dictionary.");
        }
        else {
            Adaptive.registeredDatabaseResultCallback.remove("" + id);
            callback.onResult(database);
        }
    }
    Adaptive.handleDatabaseResultCallbackResult = handleDatabaseResultCallbackResult;
    function handleDatabaseResultCallbackWarning(id, database, warning) {
        var callback = Adaptive.registeredDatabaseResultCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredDatabaseResultCallback dictionary.");
        }
        else {
            Adaptive.registeredDatabaseResultCallback.remove("" + id);
            callback.onWarning(database, warning);
        }
    }
    Adaptive.handleDatabaseResultCallbackWarning = handleDatabaseResultCallbackWarning;
    var DatabaseResultCallback = (function (_super) {
        __extends(DatabaseResultCallback, _super);
        /**
           Constructor with anonymous handler functions for callback.

           @param onErrorFunction Function receiving parameters of type: IDatabaseResultCallbackError
           @param onResultFunction Function receiving parameters of type: Database
           @param onWarningFunction Function receiving parameters of type: Database, IDatabaseResultCallbackWarning
        */
        function DatabaseResultCallback(onErrorFunction, onResultFunction, onWarningFunction) {
            _super.call(this, ++Adaptive.registeredCounter);
            if (onErrorFunction == null) {
                console.error("ERROR: DatabaseResultCallback onErrorFunction is not defined.");
            }
            else {
                this.onErrorFunction = onErrorFunction;
            }
            if (onResultFunction == null) {
                console.error("ERROR: DatabaseResultCallback onResultFunction is not defined.");
            }
            else {
                this.onResultFunction = onResultFunction;
            }
            if (onWarningFunction == null) {
                console.error("ERROR: DatabaseResultCallback onWarningFunction is not defined.");
            }
            else {
                this.onWarningFunction = onWarningFunction;
            }
        }
        /**
           Result callback for error responses

           @param error Returned error
           @since ARP1.0
        */
        DatabaseResultCallback.prototype.onError = function (error) {
            if (typeof this.onErrorFunction === 'undefined' || this.onErrorFunction == null) {
                console.warn("WARNING: DatabaseResultCallback contains a null reference to onErrorFunction.");
            }
            else {
                this.onErrorFunction(error);
            }
        };
        /**
           Result callback for correct responses

           @param database Returns the database
           @since ARP1.0
        */
        DatabaseResultCallback.prototype.onResult = function (database) {
            if (typeof this.onResultFunction === 'undefined' || this.onResultFunction == null) {
                console.warn("WARNING: DatabaseResultCallback contains a null reference to onResultFunction.");
            }
            else {
                this.onResultFunction(database);
            }
        };
        /**
           Result callback for warning responses

           @param database Returns the database
           @param warning  Returned Warning
           @since ARP1.0
        */
        DatabaseResultCallback.prototype.onWarning = function (database, warning) {
            if (typeof this.onWarningFunction === 'undefined' || this.onWarningFunction == null) {
                console.warn("WARNING: DatabaseResultCallback contains a null reference to onWarningFunction.");
            }
            else {
                this.onWarningFunction(database, warning);
            }
        };
        return DatabaseResultCallback;
    })(BaseCallback);
    Adaptive.DatabaseResultCallback = DatabaseResultCallback;
    /**
       DatabaseTableResultCallback control dictionary.
    */
    Adaptive.registeredDatabaseTableResultCallback = new Dictionary([]);
    /**
       DatabaseTableResultCallback global callback handlers.
    */
    function handleDatabaseTableResultCallbackError(id, error) {
        var callback = Adaptive.registeredDatabaseTableResultCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredDatabaseTableResultCallback dictionary.");
        }
        else {
            Adaptive.registeredDatabaseTableResultCallback.remove("" + id);
            callback.onError(error);
        }
    }
    Adaptive.handleDatabaseTableResultCallbackError = handleDatabaseTableResultCallbackError;
    function handleDatabaseTableResultCallbackResult(id, databaseTable) {
        var callback = Adaptive.registeredDatabaseTableResultCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredDatabaseTableResultCallback dictionary.");
        }
        else {
            Adaptive.registeredDatabaseTableResultCallback.remove("" + id);
            callback.onResult(databaseTable);
        }
    }
    Adaptive.handleDatabaseTableResultCallbackResult = handleDatabaseTableResultCallbackResult;
    function handleDatabaseTableResultCallbackWarning(id, databaseTable, warning) {
        var callback = Adaptive.registeredDatabaseTableResultCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredDatabaseTableResultCallback dictionary.");
        }
        else {
            Adaptive.registeredDatabaseTableResultCallback.remove("" + id);
            callback.onWarning(databaseTable, warning);
        }
    }
    Adaptive.handleDatabaseTableResultCallbackWarning = handleDatabaseTableResultCallbackWarning;
    var DatabaseTableResultCallback = (function (_super) {
        __extends(DatabaseTableResultCallback, _super);
        /**
           Constructor with anonymous handler functions for callback.

           @param onErrorFunction Function receiving parameters of type: IDatabaseTableResultCallbackError
           @param onResultFunction Function receiving parameters of type: DatabaseTable
           @param onWarningFunction Function receiving parameters of type: DatabaseTable, IDatabaseTableResultCallbackWarning
        */
        function DatabaseTableResultCallback(onErrorFunction, onResultFunction, onWarningFunction) {
            _super.call(this, ++Adaptive.registeredCounter);
            if (onErrorFunction == null) {
                console.error("ERROR: DatabaseTableResultCallback onErrorFunction is not defined.");
            }
            else {
                this.onErrorFunction = onErrorFunction;
            }
            if (onResultFunction == null) {
                console.error("ERROR: DatabaseTableResultCallback onResultFunction is not defined.");
            }
            else {
                this.onResultFunction = onResultFunction;
            }
            if (onWarningFunction == null) {
                console.error("ERROR: DatabaseTableResultCallback onWarningFunction is not defined.");
            }
            else {
                this.onWarningFunction = onWarningFunction;
            }
        }
        /**
           Result callback for error responses

           @param error Returned error
           @since ARP1.0
        */
        DatabaseTableResultCallback.prototype.onError = function (error) {
            if (typeof this.onErrorFunction === 'undefined' || this.onErrorFunction == null) {
                console.warn("WARNING: DatabaseTableResultCallback contains a null reference to onErrorFunction.");
            }
            else {
                this.onErrorFunction(error);
            }
        };
        /**
           Result callback for correct responses

           @param databaseTable Returns the databaseTable
           @since ARP1.0
        */
        DatabaseTableResultCallback.prototype.onResult = function (databaseTable) {
            if (typeof this.onResultFunction === 'undefined' || this.onResultFunction == null) {
                console.warn("WARNING: DatabaseTableResultCallback contains a null reference to onResultFunction.");
            }
            else {
                this.onResultFunction(databaseTable);
            }
        };
        /**
           Result callback for warning responses

           @param databaseTable Returns the databaseTable
           @param warning       Returned Warning
           @since ARP1.0
        */
        DatabaseTableResultCallback.prototype.onWarning = function (databaseTable, warning) {
            if (typeof this.onWarningFunction === 'undefined' || this.onWarningFunction == null) {
                console.warn("WARNING: DatabaseTableResultCallback contains a null reference to onWarningFunction.");
            }
            else {
                this.onWarningFunction(databaseTable, warning);
            }
        };
        return DatabaseTableResultCallback;
    })(BaseCallback);
    Adaptive.DatabaseTableResultCallback = DatabaseTableResultCallback;
    /**
       FileDataLoadResultCallback control dictionary.
    */
    Adaptive.registeredFileDataLoadResultCallback = new Dictionary([]);
    /**
       FileDataLoadResultCallback global callback handlers.
    */
    function handleFileDataLoadResultCallbackError(id, error) {
        var callback = Adaptive.registeredFileDataLoadResultCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredFileDataLoadResultCallback dictionary.");
        }
        else {
            Adaptive.registeredFileDataLoadResultCallback.remove("" + id);
            callback.onError(error);
        }
    }
    Adaptive.handleFileDataLoadResultCallbackError = handleFileDataLoadResultCallbackError;
    function handleFileDataLoadResultCallbackResult(id, data) {
        var callback = Adaptive.registeredFileDataLoadResultCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredFileDataLoadResultCallback dictionary.");
        }
        else {
            Adaptive.registeredFileDataLoadResultCallback.remove("" + id);
            callback.onResult(data);
        }
    }
    Adaptive.handleFileDataLoadResultCallbackResult = handleFileDataLoadResultCallbackResult;
    function handleFileDataLoadResultCallbackWarning(id, data, warning) {
        var callback = Adaptive.registeredFileDataLoadResultCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredFileDataLoadResultCallback dictionary.");
        }
        else {
            Adaptive.registeredFileDataLoadResultCallback.remove("" + id);
            callback.onWarning(data, warning);
        }
    }
    Adaptive.handleFileDataLoadResultCallbackWarning = handleFileDataLoadResultCallbackWarning;
    var FileDataLoadResultCallback = (function (_super) {
        __extends(FileDataLoadResultCallback, _super);
        /**
           Constructor with anonymous handler functions for callback.

           @param onErrorFunction Function receiving parameters of type: IFileDataLoadResultCallbackError
           @param onResultFunction Function receiving parameters of type: Array<number>
           @param onWarningFunction Function receiving parameters of type: Array<number>, IFileDataLoadResultCallbackWarning
        */
        function FileDataLoadResultCallback(onErrorFunction, onResultFunction, onWarningFunction) {
            _super.call(this, ++Adaptive.registeredCounter);
            if (onErrorFunction == null) {
                console.error("ERROR: FileDataLoadResultCallback onErrorFunction is not defined.");
            }
            else {
                this.onErrorFunction = onErrorFunction;
            }
            if (onResultFunction == null) {
                console.error("ERROR: FileDataLoadResultCallback onResultFunction is not defined.");
            }
            else {
                this.onResultFunction = onResultFunction;
            }
            if (onWarningFunction == null) {
                console.error("ERROR: FileDataLoadResultCallback onWarningFunction is not defined.");
            }
            else {
                this.onWarningFunction = onWarningFunction;
            }
        }
        /**
           Error processing data retrieval/storage operation.

           @param error Error condition encountered.
           @since ARP1.0
        */
        FileDataLoadResultCallback.prototype.onError = function (error) {
            if (typeof this.onErrorFunction === 'undefined' || this.onErrorFunction == null) {
                console.warn("WARNING: FileDataLoadResultCallback contains a null reference to onErrorFunction.");
            }
            else {
                this.onErrorFunction(error);
            }
        };
        /**
           Result of data retrieval operation.

           @param data Data loaded.
           @since ARP1.0
        */
        FileDataLoadResultCallback.prototype.onResult = function (data) {
            if (typeof this.onResultFunction === 'undefined' || this.onResultFunction == null) {
                console.warn("WARNING: FileDataLoadResultCallback contains a null reference to onResultFunction.");
            }
            else {
                this.onResultFunction(data);
            }
        };
        /**
           Result with warning of data retrieval/storage operation.

           @param data    File being loaded.
           @param warning Warning condition encountered.
           @since ARP1.0
        */
        FileDataLoadResultCallback.prototype.onWarning = function (data, warning) {
            if (typeof this.onWarningFunction === 'undefined' || this.onWarningFunction == null) {
                console.warn("WARNING: FileDataLoadResultCallback contains a null reference to onWarningFunction.");
            }
            else {
                this.onWarningFunction(data, warning);
            }
        };
        return FileDataLoadResultCallback;
    })(BaseCallback);
    Adaptive.FileDataLoadResultCallback = FileDataLoadResultCallback;
    /**
       FileDataStoreResultCallback control dictionary.
    */
    Adaptive.registeredFileDataStoreResultCallback = new Dictionary([]);
    /**
       FileDataStoreResultCallback global callback handlers.
    */
    function handleFileDataStoreResultCallbackError(id, error) {
        var callback = Adaptive.registeredFileDataStoreResultCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredFileDataStoreResultCallback dictionary.");
        }
        else {
            Adaptive.registeredFileDataStoreResultCallback.remove("" + id);
            callback.onError(error);
        }
    }
    Adaptive.handleFileDataStoreResultCallbackError = handleFileDataStoreResultCallbackError;
    function handleFileDataStoreResultCallbackResult(id, file) {
        var callback = Adaptive.registeredFileDataStoreResultCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredFileDataStoreResultCallback dictionary.");
        }
        else {
            Adaptive.registeredFileDataStoreResultCallback.remove("" + id);
            callback.onResult(file);
        }
    }
    Adaptive.handleFileDataStoreResultCallbackResult = handleFileDataStoreResultCallbackResult;
    function handleFileDataStoreResultCallbackWarning(id, file, warning) {
        var callback = Adaptive.registeredFileDataStoreResultCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredFileDataStoreResultCallback dictionary.");
        }
        else {
            Adaptive.registeredFileDataStoreResultCallback.remove("" + id);
            callback.onWarning(file, warning);
        }
    }
    Adaptive.handleFileDataStoreResultCallbackWarning = handleFileDataStoreResultCallbackWarning;
    var FileDataStoreResultCallback = (function (_super) {
        __extends(FileDataStoreResultCallback, _super);
        /**
           Constructor with anonymous handler functions for callback.

           @param onErrorFunction Function receiving parameters of type: IFileDataStoreResultCallbackError
           @param onResultFunction Function receiving parameters of type: FileDescriptor
           @param onWarningFunction Function receiving parameters of type: FileDescriptor, IFileDataStoreResultCallbackWarning
        */
        function FileDataStoreResultCallback(onErrorFunction, onResultFunction, onWarningFunction) {
            _super.call(this, ++Adaptive.registeredCounter);
            if (onErrorFunction == null) {
                console.error("ERROR: FileDataStoreResultCallback onErrorFunction is not defined.");
            }
            else {
                this.onErrorFunction = onErrorFunction;
            }
            if (onResultFunction == null) {
                console.error("ERROR: FileDataStoreResultCallback onResultFunction is not defined.");
            }
            else {
                this.onResultFunction = onResultFunction;
            }
            if (onWarningFunction == null) {
                console.error("ERROR: FileDataStoreResultCallback onWarningFunction is not defined.");
            }
            else {
                this.onWarningFunction = onWarningFunction;
            }
        }
        /**
           Error processing data retrieval/storage operation.

           @param error Error condition encountered.
           @since ARP1.0
        */
        FileDataStoreResultCallback.prototype.onError = function (error) {
            if (typeof this.onErrorFunction === 'undefined' || this.onErrorFunction == null) {
                console.warn("WARNING: FileDataStoreResultCallback contains a null reference to onErrorFunction.");
            }
            else {
                this.onErrorFunction(error);
            }
        };
        /**
           Result of data storage operation.

           @param file File reference to stored data.
           @since ARP1.0
        */
        FileDataStoreResultCallback.prototype.onResult = function (file) {
            if (typeof this.onResultFunction === 'undefined' || this.onResultFunction == null) {
                console.warn("WARNING: FileDataStoreResultCallback contains a null reference to onResultFunction.");
            }
            else {
                this.onResultFunction(file);
            }
        };
        /**
           Result with warning of data retrieval/storage operation.

           @param file    File being loaded/stored.
           @param warning Warning condition encountered.
           @since ARP1.0
        */
        FileDataStoreResultCallback.prototype.onWarning = function (file, warning) {
            if (typeof this.onWarningFunction === 'undefined' || this.onWarningFunction == null) {
                console.warn("WARNING: FileDataStoreResultCallback contains a null reference to onWarningFunction.");
            }
            else {
                this.onWarningFunction(file, warning);
            }
        };
        return FileDataStoreResultCallback;
    })(BaseCallback);
    Adaptive.FileDataStoreResultCallback = FileDataStoreResultCallback;
    /**
       FileListResultCallback control dictionary.
    */
    Adaptive.registeredFileListResultCallback = new Dictionary([]);
    /**
       FileListResultCallback global callback handlers.
    */
    function handleFileListResultCallbackError(id, error) {
        var callback = Adaptive.registeredFileListResultCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredFileListResultCallback dictionary.");
        }
        else {
            Adaptive.registeredFileListResultCallback.remove("" + id);
            callback.onError(error);
        }
    }
    Adaptive.handleFileListResultCallbackError = handleFileListResultCallbackError;
    function handleFileListResultCallbackResult(id, files) {
        var callback = Adaptive.registeredFileListResultCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredFileListResultCallback dictionary.");
        }
        else {
            Adaptive.registeredFileListResultCallback.remove("" + id);
            callback.onResult(files);
        }
    }
    Adaptive.handleFileListResultCallbackResult = handleFileListResultCallbackResult;
    function handleFileListResultCallbackWarning(id, files, warning) {
        var callback = Adaptive.registeredFileListResultCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredFileListResultCallback dictionary.");
        }
        else {
            Adaptive.registeredFileListResultCallback.remove("" + id);
            callback.onWarning(files, warning);
        }
    }
    Adaptive.handleFileListResultCallbackWarning = handleFileListResultCallbackWarning;
    var FileListResultCallback = (function (_super) {
        __extends(FileListResultCallback, _super);
        /**
           Constructor with anonymous handler functions for callback.

           @param onErrorFunction Function receiving parameters of type: IFileListResultCallbackError
           @param onResultFunction Function receiving parameters of type: Array<FileDescriptor>
           @param onWarningFunction Function receiving parameters of type: Array<FileDescriptor>, IFileListResultCallbackWarning
        */
        function FileListResultCallback(onErrorFunction, onResultFunction, onWarningFunction) {
            _super.call(this, ++Adaptive.registeredCounter);
            if (onErrorFunction == null) {
                console.error("ERROR: FileListResultCallback onErrorFunction is not defined.");
            }
            else {
                this.onErrorFunction = onErrorFunction;
            }
            if (onResultFunction == null) {
                console.error("ERROR: FileListResultCallback onResultFunction is not defined.");
            }
            else {
                this.onResultFunction = onResultFunction;
            }
            if (onWarningFunction == null) {
                console.error("ERROR: FileListResultCallback onWarningFunction is not defined.");
            }
            else {
                this.onWarningFunction = onWarningFunction;
            }
        }
        /**
           On error result of a file operation.

           @param error Error processing the request.
           @since ARP1.0
        */
        FileListResultCallback.prototype.onError = function (error) {
            if (typeof this.onErrorFunction === 'undefined' || this.onErrorFunction == null) {
                console.warn("WARNING: FileListResultCallback contains a null reference to onErrorFunction.");
            }
            else {
                this.onErrorFunction(error);
            }
        };
        /**
           On correct result of a file operation.

           @param files Array of resulting files/folders.
           @since ARP1.0
        */
        FileListResultCallback.prototype.onResult = function (files) {
            if (typeof this.onResultFunction === 'undefined' || this.onResultFunction == null) {
                console.warn("WARNING: FileListResultCallback contains a null reference to onResultFunction.");
            }
            else {
                this.onResultFunction(files);
            }
        };
        /**
           On partial result of a file operation, containing a warning.

           @param files   Array of resulting files/folders.
           @param warning Warning condition encountered.
           @since ARP1.0
        */
        FileListResultCallback.prototype.onWarning = function (files, warning) {
            if (typeof this.onWarningFunction === 'undefined' || this.onWarningFunction == null) {
                console.warn("WARNING: FileListResultCallback contains a null reference to onWarningFunction.");
            }
            else {
                this.onWarningFunction(files, warning);
            }
        };
        return FileListResultCallback;
    })(BaseCallback);
    Adaptive.FileListResultCallback = FileListResultCallback;
    /**
       FileResultCallback control dictionary.
    */
    Adaptive.registeredFileResultCallback = new Dictionary([]);
    /**
       FileResultCallback global callback handlers.
    */
    function handleFileResultCallbackError(id, error) {
        var callback = Adaptive.registeredFileResultCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredFileResultCallback dictionary.");
        }
        else {
            Adaptive.registeredFileResultCallback.remove("" + id);
            callback.onError(error);
        }
    }
    Adaptive.handleFileResultCallbackError = handleFileResultCallbackError;
    function handleFileResultCallbackResult(id, storageFile) {
        var callback = Adaptive.registeredFileResultCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredFileResultCallback dictionary.");
        }
        else {
            Adaptive.registeredFileResultCallback.remove("" + id);
            callback.onResult(storageFile);
        }
    }
    Adaptive.handleFileResultCallbackResult = handleFileResultCallbackResult;
    function handleFileResultCallbackWarning(id, file, warning) {
        var callback = Adaptive.registeredFileResultCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredFileResultCallback dictionary.");
        }
        else {
            Adaptive.registeredFileResultCallback.remove("" + id);
            callback.onWarning(file, warning);
        }
    }
    Adaptive.handleFileResultCallbackWarning = handleFileResultCallbackWarning;
    var FileResultCallback = (function (_super) {
        __extends(FileResultCallback, _super);
        /**
           Constructor with anonymous handler functions for callback.

           @param onErrorFunction Function receiving parameters of type: IFileResultCallbackError
           @param onResultFunction Function receiving parameters of type: FileDescriptor
           @param onWarningFunction Function receiving parameters of type: FileDescriptor, IFileResultCallbackWarning
        */
        function FileResultCallback(onErrorFunction, onResultFunction, onWarningFunction) {
            _super.call(this, ++Adaptive.registeredCounter);
            if (onErrorFunction == null) {
                console.error("ERROR: FileResultCallback onErrorFunction is not defined.");
            }
            else {
                this.onErrorFunction = onErrorFunction;
            }
            if (onResultFunction == null) {
                console.error("ERROR: FileResultCallback onResultFunction is not defined.");
            }
            else {
                this.onResultFunction = onResultFunction;
            }
            if (onWarningFunction == null) {
                console.error("ERROR: FileResultCallback onWarningFunction is not defined.");
            }
            else {
                this.onWarningFunction = onWarningFunction;
            }
        }
        /**
           On error result of a file operation.

           @param error Error processing the request.
           @since ARP1.0
        */
        FileResultCallback.prototype.onError = function (error) {
            if (typeof this.onErrorFunction === 'undefined' || this.onErrorFunction == null) {
                console.warn("WARNING: FileResultCallback contains a null reference to onErrorFunction.");
            }
            else {
                this.onErrorFunction(error);
            }
        };
        /**
           On correct result of a file operation.

           @param storageFile Reference to the resulting file.
           @since ARP1.0
        */
        FileResultCallback.prototype.onResult = function (storageFile) {
            if (typeof this.onResultFunction === 'undefined' || this.onResultFunction == null) {
                console.warn("WARNING: FileResultCallback contains a null reference to onResultFunction.");
            }
            else {
                this.onResultFunction(storageFile);
            }
        };
        /**
           On partial result of a file operation, containing a warning.

           @param file    Reference to the offending file.
           @param warning Warning processing the request.
           @since ARP1.0
        */
        FileResultCallback.prototype.onWarning = function (file, warning) {
            if (typeof this.onWarningFunction === 'undefined' || this.onWarningFunction == null) {
                console.warn("WARNING: FileResultCallback contains a null reference to onWarningFunction.");
            }
            else {
                this.onWarningFunction(file, warning);
            }
        };
        return FileResultCallback;
    })(BaseCallback);
    Adaptive.FileResultCallback = FileResultCallback;
    /**
       MessagingCallback control dictionary.
    */
    Adaptive.registeredMessagingCallback = new Dictionary([]);
    /**
       MessagingCallback global callback handlers.
    */
    function handleMessagingCallbackError(id, error) {
        var callback = Adaptive.registeredMessagingCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredMessagingCallback dictionary.");
        }
        else {
            Adaptive.registeredMessagingCallback.remove("" + id);
            callback.onError(error);
        }
    }
    Adaptive.handleMessagingCallbackError = handleMessagingCallbackError;
    function handleMessagingCallbackResult(id, success) {
        var callback = Adaptive.registeredMessagingCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredMessagingCallback dictionary.");
        }
        else {
            Adaptive.registeredMessagingCallback.remove("" + id);
            callback.onResult(success);
        }
    }
    Adaptive.handleMessagingCallbackResult = handleMessagingCallbackResult;
    function handleMessagingCallbackWarning(id, success, warning) {
        var callback = Adaptive.registeredMessagingCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredMessagingCallback dictionary.");
        }
        else {
            Adaptive.registeredMessagingCallback.remove("" + id);
            callback.onWarning(success, warning);
        }
    }
    Adaptive.handleMessagingCallbackWarning = handleMessagingCallbackWarning;
    var MessagingCallback = (function (_super) {
        __extends(MessagingCallback, _super);
        /**
           Constructor with anonymous handler functions for callback.

           @param onErrorFunction Function receiving parameters of type: IMessagingCallbackError
           @param onResultFunction Function receiving parameters of type: boolean
           @param onWarningFunction Function receiving parameters of type: boolean, IMessagingCallbackWarning
        */
        function MessagingCallback(onErrorFunction, onResultFunction, onWarningFunction) {
            _super.call(this, ++Adaptive.registeredCounter);
            if (onErrorFunction == null) {
                console.error("ERROR: MessagingCallback onErrorFunction is not defined.");
            }
            else {
                this.onErrorFunction = onErrorFunction;
            }
            if (onResultFunction == null) {
                console.error("ERROR: MessagingCallback onResultFunction is not defined.");
            }
            else {
                this.onResultFunction = onResultFunction;
            }
            if (onWarningFunction == null) {
                console.error("ERROR: MessagingCallback onWarningFunction is not defined.");
            }
            else {
                this.onWarningFunction = onWarningFunction;
            }
        }
        /**
           This method is called on Error

           @param error returned by the platform
           @since ARP1.0
        */
        MessagingCallback.prototype.onError = function (error) {
            if (typeof this.onErrorFunction === 'undefined' || this.onErrorFunction == null) {
                console.warn("WARNING: MessagingCallback contains a null reference to onErrorFunction.");
            }
            else {
                this.onErrorFunction(error);
            }
        };
        /**
           This method is called on Result

           @param success true if sent;false otherwise
           @since ARP1.0
        */
        MessagingCallback.prototype.onResult = function (success) {
            if (typeof this.onResultFunction === 'undefined' || this.onResultFunction == null) {
                console.warn("WARNING: MessagingCallback contains a null reference to onResultFunction.");
            }
            else {
                this.onResultFunction(success);
            }
        };
        /**
           This method is called on Warning

           @param success true if sent;false otherwise
           @param warning returned by the platform
           @since ARP1.0
        */
        MessagingCallback.prototype.onWarning = function (success, warning) {
            if (typeof this.onWarningFunction === 'undefined' || this.onWarningFunction == null) {
                console.warn("WARNING: MessagingCallback contains a null reference to onWarningFunction.");
            }
            else {
                this.onWarningFunction(success, warning);
            }
        };
        return MessagingCallback;
    })(BaseCallback);
    Adaptive.MessagingCallback = MessagingCallback;
    /**
       NetworkReachabilityCallback control dictionary.
    */
    Adaptive.registeredNetworkReachabilityCallback = new Dictionary([]);
    /**
       NetworkReachabilityCallback global callback handlers.
    */
    function handleNetworkReachabilityCallbackError(id, error) {
        var callback = Adaptive.registeredNetworkReachabilityCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredNetworkReachabilityCallback dictionary.");
        }
        else {
            Adaptive.registeredNetworkReachabilityCallback.remove("" + id);
            callback.onError(error);
        }
    }
    Adaptive.handleNetworkReachabilityCallbackError = handleNetworkReachabilityCallbackError;
    function handleNetworkReachabilityCallbackResult(id, reachable) {
        var callback = Adaptive.registeredNetworkReachabilityCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredNetworkReachabilityCallback dictionary.");
        }
        else {
            Adaptive.registeredNetworkReachabilityCallback.remove("" + id);
            callback.onResult(reachable);
        }
    }
    Adaptive.handleNetworkReachabilityCallbackResult = handleNetworkReachabilityCallbackResult;
    function handleNetworkReachabilityCallbackWarning(id, reachable, warning) {
        var callback = Adaptive.registeredNetworkReachabilityCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredNetworkReachabilityCallback dictionary.");
        }
        else {
            Adaptive.registeredNetworkReachabilityCallback.remove("" + id);
            callback.onWarning(reachable, warning);
        }
    }
    Adaptive.handleNetworkReachabilityCallbackWarning = handleNetworkReachabilityCallbackWarning;
    var NetworkReachabilityCallback = (function (_super) {
        __extends(NetworkReachabilityCallback, _super);
        /**
           Constructor with anonymous handler functions for callback.

           @param onErrorFunction Function receiving parameters of type: INetworkReachabilityCallbackError
           @param onResultFunction Function receiving parameters of type: boolean
           @param onWarningFunction Function receiving parameters of type: boolean, INetworkReachabilityCallbackWarning
        */
        function NetworkReachabilityCallback(onErrorFunction, onResultFunction, onWarningFunction) {
            _super.call(this, ++Adaptive.registeredCounter);
            if (onErrorFunction == null) {
                console.error("ERROR: NetworkReachabilityCallback onErrorFunction is not defined.");
            }
            else {
                this.onErrorFunction = onErrorFunction;
            }
            if (onResultFunction == null) {
                console.error("ERROR: NetworkReachabilityCallback onResultFunction is not defined.");
            }
            else {
                this.onResultFunction = onResultFunction;
            }
            if (onWarningFunction == null) {
                console.error("ERROR: NetworkReachabilityCallback onWarningFunction is not defined.");
            }
            else {
                this.onWarningFunction = onWarningFunction;
            }
        }
        /**
           No data received - error condition, not authorized .

           @param error Error value
           @since ARP1.0
        */
        NetworkReachabilityCallback.prototype.onError = function (error) {
            if (typeof this.onErrorFunction === 'undefined' || this.onErrorFunction == null) {
                console.warn("WARNING: NetworkReachabilityCallback contains a null reference to onErrorFunction.");
            }
            else {
                this.onErrorFunction(error);
            }
        };
        /**
           Correct data received.

           @param reachable Indicates if the host is reachable
           @since ARP1.0
        */
        NetworkReachabilityCallback.prototype.onResult = function (reachable) {
            if (typeof this.onResultFunction === 'undefined' || this.onResultFunction == null) {
                console.warn("WARNING: NetworkReachabilityCallback contains a null reference to onResultFunction.");
            }
            else {
                this.onResultFunction(reachable);
            }
        };
        /**
           Data received with warning - ie Found entries with existing key and values have been overriden

           @param reachable Indicates if the host is reachable
           @param warning   Warning value
           @since ARP1.0
        */
        NetworkReachabilityCallback.prototype.onWarning = function (reachable, warning) {
            if (typeof this.onWarningFunction === 'undefined' || this.onWarningFunction == null) {
                console.warn("WARNING: NetworkReachabilityCallback contains a null reference to onWarningFunction.");
            }
            else {
                this.onWarningFunction(reachable, warning);
            }
        };
        return NetworkReachabilityCallback;
    })(BaseCallback);
    Adaptive.NetworkReachabilityCallback = NetworkReachabilityCallback;
    /**
       SecurityResultCallback control dictionary.
    */
    Adaptive.registeredSecurityResultCallback = new Dictionary([]);
    /**
       SecurityResultCallback global callback handlers.
    */
    function handleSecurityResultCallbackError(id, error) {
        var callback = Adaptive.registeredSecurityResultCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredSecurityResultCallback dictionary.");
        }
        else {
            Adaptive.registeredSecurityResultCallback.remove("" + id);
            callback.onError(error);
        }
    }
    Adaptive.handleSecurityResultCallbackError = handleSecurityResultCallbackError;
    function handleSecurityResultCallbackResult(id, keyValues) {
        var callback = Adaptive.registeredSecurityResultCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredSecurityResultCallback dictionary.");
        }
        else {
            Adaptive.registeredSecurityResultCallback.remove("" + id);
            callback.onResult(keyValues);
        }
    }
    Adaptive.handleSecurityResultCallbackResult = handleSecurityResultCallbackResult;
    function handleSecurityResultCallbackWarning(id, keyValues, warning) {
        var callback = Adaptive.registeredSecurityResultCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredSecurityResultCallback dictionary.");
        }
        else {
            Adaptive.registeredSecurityResultCallback.remove("" + id);
            callback.onWarning(keyValues, warning);
        }
    }
    Adaptive.handleSecurityResultCallbackWarning = handleSecurityResultCallbackWarning;
    var SecurityResultCallback = (function (_super) {
        __extends(SecurityResultCallback, _super);
        /**
           Constructor with anonymous handler functions for callback.

           @param onErrorFunction Function receiving parameters of type: ISecurityResultCallbackError
           @param onResultFunction Function receiving parameters of type: Array<SecureKeyPair>
           @param onWarningFunction Function receiving parameters of type: Array<SecureKeyPair>, ISecurityResultCallbackWarning
        */
        function SecurityResultCallback(onErrorFunction, onResultFunction, onWarningFunction) {
            _super.call(this, ++Adaptive.registeredCounter);
            if (onErrorFunction == null) {
                console.error("ERROR: SecurityResultCallback onErrorFunction is not defined.");
            }
            else {
                this.onErrorFunction = onErrorFunction;
            }
            if (onResultFunction == null) {
                console.error("ERROR: SecurityResultCallback onResultFunction is not defined.");
            }
            else {
                this.onResultFunction = onResultFunction;
            }
            if (onWarningFunction == null) {
                console.error("ERROR: SecurityResultCallback onWarningFunction is not defined.");
            }
            else {
                this.onWarningFunction = onWarningFunction;
            }
        }
        /**
           No data received - error condition, not authorized .

           @param error Error values
           @since ARP1.0
        */
        SecurityResultCallback.prototype.onError = function (error) {
            if (typeof this.onErrorFunction === 'undefined' || this.onErrorFunction == null) {
                console.warn("WARNING: SecurityResultCallback contains a null reference to onErrorFunction.");
            }
            else {
                this.onErrorFunction(error);
            }
        };
        /**
           Correct data received.

           @param keyValues key and values
           @since ARP1.0
        */
        SecurityResultCallback.prototype.onResult = function (keyValues) {
            if (typeof this.onResultFunction === 'undefined' || this.onResultFunction == null) {
                console.warn("WARNING: SecurityResultCallback contains a null reference to onResultFunction.");
            }
            else {
                this.onResultFunction(keyValues);
            }
        };
        /**
           Data received with warning - ie Found entries with existing key and values have been overriden

           @param keyValues key and values
           @param warning   Warning values
           @since ARP1.0
        */
        SecurityResultCallback.prototype.onWarning = function (keyValues, warning) {
            if (typeof this.onWarningFunction === 'undefined' || this.onWarningFunction == null) {
                console.warn("WARNING: SecurityResultCallback contains a null reference to onWarningFunction.");
            }
            else {
                this.onWarningFunction(keyValues, warning);
            }
        };
        return SecurityResultCallback;
    })(BaseCallback);
    Adaptive.SecurityResultCallback = SecurityResultCallback;
    /**
       ServiceResultCallback control dictionary.
    */
    Adaptive.registeredServiceResultCallback = new Dictionary([]);
    /**
       ServiceResultCallback global callback handlers.
    */
    function handleServiceResultCallbackError(id, error) {
        var callback = Adaptive.registeredServiceResultCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredServiceResultCallback dictionary.");
        }
        else {
            Adaptive.registeredServiceResultCallback.remove("" + id);
            callback.onError(error);
        }
    }
    Adaptive.handleServiceResultCallbackError = handleServiceResultCallbackError;
    function handleServiceResultCallbackResult(id, response) {
        var callback = Adaptive.registeredServiceResultCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredServiceResultCallback dictionary.");
        }
        else {
            Adaptive.registeredServiceResultCallback.remove("" + id);
            callback.onResult(response);
        }
    }
    Adaptive.handleServiceResultCallbackResult = handleServiceResultCallbackResult;
    function handleServiceResultCallbackWarning(id, response, warning) {
        var callback = Adaptive.registeredServiceResultCallback["" + id];
        if (typeof callback === 'undefined' || callback == null) {
            console.error("ERROR: No callback with id " + id + " registered in registeredServiceResultCallback dictionary.");
        }
        else {
            Adaptive.registeredServiceResultCallback.remove("" + id);
            callback.onWarning(response, warning);
        }
    }
    Adaptive.handleServiceResultCallbackWarning = handleServiceResultCallbackWarning;
    var ServiceResultCallback = (function (_super) {
        __extends(ServiceResultCallback, _super);
        /**
           Constructor with anonymous handler functions for callback.

           @param onErrorFunction Function receiving parameters of type: IServiceResultCallbackError
           @param onResultFunction Function receiving parameters of type: ServiceResponse
           @param onWarningFunction Function receiving parameters of type: ServiceResponse, IServiceResultCallbackWarning
        */
        function ServiceResultCallback(onErrorFunction, onResultFunction, onWarningFunction) {
            _super.call(this, ++Adaptive.registeredCounter);
            if (onErrorFunction == null) {
                console.error("ERROR: ServiceResultCallback onErrorFunction is not defined.");
            }
            else {
                this.onErrorFunction = onErrorFunction;
            }
            if (onResultFunction == null) {
                console.error("ERROR: ServiceResultCallback onResultFunction is not defined.");
            }
            else {
                this.onResultFunction = onResultFunction;
            }
            if (onWarningFunction == null) {
                console.error("ERROR: ServiceResultCallback onWarningFunction is not defined.");
            }
            else {
                this.onWarningFunction = onWarningFunction;
            }
        }
        /**
           This method is called on Error

           @param error returned by the platform
           @since ARP1.0
        */
        ServiceResultCallback.prototype.onError = function (error) {
            if (typeof this.onErrorFunction === 'undefined' || this.onErrorFunction == null) {
                console.warn("WARNING: ServiceResultCallback contains a null reference to onErrorFunction.");
            }
            else {
                this.onErrorFunction(error);
            }
        };
        /**
           This method is called on Result

           @param response data
           @since ARP1.0
        */
        ServiceResultCallback.prototype.onResult = function (response) {
            if (typeof this.onResultFunction === 'undefined' || this.onResultFunction == null) {
                console.warn("WARNING: ServiceResultCallback contains a null reference to onResultFunction.");
            }
            else {
                this.onResultFunction(response);
            }
        };
        /**
           This method is called on Warning

           @param response data
           @param warning  returned by the platform
           @since ARP1.0
        */
        ServiceResultCallback.prototype.onWarning = function (response, warning) {
            if (typeof this.onWarningFunction === 'undefined' || this.onWarningFunction == null) {
                console.warn("WARNING: ServiceResultCallback contains a null reference to onWarningFunction.");
            }
            else {
                this.onWarningFunction(response, warning);
            }
        };
        return ServiceResultCallback;
    })(BaseCallback);
    Adaptive.ServiceResultCallback = ServiceResultCallback;
    /**
       Base application for Application purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var BaseApplicationBridge = (function () {
        /**
           Default constructor.
        */
        function BaseApplicationBridge() {
            this.apiGroup = IAdaptiveRPGroup.Application;
        }
        /**
           Return the API group for the given interface.
        */
        BaseApplicationBridge.prototype.getAPIGroup = function () {
            return this.apiGroup;
        };
        /**
           Return the API version for the given interface.
        */
        BaseApplicationBridge.prototype.getAPIVersion = function () {
            return "v2.0.3";
        };
        return BaseApplicationBridge;
    })();
    Adaptive.BaseApplicationBridge = BaseApplicationBridge;
    /**
       Base application for Commerce purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var BaseCommerceBridge = (function () {
        /**
           Default constructor.
        */
        function BaseCommerceBridge() {
            this.apiGroup = IAdaptiveRPGroup.Commerce;
        }
        /**
           Return the API group for the given interface.
        */
        BaseCommerceBridge.prototype.getAPIGroup = function () {
            return this.apiGroup;
        };
        /**
           Return the API version for the given interface.
        */
        BaseCommerceBridge.prototype.getAPIVersion = function () {
            return "v2.0.3";
        };
        return BaseCommerceBridge;
    })();
    Adaptive.BaseCommerceBridge = BaseCommerceBridge;
    /**
       Base application for Communication purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var BaseCommunicationBridge = (function () {
        /**
           Default constructor.
        */
        function BaseCommunicationBridge() {
            this.apiGroup = IAdaptiveRPGroup.Communication;
        }
        /**
           Return the API group for the given interface.
        */
        BaseCommunicationBridge.prototype.getAPIGroup = function () {
            return this.apiGroup;
        };
        /**
           Return the API version for the given interface.
        */
        BaseCommunicationBridge.prototype.getAPIVersion = function () {
            return "v2.0.3";
        };
        return BaseCommunicationBridge;
    })();
    Adaptive.BaseCommunicationBridge = BaseCommunicationBridge;
    /**
       Base application for Data purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var BaseDataBridge = (function () {
        /**
           Default constructor.
        */
        function BaseDataBridge() {
            this.apiGroup = IAdaptiveRPGroup.Data;
        }
        /**
           Return the API group for the given interface.
        */
        BaseDataBridge.prototype.getAPIGroup = function () {
            return this.apiGroup;
        };
        /**
           Return the API version for the given interface.
        */
        BaseDataBridge.prototype.getAPIVersion = function () {
            return "v2.0.3";
        };
        return BaseDataBridge;
    })();
    Adaptive.BaseDataBridge = BaseDataBridge;
    /**
       Base application for Media purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var BaseMediaBridge = (function () {
        /**
           Default constructor.
        */
        function BaseMediaBridge() {
            this.apiGroup = IAdaptiveRPGroup.Media;
        }
        /**
           Return the API group for the given interface.
        */
        BaseMediaBridge.prototype.getAPIGroup = function () {
            return this.apiGroup;
        };
        /**
           Return the API version for the given interface.
        */
        BaseMediaBridge.prototype.getAPIVersion = function () {
            return "v2.0.3";
        };
        return BaseMediaBridge;
    })();
    Adaptive.BaseMediaBridge = BaseMediaBridge;
    /**
       Base application for Notification purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var BaseNotificationBridge = (function () {
        /**
           Default constructor.
        */
        function BaseNotificationBridge() {
            this.apiGroup = IAdaptiveRPGroup.Notification;
        }
        /**
           Return the API group for the given interface.
        */
        BaseNotificationBridge.prototype.getAPIGroup = function () {
            return this.apiGroup;
        };
        /**
           Return the API version for the given interface.
        */
        BaseNotificationBridge.prototype.getAPIVersion = function () {
            return "v2.0.3";
        };
        return BaseNotificationBridge;
    })();
    Adaptive.BaseNotificationBridge = BaseNotificationBridge;
    /**
       Base application for PIM purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var BasePIMBridge = (function () {
        /**
           Default constructor.
        */
        function BasePIMBridge() {
            this.apiGroup = IAdaptiveRPGroup.PIM;
        }
        /**
           Return the API group for the given interface.
        */
        BasePIMBridge.prototype.getAPIGroup = function () {
            return this.apiGroup;
        };
        /**
           Return the API version for the given interface.
        */
        BasePIMBridge.prototype.getAPIVersion = function () {
            return "v2.0.3";
        };
        return BasePIMBridge;
    })();
    Adaptive.BasePIMBridge = BasePIMBridge;
    /**
       Base application for Reader purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var BaseReaderBridge = (function () {
        /**
           Default constructor.
        */
        function BaseReaderBridge() {
            this.apiGroup = IAdaptiveRPGroup.Reader;
        }
        /**
           Return the API group for the given interface.
        */
        BaseReaderBridge.prototype.getAPIGroup = function () {
            return this.apiGroup;
        };
        /**
           Return the API version for the given interface.
        */
        BaseReaderBridge.prototype.getAPIVersion = function () {
            return "v2.0.3";
        };
        return BaseReaderBridge;
    })();
    Adaptive.BaseReaderBridge = BaseReaderBridge;
    /**
       Base application for Security purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var BaseSecurityBridge = (function () {
        /**
           Default constructor.
        */
        function BaseSecurityBridge() {
            this.apiGroup = IAdaptiveRPGroup.Security;
        }
        /**
           Return the API group for the given interface.
        */
        BaseSecurityBridge.prototype.getAPIGroup = function () {
            return this.apiGroup;
        };
        /**
           Return the API version for the given interface.
        */
        BaseSecurityBridge.prototype.getAPIVersion = function () {
            return "v2.0.3";
        };
        return BaseSecurityBridge;
    })();
    Adaptive.BaseSecurityBridge = BaseSecurityBridge;
    /**
       Base application for Sensor purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var BaseSensorBridge = (function () {
        /**
           Default constructor.
        */
        function BaseSensorBridge() {
            this.apiGroup = IAdaptiveRPGroup.Sensor;
        }
        /**
           Return the API group for the given interface.
        */
        BaseSensorBridge.prototype.getAPIGroup = function () {
            return this.apiGroup;
        };
        /**
           Return the API version for the given interface.
        */
        BaseSensorBridge.prototype.getAPIVersion = function () {
            return "v2.0.3";
        };
        return BaseSensorBridge;
    })();
    Adaptive.BaseSensorBridge = BaseSensorBridge;
    /**
       Base application for Social purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var BaseSocialBridge = (function () {
        /**
           Default constructor.
        */
        function BaseSocialBridge() {
            this.apiGroup = IAdaptiveRPGroup.Social;
        }
        /**
           Return the API group for the given interface.
        */
        BaseSocialBridge.prototype.getAPIGroup = function () {
            return this.apiGroup;
        };
        /**
           Return the API version for the given interface.
        */
        BaseSocialBridge.prototype.getAPIVersion = function () {
            return "v2.0.3";
        };
        return BaseSocialBridge;
    })();
    Adaptive.BaseSocialBridge = BaseSocialBridge;
    /**
       Base application for System purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var BaseSystemBridge = (function () {
        /**
           Default constructor.
        */
        function BaseSystemBridge() {
            this.apiGroup = IAdaptiveRPGroup.System;
        }
        /**
           Return the API group for the given interface.
        */
        BaseSystemBridge.prototype.getAPIGroup = function () {
            return this.apiGroup;
        };
        /**
           Return the API version for the given interface.
        */
        BaseSystemBridge.prototype.getAPIVersion = function () {
            return "v2.0.3";
        };
        return BaseSystemBridge;
    })();
    Adaptive.BaseSystemBridge = BaseSystemBridge;
    /**
       Base application for UI purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var BaseUIBridge = (function () {
        /**
           Default constructor.
        */
        function BaseUIBridge() {
            this.apiGroup = IAdaptiveRPGroup.UI;
        }
        /**
           Return the API group for the given interface.
        */
        BaseUIBridge.prototype.getAPIGroup = function () {
            return this.apiGroup;
        };
        /**
           Return the API version for the given interface.
        */
        BaseUIBridge.prototype.getAPIVersion = function () {
            return "v2.0.3";
        };
        return BaseUIBridge;
    })();
    Adaptive.BaseUIBridge = BaseUIBridge;
    /**
       Base application for Utility purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var BaseUtilBridge = (function () {
        /**
           Default constructor.
        */
        function BaseUtilBridge() {
            this.apiGroup = IAdaptiveRPGroup.Util;
        }
        /**
           Return the API group for the given interface.
        */
        BaseUtilBridge.prototype.getAPIGroup = function () {
            return this.apiGroup;
        };
        /**
           Return the API version for the given interface.
        */
        BaseUtilBridge.prototype.getAPIVersion = function () {
            return "v2.0.3";
        };
        return BaseUtilBridge;
    })();
    Adaptive.BaseUtilBridge = BaseUtilBridge;
    /**
       Interface for Analytics purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var AnalyticsBridge = (function (_super) {
        __extends(AnalyticsBridge, _super);
        /**
           Default constructor.
        */
        function AnalyticsBridge() {
            _super.call(this);
        }
        return AnalyticsBridge;
    })(BaseApplicationBridge);
    /**
       Interface for Managing the Globalization results

       @author Francisco Javier Martin Bueno
       @since ARP1.0
    */
    var GlobalizationBridge = (function (_super) {
        __extends(GlobalizationBridge, _super);
        /**
           Default constructor.
        */
        function GlobalizationBridge() {
            _super.call(this);
        }
        /**
           Returns the default locale of the application defined in the configuration file

           @return Default Locale of the application
           @since ARP1.0
        */
        GlobalizationBridge.prototype.getDefaultLocale = function () {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("IGlobalization", "getDefaultLocale", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = null;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = Locale.toObject(JSON.parse(apiResponse.getResponse()));
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'GlobalizationBridge.getDefaultLocale' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'GlobalizationBridge.getDefaultLocale' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'GlobalizationBridge.getDefaultLocale' request.");
            }
            return response;
        };
        /**
           List of supported locales for the application defined in the configuration file

           @return List of locales
           @since ARP1.0
        */
        GlobalizationBridge.prototype.getLocaleSupportedDescriptors = function () {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("IGlobalization", "getLocaleSupportedDescriptors", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = null;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = new Array();
                        for (var __value__ in JSON.parse(apiResponse.getResponse())) {
                            response.push(Locale.toObject(__value__));
                        }
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'GlobalizationBridge.getLocaleSupportedDescriptors' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'GlobalizationBridge.getLocaleSupportedDescriptors' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'GlobalizationBridge.getLocaleSupportedDescriptors' request.");
            }
            return response;
        };
        /**
           Gets the text/message corresponding to the given key and locale.

           @param key    to match text
           @param locale The locale object to get localized message, or the locale desciptor ("language" or "language-country" two-letters ISO codes.
           @return Localized text.
           @since ARP1.0
        */
        GlobalizationBridge.prototype.getResourceLiteral = function (key, locale) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(key));
            arParams.push(JSON.stringify(locale));
            var apiRequest = new APIRequest("IGlobalization", "getResourceLiteral", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = null;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = apiResponse.getResponse();
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'GlobalizationBridge.getResourceLiteral' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'GlobalizationBridge.getResourceLiteral' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'GlobalizationBridge.getResourceLiteral' request.");
            }
            return response;
        };
        /**
           Gets the full application configured literals (key/message pairs) corresponding to the given locale.

           @param locale The locale object to get localized message, or the locale desciptor ("language" or "language-country" two-letters ISO codes.
           @return Localized texts in the form of an object.
           @since ARP1.0
        */
        GlobalizationBridge.prototype.getResourceLiterals = function (locale) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(locale));
            var apiRequest = new APIRequest("IGlobalization", "getResourceLiterals", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = null;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = new Array();
                        for (var __value__ in JSON.parse(apiResponse.getResponse())) {
                            response.push(KeyPair.toObject(__value__));
                        }
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'GlobalizationBridge.getResourceLiterals' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'GlobalizationBridge.getResourceLiterals' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'GlobalizationBridge.getResourceLiterals' request.");
            }
            return response;
        };
        return GlobalizationBridge;
    })(BaseApplicationBridge);
    /**
       Interface for Managing the Lifecycle listeners

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var LifecycleBridge = (function (_super) {
        __extends(LifecycleBridge, _super);
        /**
           Default constructor.
        */
        function LifecycleBridge() {
            _super.call(this);
        }
        /**
           Add the listener for the lifecycle of the app

           @param listener Lifecycle listener
           @since ARP1.0
        */
        LifecycleBridge.prototype.addLifecycleListener = function (listener) {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("ILifecycle", "addLifecycleListener", arParams, listener.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add listener reference to local dictionary.
            Adaptive.registeredLifecycleListener.add("" + listener.getId(), listener);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove listener reference from local dictionary due to invalid response.
                        Adaptive.registeredLifecycleListener.remove("" + listener.getId());
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'LifecycleBridge.addLifecycleListener' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove listener reference from local dictionary due to invalid response.
                    Adaptive.registeredLifecycleListener.remove("" + listener.getId());
                    console.error("ERROR: 'LifecycleBridge.addLifecycleListener' incorrect response received.");
                }
            }
            else {
                // Remove listener reference from local dictionary due to invalid response.
                Adaptive.registeredLifecycleListener.remove("" + listener.getId());
                console.error("ERROR: " + xhr.status + " sending 'LifecycleBridge.addLifecycleListener' request.");
            }
        };
        /**
           Whether the application is in background or not

           @return true if the application is in background;false otherwise
           @since ARP1.0
        */
        LifecycleBridge.prototype.isBackground = function () {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("ILifecycle", "isBackground", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = false;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = !!apiResponse.getResponse();
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'LifecycleBridge.isBackground' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'LifecycleBridge.isBackground' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'LifecycleBridge.isBackground' request.");
            }
            return response;
        };
        /**
           Un-registers an existing listener from receiving lifecycle events.

           @param listener Lifecycle listener
           @since ARP1.0
        */
        LifecycleBridge.prototype.removeLifecycleListener = function (listener) {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("ILifecycle", "removeLifecycleListener", arParams, listener.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        // Remove listener reference from local dictionary.
                        Adaptive.registeredLifecycleListener.remove("" + listener.getId());
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'LifecycleBridge.removeLifecycleListener' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'LifecycleBridge.removeLifecycleListener' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'LifecycleBridge.removeLifecycleListener' request.");
            }
        };
        /**
           Removes all existing listeners from receiving lifecycle events.

           @since ARP1.0
        */
        LifecycleBridge.prototype.removeLifecycleListeners = function () {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("ILifecycle", "removeLifecycleListeners", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        // Remove all listeners references from local dictionary.
                        var keys = Adaptive.registeredLifecycleListener.keys();
                        for (var key in keys) {
                            Adaptive.registeredLifecycleListener.remove(key);
                        }
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'LifecycleBridge.removeLifecycleListeners' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'LifecycleBridge.removeLifecycleListeners' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'LifecycleBridge.removeLifecycleListeners' request.");
            }
        };
        return LifecycleBridge;
    })(BaseApplicationBridge);
    /**
       Interface for Managing the Management operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var ManagementBridge = (function (_super) {
        __extends(ManagementBridge, _super);
        /**
           Default constructor.
        */
        function ManagementBridge() {
            _super.call(this);
        }
        return ManagementBridge;
    })(BaseApplicationBridge);
    /**
       Interface for Managing the Printing operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var PrintingBridge = (function (_super) {
        __extends(PrintingBridge, _super);
        /**
           Default constructor.
        */
        function PrintingBridge() {
            _super.call(this);
        }
        return PrintingBridge;
    })(BaseApplicationBridge);
    /**
       Interface for Managing the Settings operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var SettingsBridge = (function (_super) {
        __extends(SettingsBridge, _super);
        /**
           Default constructor.
        */
        function SettingsBridge() {
            _super.call(this);
        }
        return SettingsBridge;
    })(BaseApplicationBridge);
    /**
       Interface for Managing the Update operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var UpdateBridge = (function (_super) {
        __extends(UpdateBridge, _super);
        /**
           Default constructor.
        */
        function UpdateBridge() {
            _super.call(this);
        }
        return UpdateBridge;
    })(BaseApplicationBridge);
    /**
       Interface for Advertising purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var AdsBridge = (function (_super) {
        __extends(AdsBridge, _super);
        /**
           Default constructor.
        */
        function AdsBridge() {
            _super.call(this);
        }
        return AdsBridge;
    })(BaseCommerceBridge);
    /**
       Interface for Managing the Store operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var StoreBridge = (function (_super) {
        __extends(StoreBridge, _super);
        /**
           Default constructor.
        */
        function StoreBridge() {
            _super.call(this);
        }
        return StoreBridge;
    })(BaseCommerceBridge);
    /**
       Interface for Managing the Wallet operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var WalletBridge = (function (_super) {
        __extends(WalletBridge, _super);
        /**
           Default constructor.
        */
        function WalletBridge() {
            _super.call(this);
        }
        return WalletBridge;
    })(BaseCommerceBridge);
    /**
       Interface for Bluetooth purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var BluetoothBridge = (function (_super) {
        __extends(BluetoothBridge, _super);
        /**
           Default constructor.
        */
        function BluetoothBridge() {
            _super.call(this);
        }
        return BluetoothBridge;
    })(BaseCommunicationBridge);
    /**
       Interface for Managing the Network information operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var NetworkInfoBridge = (function (_super) {
        __extends(NetworkInfoBridge, _super);
        /**
           Default constructor.
        */
        function NetworkInfoBridge() {
            _super.call(this);
        }
        return NetworkInfoBridge;
    })(BaseCommunicationBridge);
    /**
       Interface for Managing the Network naming operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var NetworkNamingBridge = (function (_super) {
        __extends(NetworkNamingBridge, _super);
        /**
           Default constructor.
        */
        function NetworkNamingBridge() {
            _super.call(this);
        }
        return NetworkNamingBridge;
    })(BaseCommunicationBridge);
    /**
       Interface for Managing the Network reachability operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var NetworkReachabilityBridge = (function (_super) {
        __extends(NetworkReachabilityBridge, _super);
        /**
           Default constructor.
        */
        function NetworkReachabilityBridge() {
            _super.call(this);
        }
        /**
           Whether there is connectivity to a host, via domain name or ip address, or not.

           @param host     domain name or ip address of host.
           @param callback Callback called at the end.
           @since ARP1.0
        */
        NetworkReachabilityBridge.prototype.isNetworkReachable = function (host, callback) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(host));
            var apiRequest = new APIRequest("INetworkReachability", "isNetworkReachable", arParams, callback.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add callback reference to local dictionary.
            Adaptive.registeredNetworkReachabilityCallback.add("" + callback.getId(), callback);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove callback reference from local dictionary due to invalid response.
                        Adaptive.registeredNetworkReachabilityCallback.remove("" + callback.getId());
                        callback.onError(INetworkReachabilityCallbackError.Unknown);
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'NetworkReachabilityBridge.isNetworkReachable' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove callback reference from local dictionary due to invalid response.
                    Adaptive.registeredNetworkReachabilityCallback.remove("" + callback.getId());
                    callback.onError(INetworkReachabilityCallbackError.Unknown);
                    console.error("ERROR: 'NetworkReachabilityBridge.isNetworkReachable' incorrect response received.");
                }
            }
            else {
                // Unknown error - remove from dictionary and notify callback.
                Adaptive.registeredNetworkReachabilityCallback.remove("" + callback.getId());
                callback.onError(INetworkReachabilityCallbackError.Unknown);
                console.error("ERROR: " + xhr.status + " sending 'NetworkReachabilityBridge.isNetworkReachable' request.");
            }
        };
        /**
           Whether there is connectivity to an url of a service or not.

           @param url      to look for
           @param callback Callback called at the end
           @since ARP1.0
        */
        NetworkReachabilityBridge.prototype.isNetworkServiceReachable = function (url, callback) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(url));
            var apiRequest = new APIRequest("INetworkReachability", "isNetworkServiceReachable", arParams, callback.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add callback reference to local dictionary.
            Adaptive.registeredNetworkReachabilityCallback.add("" + callback.getId(), callback);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove callback reference from local dictionary due to invalid response.
                        Adaptive.registeredNetworkReachabilityCallback.remove("" + callback.getId());
                        callback.onError(INetworkReachabilityCallbackError.Unknown);
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'NetworkReachabilityBridge.isNetworkServiceReachable' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove callback reference from local dictionary due to invalid response.
                    Adaptive.registeredNetworkReachabilityCallback.remove("" + callback.getId());
                    callback.onError(INetworkReachabilityCallbackError.Unknown);
                    console.error("ERROR: 'NetworkReachabilityBridge.isNetworkServiceReachable' incorrect response received.");
                }
            }
            else {
                // Unknown error - remove from dictionary and notify callback.
                Adaptive.registeredNetworkReachabilityCallback.remove("" + callback.getId());
                callback.onError(INetworkReachabilityCallbackError.Unknown);
                console.error("ERROR: " + xhr.status + " sending 'NetworkReachabilityBridge.isNetworkServiceReachable' request.");
            }
        };
        return NetworkReachabilityBridge;
    })(BaseCommunicationBridge);
    /**
       Interface for Managing the Network status

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var NetworkStatusBridge = (function (_super) {
        __extends(NetworkStatusBridge, _super);
        /**
           Default constructor.
        */
        function NetworkStatusBridge() {
            _super.call(this);
        }
        /**
           Add the listener for network status changes of the app

           @param listener Listener with the result
           @since ARP1.0
        */
        NetworkStatusBridge.prototype.addNetworkStatusListener = function (listener) {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("INetworkStatus", "addNetworkStatusListener", arParams, listener.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add listener reference to local dictionary.
            Adaptive.registeredNetworkStatusListener.add("" + listener.getId(), listener);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove listener reference from local dictionary due to invalid response.
                        Adaptive.registeredNetworkStatusListener.remove("" + listener.getId());
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'NetworkStatusBridge.addNetworkStatusListener' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove listener reference from local dictionary due to invalid response.
                    Adaptive.registeredNetworkStatusListener.remove("" + listener.getId());
                    console.error("ERROR: 'NetworkStatusBridge.addNetworkStatusListener' incorrect response received.");
                }
            }
            else {
                // Remove listener reference from local dictionary due to invalid response.
                Adaptive.registeredNetworkStatusListener.remove("" + listener.getId());
                console.error("ERROR: " + xhr.status + " sending 'NetworkStatusBridge.addNetworkStatusListener' request.");
            }
        };
        /**
           Un-registers an existing listener from receiving network status events.

           @param listener Listener with the result
           @since ARP1.0
        */
        NetworkStatusBridge.prototype.removeNetworkStatusListener = function (listener) {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("INetworkStatus", "removeNetworkStatusListener", arParams, listener.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        // Remove listener reference from local dictionary.
                        Adaptive.registeredNetworkStatusListener.remove("" + listener.getId());
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'NetworkStatusBridge.removeNetworkStatusListener' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'NetworkStatusBridge.removeNetworkStatusListener' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'NetworkStatusBridge.removeNetworkStatusListener' request.");
            }
        };
        /**
           Removes all existing listeners from receiving network status events.

           @since ARP1.0
        */
        NetworkStatusBridge.prototype.removeNetworkStatusListeners = function () {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("INetworkStatus", "removeNetworkStatusListeners", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        // Remove all listeners references from local dictionary.
                        var keys = Adaptive.registeredNetworkStatusListener.keys();
                        for (var key in keys) {
                            Adaptive.registeredNetworkStatusListener.remove(key);
                        }
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'NetworkStatusBridge.removeNetworkStatusListeners' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'NetworkStatusBridge.removeNetworkStatusListeners' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'NetworkStatusBridge.removeNetworkStatusListeners' request.");
            }
        };
        return NetworkStatusBridge;
    })(BaseCommunicationBridge);
    /**
       Interface for Managing the Services operations

       @author Francisco Javier Martin Bueno
       @since ARP1.0
    */
    var ServiceBridge = (function (_super) {
        __extends(ServiceBridge, _super);
        /**
           Default constructor.
        */
        function ServiceBridge() {
            _super.call(this);
        }
        /**
           Get a reference to a registered service by name.

           @param serviceName Name of service.
           @return A service, if registered, or null of the service does not exist.
           @since ARP1.0
        */
        ServiceBridge.prototype.getService = function (serviceName) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(serviceName));
            var apiRequest = new APIRequest("IService", "getService", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = null;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = Service.toObject(JSON.parse(apiResponse.getResponse()));
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'ServiceBridge.getService' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'ServiceBridge.getService' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'ServiceBridge.getService' request.");
            }
            return response;
        };
        /**
           Request async a service for an Url

           @param serviceRequest Service Request to invoke
           @param service        Service to call
           @param callback       Callback to execute with the result
           @since ARP1.0
        */
        ServiceBridge.prototype.invokeService = function (serviceRequest, service, callback) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(serviceRequest));
            arParams.push(JSON.stringify(service));
            var apiRequest = new APIRequest("IService", "invokeService", arParams, callback.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add callback reference to local dictionary.
            Adaptive.registeredServiceResultCallback.add("" + callback.getId(), callback);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove callback reference from local dictionary due to invalid response.
                        Adaptive.registeredServiceResultCallback.remove("" + callback.getId());
                        callback.onError(IServiceResultCallbackError.Unknown);
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'ServiceBridge.invokeService' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove callback reference from local dictionary due to invalid response.
                    Adaptive.registeredServiceResultCallback.remove("" + callback.getId());
                    callback.onError(IServiceResultCallbackError.Unknown);
                    console.error("ERROR: 'ServiceBridge.invokeService' incorrect response received.");
                }
            }
            else {
                // Unknown error - remove from dictionary and notify callback.
                Adaptive.registeredServiceResultCallback.remove("" + callback.getId());
                callback.onError(IServiceResultCallbackError.Unknown);
                console.error("ERROR: " + xhr.status + " sending 'ServiceBridge.invokeService' request.");
            }
        };
        /**
           Register a new service

           @param service to register
           @since ARP1.0
        */
        ServiceBridge.prototype.registerService = function (service) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(service));
            var apiRequest = new APIRequest("IService", "registerService", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'ServiceBridge.registerService' request.");
            }
        };
        /**
           Unregister a service

           @param service to unregister
           @since ARP1.0
        */
        ServiceBridge.prototype.unregisterService = function (service) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(service));
            var apiRequest = new APIRequest("IService", "unregisterService", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'ServiceBridge.unregisterService' request.");
            }
        };
        /**
           Unregister all services.

           @since ARP1.0
        */
        ServiceBridge.prototype.unregisterServices = function () {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("IService", "unregisterServices", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'ServiceBridge.unregisterServices' request.");
            }
        };
        /**
           Check whether a service by the given service is already registered.

           @param service Service to check
           @return True if the service is registered, false otherwise.
           @since ARP1.0
        */
        ServiceBridge.prototype.isRegistered_service = function (service) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(service));
            var apiRequest = new APIRequest("IService", "isRegistered_service", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = false;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = !!apiResponse.getResponse();
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'ServiceBridge.isRegistered_service' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'ServiceBridge.isRegistered_service' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'ServiceBridge.isRegistered_service' request.");
            }
            return response;
        };
        /**
           Check whether a service by the given name is registered.

           @param serviceName Name of service.
           @return True if the service is registered, false otherwise.
           @since ARP1.0
        */
        ServiceBridge.prototype.isRegistered_serviceName = function (serviceName) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(serviceName));
            var apiRequest = new APIRequest("IService", "isRegistered_serviceName", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = false;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = !!apiResponse.getResponse();
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'ServiceBridge.isRegistered_serviceName' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'ServiceBridge.isRegistered_serviceName' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'ServiceBridge.isRegistered_serviceName' request.");
            }
            return response;
        };
        return ServiceBridge;
    })(BaseCommunicationBridge);
    /**
       Interface for Managing the Socket operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var SocketBridge = (function (_super) {
        __extends(SocketBridge, _super);
        /**
           Default constructor.
        */
        function SocketBridge() {
            _super.call(this);
        }
        return SocketBridge;
    })(BaseCommunicationBridge);
    /**
       Interface for Managing the Telephony operations

       @author Francisco Javier Martin Bueno
       @since ARP1.0
    */
    var TelephonyBridge = (function (_super) {
        __extends(TelephonyBridge, _super);
        /**
           Default constructor.
        */
        function TelephonyBridge() {
            _super.call(this);
        }
        /**
           Invoke a phone call

           @param number to call
           @return Status of the call
           @since ARP1.0
        */
        TelephonyBridge.prototype.call = function (number) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(number));
            var apiRequest = new APIRequest("ITelephony", "call", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = null;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = ITelephonyStatus.toObject(JSON.parse(apiResponse.getResponse()));
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'TelephonyBridge.call' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'TelephonyBridge.call' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'TelephonyBridge.call' request.");
            }
            return response;
        };
        return TelephonyBridge;
    })(BaseCommunicationBridge);
    /**
       Interface for Managing the Cloud operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var CloudBridge = (function (_super) {
        __extends(CloudBridge, _super);
        /**
           Default constructor.
        */
        function CloudBridge() {
            _super.call(this);
        }
        return CloudBridge;
    })(BaseDataBridge);
    /**
       Interface for Managing the DataStream operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var DataStreamBridge = (function (_super) {
        __extends(DataStreamBridge, _super);
        /**
           Default constructor.
        */
        function DataStreamBridge() {
            _super.call(this);
        }
        return DataStreamBridge;
    })(BaseDataBridge);
    /**
       Interface for Managing the Cloud operations

       @author Ferran Vila Conesa
       @since ARP1.0
    */
    var DatabaseBridge = (function (_super) {
        __extends(DatabaseBridge, _super);
        /**
           Default constructor.
        */
        function DatabaseBridge() {
            _super.call(this);
        }
        /**
           Creates a database on default path for every platform.

           @param callback Asynchronous callback
           @param database Database object to create
           @since ARP1.0
        */
        DatabaseBridge.prototype.createDatabase = function (database, callback) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(database));
            var apiRequest = new APIRequest("IDatabase", "createDatabase", arParams, callback.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add callback reference to local dictionary.
            Adaptive.registeredDatabaseResultCallback.add("" + callback.getId(), callback);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove callback reference from local dictionary due to invalid response.
                        Adaptive.registeredDatabaseResultCallback.remove("" + callback.getId());
                        callback.onError(IDatabaseResultCallbackError.Unknown);
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'DatabaseBridge.createDatabase' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove callback reference from local dictionary due to invalid response.
                    Adaptive.registeredDatabaseResultCallback.remove("" + callback.getId());
                    callback.onError(IDatabaseResultCallbackError.Unknown);
                    console.error("ERROR: 'DatabaseBridge.createDatabase' incorrect response received.");
                }
            }
            else {
                // Unknown error - remove from dictionary and notify callback.
                Adaptive.registeredDatabaseResultCallback.remove("" + callback.getId());
                callback.onError(IDatabaseResultCallbackError.Unknown);
                console.error("ERROR: " + xhr.status + " sending 'DatabaseBridge.createDatabase' request.");
            }
        };
        /**
           Creates a databaseTable inside a database for every platform.

           @param database      Database for databaseTable creating.
           @param databaseTable DatabaseTable object with the name of the databaseTable inside.
           @param callback      DatabaseTable callback with the response
           @since ARP1.0
        */
        DatabaseBridge.prototype.createTable = function (database, databaseTable, callback) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(database));
            arParams.push(JSON.stringify(databaseTable));
            var apiRequest = new APIRequest("IDatabase", "createTable", arParams, callback.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add callback reference to local dictionary.
            Adaptive.registeredDatabaseTableResultCallback.add("" + callback.getId(), callback);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove callback reference from local dictionary due to invalid response.
                        Adaptive.registeredDatabaseTableResultCallback.remove("" + callback.getId());
                        callback.onError(IDatabaseTableResultCallbackError.Unknown);
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'DatabaseBridge.createTable' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove callback reference from local dictionary due to invalid response.
                    Adaptive.registeredDatabaseTableResultCallback.remove("" + callback.getId());
                    callback.onError(IDatabaseTableResultCallbackError.Unknown);
                    console.error("ERROR: 'DatabaseBridge.createTable' incorrect response received.");
                }
            }
            else {
                // Unknown error - remove from dictionary and notify callback.
                Adaptive.registeredDatabaseTableResultCallback.remove("" + callback.getId());
                callback.onError(IDatabaseTableResultCallbackError.Unknown);
                console.error("ERROR: " + xhr.status + " sending 'DatabaseBridge.createTable' request.");
            }
        };
        /**
           Deletes a database on default path for every platform.

           @param database Database object to delete
           @param callback Asynchronous callback
           @since ARP1.0
        */
        DatabaseBridge.prototype.deleteDatabase = function (database, callback) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(database));
            var apiRequest = new APIRequest("IDatabase", "deleteDatabase", arParams, callback.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add callback reference to local dictionary.
            Adaptive.registeredDatabaseResultCallback.add("" + callback.getId(), callback);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove callback reference from local dictionary due to invalid response.
                        Adaptive.registeredDatabaseResultCallback.remove("" + callback.getId());
                        callback.onError(IDatabaseResultCallbackError.Unknown);
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'DatabaseBridge.deleteDatabase' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove callback reference from local dictionary due to invalid response.
                    Adaptive.registeredDatabaseResultCallback.remove("" + callback.getId());
                    callback.onError(IDatabaseResultCallbackError.Unknown);
                    console.error("ERROR: 'DatabaseBridge.deleteDatabase' incorrect response received.");
                }
            }
            else {
                // Unknown error - remove from dictionary and notify callback.
                Adaptive.registeredDatabaseResultCallback.remove("" + callback.getId());
                callback.onError(IDatabaseResultCallbackError.Unknown);
                console.error("ERROR: " + xhr.status + " sending 'DatabaseBridge.deleteDatabase' request.");
            }
        };
        /**
           Deletes a databaseTable inside a database for every platform.

           @param database      Database for databaseTable removal.
           @param databaseTable DatabaseTable object with the name of the databaseTable inside.
           @param callback      DatabaseTable callback with the response
           @since ARP1.0
        */
        DatabaseBridge.prototype.deleteTable = function (database, databaseTable, callback) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(database));
            arParams.push(JSON.stringify(databaseTable));
            var apiRequest = new APIRequest("IDatabase", "deleteTable", arParams, callback.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add callback reference to local dictionary.
            Adaptive.registeredDatabaseTableResultCallback.add("" + callback.getId(), callback);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove callback reference from local dictionary due to invalid response.
                        Adaptive.registeredDatabaseTableResultCallback.remove("" + callback.getId());
                        callback.onError(IDatabaseTableResultCallbackError.Unknown);
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'DatabaseBridge.deleteTable' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove callback reference from local dictionary due to invalid response.
                    Adaptive.registeredDatabaseTableResultCallback.remove("" + callback.getId());
                    callback.onError(IDatabaseTableResultCallbackError.Unknown);
                    console.error("ERROR: 'DatabaseBridge.deleteTable' incorrect response received.");
                }
            }
            else {
                // Unknown error - remove from dictionary and notify callback.
                Adaptive.registeredDatabaseTableResultCallback.remove("" + callback.getId());
                callback.onError(IDatabaseTableResultCallbackError.Unknown);
                console.error("ERROR: " + xhr.status + " sending 'DatabaseBridge.deleteTable' request.");
            }
        };
        /**
           Executes SQL statement into the given database. The replacements
should be passed as a parameter

           @param database     The database object reference.
           @param statement    SQL statement.
           @param replacements List of SQL statement replacements.
           @param callback     DatabaseTable callback with the response.
           @since ARP1.0
        */
        DatabaseBridge.prototype.executeSqlStatement = function (database, statement, replacements, callback) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(database));
            arParams.push(JSON.stringify(statement));
            arParams.push(JSON.stringify(replacements));
            var apiRequest = new APIRequest("IDatabase", "executeSqlStatement", arParams, callback.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add callback reference to local dictionary.
            Adaptive.registeredDatabaseTableResultCallback.add("" + callback.getId(), callback);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove callback reference from local dictionary due to invalid response.
                        Adaptive.registeredDatabaseTableResultCallback.remove("" + callback.getId());
                        callback.onError(IDatabaseTableResultCallbackError.Unknown);
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'DatabaseBridge.executeSqlStatement' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove callback reference from local dictionary due to invalid response.
                    Adaptive.registeredDatabaseTableResultCallback.remove("" + callback.getId());
                    callback.onError(IDatabaseTableResultCallbackError.Unknown);
                    console.error("ERROR: 'DatabaseBridge.executeSqlStatement' incorrect response received.");
                }
            }
            else {
                // Unknown error - remove from dictionary and notify callback.
                Adaptive.registeredDatabaseTableResultCallback.remove("" + callback.getId());
                callback.onError(IDatabaseTableResultCallbackError.Unknown);
                console.error("ERROR: " + xhr.status + " sending 'DatabaseBridge.executeSqlStatement' request.");
            }
        };
        /**
           Executes SQL transaction (some statements chain) inside given database.

           @param database     The database object reference.
           @param statements   The statements to be executed during transaction.
           @param rollbackFlag Indicates if rollback should be performed when any
                  statement execution fails.
           @param callback     DatabaseTable callback with the response.
           @since ARP1.0
        */
        DatabaseBridge.prototype.executeSqlTransactions = function (database, statements, rollbackFlag, callback) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(database));
            arParams.push(JSON.stringify(statements));
            arParams.push(JSON.stringify(rollbackFlag));
            var apiRequest = new APIRequest("IDatabase", "executeSqlTransactions", arParams, callback.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add callback reference to local dictionary.
            Adaptive.registeredDatabaseTableResultCallback.add("" + callback.getId(), callback);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove callback reference from local dictionary due to invalid response.
                        Adaptive.registeredDatabaseTableResultCallback.remove("" + callback.getId());
                        callback.onError(IDatabaseTableResultCallbackError.Unknown);
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'DatabaseBridge.executeSqlTransactions' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove callback reference from local dictionary due to invalid response.
                    Adaptive.registeredDatabaseTableResultCallback.remove("" + callback.getId());
                    callback.onError(IDatabaseTableResultCallbackError.Unknown);
                    console.error("ERROR: 'DatabaseBridge.executeSqlTransactions' incorrect response received.");
                }
            }
            else {
                // Unknown error - remove from dictionary and notify callback.
                Adaptive.registeredDatabaseTableResultCallback.remove("" + callback.getId());
                callback.onError(IDatabaseTableResultCallbackError.Unknown);
                console.error("ERROR: " + xhr.status + " sending 'DatabaseBridge.executeSqlTransactions' request.");
            }
        };
        /**
           Checks if database exists by given database name.

           @param database Database Object to check if exists
           @return True if exists, false otherwise
           @since ARP1.0
        */
        DatabaseBridge.prototype.existsDatabase = function (database) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(database));
            var apiRequest = new APIRequest("IDatabase", "existsDatabase", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = false;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = !!apiResponse.getResponse();
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'DatabaseBridge.existsDatabase' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'DatabaseBridge.existsDatabase' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'DatabaseBridge.existsDatabase' request.");
            }
            return response;
        };
        /**
           Checks if databaseTable exists by given database name.

           @param database      Database for databaseTable consulting.
           @param databaseTable DatabaseTable object with the name of the databaseTable inside.
           @return True if exists, false otherwise
           @since ARP1.0
        */
        DatabaseBridge.prototype.existsTable = function (database, databaseTable) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(database));
            arParams.push(JSON.stringify(databaseTable));
            var apiRequest = new APIRequest("IDatabase", "existsTable", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = false;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = !!apiResponse.getResponse();
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'DatabaseBridge.existsTable' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'DatabaseBridge.existsTable' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'DatabaseBridge.existsTable' request.");
            }
            return response;
        };
        return DatabaseBridge;
    })(BaseDataBridge);
    /**
       Interface for Managing the File operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var FileBridge = (function (_super) {
        __extends(FileBridge, _super);
        /**
           Default constructor.
        */
        function FileBridge() {
            _super.call(this);
        }
        /**
           Determine whether the current file/folder can be read from.

           @param descriptor File descriptor of file or folder used for operation.
           @return True if the folder/file is readable, false otherwise.
           @since ARP1.0
        */
        FileBridge.prototype.canRead = function (descriptor) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(descriptor));
            var apiRequest = new APIRequest("IFile", "canRead", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = false;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = !!apiResponse.getResponse();
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'FileBridge.canRead' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'FileBridge.canRead' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'FileBridge.canRead' request.");
            }
            return response;
        };
        /**
           Determine whether the current file/folder can be written to.

           @param descriptor File descriptor of file or folder used for operation.
           @return True if the folder/file is writable, false otherwise.
           @since ARP1.0
        */
        FileBridge.prototype.canWrite = function (descriptor) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(descriptor));
            var apiRequest = new APIRequest("IFile", "canWrite", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = false;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = !!apiResponse.getResponse();
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'FileBridge.canWrite' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'FileBridge.canWrite' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'FileBridge.canWrite' request.");
            }
            return response;
        };
        /**
           Creates a file with the specified name.

           @param descriptor File descriptor of file or folder used for operation.
           @param callback   Result of the operation.
           @since ARP1.0
        */
        FileBridge.prototype.create = function (descriptor, callback) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(descriptor));
            var apiRequest = new APIRequest("IFile", "create", arParams, callback.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add callback reference to local dictionary.
            Adaptive.registeredFileResultCallback.add("" + callback.getId(), callback);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove callback reference from local dictionary due to invalid response.
                        Adaptive.registeredFileResultCallback.remove("" + callback.getId());
                        callback.onError(IFileResultCallbackError.Unknown);
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'FileBridge.create' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove callback reference from local dictionary due to invalid response.
                    Adaptive.registeredFileResultCallback.remove("" + callback.getId());
                    callback.onError(IFileResultCallbackError.Unknown);
                    console.error("ERROR: 'FileBridge.create' incorrect response received.");
                }
            }
            else {
                // Unknown error - remove from dictionary and notify callback.
                Adaptive.registeredFileResultCallback.remove("" + callback.getId());
                callback.onError(IFileResultCallbackError.Unknown);
                console.error("ERROR: " + xhr.status + " sending 'FileBridge.create' request.");
            }
        };
        /**
           Deletes the given file or path. If the file is a directory and contains files and or subdirectories, these will be
deleted if the cascade parameter is set to true.

           @param descriptor File descriptor of file or folder used for operation.
           @param cascade    Whether to delete sub-files and sub-folders.
           @return True if files (and sub-files and folders) whether deleted.
           @since ARP1.0
        */
        FileBridge.prototype.delete = function (descriptor, cascade) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(descriptor));
            arParams.push(JSON.stringify(cascade));
            var apiRequest = new APIRequest("IFile", "delete", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = false;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = !!apiResponse.getResponse();
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'FileBridge.delete' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'FileBridge.delete' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'FileBridge.delete' request.");
            }
            return response;
        };
        /**
           Check whether the file/path exists.

           @param descriptor File descriptor of file or folder used for operation.
           @return True if the file exists in the filesystem, false otherwise.
           @since ARP1.0
        */
        FileBridge.prototype.exists = function (descriptor) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(descriptor));
            var apiRequest = new APIRequest("IFile", "exists", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = false;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = !!apiResponse.getResponse();
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'FileBridge.exists' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'FileBridge.exists' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'FileBridge.exists' request.");
            }
            return response;
        };
        /**
           Loads the content of the file.

           @param descriptor File descriptor of file or folder used for operation.
           @param callback   Result of the operation.
           @since ARP1.0
        */
        FileBridge.prototype.getContent = function (descriptor, callback) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(descriptor));
            var apiRequest = new APIRequest("IFile", "getContent", arParams, callback.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add callback reference to local dictionary.
            Adaptive.registeredFileDataLoadResultCallback.add("" + callback.getId(), callback);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove callback reference from local dictionary due to invalid response.
                        Adaptive.registeredFileDataLoadResultCallback.remove("" + callback.getId());
                        callback.onError(IFileDataLoadResultCallbackError.Unknown);
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'FileBridge.getContent' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove callback reference from local dictionary due to invalid response.
                    Adaptive.registeredFileDataLoadResultCallback.remove("" + callback.getId());
                    callback.onError(IFileDataLoadResultCallbackError.Unknown);
                    console.error("ERROR: 'FileBridge.getContent' incorrect response received.");
                }
            }
            else {
                // Unknown error - remove from dictionary and notify callback.
                Adaptive.registeredFileDataLoadResultCallback.remove("" + callback.getId());
                callback.onError(IFileDataLoadResultCallbackError.Unknown);
                console.error("ERROR: " + xhr.status + " sending 'FileBridge.getContent' request.");
            }
        };
        /**
           Returns the file storage type of the file

           @param descriptor File descriptor of file or folder used for operation.
           @return Storage Type file
           @since ARP1.0
        */
        FileBridge.prototype.getFileStorageType = function (descriptor) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(descriptor));
            var apiRequest = new APIRequest("IFile", "getFileStorageType", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = null;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = IFileSystemStorageType.toObject(JSON.parse(apiResponse.getResponse()));
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'FileBridge.getFileStorageType' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'FileBridge.getFileStorageType' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'FileBridge.getFileStorageType' request.");
            }
            return response;
        };
        /**
           Returns the file type

           @param descriptor File descriptor of file or folder used for operation.
           @return Returns the file type of the file
           @since ARP1.0
        */
        FileBridge.prototype.getFileType = function (descriptor) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(descriptor));
            var apiRequest = new APIRequest("IFile", "getFileType", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = null;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = IFileSystemType.toObject(JSON.parse(apiResponse.getResponse()));
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'FileBridge.getFileType' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'FileBridge.getFileType' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'FileBridge.getFileType' request.");
            }
            return response;
        };
        /**
           Returns the security type of the file

           @param descriptor File descriptor of file or folder used for operation.
           @return Security Level of the file
           @since ARP1.0
        */
        FileBridge.prototype.getSecurityType = function (descriptor) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(descriptor));
            var apiRequest = new APIRequest("IFile", "getSecurityType", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = null;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = IFileSystemSecurity.toObject(JSON.parse(apiResponse.getResponse()));
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'FileBridge.getSecurityType' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'FileBridge.getSecurityType' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'FileBridge.getSecurityType' request.");
            }
            return response;
        };
        /**
           Check whether this is a path of a file.

           @param descriptor File descriptor of file or folder used for operation.
           @return true if this is a path to a folder/directory, false if this is a path to a file.
           @since ARP1.0
        */
        FileBridge.prototype.isDirectory = function (descriptor) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(descriptor));
            var apiRequest = new APIRequest("IFile", "isDirectory", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = false;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = !!apiResponse.getResponse();
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'FileBridge.isDirectory' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'FileBridge.isDirectory' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'FileBridge.isDirectory' request.");
            }
            return response;
        };
        /**
           List all the files contained within this file/path reference. If the reference is a file, it will not yield
any results.

           @param descriptor File descriptor of file or folder used for operation.
           @param callback   Result of operation.
           @since ARP1.0
        */
        FileBridge.prototype.listFiles = function (descriptor, callback) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(descriptor));
            var apiRequest = new APIRequest("IFile", "listFiles", arParams, callback.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add callback reference to local dictionary.
            Adaptive.registeredFileListResultCallback.add("" + callback.getId(), callback);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove callback reference from local dictionary due to invalid response.
                        Adaptive.registeredFileListResultCallback.remove("" + callback.getId());
                        callback.onError(IFileListResultCallbackError.Unknown);
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'FileBridge.listFiles' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove callback reference from local dictionary due to invalid response.
                    Adaptive.registeredFileListResultCallback.remove("" + callback.getId());
                    callback.onError(IFileListResultCallbackError.Unknown);
                    console.error("ERROR: 'FileBridge.listFiles' incorrect response received.");
                }
            }
            else {
                // Unknown error - remove from dictionary and notify callback.
                Adaptive.registeredFileListResultCallback.remove("" + callback.getId());
                callback.onError(IFileListResultCallbackError.Unknown);
                console.error("ERROR: " + xhr.status + " sending 'FileBridge.listFiles' request.");
            }
        };
        /**
           List all the files matching the speficied regex filter within this file/path reference. If the reference
is a file, it will not yield any results.

           @param descriptor File descriptor of file or folder used for operation.
           @param regex      Filter (eg. *.jpg, *.png, Fil*) name string.
           @param callback   Result of operation.
           @since ARP1.0
        */
        FileBridge.prototype.listFilesForRegex = function (descriptor, regex, callback) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(descriptor));
            arParams.push(JSON.stringify(regex));
            var apiRequest = new APIRequest("IFile", "listFilesForRegex", arParams, callback.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add callback reference to local dictionary.
            Adaptive.registeredFileListResultCallback.add("" + callback.getId(), callback);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove callback reference from local dictionary due to invalid response.
                        Adaptive.registeredFileListResultCallback.remove("" + callback.getId());
                        callback.onError(IFileListResultCallbackError.Unknown);
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'FileBridge.listFilesForRegex' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove callback reference from local dictionary due to invalid response.
                    Adaptive.registeredFileListResultCallback.remove("" + callback.getId());
                    callback.onError(IFileListResultCallbackError.Unknown);
                    console.error("ERROR: 'FileBridge.listFilesForRegex' incorrect response received.");
                }
            }
            else {
                // Unknown error - remove from dictionary and notify callback.
                Adaptive.registeredFileListResultCallback.remove("" + callback.getId());
                callback.onError(IFileListResultCallbackError.Unknown);
                console.error("ERROR: " + xhr.status + " sending 'FileBridge.listFilesForRegex' request.");
            }
        };
        /**
           Creates the parent path (or paths, if recursive) to the given file/path if it doesn't already exist.

           @param descriptor File descriptor of file or folder used for operation.
           @param recursive  Whether to create all parent path elements.
           @return True if the path was created, false otherwise (or it exists already).
           @since ARP1.0
        */
        FileBridge.prototype.mkDir = function (descriptor, recursive) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(descriptor));
            arParams.push(JSON.stringify(recursive));
            var apiRequest = new APIRequest("IFile", "mkDir", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = false;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = !!apiResponse.getResponse();
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'FileBridge.mkDir' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'FileBridge.mkDir' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'FileBridge.mkDir' request.");
            }
            return response;
        };
        /**
           Moves the current file to the given file destination, optionally overwriting and creating the path to the
new destination file.

           @param source      File descriptor of file or folder used for operation as source.
           @param destination File descriptor of file or folder used for operation as destination.
           @param createPath  True to create the path if it does not already exist.
           @param callback    Result of the operation.
           @param overwrite   True to create the path if it does not already exist.
           @since ARP1.0
        */
        FileBridge.prototype.move = function (source, destination, createPath, overwrite, callback) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(source));
            arParams.push(JSON.stringify(destination));
            arParams.push(JSON.stringify(createPath));
            arParams.push(JSON.stringify(overwrite));
            var apiRequest = new APIRequest("IFile", "move", arParams, callback.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add callback reference to local dictionary.
            Adaptive.registeredFileResultCallback.add("" + callback.getId(), callback);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove callback reference from local dictionary due to invalid response.
                        Adaptive.registeredFileResultCallback.remove("" + callback.getId());
                        callback.onError(IFileResultCallbackError.Unknown);
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'FileBridge.move' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove callback reference from local dictionary due to invalid response.
                    Adaptive.registeredFileResultCallback.remove("" + callback.getId());
                    callback.onError(IFileResultCallbackError.Unknown);
                    console.error("ERROR: 'FileBridge.move' incorrect response received.");
                }
            }
            else {
                // Unknown error - remove from dictionary and notify callback.
                Adaptive.registeredFileResultCallback.remove("" + callback.getId());
                callback.onError(IFileResultCallbackError.Unknown);
                console.error("ERROR: " + xhr.status + " sending 'FileBridge.move' request.");
            }
        };
        /**
           Sets the content of the file.

           @param descriptor File descriptor of file or folder used for operation.
           @param content    Binary content to store in the file.
           @param callback   Result of the operation.
           @since ARP1.0
        */
        FileBridge.prototype.setContent = function (descriptor, content, callback) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(descriptor));
            arParams.push(JSON.stringify(content));
            var apiRequest = new APIRequest("IFile", "setContent", arParams, callback.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add callback reference to local dictionary.
            Adaptive.registeredFileDataStoreResultCallback.add("" + callback.getId(), callback);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove callback reference from local dictionary due to invalid response.
                        Adaptive.registeredFileDataStoreResultCallback.remove("" + callback.getId());
                        callback.onError(IFileDataStoreResultCallbackError.Unknown);
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'FileBridge.setContent' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove callback reference from local dictionary due to invalid response.
                    Adaptive.registeredFileDataStoreResultCallback.remove("" + callback.getId());
                    callback.onError(IFileDataStoreResultCallbackError.Unknown);
                    console.error("ERROR: 'FileBridge.setContent' incorrect response received.");
                }
            }
            else {
                // Unknown error - remove from dictionary and notify callback.
                Adaptive.registeredFileDataStoreResultCallback.remove("" + callback.getId());
                callback.onError(IFileDataStoreResultCallbackError.Unknown);
                console.error("ERROR: " + xhr.status + " sending 'FileBridge.setContent' request.");
            }
        };
        return FileBridge;
    })(BaseDataBridge);
    /**
       Interface for Managing the File System operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var FileSystemBridge = (function (_super) {
        __extends(FileSystemBridge, _super);
        /**
           Default constructor.
        */
        function FileSystemBridge() {
            _super.call(this);
        }
        /**
           Creates a new reference to a new or existing location in the filesystem.
This method does not create the actual file in the specified folder.

           @param parent Parent directory.
           @param name   Name of new file or directory.
           @return A reference to a new or existing location in the filesystem.
           @since ARP1.0
        */
        FileSystemBridge.prototype.createFileDescriptor = function (parent, name) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(parent));
            arParams.push(JSON.stringify(name));
            var apiRequest = new APIRequest("IFileSystem", "createFileDescriptor", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = null;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = FileDescriptor.toObject(JSON.parse(apiResponse.getResponse()));
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'FileSystemBridge.createFileDescriptor' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'FileSystemBridge.createFileDescriptor' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'FileSystemBridge.createFileDescriptor' request.");
            }
            return response;
        };
        /**
           Returns a reference to the cache folder for the current application.
This path must always be writable by the current application.
This path is volatile and may be cleaned by the OS periodically.

           @return Path to the application's cache folder.
           @since ARP1.0
        */
        FileSystemBridge.prototype.getApplicationCacheFolder = function () {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("IFileSystem", "getApplicationCacheFolder", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = null;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = FileDescriptor.toObject(JSON.parse(apiResponse.getResponse()));
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'FileSystemBridge.getApplicationCacheFolder' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'FileSystemBridge.getApplicationCacheFolder' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'FileSystemBridge.getApplicationCacheFolder' request.");
            }
            return response;
        };
        /**
           Returns a reference to the cloud synchronizable folder for the current application.
This path must always be writable by the current application.

           @return Path to the application's cloud storage folder.
           @since ARP1.0
        */
        FileSystemBridge.prototype.getApplicationCloudFolder = function () {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("IFileSystem", "getApplicationCloudFolder", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = null;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = FileDescriptor.toObject(JSON.parse(apiResponse.getResponse()));
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'FileSystemBridge.getApplicationCloudFolder' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'FileSystemBridge.getApplicationCloudFolder' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'FileSystemBridge.getApplicationCloudFolder' request.");
            }
            return response;
        };
        /**
           Returns a reference to the documents folder for the current application.
This path must always be writable by the current application.

           @return Path to the application's documents folder.
           @since ARP1.0
        */
        FileSystemBridge.prototype.getApplicationDocumentsFolder = function () {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("IFileSystem", "getApplicationDocumentsFolder", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = null;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = FileDescriptor.toObject(JSON.parse(apiResponse.getResponse()));
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'FileSystemBridge.getApplicationDocumentsFolder' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'FileSystemBridge.getApplicationDocumentsFolder' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'FileSystemBridge.getApplicationDocumentsFolder' request.");
            }
            return response;
        };
        /**
           Returns a reference to the application installation folder.
This path may or may not be directly readable or writable - it usually contains the app binary and data.

           @return Path to the application folder.
           @since ARP1.0
        */
        FileSystemBridge.prototype.getApplicationFolder = function () {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("IFileSystem", "getApplicationFolder", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = null;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = FileDescriptor.toObject(JSON.parse(apiResponse.getResponse()));
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'FileSystemBridge.getApplicationFolder' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'FileSystemBridge.getApplicationFolder' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'FileSystemBridge.getApplicationFolder' request.");
            }
            return response;
        };
        /**
           Returns a reference to the protected storage folder for the current application.
This path must always be writable by the current application.

           @return Path to the application's protected storage folder.
           @since ARP1.0
        */
        FileSystemBridge.prototype.getApplicationProtectedFolder = function () {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("IFileSystem", "getApplicationProtectedFolder", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = null;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = FileDescriptor.toObject(JSON.parse(apiResponse.getResponse()));
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'FileSystemBridge.getApplicationProtectedFolder' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'FileSystemBridge.getApplicationProtectedFolder' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'FileSystemBridge.getApplicationProtectedFolder' request.");
            }
            return response;
        };
        /**
           Returns the file system dependent file separator.

           @return char with the directory/file separator.
           @since ARP1.0
        */
        FileSystemBridge.prototype.getSeparator = function () {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("IFileSystem", "getSeparator", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = null;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = apiResponse.getResponse();
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'FileSystemBridge.getSeparator' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'FileSystemBridge.getSeparator' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'FileSystemBridge.getSeparator' request.");
            }
            return response;
        };
        /**
           Returns a reference to the external storage folder provided by the OS. This may
be an external SSD card or similar. This type of storage is removable and by
definition, not secure.
This path may or may not be writable by the current application.

           @return Path to the application's documents folder.
           @since ARP1.0
        */
        FileSystemBridge.prototype.getSystemExternalFolder = function () {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("IFileSystem", "getSystemExternalFolder", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = null;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = FileDescriptor.toObject(JSON.parse(apiResponse.getResponse()));
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'FileSystemBridge.getSystemExternalFolder' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'FileSystemBridge.getSystemExternalFolder' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'FileSystemBridge.getSystemExternalFolder' request.");
            }
            return response;
        };
        return FileSystemBridge;
    })(BaseDataBridge);
    /**
       Interface for Managing the Internal Storage operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var InternalStorageBridge = (function (_super) {
        __extends(InternalStorageBridge, _super);
        /**
           Default constructor.
        */
        function InternalStorageBridge() {
            _super.call(this);
        }
        return InternalStorageBridge;
    })(BaseDataBridge);
    /**
       Interface for Managing the XML operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var XMLBridge = (function (_super) {
        __extends(XMLBridge, _super);
        /**
           Default constructor.
        */
        function XMLBridge() {
            _super.call(this);
        }
        return XMLBridge;
    })(BaseDataBridge);
    /**
       Interface for Audio purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var AudioBridge = (function (_super) {
        __extends(AudioBridge, _super);
        /**
           Default constructor.
        */
        function AudioBridge() {
            _super.call(this);
        }
        return AudioBridge;
    })(BaseMediaBridge);
    /**
       Interface for Managing the camera operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var CameraBridge = (function (_super) {
        __extends(CameraBridge, _super);
        /**
           Default constructor.
        */
        function CameraBridge() {
            _super.call(this);
        }
        return CameraBridge;
    })(BaseMediaBridge);
    /**
       Interface for Managing the Imaging operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var ImagingBridge = (function (_super) {
        __extends(ImagingBridge, _super);
        /**
           Default constructor.
        */
        function ImagingBridge() {
            _super.call(this);
        }
        return ImagingBridge;
    })(BaseMediaBridge);
    /**
       Interface for Managing the Video operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var VideoBridge = (function (_super) {
        __extends(VideoBridge, _super);
        /**
           Default constructor.
        */
        function VideoBridge() {
            _super.call(this);
        }
        /**
           Play url video stream

           @param url of the video
           @since ARP1.0
        */
        VideoBridge.prototype.playStream = function (url) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(url));
            var apiRequest = new APIRequest("IVideo", "playStream", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'VideoBridge.playStream' request.");
            }
        };
        return VideoBridge;
    })(BaseMediaBridge);
    /**
       Interface for Alarm purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var AlarmBridge = (function (_super) {
        __extends(AlarmBridge, _super);
        /**
           Default constructor.
        */
        function AlarmBridge() {
            _super.call(this);
        }
        return AlarmBridge;
    })(BaseNotificationBridge);
    /**
       Interface for Managing the Notification operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var NotificationBridge = (function (_super) {
        __extends(NotificationBridge, _super);
        /**
           Default constructor.
        */
        function NotificationBridge() {
            _super.call(this);
        }
        return NotificationBridge;
    })(BaseNotificationBridge);
    /**
       Interface for Managing the Local Notifications operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var NotificationLocalBridge = (function (_super) {
        __extends(NotificationLocalBridge, _super);
        /**
           Default constructor.
        */
        function NotificationLocalBridge() {
            _super.call(this);
        }
        return NotificationLocalBridge;
    })(BaseNotificationBridge);
    /**
       Interface for Managing the Vibration operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var VibrationBridge = (function (_super) {
        __extends(VibrationBridge, _super);
        /**
           Default constructor.
        */
        function VibrationBridge() {
            _super.call(this);
        }
        return VibrationBridge;
    })(BaseNotificationBridge);
    /**
       Interface for Managing the Calendar operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var CalendarBridge = (function (_super) {
        __extends(CalendarBridge, _super);
        /**
           Default constructor.
        */
        function CalendarBridge() {
            _super.call(this);
        }
        return CalendarBridge;
    })(BasePIMBridge);
    /**
       Interface for Managing the Contact operations

       @author Francisco Javier Martin Bueno
       @since ARP1.0
    */
    var ContactBridge = (function (_super) {
        __extends(ContactBridge, _super);
        /**
           Default constructor.
        */
        function ContactBridge() {
            _super.call(this);
        }
        /**
           Get all the details of a contact according to its id

           @param contact  id to search for
           @param callback called for return
           @since ARP1.0
        */
        ContactBridge.prototype.getContact = function (contact, callback) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(contact));
            var apiRequest = new APIRequest("IContact", "getContact", arParams, callback.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add callback reference to local dictionary.
            Adaptive.registeredContactResultCallback.add("" + callback.getId(), callback);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove callback reference from local dictionary due to invalid response.
                        Adaptive.registeredContactResultCallback.remove("" + callback.getId());
                        callback.onError(IContactResultCallbackError.Unknown);
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'ContactBridge.getContact' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove callback reference from local dictionary due to invalid response.
                    Adaptive.registeredContactResultCallback.remove("" + callback.getId());
                    callback.onError(IContactResultCallbackError.Unknown);
                    console.error("ERROR: 'ContactBridge.getContact' incorrect response received.");
                }
            }
            else {
                // Unknown error - remove from dictionary and notify callback.
                Adaptive.registeredContactResultCallback.remove("" + callback.getId());
                callback.onError(IContactResultCallbackError.Unknown);
                console.error("ERROR: " + xhr.status + " sending 'ContactBridge.getContact' request.");
            }
        };
        /**
           Get the contact photo

           @param contact  id to search for
           @param callback called for return
           @since ARP1.0
        */
        ContactBridge.prototype.getContactPhoto = function (contact, callback) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(contact));
            var apiRequest = new APIRequest("IContact", "getContactPhoto", arParams, callback.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add callback reference to local dictionary.
            Adaptive.registeredContactPhotoResultCallback.add("" + callback.getId(), callback);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove callback reference from local dictionary due to invalid response.
                        Adaptive.registeredContactPhotoResultCallback.remove("" + callback.getId());
                        callback.onError(IContactPhotoResultCallbackError.Unknown);
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'ContactBridge.getContactPhoto' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove callback reference from local dictionary due to invalid response.
                    Adaptive.registeredContactPhotoResultCallback.remove("" + callback.getId());
                    callback.onError(IContactPhotoResultCallbackError.Unknown);
                    console.error("ERROR: 'ContactBridge.getContactPhoto' incorrect response received.");
                }
            }
            else {
                // Unknown error - remove from dictionary and notify callback.
                Adaptive.registeredContactPhotoResultCallback.remove("" + callback.getId());
                callback.onError(IContactPhotoResultCallbackError.Unknown);
                console.error("ERROR: " + xhr.status + " sending 'ContactBridge.getContactPhoto' request.");
            }
        };
        /**
           Get all contacts

           @param callback called for return
           @since ARP1.0
        */
        ContactBridge.prototype.getContacts = function (callback) {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("IContact", "getContacts", arParams, callback.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add callback reference to local dictionary.
            Adaptive.registeredContactResultCallback.add("" + callback.getId(), callback);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove callback reference from local dictionary due to invalid response.
                        Adaptive.registeredContactResultCallback.remove("" + callback.getId());
                        callback.onError(IContactResultCallbackError.Unknown);
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'ContactBridge.getContacts' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove callback reference from local dictionary due to invalid response.
                    Adaptive.registeredContactResultCallback.remove("" + callback.getId());
                    callback.onError(IContactResultCallbackError.Unknown);
                    console.error("ERROR: 'ContactBridge.getContacts' incorrect response received.");
                }
            }
            else {
                // Unknown error - remove from dictionary and notify callback.
                Adaptive.registeredContactResultCallback.remove("" + callback.getId());
                callback.onError(IContactResultCallbackError.Unknown);
                console.error("ERROR: " + xhr.status + " sending 'ContactBridge.getContacts' request.");
            }
        };
        /**
           Get marked fields of all contacts

           @param callback called for return
           @param fields   to get for each Contact
           @since ARP1.0
        */
        ContactBridge.prototype.getContactsForFields = function (callback, fields) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(fields));
            var apiRequest = new APIRequest("IContact", "getContactsForFields", arParams, callback.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add callback reference to local dictionary.
            Adaptive.registeredContactResultCallback.add("" + callback.getId(), callback);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove callback reference from local dictionary due to invalid response.
                        Adaptive.registeredContactResultCallback.remove("" + callback.getId());
                        callback.onError(IContactResultCallbackError.Unknown);
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'ContactBridge.getContactsForFields' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove callback reference from local dictionary due to invalid response.
                    Adaptive.registeredContactResultCallback.remove("" + callback.getId());
                    callback.onError(IContactResultCallbackError.Unknown);
                    console.error("ERROR: 'ContactBridge.getContactsForFields' incorrect response received.");
                }
            }
            else {
                // Unknown error - remove from dictionary and notify callback.
                Adaptive.registeredContactResultCallback.remove("" + callback.getId());
                callback.onError(IContactResultCallbackError.Unknown);
                console.error("ERROR: " + xhr.status + " sending 'ContactBridge.getContactsForFields' request.");
            }
        };
        /**
           Get marked fields of all contacts according to a filter

           @param callback called for return
           @param fields   to get for each Contact
           @param filter   to search for
           @since ARP1.0
        */
        ContactBridge.prototype.getContactsWithFilter = function (callback, fields, filter) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(fields));
            arParams.push(JSON.stringify(filter));
            var apiRequest = new APIRequest("IContact", "getContactsWithFilter", arParams, callback.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add callback reference to local dictionary.
            Adaptive.registeredContactResultCallback.add("" + callback.getId(), callback);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove callback reference from local dictionary due to invalid response.
                        Adaptive.registeredContactResultCallback.remove("" + callback.getId());
                        callback.onError(IContactResultCallbackError.Unknown);
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'ContactBridge.getContactsWithFilter' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove callback reference from local dictionary due to invalid response.
                    Adaptive.registeredContactResultCallback.remove("" + callback.getId());
                    callback.onError(IContactResultCallbackError.Unknown);
                    console.error("ERROR: 'ContactBridge.getContactsWithFilter' incorrect response received.");
                }
            }
            else {
                // Unknown error - remove from dictionary and notify callback.
                Adaptive.registeredContactResultCallback.remove("" + callback.getId());
                callback.onError(IContactResultCallbackError.Unknown);
                console.error("ERROR: " + xhr.status + " sending 'ContactBridge.getContactsWithFilter' request.");
            }
        };
        /**
           Search contacts according to a term and send it to the callback

           @param term     string to search
           @param callback called for return
           @since ARP1.0
        */
        ContactBridge.prototype.searchContacts = function (term, callback) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(term));
            var apiRequest = new APIRequest("IContact", "searchContacts", arParams, callback.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add callback reference to local dictionary.
            Adaptive.registeredContactResultCallback.add("" + callback.getId(), callback);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove callback reference from local dictionary due to invalid response.
                        Adaptive.registeredContactResultCallback.remove("" + callback.getId());
                        callback.onError(IContactResultCallbackError.Unknown);
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'ContactBridge.searchContacts' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove callback reference from local dictionary due to invalid response.
                    Adaptive.registeredContactResultCallback.remove("" + callback.getId());
                    callback.onError(IContactResultCallbackError.Unknown);
                    console.error("ERROR: 'ContactBridge.searchContacts' incorrect response received.");
                }
            }
            else {
                // Unknown error - remove from dictionary and notify callback.
                Adaptive.registeredContactResultCallback.remove("" + callback.getId());
                callback.onError(IContactResultCallbackError.Unknown);
                console.error("ERROR: " + xhr.status + " sending 'ContactBridge.searchContacts' request.");
            }
        };
        /**
           Search contacts according to a term with a filter and send it to the callback

           @param term     string to search
           @param callback called for return
           @param filter   to search for
           @since ARP1.0
        */
        ContactBridge.prototype.searchContactsWithFilter = function (term, callback, filter) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(term));
            arParams.push(JSON.stringify(filter));
            var apiRequest = new APIRequest("IContact", "searchContactsWithFilter", arParams, callback.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add callback reference to local dictionary.
            Adaptive.registeredContactResultCallback.add("" + callback.getId(), callback);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove callback reference from local dictionary due to invalid response.
                        Adaptive.registeredContactResultCallback.remove("" + callback.getId());
                        callback.onError(IContactResultCallbackError.Unknown);
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'ContactBridge.searchContactsWithFilter' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove callback reference from local dictionary due to invalid response.
                    Adaptive.registeredContactResultCallback.remove("" + callback.getId());
                    callback.onError(IContactResultCallbackError.Unknown);
                    console.error("ERROR: 'ContactBridge.searchContactsWithFilter' incorrect response received.");
                }
            }
            else {
                // Unknown error - remove from dictionary and notify callback.
                Adaptive.registeredContactResultCallback.remove("" + callback.getId());
                callback.onError(IContactResultCallbackError.Unknown);
                console.error("ERROR: " + xhr.status + " sending 'ContactBridge.searchContactsWithFilter' request.");
            }
        };
        /**
           Set the contact photo

           @param contact  id to assign the photo
           @param pngImage photo as byte array
           @return true if set is successful;false otherwise
           @since ARP1.0
        */
        ContactBridge.prototype.setContactPhoto = function (contact, pngImage) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(contact));
            arParams.push(JSON.stringify(pngImage));
            var apiRequest = new APIRequest("IContact", "setContactPhoto", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = false;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = !!apiResponse.getResponse();
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'ContactBridge.setContactPhoto' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'ContactBridge.setContactPhoto' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'ContactBridge.setContactPhoto' request.");
            }
            return response;
        };
        return ContactBridge;
    })(BasePIMBridge);
    /**
       Interface for Managing the Mail operations

       @author Francisco Javier Martin Bueno
       @since ARP1.0
    */
    var MailBridge = (function (_super) {
        __extends(MailBridge, _super);
        /**
           Default constructor.
        */
        function MailBridge() {
            _super.call(this);
        }
        /**
           Send an Email

           @param data     Payload of the email
           @param callback Result callback of the operation
           @since ARP1.0
        */
        MailBridge.prototype.sendEmail = function (data, callback) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(data));
            var apiRequest = new APIRequest("IMail", "sendEmail", arParams, callback.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add callback reference to local dictionary.
            Adaptive.registeredMessagingCallback.add("" + callback.getId(), callback);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove callback reference from local dictionary due to invalid response.
                        Adaptive.registeredMessagingCallback.remove("" + callback.getId());
                        callback.onError(IMessagingCallbackError.Unknown);
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'MailBridge.sendEmail' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove callback reference from local dictionary due to invalid response.
                    Adaptive.registeredMessagingCallback.remove("" + callback.getId());
                    callback.onError(IMessagingCallbackError.Unknown);
                    console.error("ERROR: 'MailBridge.sendEmail' incorrect response received.");
                }
            }
            else {
                // Unknown error - remove from dictionary and notify callback.
                Adaptive.registeredMessagingCallback.remove("" + callback.getId());
                callback.onError(IMessagingCallbackError.Unknown);
                console.error("ERROR: " + xhr.status + " sending 'MailBridge.sendEmail' request.");
            }
        };
        return MailBridge;
    })(BasePIMBridge);
    /**
       Interface for Managing the Messaging operations

       @author Francisco Javier Martin Bueno
       @since ARP1.0
    */
    var MessagingBridge = (function (_super) {
        __extends(MessagingBridge, _super);
        /**
           Default constructor.
        */
        function MessagingBridge() {
            _super.call(this);
        }
        /**
           Send text SMS

           @param number   to send
           @param text     to send
           @param callback with the result
           @since ARP1.0
        */
        MessagingBridge.prototype.sendSMS = function (number, text, callback) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(number));
            arParams.push(JSON.stringify(text));
            var apiRequest = new APIRequest("IMessaging", "sendSMS", arParams, callback.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add callback reference to local dictionary.
            Adaptive.registeredMessagingCallback.add("" + callback.getId(), callback);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove callback reference from local dictionary due to invalid response.
                        Adaptive.registeredMessagingCallback.remove("" + callback.getId());
                        callback.onError(IMessagingCallbackError.Unknown);
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'MessagingBridge.sendSMS' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove callback reference from local dictionary due to invalid response.
                    Adaptive.registeredMessagingCallback.remove("" + callback.getId());
                    callback.onError(IMessagingCallbackError.Unknown);
                    console.error("ERROR: 'MessagingBridge.sendSMS' incorrect response received.");
                }
            }
            else {
                // Unknown error - remove from dictionary and notify callback.
                Adaptive.registeredMessagingCallback.remove("" + callback.getId());
                callback.onError(IMessagingCallbackError.Unknown);
                console.error("ERROR: " + xhr.status + " sending 'MessagingBridge.sendSMS' request.");
            }
        };
        return MessagingBridge;
    })(BasePIMBridge);
    /**
       Interface for Barcode Reading purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var BarcodeBridge = (function (_super) {
        __extends(BarcodeBridge, _super);
        /**
           Default constructor.
        */
        function BarcodeBridge() {
            _super.call(this);
        }
        return BarcodeBridge;
    })(BaseReaderBridge);
    /**
       Interface for Managing the NFC operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var NFCBridge = (function (_super) {
        __extends(NFCBridge, _super);
        /**
           Default constructor.
        */
        function NFCBridge() {
            _super.call(this);
        }
        return NFCBridge;
    })(BaseReaderBridge);
    /**
       Interface for Managing the OCR operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var OCRBridge = (function (_super) {
        __extends(OCRBridge, _super);
        /**
           Default constructor.
        */
        function OCRBridge() {
            _super.call(this);
        }
        return OCRBridge;
    })(BaseReaderBridge);
    /**
       Interface for Managing the QR Code operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var QRCodeBridge = (function (_super) {
        __extends(QRCodeBridge, _super);
        /**
           Default constructor.
        */
        function QRCodeBridge() {
            _super.call(this);
        }
        return QRCodeBridge;
    })(BaseReaderBridge);
    /**
       Interface for Managing the OAuth operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var OAuthBridge = (function (_super) {
        __extends(OAuthBridge, _super);
        /**
           Default constructor.
        */
        function OAuthBridge() {
            _super.call(this);
        }
        return OAuthBridge;
    })(BaseSecurityBridge);
    /**
       Interface for Managing the OpenID operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var OpenIdBridge = (function (_super) {
        __extends(OpenIdBridge, _super);
        /**
           Default constructor.
        */
        function OpenIdBridge() {
            _super.call(this);
        }
        return OpenIdBridge;
    })(BaseSecurityBridge);
    /**
       Interface for Managing the Security operations

       @author Aryslan
       @since ARP1.0
    */
    var SecurityBridge = (function (_super) {
        __extends(SecurityBridge, _super);
        /**
           Default constructor.
        */
        function SecurityBridge() {
            _super.call(this);
        }
        /**
           Deletes from the device internal storage the entry/entries containing the specified key names.

           @param keys             Array with the key names to delete.
           @param publicAccessName The name of the shared internal storage object (if needed).
           @param callback         callback to be executed upon function result.
           @since ARP 1.0
        */
        SecurityBridge.prototype.deleteSecureKeyValuePairs = function (keys, publicAccessName, callback) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(keys));
            arParams.push(JSON.stringify(publicAccessName));
            var apiRequest = new APIRequest("ISecurity", "deleteSecureKeyValuePairs", arParams, callback.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add callback reference to local dictionary.
            Adaptive.registeredSecurityResultCallback.add("" + callback.getId(), callback);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove callback reference from local dictionary due to invalid response.
                        Adaptive.registeredSecurityResultCallback.remove("" + callback.getId());
                        callback.onError(ISecurityResultCallbackError.Unknown);
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'SecurityBridge.deleteSecureKeyValuePairs' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove callback reference from local dictionary due to invalid response.
                    Adaptive.registeredSecurityResultCallback.remove("" + callback.getId());
                    callback.onError(ISecurityResultCallbackError.Unknown);
                    console.error("ERROR: 'SecurityBridge.deleteSecureKeyValuePairs' incorrect response received.");
                }
            }
            else {
                // Unknown error - remove from dictionary and notify callback.
                Adaptive.registeredSecurityResultCallback.remove("" + callback.getId());
                callback.onError(ISecurityResultCallbackError.Unknown);
                console.error("ERROR: " + xhr.status + " sending 'SecurityBridge.deleteSecureKeyValuePairs' request.");
            }
        };
        /**
           Retrieves from the device internal storage the entry/entries containing the specified key names.

           @param keys             Array with the key names to retrieve.
           @param publicAccessName The name of the shared internal storage object (if needed).
           @param callback         callback to be executed upon function result.
           @since ARP 1.0
        */
        SecurityBridge.prototype.getSecureKeyValuePairs = function (keys, publicAccessName, callback) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(keys));
            arParams.push(JSON.stringify(publicAccessName));
            var apiRequest = new APIRequest("ISecurity", "getSecureKeyValuePairs", arParams, callback.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add callback reference to local dictionary.
            Adaptive.registeredSecurityResultCallback.add("" + callback.getId(), callback);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove callback reference from local dictionary due to invalid response.
                        Adaptive.registeredSecurityResultCallback.remove("" + callback.getId());
                        callback.onError(ISecurityResultCallbackError.Unknown);
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'SecurityBridge.getSecureKeyValuePairs' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove callback reference from local dictionary due to invalid response.
                    Adaptive.registeredSecurityResultCallback.remove("" + callback.getId());
                    callback.onError(ISecurityResultCallbackError.Unknown);
                    console.error("ERROR: 'SecurityBridge.getSecureKeyValuePairs' incorrect response received.");
                }
            }
            else {
                // Unknown error - remove from dictionary and notify callback.
                Adaptive.registeredSecurityResultCallback.remove("" + callback.getId());
                callback.onError(ISecurityResultCallbackError.Unknown);
                console.error("ERROR: " + xhr.status + " sending 'SecurityBridge.getSecureKeyValuePairs' request.");
            }
        };
        /**
           Returns if the device has been modified in anyhow

           @return true if the device has been modified; false otherwise
           @since ARP1.0
        */
        SecurityBridge.prototype.isDeviceModified = function () {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("ISecurity", "isDeviceModified", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = false;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = !!apiResponse.getResponse();
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'SecurityBridge.isDeviceModified' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'SecurityBridge.isDeviceModified' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'SecurityBridge.isDeviceModified' request.");
            }
            return response;
        };
        /**
           Stores in the device internal storage the specified item/s.

           @param keyValues        Array containing the items to store on the device internal memory.
           @param publicAccessName The name of the shared internal storage object (if needed).
           @param callback         callback to be executed upon function result.
           @since ARP 1.0
        */
        SecurityBridge.prototype.setSecureKeyValuePairs = function (keyValues, publicAccessName, callback) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(keyValues));
            arParams.push(JSON.stringify(publicAccessName));
            var apiRequest = new APIRequest("ISecurity", "setSecureKeyValuePairs", arParams, callback.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add callback reference to local dictionary.
            Adaptive.registeredSecurityResultCallback.add("" + callback.getId(), callback);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove callback reference from local dictionary due to invalid response.
                        Adaptive.registeredSecurityResultCallback.remove("" + callback.getId());
                        callback.onError(ISecurityResultCallbackError.Unknown);
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'SecurityBridge.setSecureKeyValuePairs' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove callback reference from local dictionary due to invalid response.
                    Adaptive.registeredSecurityResultCallback.remove("" + callback.getId());
                    callback.onError(ISecurityResultCallbackError.Unknown);
                    console.error("ERROR: 'SecurityBridge.setSecureKeyValuePairs' incorrect response received.");
                }
            }
            else {
                // Unknown error - remove from dictionary and notify callback.
                Adaptive.registeredSecurityResultCallback.remove("" + callback.getId());
                callback.onError(ISecurityResultCallbackError.Unknown);
                console.error("ERROR: " + xhr.status + " sending 'SecurityBridge.setSecureKeyValuePairs' request.");
            }
        };
        return SecurityBridge;
    })(BaseSecurityBridge);
    /**
       Interface defining methods about the acceleration sensor

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var AccelerationBridge = (function (_super) {
        __extends(AccelerationBridge, _super);
        /**
           Default constructor.
        */
        function AccelerationBridge() {
            _super.call(this);
        }
        /**
           Register a new listener that will receive acceleration events.

           @param listener to be registered.
           @since ARP1.0
        */
        AccelerationBridge.prototype.addAccelerationListener = function (listener) {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("IAcceleration", "addAccelerationListener", arParams, listener.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add listener reference to local dictionary.
            Adaptive.registeredAccelerationListener.add("" + listener.getId(), listener);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove listener reference from local dictionary due to invalid response.
                        Adaptive.registeredAccelerationListener.remove("" + listener.getId());
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'AccelerationBridge.addAccelerationListener' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove listener reference from local dictionary due to invalid response.
                    Adaptive.registeredAccelerationListener.remove("" + listener.getId());
                    console.error("ERROR: 'AccelerationBridge.addAccelerationListener' incorrect response received.");
                }
            }
            else {
                // Remove listener reference from local dictionary due to invalid response.
                Adaptive.registeredAccelerationListener.remove("" + listener.getId());
                console.error("ERROR: " + xhr.status + " sending 'AccelerationBridge.addAccelerationListener' request.");
            }
        };
        /**
           De-registers an existing listener from receiving acceleration events.

           @param listener to be registered.
           @since ARP1.0
        */
        AccelerationBridge.prototype.removeAccelerationListener = function (listener) {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("IAcceleration", "removeAccelerationListener", arParams, listener.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        // Remove listener reference from local dictionary.
                        Adaptive.registeredAccelerationListener.remove("" + listener.getId());
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'AccelerationBridge.removeAccelerationListener' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'AccelerationBridge.removeAccelerationListener' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'AccelerationBridge.removeAccelerationListener' request.");
            }
        };
        /**
           Removed all existing listeners from receiving acceleration events.

           @since ARP1.0
        */
        AccelerationBridge.prototype.removeAccelerationListeners = function () {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("IAcceleration", "removeAccelerationListeners", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        // Remove all listeners references from local dictionary.
                        var keys = Adaptive.registeredAccelerationListener.keys();
                        for (var key in keys) {
                            Adaptive.registeredAccelerationListener.remove(key);
                        }
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'AccelerationBridge.removeAccelerationListeners' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'AccelerationBridge.removeAccelerationListeners' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'AccelerationBridge.removeAccelerationListeners' request.");
            }
        };
        return AccelerationBridge;
    })(BaseSensorBridge);
    /**
       Interface for managinf the Ambient Light

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var AmbientLightBridge = (function (_super) {
        __extends(AmbientLightBridge, _super);
        /**
           Default constructor.
        */
        function AmbientLightBridge() {
            _super.call(this);
        }
        return AmbientLightBridge;
    })(BaseSensorBridge);
    /**
       Interface for Barometer management purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var BarometerBridge = (function (_super) {
        __extends(BarometerBridge, _super);
        /**
           Default constructor.
        */
        function BarometerBridge() {
            _super.call(this);
        }
        return BarometerBridge;
    })(BaseSensorBridge);
    /**
       Interface for Managing the Geolocation operations

       @author Francisco Javier Martin Bueno
       @since ARP1.0
    */
    var GeolocationBridge = (function (_super) {
        __extends(GeolocationBridge, _super);
        /**
           Default constructor.
        */
        function GeolocationBridge() {
            _super.call(this);
        }
        /**
           Register a new listener that will receive geolocation events.

           @param listener to be registered.
           @since ARP1.0
        */
        GeolocationBridge.prototype.addGeolocationListener = function (listener) {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("IGeolocation", "addGeolocationListener", arParams, listener.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add listener reference to local dictionary.
            Adaptive.registeredGeolocationListener.add("" + listener.getId(), listener);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove listener reference from local dictionary due to invalid response.
                        Adaptive.registeredGeolocationListener.remove("" + listener.getId());
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'GeolocationBridge.addGeolocationListener' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove listener reference from local dictionary due to invalid response.
                    Adaptive.registeredGeolocationListener.remove("" + listener.getId());
                    console.error("ERROR: 'GeolocationBridge.addGeolocationListener' incorrect response received.");
                }
            }
            else {
                // Remove listener reference from local dictionary due to invalid response.
                Adaptive.registeredGeolocationListener.remove("" + listener.getId());
                console.error("ERROR: " + xhr.status + " sending 'GeolocationBridge.addGeolocationListener' request.");
            }
        };
        /**
           De-registers an existing listener from receiving geolocation events.

           @param listener to be registered.
           @since ARP1.0
        */
        GeolocationBridge.prototype.removeGeolocationListener = function (listener) {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("IGeolocation", "removeGeolocationListener", arParams, listener.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        // Remove listener reference from local dictionary.
                        Adaptive.registeredGeolocationListener.remove("" + listener.getId());
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'GeolocationBridge.removeGeolocationListener' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'GeolocationBridge.removeGeolocationListener' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'GeolocationBridge.removeGeolocationListener' request.");
            }
        };
        /**
           Removed all existing listeners from receiving geolocation events.

           @since ARP1.0
        */
        GeolocationBridge.prototype.removeGeolocationListeners = function () {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("IGeolocation", "removeGeolocationListeners", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        // Remove all listeners references from local dictionary.
                        var keys = Adaptive.registeredGeolocationListener.keys();
                        for (var key in keys) {
                            Adaptive.registeredGeolocationListener.remove(key);
                        }
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'GeolocationBridge.removeGeolocationListeners' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'GeolocationBridge.removeGeolocationListeners' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'GeolocationBridge.removeGeolocationListeners' request.");
            }
        };
        return GeolocationBridge;
    })(BaseSensorBridge);
    /**
       Interface for Managing the Giroscope operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var GyroscopeBridge = (function (_super) {
        __extends(GyroscopeBridge, _super);
        /**
           Default constructor.
        */
        function GyroscopeBridge() {
            _super.call(this);
        }
        return GyroscopeBridge;
    })(BaseSensorBridge);
    /**
       Interface for Managing the Magnetometer operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var MagnetometerBridge = (function (_super) {
        __extends(MagnetometerBridge, _super);
        /**
           Default constructor.
        */
        function MagnetometerBridge() {
            _super.call(this);
        }
        return MagnetometerBridge;
    })(BaseSensorBridge);
    /**
       Interface for Managing the Proximity operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var ProximityBridge = (function (_super) {
        __extends(ProximityBridge, _super);
        /**
           Default constructor.
        */
        function ProximityBridge() {
            _super.call(this);
        }
        return ProximityBridge;
    })(BaseSensorBridge);
    /**
       Interface for Managing the Facebook operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var FacebookBridge = (function (_super) {
        __extends(FacebookBridge, _super);
        /**
           Default constructor.
        */
        function FacebookBridge() {
            _super.call(this);
        }
        return FacebookBridge;
    })(BaseSocialBridge);
    /**
       Interface for Managing the Google Plus operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var GooglePlusBridge = (function (_super) {
        __extends(GooglePlusBridge, _super);
        /**
           Default constructor.
        */
        function GooglePlusBridge() {
            _super.call(this);
        }
        return GooglePlusBridge;
    })(BaseSocialBridge);
    /**
       Interface for Managing the Linkedin operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var LinkedInBridge = (function (_super) {
        __extends(LinkedInBridge, _super);
        /**
           Default constructor.
        */
        function LinkedInBridge() {
            _super.call(this);
        }
        return LinkedInBridge;
    })(BaseSocialBridge);
    /**
       Interface for Managing the RSS operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var RSSBridge = (function (_super) {
        __extends(RSSBridge, _super);
        /**
           Default constructor.
        */
        function RSSBridge() {
            _super.call(this);
        }
        return RSSBridge;
    })(BaseSocialBridge);
    /**
       Interface for Managing the Twitter operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var TwitterBridge = (function (_super) {
        __extends(TwitterBridge, _super);
        /**
           Default constructor.
        */
        function TwitterBridge() {
            _super.call(this);
        }
        return TwitterBridge;
    })(BaseSocialBridge);
    /**
       Interface for testing the Capabilities operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var CapabilitiesBridge = (function (_super) {
        __extends(CapabilitiesBridge, _super);
        /**
           Default constructor.
        */
        function CapabilitiesBridge() {
            _super.call(this);
        }
        /**
           Determines whether a specific hardware button is supported for interaction.

           @param type Type of feature to check.
           @return true is supported, false otherwise.
           @since ARP1.0
        */
        CapabilitiesBridge.prototype.hasButtonSupport = function (type) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(type));
            var apiRequest = new APIRequest("ICapabilities", "hasButtonSupport", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = false;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = !!apiResponse.getResponse();
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'CapabilitiesBridge.hasButtonSupport' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'CapabilitiesBridge.hasButtonSupport' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'CapabilitiesBridge.hasButtonSupport' request.");
            }
            return response;
        };
        /**
           Determines whether a specific Communication capability is supported by
the device.

           @param type Type of feature to check.
           @return true if supported, false otherwise.
           @since ARP1.0
        */
        CapabilitiesBridge.prototype.hasCommunicationSupport = function (type) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(type));
            var apiRequest = new APIRequest("ICapabilities", "hasCommunicationSupport", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = false;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = !!apiResponse.getResponse();
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'CapabilitiesBridge.hasCommunicationSupport' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'CapabilitiesBridge.hasCommunicationSupport' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'CapabilitiesBridge.hasCommunicationSupport' request.");
            }
            return response;
        };
        /**
           Determines whether a specific Data capability is supported by the device.

           @param type Type of feature to check.
           @return true if supported, false otherwise.
           @since ARP1.0
        */
        CapabilitiesBridge.prototype.hasDataSupport = function (type) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(type));
            var apiRequest = new APIRequest("ICapabilities", "hasDataSupport", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = false;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = !!apiResponse.getResponse();
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'CapabilitiesBridge.hasDataSupport' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'CapabilitiesBridge.hasDataSupport' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'CapabilitiesBridge.hasDataSupport' request.");
            }
            return response;
        };
        /**
           Determines whether a specific Media capability is supported by the
device.

           @param type Type of feature to check.
           @return true if supported, false otherwise.
           @since ARP1.0
        */
        CapabilitiesBridge.prototype.hasMediaSupport = function (type) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(type));
            var apiRequest = new APIRequest("ICapabilities", "hasMediaSupport", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = false;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = !!apiResponse.getResponse();
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'CapabilitiesBridge.hasMediaSupport' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'CapabilitiesBridge.hasMediaSupport' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'CapabilitiesBridge.hasMediaSupport' request.");
            }
            return response;
        };
        /**
           Determines whether a specific Net capability is supported by the device.

           @param type Type of feature to check.
           @return true if supported, false otherwise.
           @since ARP1.0
        */
        CapabilitiesBridge.prototype.hasNetSupport = function (type) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(type));
            var apiRequest = new APIRequest("ICapabilities", "hasNetSupport", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = false;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = !!apiResponse.getResponse();
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'CapabilitiesBridge.hasNetSupport' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'CapabilitiesBridge.hasNetSupport' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'CapabilitiesBridge.hasNetSupport' request.");
            }
            return response;
        };
        /**
           Determines whether a specific Notification capability is supported by the
device.

           @param type Type of feature to check.
           @return true if supported, false otherwise.
           @since ARP1.0
        */
        CapabilitiesBridge.prototype.hasNotificationSupport = function (type) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(type));
            var apiRequest = new APIRequest("ICapabilities", "hasNotificationSupport", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = false;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = !!apiResponse.getResponse();
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'CapabilitiesBridge.hasNotificationSupport' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'CapabilitiesBridge.hasNotificationSupport' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'CapabilitiesBridge.hasNotificationSupport' request.");
            }
            return response;
        };
        /**
           Determines whether a specific Sensor capability is supported by the
device.

           @param type Type of feature to check.
           @return true if supported, false otherwise.
           @since ARP1.0
        */
        CapabilitiesBridge.prototype.hasSensorSupport = function (type) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(type));
            var apiRequest = new APIRequest("ICapabilities", "hasSensorSupport", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = false;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = !!apiResponse.getResponse();
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'CapabilitiesBridge.hasSensorSupport' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'CapabilitiesBridge.hasSensorSupport' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'CapabilitiesBridge.hasSensorSupport' request.");
            }
            return response;
        };
        return CapabilitiesBridge;
    })(BaseSystemBridge);
    /**
       Interface for Managing the Device operations

       @author Francisco Javier Martin Bueno
       @since ARP1.0
    */
    var DeviceBridge = (function (_super) {
        __extends(DeviceBridge, _super);
        /**
           Default constructor.
        */
        function DeviceBridge() {
            _super.call(this);
        }
        /**
           Register a new listener that will receive button events.

           @param listener to be registered.
           @since ARP1.0
        */
        DeviceBridge.prototype.addButtonListener = function (listener) {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("IDevice", "addButtonListener", arParams, listener.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            // Add listener reference to local dictionary.
            Adaptive.registeredButtonListener.add("" + listener.getId(), listener);
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                    }
                    else {
                        // Remove listener reference from local dictionary due to invalid response.
                        Adaptive.registeredButtonListener.remove("" + listener.getId());
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'DeviceBridge.addButtonListener' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    // Remove listener reference from local dictionary due to invalid response.
                    Adaptive.registeredButtonListener.remove("" + listener.getId());
                    console.error("ERROR: 'DeviceBridge.addButtonListener' incorrect response received.");
                }
            }
            else {
                // Remove listener reference from local dictionary due to invalid response.
                Adaptive.registeredButtonListener.remove("" + listener.getId());
                console.error("ERROR: " + xhr.status + " sending 'DeviceBridge.addButtonListener' request.");
            }
        };
        /**
           Returns the device information for the current device executing the runtime.

           @return DeviceInfo for the current device.
           @since ARP1.0
        */
        DeviceBridge.prototype.getDeviceInfo = function () {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("IDevice", "getDeviceInfo", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = null;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = DeviceInfo.toObject(JSON.parse(apiResponse.getResponse()));
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'DeviceBridge.getDeviceInfo' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'DeviceBridge.getDeviceInfo' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'DeviceBridge.getDeviceInfo' request.");
            }
            return response;
        };
        /**
           Gets the current Locale for the device.

           @return The current Locale information.
           @since ARP1.0
        */
        DeviceBridge.prototype.getLocaleCurrent = function () {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("IDevice", "getLocaleCurrent", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = null;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = Locale.toObject(JSON.parse(apiResponse.getResponse()));
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'DeviceBridge.getLocaleCurrent' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'DeviceBridge.getLocaleCurrent' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'DeviceBridge.getLocaleCurrent' request.");
            }
            return response;
        };
        /**
           De-registers an existing listener from receiving button events.

           @param listener to be removed.
           @since ARP1.0
        */
        DeviceBridge.prototype.removeButtonListener = function (listener) {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("IDevice", "removeButtonListener", arParams, listener.getId());
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        // Remove listener reference from local dictionary.
                        Adaptive.registeredButtonListener.remove("" + listener.getId());
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'DeviceBridge.removeButtonListener' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'DeviceBridge.removeButtonListener' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'DeviceBridge.removeButtonListener' request.");
            }
        };
        /**
           Removed all existing listeners from receiving button events.

           @since ARP1.0
        */
        DeviceBridge.prototype.removeButtonListeners = function () {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("IDevice", "removeButtonListeners", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        // Remove all listeners references from local dictionary.
                        var keys = Adaptive.registeredButtonListener.keys();
                        for (var key in keys) {
                            Adaptive.registeredButtonListener.remove(key);
                        }
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'DeviceBridge.removeButtonListeners' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'DeviceBridge.removeButtonListeners' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'DeviceBridge.removeButtonListeners' request.");
            }
        };
        return DeviceBridge;
    })(BaseSystemBridge);
    /**
       Interface for Managing the Display operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var DisplayBridge = (function (_super) {
        __extends(DisplayBridge, _super);
        /**
           Default constructor.
        */
        function DisplayBridge() {
            _super.call(this);
        }
        return DisplayBridge;
    })(BaseSystemBridge);
    /**
       Interface for Managing the OS operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var OSBridge = (function (_super) {
        __extends(OSBridge, _super);
        /**
           Default constructor.
        */
        function OSBridge() {
            _super.call(this);
        }
        /**
           Returns the OSInfo for the current operating system.

           @return OSInfo with name, version and vendor of the OS.
           @since ARP1.0
        */
        OSBridge.prototype.getOSInfo = function () {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("IOS", "getOSInfo", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = null;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = OSInfo.toObject(JSON.parse(apiResponse.getResponse()));
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'OSBridge.getOSInfo' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'OSBridge.getOSInfo' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'OSBridge.getOSInfo' request.");
            }
            return response;
        };
        return OSBridge;
    })(BaseSystemBridge);
    /**
       Interface for Managing the Runtime operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var RuntimeBridge = (function (_super) {
        __extends(RuntimeBridge, _super);
        /**
           Default constructor.
        */
        function RuntimeBridge() {
            _super.call(this);
        }
        /**
           Dismiss the current Application

           @since ARP1.0
        */
        RuntimeBridge.prototype.dismissApplication = function () {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("IRuntime", "dismissApplication", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'RuntimeBridge.dismissApplication' request.");
            }
        };
        /**
           Whether the application dismiss the splash screen successfully or not

           @return true if the application has dismissed the splash screen;false otherwise
           @since ARP1.0
        */
        RuntimeBridge.prototype.dismissSplashScreen = function () {
            // Create and populate API request.
            var arParams = [];
            var apiRequest = new APIRequest("IRuntime", "dismissSplashScreen", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = false;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = !!apiResponse.getResponse();
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'RuntimeBridge.dismissSplashScreen' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'RuntimeBridge.dismissSplashScreen' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'RuntimeBridge.dismissSplashScreen' request.");
            }
            return response;
        };
        return RuntimeBridge;
    })(BaseSystemBridge);
    /**
       Interface for Managing the browser operations

       @author Francisco Javier Martin Bueno
       @since ARP1.0
    */
    var BrowserBridge = (function (_super) {
        __extends(BrowserBridge, _super);
        /**
           Default constructor.
        */
        function BrowserBridge() {
            _super.call(this);
        }
        /**
           Method for opening a URL like a link in the native default browser

           @param url Url to open
           @return The result of the operation
           @since ARP1.0
        */
        BrowserBridge.prototype.openExtenalBrowser = function (url) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(url));
            var apiRequest = new APIRequest("IBrowser", "openExtenalBrowser", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = false;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = !!apiResponse.getResponse();
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'BrowserBridge.openExtenalBrowser' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'BrowserBridge.openExtenalBrowser' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'BrowserBridge.openExtenalBrowser' request.");
            }
            return response;
        };
        /**
           Method for opening a browser embedded into the application

           @param url            Url to open
           @param title          Title of the Navigation bar
           @param backButtonText Title of the Back button bar
           @return The result of the operation
           @since ARP1.0
        */
        BrowserBridge.prototype.openInternalBrowser = function (url, title, backButtonText) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(url));
            arParams.push(JSON.stringify(title));
            arParams.push(JSON.stringify(backButtonText));
            var apiRequest = new APIRequest("IBrowser", "openInternalBrowser", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = false;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = !!apiResponse.getResponse();
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'BrowserBridge.openInternalBrowser' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'BrowserBridge.openInternalBrowser' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'BrowserBridge.openInternalBrowser' request.");
            }
            return response;
        };
        /**
           Method for opening a browser embedded into the application in a modal window

           @param url            Url to open
           @param title          Title of the Navigation bar
           @param backButtonText Title of the Back button bar
           @return The result of the operation
           @since ARP1.0
        */
        BrowserBridge.prototype.openInternalBrowserModal = function (url, title, backButtonText) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(url));
            arParams.push(JSON.stringify(title));
            arParams.push(JSON.stringify(backButtonText));
            var apiRequest = new APIRequest("IBrowser", "openInternalBrowserModal", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Prepare response.
            var response = false;
            // Check response.
            if (xhr.status == 200) {
                // Process response.
                if (xhr.responseText != null && xhr.responseText != '') {
                    apiResponse = APIResponse.toObject(JSON.parse(xhr.responseText));
                    if (apiResponse != null && apiResponse.getStatusCode() == 200) {
                        response = !!apiResponse.getResponse();
                    }
                    else {
                        console.error("ERROR: " + apiResponse.getStatusCode() + " receiving response in 'BrowserBridge.openInternalBrowserModal' [" + apiResponse.getStatusMessage() + "].");
                    }
                }
                else {
                    console.error("ERROR: 'BrowserBridge.openInternalBrowserModal' incorrect response received.");
                }
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'BrowserBridge.openInternalBrowserModal' request.");
            }
            return response;
        };
        return BrowserBridge;
    })(BaseUIBridge);
    /**
       Interface for Managing the Desktop operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var DesktopBridge = (function (_super) {
        __extends(DesktopBridge, _super);
        /**
           Default constructor.
        */
        function DesktopBridge() {
            _super.call(this);
        }
        return DesktopBridge;
    })(BaseUIBridge);
    /**
       Interface for Managing the Map operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var MapBridge = (function (_super) {
        __extends(MapBridge, _super);
        /**
           Default constructor.
        */
        function MapBridge() {
            _super.call(this);
        }
        return MapBridge;
    })(BaseUIBridge);
    /**
       Interface for Managing the UI operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var UIBridge = (function (_super) {
        __extends(UIBridge, _super);
        /**
           Default constructor.
        */
        function UIBridge() {
            _super.call(this);
        }
        return UIBridge;
    })(BaseUIBridge);
    /**
       Interface for Managing the Compression operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var CompressionBridge = (function (_super) {
        __extends(CompressionBridge, _super);
        /**
           Default constructor.
        */
        function CompressionBridge() {
            _super.call(this);
        }
        return CompressionBridge;
    })(BaseUtilBridge);
    /**
       Interface for Managing the Concurrent operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var ConcurrentBridge = (function (_super) {
        __extends(ConcurrentBridge, _super);
        /**
           Default constructor.
        */
        function ConcurrentBridge() {
            _super.call(this);
        }
        return ConcurrentBridge;
    })(BaseUtilBridge);
    /**
       Interface for Managing the Cloud operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var CryptoBridge = (function (_super) {
        __extends(CryptoBridge, _super);
        /**
           Default constructor.
        */
        function CryptoBridge() {
            _super.call(this);
        }
        return CryptoBridge;
    })(BaseUtilBridge);
    /**
       Interface for Managing the Logging operations

       @author Ferran Vila Conesa
       @since ARP1.0
    */
    var LoggingBridge = (function (_super) {
        __extends(LoggingBridge, _super);
        /**
           Default constructor.
        */
        function LoggingBridge() {
            _super.call(this);
        }
        /**
           Logs the given message, with the given log level if specified, to the standard platform/environment.

           @param level   Log level
           @param message Message to be logged
           @since ARP1.0
        */
        LoggingBridge.prototype.log_level_message = function (level, message) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(level));
            arParams.push(JSON.stringify(message));
            var apiRequest = new APIRequest("ILogging", "log_level_message", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'LoggingBridge.log_level_message' request.");
            }
        };
        /**
           Logs the given message, with the given log level if specified, to the standard platform/environment.

           @param level    Log level
           @param category Category/tag name to identify/filter the log.
           @param message  Message to be logged
           @since ARP1.0
        */
        LoggingBridge.prototype.log_level_category_message = function (level, category, message) {
            // Create and populate API request.
            var arParams = [];
            arParams.push(JSON.stringify(level));
            arParams.push(JSON.stringify(category));
            arParams.push(JSON.stringify(message));
            var apiRequest = new APIRequest("ILogging", "log_level_category_message", arParams, -1);
            var apiResponse = new APIResponse("", 200, "");
            // Create and send JSON request.
            var xhr = new XMLHttpRequest();
            xhr.open("POST", Adaptive.bridgePath, false);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.setRequestHeader("X-AdaptiveVersion", "v2.0.3");
            xhr.send(JSON.stringify(apiRequest));
            // Check response.
            if (xhr.status == 200) {
            }
            else {
                console.error("ERROR: " + xhr.status + " sending 'LoggingBridge.log_level_category_message' request.");
            }
        };
        return LoggingBridge;
    })(BaseUtilBridge);
    /**
       Interface for Managing the Timer operations

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var TimerBridge = (function (_super) {
        __extends(TimerBridge, _super);
        /**
           Default constructor.
        */
        function TimerBridge() {
            _super.call(this);
        }
        return TimerBridge;
    })(BaseUtilBridge);
    /**
       Interface to retrieve auto-registered service implementation references.

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    var AppRegistryBridge = (function () {
        function AppRegistryBridge() {
        }
        AppRegistryBridge.getInstance = function () {
            if (AppRegistryBridge.instance === null) {
                AppRegistryBridge.instance = new AppRegistryBridge();
            }
            return AppRegistryBridge.instance;
        };
        /**
           Obtain a reference to the IAcceleration bridge.

           @return IAcceleration bridge instance.
        */
        AppRegistryBridge.prototype.getAccelerationBridge = function () {
            if (AppRegistryBridge.instanceAcceleration === null) {
                AppRegistryBridge.instanceAcceleration = new AccelerationBridge();
            }
            return AppRegistryBridge.instanceAcceleration;
        };
        /**
           Obtain a reference to the IAds bridge.

           @return IAds bridge instance.
        */
        AppRegistryBridge.prototype.getAdsBridge = function () {
            if (AppRegistryBridge.instanceAds === null) {
                AppRegistryBridge.instanceAds = new AdsBridge();
            }
            return AppRegistryBridge.instanceAds;
        };
        /**
           Obtain a reference to the IAlarm bridge.

           @return IAlarm bridge instance.
        */
        AppRegistryBridge.prototype.getAlarmBridge = function () {
            if (AppRegistryBridge.instanceAlarm === null) {
                AppRegistryBridge.instanceAlarm = new AlarmBridge();
            }
            return AppRegistryBridge.instanceAlarm;
        };
        /**
           Obtain a reference to the IAmbientLight bridge.

           @return IAmbientLight bridge instance.
        */
        AppRegistryBridge.prototype.getAmbientLightBridge = function () {
            if (AppRegistryBridge.instanceAmbientLight === null) {
                AppRegistryBridge.instanceAmbientLight = new AmbientLightBridge();
            }
            return AppRegistryBridge.instanceAmbientLight;
        };
        /**
           Obtain a reference to the IAnalytics bridge.

           @return IAnalytics bridge instance.
        */
        AppRegistryBridge.prototype.getAnalyticsBridge = function () {
            if (AppRegistryBridge.instanceAnalytics === null) {
                AppRegistryBridge.instanceAnalytics = new AnalyticsBridge();
            }
            return AppRegistryBridge.instanceAnalytics;
        };
        /**
           Obtain a reference to the IAudio bridge.

           @return IAudio bridge instance.
        */
        AppRegistryBridge.prototype.getAudioBridge = function () {
            if (AppRegistryBridge.instanceAudio === null) {
                AppRegistryBridge.instanceAudio = new AudioBridge();
            }
            return AppRegistryBridge.instanceAudio;
        };
        /**
           Obtain a reference to the IBarcode bridge.

           @return IBarcode bridge instance.
        */
        AppRegistryBridge.prototype.getBarcodeBridge = function () {
            if (AppRegistryBridge.instanceBarcode === null) {
                AppRegistryBridge.instanceBarcode = new BarcodeBridge();
            }
            return AppRegistryBridge.instanceBarcode;
        };
        /**
           Obtain a reference to the IBarometer bridge.

           @return IBarometer bridge instance.
        */
        AppRegistryBridge.prototype.getBarometerBridge = function () {
            if (AppRegistryBridge.instanceBarometer === null) {
                AppRegistryBridge.instanceBarometer = new BarometerBridge();
            }
            return AppRegistryBridge.instanceBarometer;
        };
        /**
           Obtain a reference to the IBluetooth bridge.

           @return IBluetooth bridge instance.
        */
        AppRegistryBridge.prototype.getBluetoothBridge = function () {
            if (AppRegistryBridge.instanceBluetooth === null) {
                AppRegistryBridge.instanceBluetooth = new BluetoothBridge();
            }
            return AppRegistryBridge.instanceBluetooth;
        };
        /**
           Obtain a reference to the IBrowser bridge.

           @return IBrowser bridge instance.
        */
        AppRegistryBridge.prototype.getBrowserBridge = function () {
            if (AppRegistryBridge.instanceBrowser === null) {
                AppRegistryBridge.instanceBrowser = new BrowserBridge();
            }
            return AppRegistryBridge.instanceBrowser;
        };
        /**
           Obtain a reference to the ICalendar bridge.

           @return ICalendar bridge instance.
        */
        AppRegistryBridge.prototype.getCalendarBridge = function () {
            if (AppRegistryBridge.instanceCalendar === null) {
                AppRegistryBridge.instanceCalendar = new CalendarBridge();
            }
            return AppRegistryBridge.instanceCalendar;
        };
        /**
           Obtain a reference to the ICamera bridge.

           @return ICamera bridge instance.
        */
        AppRegistryBridge.prototype.getCameraBridge = function () {
            if (AppRegistryBridge.instanceCamera === null) {
                AppRegistryBridge.instanceCamera = new CameraBridge();
            }
            return AppRegistryBridge.instanceCamera;
        };
        /**
           Obtain a reference to the ICapabilities bridge.

           @return ICapabilities bridge instance.
        */
        AppRegistryBridge.prototype.getCapabilitiesBridge = function () {
            if (AppRegistryBridge.instanceCapabilities === null) {
                AppRegistryBridge.instanceCapabilities = new CapabilitiesBridge();
            }
            return AppRegistryBridge.instanceCapabilities;
        };
        /**
           Obtain a reference to the ICloud bridge.

           @return ICloud bridge instance.
        */
        AppRegistryBridge.prototype.getCloudBridge = function () {
            if (AppRegistryBridge.instanceCloud === null) {
                AppRegistryBridge.instanceCloud = new CloudBridge();
            }
            return AppRegistryBridge.instanceCloud;
        };
        /**
           Obtain a reference to the ICompression bridge.

           @return ICompression bridge instance.
        */
        AppRegistryBridge.prototype.getCompressionBridge = function () {
            if (AppRegistryBridge.instanceCompression === null) {
                AppRegistryBridge.instanceCompression = new CompressionBridge();
            }
            return AppRegistryBridge.instanceCompression;
        };
        /**
           Obtain a reference to the IConcurrent bridge.

           @return IConcurrent bridge instance.
        */
        AppRegistryBridge.prototype.getConcurrentBridge = function () {
            if (AppRegistryBridge.instanceConcurrent === null) {
                AppRegistryBridge.instanceConcurrent = new ConcurrentBridge();
            }
            return AppRegistryBridge.instanceConcurrent;
        };
        /**
           Obtain a reference to the IContact bridge.

           @return IContact bridge instance.
        */
        AppRegistryBridge.prototype.getContactBridge = function () {
            if (AppRegistryBridge.instanceContact === null) {
                AppRegistryBridge.instanceContact = new ContactBridge();
            }
            return AppRegistryBridge.instanceContact;
        };
        /**
           Obtain a reference to the ICrypto bridge.

           @return ICrypto bridge instance.
        */
        AppRegistryBridge.prototype.getCryptoBridge = function () {
            if (AppRegistryBridge.instanceCrypto === null) {
                AppRegistryBridge.instanceCrypto = new CryptoBridge();
            }
            return AppRegistryBridge.instanceCrypto;
        };
        /**
           Obtain a reference to the IDataStream bridge.

           @return IDataStream bridge instance.
        */
        AppRegistryBridge.prototype.getDataStreamBridge = function () {
            if (AppRegistryBridge.instanceDataStream === null) {
                AppRegistryBridge.instanceDataStream = new DataStreamBridge();
            }
            return AppRegistryBridge.instanceDataStream;
        };
        /**
           Obtain a reference to the IDatabase bridge.

           @return IDatabase bridge instance.
        */
        AppRegistryBridge.prototype.getDatabaseBridge = function () {
            if (AppRegistryBridge.instanceDatabase === null) {
                AppRegistryBridge.instanceDatabase = new DatabaseBridge();
            }
            return AppRegistryBridge.instanceDatabase;
        };
        /**
           Obtain a reference to the IDesktop bridge.

           @return IDesktop bridge instance.
        */
        AppRegistryBridge.prototype.getDesktopBridge = function () {
            if (AppRegistryBridge.instanceDesktop === null) {
                AppRegistryBridge.instanceDesktop = new DesktopBridge();
            }
            return AppRegistryBridge.instanceDesktop;
        };
        /**
           Obtain a reference to the IDevice bridge.

           @return IDevice bridge instance.
        */
        AppRegistryBridge.prototype.getDeviceBridge = function () {
            if (AppRegistryBridge.instanceDevice === null) {
                AppRegistryBridge.instanceDevice = new DeviceBridge();
            }
            return AppRegistryBridge.instanceDevice;
        };
        /**
           Obtain a reference to the IDisplay bridge.

           @return IDisplay bridge instance.
        */
        AppRegistryBridge.prototype.getDisplayBridge = function () {
            if (AppRegistryBridge.instanceDisplay === null) {
                AppRegistryBridge.instanceDisplay = new DisplayBridge();
            }
            return AppRegistryBridge.instanceDisplay;
        };
        /**
           Obtain a reference to the IFacebook bridge.

           @return IFacebook bridge instance.
        */
        AppRegistryBridge.prototype.getFacebookBridge = function () {
            if (AppRegistryBridge.instanceFacebook === null) {
                AppRegistryBridge.instanceFacebook = new FacebookBridge();
            }
            return AppRegistryBridge.instanceFacebook;
        };
        /**
           Obtain a reference to the IFile bridge.

           @return IFile bridge instance.
        */
        AppRegistryBridge.prototype.getFileBridge = function () {
            if (AppRegistryBridge.instanceFile === null) {
                AppRegistryBridge.instanceFile = new FileBridge();
            }
            return AppRegistryBridge.instanceFile;
        };
        /**
           Obtain a reference to the IFileSystem bridge.

           @return IFileSystem bridge instance.
        */
        AppRegistryBridge.prototype.getFileSystemBridge = function () {
            if (AppRegistryBridge.instanceFileSystem === null) {
                AppRegistryBridge.instanceFileSystem = new FileSystemBridge();
            }
            return AppRegistryBridge.instanceFileSystem;
        };
        /**
           Obtain a reference to the IGeolocation bridge.

           @return IGeolocation bridge instance.
        */
        AppRegistryBridge.prototype.getGeolocationBridge = function () {
            if (AppRegistryBridge.instanceGeolocation === null) {
                AppRegistryBridge.instanceGeolocation = new GeolocationBridge();
            }
            return AppRegistryBridge.instanceGeolocation;
        };
        /**
           Obtain a reference to the IGlobalization bridge.

           @return IGlobalization bridge instance.
        */
        AppRegistryBridge.prototype.getGlobalizationBridge = function () {
            if (AppRegistryBridge.instanceGlobalization === null) {
                AppRegistryBridge.instanceGlobalization = new GlobalizationBridge();
            }
            return AppRegistryBridge.instanceGlobalization;
        };
        /**
           Obtain a reference to the IGooglePlus bridge.

           @return IGooglePlus bridge instance.
        */
        AppRegistryBridge.prototype.getGooglePlusBridge = function () {
            if (AppRegistryBridge.instanceGooglePlus === null) {
                AppRegistryBridge.instanceGooglePlus = new GooglePlusBridge();
            }
            return AppRegistryBridge.instanceGooglePlus;
        };
        /**
           Obtain a reference to the IGyroscope bridge.

           @return IGyroscope bridge instance.
        */
        AppRegistryBridge.prototype.getGyroscopeBridge = function () {
            if (AppRegistryBridge.instanceGyroscope === null) {
                AppRegistryBridge.instanceGyroscope = new GyroscopeBridge();
            }
            return AppRegistryBridge.instanceGyroscope;
        };
        /**
           Obtain a reference to the IImaging bridge.

           @return IImaging bridge instance.
        */
        AppRegistryBridge.prototype.getImagingBridge = function () {
            if (AppRegistryBridge.instanceImaging === null) {
                AppRegistryBridge.instanceImaging = new ImagingBridge();
            }
            return AppRegistryBridge.instanceImaging;
        };
        /**
           Obtain a reference to the IInternalStorage bridge.

           @return IInternalStorage bridge instance.
        */
        AppRegistryBridge.prototype.getInternalStorageBridge = function () {
            if (AppRegistryBridge.instanceInternalStorage === null) {
                AppRegistryBridge.instanceInternalStorage = new InternalStorageBridge();
            }
            return AppRegistryBridge.instanceInternalStorage;
        };
        /**
           Obtain a reference to the ILifecycle bridge.

           @return ILifecycle bridge instance.
        */
        AppRegistryBridge.prototype.getLifecycleBridge = function () {
            if (AppRegistryBridge.instanceLifecycle === null) {
                AppRegistryBridge.instanceLifecycle = new LifecycleBridge();
            }
            return AppRegistryBridge.instanceLifecycle;
        };
        /**
           Obtain a reference to the ILinkedIn bridge.

           @return ILinkedIn bridge instance.
        */
        AppRegistryBridge.prototype.getLinkedInBridge = function () {
            if (AppRegistryBridge.instanceLinkedIn === null) {
                AppRegistryBridge.instanceLinkedIn = new LinkedInBridge();
            }
            return AppRegistryBridge.instanceLinkedIn;
        };
        /**
           Obtain a reference to the ILogging bridge.

           @return ILogging bridge instance.
        */
        AppRegistryBridge.prototype.getLoggingBridge = function () {
            if (AppRegistryBridge.instanceLogging === null) {
                AppRegistryBridge.instanceLogging = new LoggingBridge();
            }
            return AppRegistryBridge.instanceLogging;
        };
        /**
           Obtain a reference to the IMagnetometer bridge.

           @return IMagnetometer bridge instance.
        */
        AppRegistryBridge.prototype.getMagnetometerBridge = function () {
            if (AppRegistryBridge.instanceMagnetometer === null) {
                AppRegistryBridge.instanceMagnetometer = new MagnetometerBridge();
            }
            return AppRegistryBridge.instanceMagnetometer;
        };
        /**
           Obtain a reference to the IMail bridge.

           @return IMail bridge instance.
        */
        AppRegistryBridge.prototype.getMailBridge = function () {
            if (AppRegistryBridge.instanceMail === null) {
                AppRegistryBridge.instanceMail = new MailBridge();
            }
            return AppRegistryBridge.instanceMail;
        };
        /**
           Obtain a reference to the IManagement bridge.

           @return IManagement bridge instance.
        */
        AppRegistryBridge.prototype.getManagementBridge = function () {
            if (AppRegistryBridge.instanceManagement === null) {
                AppRegistryBridge.instanceManagement = new ManagementBridge();
            }
            return AppRegistryBridge.instanceManagement;
        };
        /**
           Obtain a reference to the IMap bridge.

           @return IMap bridge instance.
        */
        AppRegistryBridge.prototype.getMapBridge = function () {
            if (AppRegistryBridge.instanceMap === null) {
                AppRegistryBridge.instanceMap = new MapBridge();
            }
            return AppRegistryBridge.instanceMap;
        };
        /**
           Obtain a reference to the IMessaging bridge.

           @return IMessaging bridge instance.
        */
        AppRegistryBridge.prototype.getMessagingBridge = function () {
            if (AppRegistryBridge.instanceMessaging === null) {
                AppRegistryBridge.instanceMessaging = new MessagingBridge();
            }
            return AppRegistryBridge.instanceMessaging;
        };
        /**
           Obtain a reference to the INFC bridge.

           @return INFC bridge instance.
        */
        AppRegistryBridge.prototype.getNFCBridge = function () {
            if (AppRegistryBridge.instanceNFC === null) {
                AppRegistryBridge.instanceNFC = new NFCBridge();
            }
            return AppRegistryBridge.instanceNFC;
        };
        /**
           Obtain a reference to the INetworkInfo bridge.

           @return INetworkInfo bridge instance.
        */
        AppRegistryBridge.prototype.getNetworkInfoBridge = function () {
            if (AppRegistryBridge.instanceNetworkInfo === null) {
                AppRegistryBridge.instanceNetworkInfo = new NetworkInfoBridge();
            }
            return AppRegistryBridge.instanceNetworkInfo;
        };
        /**
           Obtain a reference to the INetworkNaming bridge.

           @return INetworkNaming bridge instance.
        */
        AppRegistryBridge.prototype.getNetworkNamingBridge = function () {
            if (AppRegistryBridge.instanceNetworkNaming === null) {
                AppRegistryBridge.instanceNetworkNaming = new NetworkNamingBridge();
            }
            return AppRegistryBridge.instanceNetworkNaming;
        };
        /**
           Obtain a reference to the INetworkReachability bridge.

           @return INetworkReachability bridge instance.
        */
        AppRegistryBridge.prototype.getNetworkReachabilityBridge = function () {
            if (AppRegistryBridge.instanceNetworkReachability === null) {
                AppRegistryBridge.instanceNetworkReachability = new NetworkReachabilityBridge();
            }
            return AppRegistryBridge.instanceNetworkReachability;
        };
        /**
           Obtain a reference to the INetworkStatus bridge.

           @return INetworkStatus bridge instance.
        */
        AppRegistryBridge.prototype.getNetworkStatusBridge = function () {
            if (AppRegistryBridge.instanceNetworkStatus === null) {
                AppRegistryBridge.instanceNetworkStatus = new NetworkStatusBridge();
            }
            return AppRegistryBridge.instanceNetworkStatus;
        };
        /**
           Obtain a reference to the INotification bridge.

           @return INotification bridge instance.
        */
        AppRegistryBridge.prototype.getNotificationBridge = function () {
            if (AppRegistryBridge.instanceNotification === null) {
                AppRegistryBridge.instanceNotification = new NotificationBridge();
            }
            return AppRegistryBridge.instanceNotification;
        };
        /**
           Obtain a reference to the INotificationLocal bridge.

           @return INotificationLocal bridge instance.
        */
        AppRegistryBridge.prototype.getNotificationLocalBridge = function () {
            if (AppRegistryBridge.instanceNotificationLocal === null) {
                AppRegistryBridge.instanceNotificationLocal = new NotificationLocalBridge();
            }
            return AppRegistryBridge.instanceNotificationLocal;
        };
        /**
           Obtain a reference to the IOAuth bridge.

           @return IOAuth bridge instance.
        */
        AppRegistryBridge.prototype.getOAuthBridge = function () {
            if (AppRegistryBridge.instanceOAuth === null) {
                AppRegistryBridge.instanceOAuth = new OAuthBridge();
            }
            return AppRegistryBridge.instanceOAuth;
        };
        /**
           Obtain a reference to the IOCR bridge.

           @return IOCR bridge instance.
        */
        AppRegistryBridge.prototype.getOCRBridge = function () {
            if (AppRegistryBridge.instanceOCR === null) {
                AppRegistryBridge.instanceOCR = new OCRBridge();
            }
            return AppRegistryBridge.instanceOCR;
        };
        /**
           Obtain a reference to the IOS bridge.

           @return IOS bridge instance.
        */
        AppRegistryBridge.prototype.getOSBridge = function () {
            if (AppRegistryBridge.instanceOS === null) {
                AppRegistryBridge.instanceOS = new OSBridge();
            }
            return AppRegistryBridge.instanceOS;
        };
        /**
           Obtain a reference to the IOpenId bridge.

           @return IOpenId bridge instance.
        */
        AppRegistryBridge.prototype.getOpenIdBridge = function () {
            if (AppRegistryBridge.instanceOpenId === null) {
                AppRegistryBridge.instanceOpenId = new OpenIdBridge();
            }
            return AppRegistryBridge.instanceOpenId;
        };
        /**
           Obtain a reference to the IPrinting bridge.

           @return IPrinting bridge instance.
        */
        AppRegistryBridge.prototype.getPrintingBridge = function () {
            if (AppRegistryBridge.instancePrinting === null) {
                AppRegistryBridge.instancePrinting = new PrintingBridge();
            }
            return AppRegistryBridge.instancePrinting;
        };
        /**
           Obtain a reference to the IProximity bridge.

           @return IProximity bridge instance.
        */
        AppRegistryBridge.prototype.getProximityBridge = function () {
            if (AppRegistryBridge.instanceProximity === null) {
                AppRegistryBridge.instanceProximity = new ProximityBridge();
            }
            return AppRegistryBridge.instanceProximity;
        };
        /**
           Obtain a reference to the IQRCode bridge.

           @return IQRCode bridge instance.
        */
        AppRegistryBridge.prototype.getQRCodeBridge = function () {
            if (AppRegistryBridge.instanceQRCode === null) {
                AppRegistryBridge.instanceQRCode = new QRCodeBridge();
            }
            return AppRegistryBridge.instanceQRCode;
        };
        /**
           Obtain a reference to the IRSS bridge.

           @return IRSS bridge instance.
        */
        AppRegistryBridge.prototype.getRSSBridge = function () {
            if (AppRegistryBridge.instanceRSS === null) {
                AppRegistryBridge.instanceRSS = new RSSBridge();
            }
            return AppRegistryBridge.instanceRSS;
        };
        /**
           Obtain a reference to the IRuntime bridge.

           @return IRuntime bridge instance.
        */
        AppRegistryBridge.prototype.getRuntimeBridge = function () {
            if (AppRegistryBridge.instanceRuntime === null) {
                AppRegistryBridge.instanceRuntime = new RuntimeBridge();
            }
            return AppRegistryBridge.instanceRuntime;
        };
        /**
           Obtain a reference to the ISecurity bridge.

           @return ISecurity bridge instance.
        */
        AppRegistryBridge.prototype.getSecurityBridge = function () {
            if (AppRegistryBridge.instanceSecurity === null) {
                AppRegistryBridge.instanceSecurity = new SecurityBridge();
            }
            return AppRegistryBridge.instanceSecurity;
        };
        /**
           Obtain a reference to the IService bridge.

           @return IService bridge instance.
        */
        AppRegistryBridge.prototype.getServiceBridge = function () {
            if (AppRegistryBridge.instanceService === null) {
                AppRegistryBridge.instanceService = new ServiceBridge();
            }
            return AppRegistryBridge.instanceService;
        };
        /**
           Obtain a reference to the ISettings bridge.

           @return ISettings bridge instance.
        */
        AppRegistryBridge.prototype.getSettingsBridge = function () {
            if (AppRegistryBridge.instanceSettings === null) {
                AppRegistryBridge.instanceSettings = new SettingsBridge();
            }
            return AppRegistryBridge.instanceSettings;
        };
        /**
           Obtain a reference to the ISocket bridge.

           @return ISocket bridge instance.
        */
        AppRegistryBridge.prototype.getSocketBridge = function () {
            if (AppRegistryBridge.instanceSocket === null) {
                AppRegistryBridge.instanceSocket = new SocketBridge();
            }
            return AppRegistryBridge.instanceSocket;
        };
        /**
           Obtain a reference to the IStore bridge.

           @return IStore bridge instance.
        */
        AppRegistryBridge.prototype.getStoreBridge = function () {
            if (AppRegistryBridge.instanceStore === null) {
                AppRegistryBridge.instanceStore = new StoreBridge();
            }
            return AppRegistryBridge.instanceStore;
        };
        /**
           Obtain a reference to the ITelephony bridge.

           @return ITelephony bridge instance.
        */
        AppRegistryBridge.prototype.getTelephonyBridge = function () {
            if (AppRegistryBridge.instanceTelephony === null) {
                AppRegistryBridge.instanceTelephony = new TelephonyBridge();
            }
            return AppRegistryBridge.instanceTelephony;
        };
        /**
           Obtain a reference to the ITimer bridge.

           @return ITimer bridge instance.
        */
        AppRegistryBridge.prototype.getTimerBridge = function () {
            if (AppRegistryBridge.instanceTimer === null) {
                AppRegistryBridge.instanceTimer = new TimerBridge();
            }
            return AppRegistryBridge.instanceTimer;
        };
        /**
           Obtain a reference to the ITwitter bridge.

           @return ITwitter bridge instance.
        */
        AppRegistryBridge.prototype.getTwitterBridge = function () {
            if (AppRegistryBridge.instanceTwitter === null) {
                AppRegistryBridge.instanceTwitter = new TwitterBridge();
            }
            return AppRegistryBridge.instanceTwitter;
        };
        /**
           Obtain a reference to the IUI bridge.

           @return IUI bridge instance.
        */
        AppRegistryBridge.prototype.getUIBridge = function () {
            if (AppRegistryBridge.instanceUI === null) {
                AppRegistryBridge.instanceUI = new UIBridge();
            }
            return AppRegistryBridge.instanceUI;
        };
        /**
           Obtain a reference to the IUpdate bridge.

           @return IUpdate bridge instance.
        */
        AppRegistryBridge.prototype.getUpdateBridge = function () {
            if (AppRegistryBridge.instanceUpdate === null) {
                AppRegistryBridge.instanceUpdate = new UpdateBridge();
            }
            return AppRegistryBridge.instanceUpdate;
        };
        /**
           Obtain a reference to the IVibration bridge.

           @return IVibration bridge instance.
        */
        AppRegistryBridge.prototype.getVibrationBridge = function () {
            if (AppRegistryBridge.instanceVibration === null) {
                AppRegistryBridge.instanceVibration = new VibrationBridge();
            }
            return AppRegistryBridge.instanceVibration;
        };
        /**
           Obtain a reference to the IVideo bridge.

           @return IVideo bridge instance.
        */
        AppRegistryBridge.prototype.getVideoBridge = function () {
            if (AppRegistryBridge.instanceVideo === null) {
                AppRegistryBridge.instanceVideo = new VideoBridge();
            }
            return AppRegistryBridge.instanceVideo;
        };
        /**
           Obtain a reference to the IWallet bridge.

           @return IWallet bridge instance.
        */
        AppRegistryBridge.prototype.getWalletBridge = function () {
            if (AppRegistryBridge.instanceWallet === null) {
                AppRegistryBridge.instanceWallet = new WalletBridge();
            }
            return AppRegistryBridge.instanceWallet;
        };
        /**
           Obtain a reference to the IXML bridge.

           @return IXML bridge instance.
        */
        AppRegistryBridge.prototype.getXMLBridge = function () {
            if (AppRegistryBridge.instanceXML === null) {
                AppRegistryBridge.instanceXML = new XMLBridge();
            }
            return AppRegistryBridge.instanceXML;
        };
        /**
           Return the API version for the given interface.
        */
        AppRegistryBridge.prototype.getAPIVersion = function () {
            return "v2.0.3";
        };
        /**
           Singleton instance of AppRegistry.
        */
        AppRegistryBridge.instance = null;
        /**
           Singleton instances of Bridges.
        */
        AppRegistryBridge.instanceAcceleration = null;
        AppRegistryBridge.instanceAds = null;
        AppRegistryBridge.instanceAlarm = null;
        AppRegistryBridge.instanceAmbientLight = null;
        AppRegistryBridge.instanceAnalytics = null;
        AppRegistryBridge.instanceAudio = null;
        AppRegistryBridge.instanceBarcode = null;
        AppRegistryBridge.instanceBarometer = null;
        AppRegistryBridge.instanceBluetooth = null;
        AppRegistryBridge.instanceBrowser = null;
        AppRegistryBridge.instanceCalendar = null;
        AppRegistryBridge.instanceCamera = null;
        AppRegistryBridge.instanceCapabilities = null;
        AppRegistryBridge.instanceCloud = null;
        AppRegistryBridge.instanceCompression = null;
        AppRegistryBridge.instanceConcurrent = null;
        AppRegistryBridge.instanceContact = null;
        AppRegistryBridge.instanceCrypto = null;
        AppRegistryBridge.instanceDataStream = null;
        AppRegistryBridge.instanceDatabase = null;
        AppRegistryBridge.instanceDesktop = null;
        AppRegistryBridge.instanceDevice = null;
        AppRegistryBridge.instanceDisplay = null;
        AppRegistryBridge.instanceFacebook = null;
        AppRegistryBridge.instanceFile = null;
        AppRegistryBridge.instanceFileSystem = null;
        AppRegistryBridge.instanceGeolocation = null;
        AppRegistryBridge.instanceGlobalization = null;
        AppRegistryBridge.instanceGooglePlus = null;
        AppRegistryBridge.instanceGyroscope = null;
        AppRegistryBridge.instanceImaging = null;
        AppRegistryBridge.instanceInternalStorage = null;
        AppRegistryBridge.instanceLifecycle = null;
        AppRegistryBridge.instanceLinkedIn = null;
        AppRegistryBridge.instanceLogging = null;
        AppRegistryBridge.instanceMagnetometer = null;
        AppRegistryBridge.instanceMail = null;
        AppRegistryBridge.instanceManagement = null;
        AppRegistryBridge.instanceMap = null;
        AppRegistryBridge.instanceMessaging = null;
        AppRegistryBridge.instanceNFC = null;
        AppRegistryBridge.instanceNetworkInfo = null;
        AppRegistryBridge.instanceNetworkNaming = null;
        AppRegistryBridge.instanceNetworkReachability = null;
        AppRegistryBridge.instanceNetworkStatus = null;
        AppRegistryBridge.instanceNotification = null;
        AppRegistryBridge.instanceNotificationLocal = null;
        AppRegistryBridge.instanceOAuth = null;
        AppRegistryBridge.instanceOCR = null;
        AppRegistryBridge.instanceOS = null;
        AppRegistryBridge.instanceOpenId = null;
        AppRegistryBridge.instancePrinting = null;
        AppRegistryBridge.instanceProximity = null;
        AppRegistryBridge.instanceQRCode = null;
        AppRegistryBridge.instanceRSS = null;
        AppRegistryBridge.instanceRuntime = null;
        AppRegistryBridge.instanceSecurity = null;
        AppRegistryBridge.instanceService = null;
        AppRegistryBridge.instanceSettings = null;
        AppRegistryBridge.instanceSocket = null;
        AppRegistryBridge.instanceStore = null;
        AppRegistryBridge.instanceTelephony = null;
        AppRegistryBridge.instanceTimer = null;
        AppRegistryBridge.instanceTwitter = null;
        AppRegistryBridge.instanceUI = null;
        AppRegistryBridge.instanceUpdate = null;
        AppRegistryBridge.instanceVibration = null;
        AppRegistryBridge.instanceVideo = null;
        AppRegistryBridge.instanceWallet = null;
        AppRegistryBridge.instanceXML = null;
        return AppRegistryBridge;
    })();
    Adaptive.AppRegistryBridge = AppRegistryBridge;
    /**
       Enumeration ContactAddressType
    */
    var ContactAddressType = (function () {
        function ContactAddressType(value) {
            this.value = value;
        }
        ContactAddressType.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        ContactAddressType.toObject = function (object) {
            switch (object.value) {
                case "Home":
                    return ContactAddressType.Home;
                case "Work":
                    return ContactAddressType.Work;
                case "Other":
                    return ContactAddressType.Other;
                case "Unknown":
                    return ContactAddressType.Unknown;
                default:
                    return ContactAddressType.Unknown;
            }
        };
        ContactAddressType.Home = new ContactAddressType("Home");
        ContactAddressType.Work = new ContactAddressType("Work");
        ContactAddressType.Other = new ContactAddressType("Other");
        ContactAddressType.Unknown = new ContactAddressType("Unknown");
        return ContactAddressType;
    })();
    Adaptive.ContactAddressType = ContactAddressType;
    /**
       Enumeration ContactEmailType
    */
    var ContactEmailType = (function () {
        function ContactEmailType(value) {
            this.value = value;
        }
        ContactEmailType.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        ContactEmailType.toObject = function (object) {
            switch (object.value) {
                case "Personal":
                    return ContactEmailType.Personal;
                case "Work":
                    return ContactEmailType.Work;
                case "Other":
                    return ContactEmailType.Other;
                case "Unknown":
                    return ContactEmailType.Unknown;
                default:
                    return ContactEmailType.Unknown;
            }
        };
        ContactEmailType.Personal = new ContactEmailType("Personal");
        ContactEmailType.Work = new ContactEmailType("Work");
        ContactEmailType.Other = new ContactEmailType("Other");
        ContactEmailType.Unknown = new ContactEmailType("Unknown");
        return ContactEmailType;
    })();
    Adaptive.ContactEmailType = ContactEmailType;
    /**
       Enumeration ContactPersonalInfoTitle
    */
    var ContactPersonalInfoTitle = (function () {
        function ContactPersonalInfoTitle(value) {
            this.value = value;
        }
        ContactPersonalInfoTitle.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        ContactPersonalInfoTitle.toObject = function (object) {
            switch (object.value) {
                case "Mr":
                    return ContactPersonalInfoTitle.Mr;
                case "Mrs":
                    return ContactPersonalInfoTitle.Mrs;
                case "Ms":
                    return ContactPersonalInfoTitle.Ms;
                case "Dr":
                    return ContactPersonalInfoTitle.Dr;
                case "Unknown":
                    return ContactPersonalInfoTitle.Unknown;
                default:
                    return ContactPersonalInfoTitle.Unknown;
            }
        };
        ContactPersonalInfoTitle.Mr = new ContactPersonalInfoTitle("Mr");
        ContactPersonalInfoTitle.Mrs = new ContactPersonalInfoTitle("Mrs");
        ContactPersonalInfoTitle.Ms = new ContactPersonalInfoTitle("Ms");
        ContactPersonalInfoTitle.Dr = new ContactPersonalInfoTitle("Dr");
        ContactPersonalInfoTitle.Unknown = new ContactPersonalInfoTitle("Unknown");
        return ContactPersonalInfoTitle;
    })();
    Adaptive.ContactPersonalInfoTitle = ContactPersonalInfoTitle;
    /**
       Enumeration ContactPhoneType
    */
    var ContactPhoneType = (function () {
        function ContactPhoneType(value) {
            this.value = value;
        }
        ContactPhoneType.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        ContactPhoneType.toObject = function (object) {
            switch (object.value) {
                case "Mobile":
                    return ContactPhoneType.Mobile;
                case "Work":
                    return ContactPhoneType.Work;
                case "Home":
                    return ContactPhoneType.Home;
                case "Main":
                    return ContactPhoneType.Main;
                case "HomeFax":
                    return ContactPhoneType.HomeFax;
                case "WorkFax":
                    return ContactPhoneType.WorkFax;
                case "Other":
                    return ContactPhoneType.Other;
                case "Unknown":
                    return ContactPhoneType.Unknown;
                default:
                    return ContactPhoneType.Unknown;
            }
        };
        ContactPhoneType.Mobile = new ContactPhoneType("Mobile");
        ContactPhoneType.Work = new ContactPhoneType("Work");
        ContactPhoneType.Home = new ContactPhoneType("Home");
        ContactPhoneType.Main = new ContactPhoneType("Main");
        ContactPhoneType.HomeFax = new ContactPhoneType("HomeFax");
        ContactPhoneType.WorkFax = new ContactPhoneType("WorkFax");
        ContactPhoneType.Other = new ContactPhoneType("Other");
        ContactPhoneType.Unknown = new ContactPhoneType("Unknown");
        return ContactPhoneType;
    })();
    Adaptive.ContactPhoneType = ContactPhoneType;
    /**
       Enumeration ContactSocialNetwork
    */
    var ContactSocialNetwork = (function () {
        function ContactSocialNetwork(value) {
            this.value = value;
        }
        ContactSocialNetwork.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        ContactSocialNetwork.toObject = function (object) {
            switch (object.value) {
                case "Twitter":
                    return ContactSocialNetwork.Twitter;
                case "Facebook":
                    return ContactSocialNetwork.Facebook;
                case "GooglePlus":
                    return ContactSocialNetwork.GooglePlus;
                case "LinkedIn":
                    return ContactSocialNetwork.LinkedIn;
                case "Flickr":
                    return ContactSocialNetwork.Flickr;
                case "Unknown":
                    return ContactSocialNetwork.Unknown;
                default:
                    return ContactSocialNetwork.Unknown;
            }
        };
        ContactSocialNetwork.Twitter = new ContactSocialNetwork("Twitter");
        ContactSocialNetwork.Facebook = new ContactSocialNetwork("Facebook");
        ContactSocialNetwork.GooglePlus = new ContactSocialNetwork("GooglePlus");
        ContactSocialNetwork.LinkedIn = new ContactSocialNetwork("LinkedIn");
        ContactSocialNetwork.Flickr = new ContactSocialNetwork("Flickr");
        ContactSocialNetwork.Unknown = new ContactSocialNetwork("Unknown");
        return ContactSocialNetwork;
    })();
    Adaptive.ContactSocialNetwork = ContactSocialNetwork;
    /**
       Enumeration IAccelerationListenerError
    */
    var IAccelerationListenerError = (function () {
        function IAccelerationListenerError(value) {
            this.value = value;
        }
        IAccelerationListenerError.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IAccelerationListenerError.toObject = function (object) {
            switch (object.value) {
                case "Unauthorized":
                    return IAccelerationListenerError.Unauthorized;
                case "Unavailable":
                    return IAccelerationListenerError.Unavailable;
                case "Unknown":
                    return IAccelerationListenerError.Unknown;
                default:
                    return IAccelerationListenerError.Unknown;
            }
        };
        IAccelerationListenerError.Unauthorized = new IAccelerationListenerError("Unauthorized");
        IAccelerationListenerError.Unavailable = new IAccelerationListenerError("Unavailable");
        IAccelerationListenerError.Unknown = new IAccelerationListenerError("Unknown");
        return IAccelerationListenerError;
    })();
    Adaptive.IAccelerationListenerError = IAccelerationListenerError;
    /**
       Enumeration IAccelerationListenerWarning
    */
    var IAccelerationListenerWarning = (function () {
        function IAccelerationListenerWarning(value) {
            this.value = value;
        }
        IAccelerationListenerWarning.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IAccelerationListenerWarning.toObject = function (object) {
            switch (object.value) {
                case "NeedsCalibration":
                    return IAccelerationListenerWarning.NeedsCalibration;
                case "Stale":
                    return IAccelerationListenerWarning.Stale;
                case "Unknown":
                    return IAccelerationListenerWarning.Unknown;
                default:
                    return IAccelerationListenerWarning.Unknown;
            }
        };
        IAccelerationListenerWarning.NeedsCalibration = new IAccelerationListenerWarning("NeedsCalibration");
        IAccelerationListenerWarning.Stale = new IAccelerationListenerWarning("Stale");
        IAccelerationListenerWarning.Unknown = new IAccelerationListenerWarning("Unknown");
        return IAccelerationListenerWarning;
    })();
    Adaptive.IAccelerationListenerWarning = IAccelerationListenerWarning;
    /**
       Enumeration IAdaptiveRPGroup
    */
    var IAdaptiveRPGroup = (function () {
        function IAdaptiveRPGroup(value) {
            this.value = value;
        }
        IAdaptiveRPGroup.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IAdaptiveRPGroup.toObject = function (object) {
            switch (object.value) {
                case "Application":
                    return IAdaptiveRPGroup.Application;
                case "Commerce":
                    return IAdaptiveRPGroup.Commerce;
                case "Communication":
                    return IAdaptiveRPGroup.Communication;
                case "Data":
                    return IAdaptiveRPGroup.Data;
                case "Media":
                    return IAdaptiveRPGroup.Media;
                case "Notification":
                    return IAdaptiveRPGroup.Notification;
                case "PIM":
                    return IAdaptiveRPGroup.PIM;
                case "Reader":
                    return IAdaptiveRPGroup.Reader;
                case "Security":
                    return IAdaptiveRPGroup.Security;
                case "Sensor":
                    return IAdaptiveRPGroup.Sensor;
                case "Social":
                    return IAdaptiveRPGroup.Social;
                case "System":
                    return IAdaptiveRPGroup.System;
                case "UI":
                    return IAdaptiveRPGroup.UI;
                case "Util":
                    return IAdaptiveRPGroup.Util;
                case "Kernel":
                    return IAdaptiveRPGroup.Kernel;
                case "Unknown":
                    return IAdaptiveRPGroup.Unknown;
                default:
                    return IAdaptiveRPGroup.Unknown;
            }
        };
        IAdaptiveRPGroup.Application = new IAdaptiveRPGroup("Application");
        IAdaptiveRPGroup.Commerce = new IAdaptiveRPGroup("Commerce");
        IAdaptiveRPGroup.Communication = new IAdaptiveRPGroup("Communication");
        IAdaptiveRPGroup.Data = new IAdaptiveRPGroup("Data");
        IAdaptiveRPGroup.Media = new IAdaptiveRPGroup("Media");
        IAdaptiveRPGroup.Notification = new IAdaptiveRPGroup("Notification");
        IAdaptiveRPGroup.PIM = new IAdaptiveRPGroup("PIM");
        IAdaptiveRPGroup.Reader = new IAdaptiveRPGroup("Reader");
        IAdaptiveRPGroup.Security = new IAdaptiveRPGroup("Security");
        IAdaptiveRPGroup.Sensor = new IAdaptiveRPGroup("Sensor");
        IAdaptiveRPGroup.Social = new IAdaptiveRPGroup("Social");
        IAdaptiveRPGroup.System = new IAdaptiveRPGroup("System");
        IAdaptiveRPGroup.UI = new IAdaptiveRPGroup("UI");
        IAdaptiveRPGroup.Util = new IAdaptiveRPGroup("Util");
        IAdaptiveRPGroup.Kernel = new IAdaptiveRPGroup("Kernel");
        IAdaptiveRPGroup.Unknown = new IAdaptiveRPGroup("Unknown");
        return IAdaptiveRPGroup;
    })();
    Adaptive.IAdaptiveRPGroup = IAdaptiveRPGroup;
    /**
       Enumeration IButtonListenerError
    */
    var IButtonListenerError = (function () {
        function IButtonListenerError(value) {
            this.value = value;
        }
        IButtonListenerError.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IButtonListenerError.toObject = function (object) {
            switch (object.value) {
                case "Not_Present":
                    return IButtonListenerError.Not_Present;
                case "Unknown":
                    return IButtonListenerError.Unknown;
                default:
                    return IButtonListenerError.Unknown;
            }
        };
        IButtonListenerError.Not_Present = new IButtonListenerError("Not_Present");
        IButtonListenerError.Unknown = new IButtonListenerError("Unknown");
        return IButtonListenerError;
    })();
    Adaptive.IButtonListenerError = IButtonListenerError;
    /**
       Enumeration IButtonListenerWarning
    */
    var IButtonListenerWarning = (function () {
        function IButtonListenerWarning(value) {
            this.value = value;
        }
        IButtonListenerWarning.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IButtonListenerWarning.toObject = function (object) {
            switch (object.value) {
                case "Not_Implemented":
                    return IButtonListenerWarning.Not_Implemented;
                case "Unknown":
                    return IButtonListenerWarning.Unknown;
                default:
                    return IButtonListenerWarning.Unknown;
            }
        };
        IButtonListenerWarning.Not_Implemented = new IButtonListenerWarning("Not_Implemented");
        IButtonListenerWarning.Unknown = new IButtonListenerWarning("Unknown");
        return IButtonListenerWarning;
    })();
    Adaptive.IButtonListenerWarning = IButtonListenerWarning;
    /**
       Enumeration ICapabilitiesButton
    */
    var ICapabilitiesButton = (function () {
        function ICapabilitiesButton(value) {
            this.value = value;
        }
        ICapabilitiesButton.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        ICapabilitiesButton.toObject = function (object) {
            switch (object.value) {
                case "HomeButton":
                    return ICapabilitiesButton.HomeButton;
                case "BackButton":
                    return ICapabilitiesButton.BackButton;
                case "OptionButton":
                    return ICapabilitiesButton.OptionButton;
                case "Unknown":
                    return ICapabilitiesButton.Unknown;
                default:
                    return ICapabilitiesButton.Unknown;
            }
        };
        ICapabilitiesButton.HomeButton = new ICapabilitiesButton("HomeButton");
        ICapabilitiesButton.BackButton = new ICapabilitiesButton("BackButton");
        ICapabilitiesButton.OptionButton = new ICapabilitiesButton("OptionButton");
        ICapabilitiesButton.Unknown = new ICapabilitiesButton("Unknown");
        return ICapabilitiesButton;
    })();
    Adaptive.ICapabilitiesButton = ICapabilitiesButton;
    /**
       Enumeration ICapabilitiesCommunication
    */
    var ICapabilitiesCommunication = (function () {
        function ICapabilitiesCommunication(value) {
            this.value = value;
        }
        ICapabilitiesCommunication.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        ICapabilitiesCommunication.toObject = function (object) {
            switch (object.value) {
                case "Calendar":
                    return ICapabilitiesCommunication.Calendar;
                case "Contact":
                    return ICapabilitiesCommunication.Contact;
                case "Mail":
                    return ICapabilitiesCommunication.Mail;
                case "Messaging":
                    return ICapabilitiesCommunication.Messaging;
                case "Telephony":
                    return ICapabilitiesCommunication.Telephony;
                case "Unknown":
                    return ICapabilitiesCommunication.Unknown;
                default:
                    return ICapabilitiesCommunication.Unknown;
            }
        };
        ICapabilitiesCommunication.Calendar = new ICapabilitiesCommunication("Calendar");
        ICapabilitiesCommunication.Contact = new ICapabilitiesCommunication("Contact");
        ICapabilitiesCommunication.Mail = new ICapabilitiesCommunication("Mail");
        ICapabilitiesCommunication.Messaging = new ICapabilitiesCommunication("Messaging");
        ICapabilitiesCommunication.Telephony = new ICapabilitiesCommunication("Telephony");
        ICapabilitiesCommunication.Unknown = new ICapabilitiesCommunication("Unknown");
        return ICapabilitiesCommunication;
    })();
    Adaptive.ICapabilitiesCommunication = ICapabilitiesCommunication;
    /**
       Enumeration ICapabilitiesData
    */
    var ICapabilitiesData = (function () {
        function ICapabilitiesData(value) {
            this.value = value;
        }
        ICapabilitiesData.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        ICapabilitiesData.toObject = function (object) {
            switch (object.value) {
                case "Database":
                    return ICapabilitiesData.Database;
                case "File":
                    return ICapabilitiesData.File;
                case "Cloud":
                    return ICapabilitiesData.Cloud;
                case "Unknown":
                    return ICapabilitiesData.Unknown;
                default:
                    return ICapabilitiesData.Unknown;
            }
        };
        ICapabilitiesData.Database = new ICapabilitiesData("Database");
        ICapabilitiesData.File = new ICapabilitiesData("File");
        ICapabilitiesData.Cloud = new ICapabilitiesData("Cloud");
        ICapabilitiesData.Unknown = new ICapabilitiesData("Unknown");
        return ICapabilitiesData;
    })();
    Adaptive.ICapabilitiesData = ICapabilitiesData;
    /**
       Enumeration ICapabilitiesMedia
    */
    var ICapabilitiesMedia = (function () {
        function ICapabilitiesMedia(value) {
            this.value = value;
        }
        ICapabilitiesMedia.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        ICapabilitiesMedia.toObject = function (object) {
            switch (object.value) {
                case "Audio_Playback":
                    return ICapabilitiesMedia.Audio_Playback;
                case "Audio_Recording":
                    return ICapabilitiesMedia.Audio_Recording;
                case "Camera":
                    return ICapabilitiesMedia.Camera;
                case "Video_Playback":
                    return ICapabilitiesMedia.Video_Playback;
                case "Video_Recording":
                    return ICapabilitiesMedia.Video_Recording;
                case "Unknown":
                    return ICapabilitiesMedia.Unknown;
                default:
                    return ICapabilitiesMedia.Unknown;
            }
        };
        ICapabilitiesMedia.Audio_Playback = new ICapabilitiesMedia("Audio_Playback");
        ICapabilitiesMedia.Audio_Recording = new ICapabilitiesMedia("Audio_Recording");
        ICapabilitiesMedia.Camera = new ICapabilitiesMedia("Camera");
        ICapabilitiesMedia.Video_Playback = new ICapabilitiesMedia("Video_Playback");
        ICapabilitiesMedia.Video_Recording = new ICapabilitiesMedia("Video_Recording");
        ICapabilitiesMedia.Unknown = new ICapabilitiesMedia("Unknown");
        return ICapabilitiesMedia;
    })();
    Adaptive.ICapabilitiesMedia = ICapabilitiesMedia;
    /**
       Enumeration ICapabilitiesNet
    */
    var ICapabilitiesNet = (function () {
        function ICapabilitiesNet(value) {
            this.value = value;
        }
        ICapabilitiesNet.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        ICapabilitiesNet.toObject = function (object) {
            switch (object.value) {
                case "GSM":
                    return ICapabilitiesNet.GSM;
                case "GPRS":
                    return ICapabilitiesNet.GPRS;
                case "HSDPA":
                    return ICapabilitiesNet.HSDPA;
                case "LTE":
                    return ICapabilitiesNet.LTE;
                case "WIFI":
                    return ICapabilitiesNet.WIFI;
                case "Ethernet":
                    return ICapabilitiesNet.Ethernet;
                case "Unavailable":
                    return ICapabilitiesNet.Unavailable;
                case "Unknown":
                    return ICapabilitiesNet.Unknown;
                default:
                    return ICapabilitiesNet.Unknown;
            }
        };
        ICapabilitiesNet.GSM = new ICapabilitiesNet("GSM");
        ICapabilitiesNet.GPRS = new ICapabilitiesNet("GPRS");
        ICapabilitiesNet.HSDPA = new ICapabilitiesNet("HSDPA");
        ICapabilitiesNet.LTE = new ICapabilitiesNet("LTE");
        ICapabilitiesNet.WIFI = new ICapabilitiesNet("WIFI");
        ICapabilitiesNet.Ethernet = new ICapabilitiesNet("Ethernet");
        ICapabilitiesNet.Unavailable = new ICapabilitiesNet("Unavailable");
        ICapabilitiesNet.Unknown = new ICapabilitiesNet("Unknown");
        return ICapabilitiesNet;
    })();
    Adaptive.ICapabilitiesNet = ICapabilitiesNet;
    /**
       Enumeration ICapabilitiesNotification
    */
    var ICapabilitiesNotification = (function () {
        function ICapabilitiesNotification(value) {
            this.value = value;
        }
        ICapabilitiesNotification.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        ICapabilitiesNotification.toObject = function (object) {
            switch (object.value) {
                case "Alarm":
                    return ICapabilitiesNotification.Alarm;
                case "LocalNotification":
                    return ICapabilitiesNotification.LocalNotification;
                case "RemoteNotification":
                    return ICapabilitiesNotification.RemoteNotification;
                case "Vibration":
                    return ICapabilitiesNotification.Vibration;
                case "Unknown":
                    return ICapabilitiesNotification.Unknown;
                default:
                    return ICapabilitiesNotification.Unknown;
            }
        };
        ICapabilitiesNotification.Alarm = new ICapabilitiesNotification("Alarm");
        ICapabilitiesNotification.LocalNotification = new ICapabilitiesNotification("LocalNotification");
        ICapabilitiesNotification.RemoteNotification = new ICapabilitiesNotification("RemoteNotification");
        ICapabilitiesNotification.Vibration = new ICapabilitiesNotification("Vibration");
        ICapabilitiesNotification.Unknown = new ICapabilitiesNotification("Unknown");
        return ICapabilitiesNotification;
    })();
    Adaptive.ICapabilitiesNotification = ICapabilitiesNotification;
    /**
       Enumeration ICapabilitiesSensor
    */
    var ICapabilitiesSensor = (function () {
        function ICapabilitiesSensor(value) {
            this.value = value;
        }
        ICapabilitiesSensor.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        ICapabilitiesSensor.toObject = function (object) {
            switch (object.value) {
                case "Accelerometer":
                    return ICapabilitiesSensor.Accelerometer;
                case "AmbientLight":
                    return ICapabilitiesSensor.AmbientLight;
                case "Barometer":
                    return ICapabilitiesSensor.Barometer;
                case "Geolocation":
                    return ICapabilitiesSensor.Geolocation;
                case "Gyroscope":
                    return ICapabilitiesSensor.Gyroscope;
                case "Magnetometer":
                    return ICapabilitiesSensor.Magnetometer;
                case "Proximity":
                    return ICapabilitiesSensor.Proximity;
                case "Unknown":
                    return ICapabilitiesSensor.Unknown;
                default:
                    return ICapabilitiesSensor.Unknown;
            }
        };
        ICapabilitiesSensor.Accelerometer = new ICapabilitiesSensor("Accelerometer");
        ICapabilitiesSensor.AmbientLight = new ICapabilitiesSensor("AmbientLight");
        ICapabilitiesSensor.Barometer = new ICapabilitiesSensor("Barometer");
        ICapabilitiesSensor.Geolocation = new ICapabilitiesSensor("Geolocation");
        ICapabilitiesSensor.Gyroscope = new ICapabilitiesSensor("Gyroscope");
        ICapabilitiesSensor.Magnetometer = new ICapabilitiesSensor("Magnetometer");
        ICapabilitiesSensor.Proximity = new ICapabilitiesSensor("Proximity");
        ICapabilitiesSensor.Unknown = new ICapabilitiesSensor("Unknown");
        return ICapabilitiesSensor;
    })();
    Adaptive.ICapabilitiesSensor = ICapabilitiesSensor;
    /**
       Enumeration IContactFieldGroup
    */
    var IContactFieldGroup = (function () {
        function IContactFieldGroup(value) {
            this.value = value;
        }
        IContactFieldGroup.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IContactFieldGroup.toObject = function (object) {
            switch (object.value) {
                case "PERSONAL_INFO":
                    return IContactFieldGroup.PERSONAL_INFO;
                case "PROFESSIONAL_INFO":
                    return IContactFieldGroup.PROFESSIONAL_INFO;
                case "ADDRESSES":
                    return IContactFieldGroup.ADDRESSES;
                case "PHONES":
                    return IContactFieldGroup.PHONES;
                case "EMAILS":
                    return IContactFieldGroup.EMAILS;
                case "WEBSITES":
                    return IContactFieldGroup.WEBSITES;
                case "SOCIALS":
                    return IContactFieldGroup.SOCIALS;
                case "TAGS":
                    return IContactFieldGroup.TAGS;
                case "Unknown":
                    return IContactFieldGroup.Unknown;
                default:
                    return IContactFieldGroup.Unknown;
            }
        };
        IContactFieldGroup.PERSONAL_INFO = new IContactFieldGroup("PERSONAL_INFO");
        IContactFieldGroup.PROFESSIONAL_INFO = new IContactFieldGroup("PROFESSIONAL_INFO");
        IContactFieldGroup.ADDRESSES = new IContactFieldGroup("ADDRESSES");
        IContactFieldGroup.PHONES = new IContactFieldGroup("PHONES");
        IContactFieldGroup.EMAILS = new IContactFieldGroup("EMAILS");
        IContactFieldGroup.WEBSITES = new IContactFieldGroup("WEBSITES");
        IContactFieldGroup.SOCIALS = new IContactFieldGroup("SOCIALS");
        IContactFieldGroup.TAGS = new IContactFieldGroup("TAGS");
        IContactFieldGroup.Unknown = new IContactFieldGroup("Unknown");
        return IContactFieldGroup;
    })();
    Adaptive.IContactFieldGroup = IContactFieldGroup;
    /**
       Enumeration IContactFilter
    */
    var IContactFilter = (function () {
        function IContactFilter(value) {
            this.value = value;
        }
        IContactFilter.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IContactFilter.toObject = function (object) {
            switch (object.value) {
                case "HAS_PHONE":
                    return IContactFilter.HAS_PHONE;
                case "HAS_EMAIL":
                    return IContactFilter.HAS_EMAIL;
                case "HAS_ADDRESS":
                    return IContactFilter.HAS_ADDRESS;
                case "Unknown":
                    return IContactFilter.Unknown;
                default:
                    return IContactFilter.Unknown;
            }
        };
        IContactFilter.HAS_PHONE = new IContactFilter("HAS_PHONE");
        IContactFilter.HAS_EMAIL = new IContactFilter("HAS_EMAIL");
        IContactFilter.HAS_ADDRESS = new IContactFilter("HAS_ADDRESS");
        IContactFilter.Unknown = new IContactFilter("Unknown");
        return IContactFilter;
    })();
    Adaptive.IContactFilter = IContactFilter;
    /**
       Enumeration IContactPhotoResultCallbackError
    */
    var IContactPhotoResultCallbackError = (function () {
        function IContactPhotoResultCallbackError(value) {
            this.value = value;
        }
        IContactPhotoResultCallbackError.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IContactPhotoResultCallbackError.toObject = function (object) {
            switch (object.value) {
                case "NoPermission":
                    return IContactPhotoResultCallbackError.NoPermission;
                case "Wrong_Params":
                    return IContactPhotoResultCallbackError.Wrong_Params;
                case "No_Photo":
                    return IContactPhotoResultCallbackError.No_Photo;
                case "Unknown":
                    return IContactPhotoResultCallbackError.Unknown;
                default:
                    return IContactPhotoResultCallbackError.Unknown;
            }
        };
        IContactPhotoResultCallbackError.NoPermission = new IContactPhotoResultCallbackError("NoPermission");
        IContactPhotoResultCallbackError.Wrong_Params = new IContactPhotoResultCallbackError("Wrong_Params");
        IContactPhotoResultCallbackError.No_Photo = new IContactPhotoResultCallbackError("No_Photo");
        IContactPhotoResultCallbackError.Unknown = new IContactPhotoResultCallbackError("Unknown");
        return IContactPhotoResultCallbackError;
    })();
    Adaptive.IContactPhotoResultCallbackError = IContactPhotoResultCallbackError;
    /**
       Enumeration IContactPhotoResultCallbackWarning
    */
    var IContactPhotoResultCallbackWarning = (function () {
        function IContactPhotoResultCallbackWarning(value) {
            this.value = value;
        }
        IContactPhotoResultCallbackWarning.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IContactPhotoResultCallbackWarning.toObject = function (object) {
            switch (object.value) {
                case "LimitExceeded":
                    return IContactPhotoResultCallbackWarning.LimitExceeded;
                case "No_Matches":
                    return IContactPhotoResultCallbackWarning.No_Matches;
                case "Unknown":
                    return IContactPhotoResultCallbackWarning.Unknown;
                default:
                    return IContactPhotoResultCallbackWarning.Unknown;
            }
        };
        IContactPhotoResultCallbackWarning.LimitExceeded = new IContactPhotoResultCallbackWarning("LimitExceeded");
        IContactPhotoResultCallbackWarning.No_Matches = new IContactPhotoResultCallbackWarning("No_Matches");
        IContactPhotoResultCallbackWarning.Unknown = new IContactPhotoResultCallbackWarning("Unknown");
        return IContactPhotoResultCallbackWarning;
    })();
    Adaptive.IContactPhotoResultCallbackWarning = IContactPhotoResultCallbackWarning;
    /**
       Enumeration IContactResultCallbackError
    */
    var IContactResultCallbackError = (function () {
        function IContactResultCallbackError(value) {
            this.value = value;
        }
        IContactResultCallbackError.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IContactResultCallbackError.toObject = function (object) {
            switch (object.value) {
                case "NoPermission":
                    return IContactResultCallbackError.NoPermission;
                case "Wrong_Params":
                    return IContactResultCallbackError.Wrong_Params;
                case "Unknown":
                    return IContactResultCallbackError.Unknown;
                default:
                    return IContactResultCallbackError.Unknown;
            }
        };
        IContactResultCallbackError.NoPermission = new IContactResultCallbackError("NoPermission");
        IContactResultCallbackError.Wrong_Params = new IContactResultCallbackError("Wrong_Params");
        IContactResultCallbackError.Unknown = new IContactResultCallbackError("Unknown");
        return IContactResultCallbackError;
    })();
    Adaptive.IContactResultCallbackError = IContactResultCallbackError;
    /**
       Enumeration IContactResultCallbackWarning
    */
    var IContactResultCallbackWarning = (function () {
        function IContactResultCallbackWarning(value) {
            this.value = value;
        }
        IContactResultCallbackWarning.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IContactResultCallbackWarning.toObject = function (object) {
            switch (object.value) {
                case "LimitExceeded":
                    return IContactResultCallbackWarning.LimitExceeded;
                case "No_Matches":
                    return IContactResultCallbackWarning.No_Matches;
                case "Unknown":
                    return IContactResultCallbackWarning.Unknown;
                default:
                    return IContactResultCallbackWarning.Unknown;
            }
        };
        IContactResultCallbackWarning.LimitExceeded = new IContactResultCallbackWarning("LimitExceeded");
        IContactResultCallbackWarning.No_Matches = new IContactResultCallbackWarning("No_Matches");
        IContactResultCallbackWarning.Unknown = new IContactResultCallbackWarning("Unknown");
        return IContactResultCallbackWarning;
    })();
    Adaptive.IContactResultCallbackWarning = IContactResultCallbackWarning;
    /**
       Enumeration IDatabaseResultCallbackError
    */
    var IDatabaseResultCallbackError = (function () {
        function IDatabaseResultCallbackError(value) {
            this.value = value;
        }
        IDatabaseResultCallbackError.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IDatabaseResultCallbackError.toObject = function (object) {
            switch (object.value) {
                case "NoSpace":
                    return IDatabaseResultCallbackError.NoSpace;
                case "SqlException":
                    return IDatabaseResultCallbackError.SqlException;
                case "NotDeleted":
                    return IDatabaseResultCallbackError.NotDeleted;
                case "Unknown":
                    return IDatabaseResultCallbackError.Unknown;
                default:
                    return IDatabaseResultCallbackError.Unknown;
            }
        };
        IDatabaseResultCallbackError.NoSpace = new IDatabaseResultCallbackError("NoSpace");
        IDatabaseResultCallbackError.SqlException = new IDatabaseResultCallbackError("SqlException");
        IDatabaseResultCallbackError.NotDeleted = new IDatabaseResultCallbackError("NotDeleted");
        IDatabaseResultCallbackError.Unknown = new IDatabaseResultCallbackError("Unknown");
        return IDatabaseResultCallbackError;
    })();
    Adaptive.IDatabaseResultCallbackError = IDatabaseResultCallbackError;
    /**
       Enumeration IDatabaseResultCallbackWarning
    */
    var IDatabaseResultCallbackWarning = (function () {
        function IDatabaseResultCallbackWarning(value) {
            this.value = value;
        }
        IDatabaseResultCallbackWarning.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IDatabaseResultCallbackWarning.toObject = function (object) {
            switch (object.value) {
                case "DatabaseExists":
                    return IDatabaseResultCallbackWarning.DatabaseExists;
                case "IsOpen":
                    return IDatabaseResultCallbackWarning.IsOpen;
                case "Unknown":
                    return IDatabaseResultCallbackWarning.Unknown;
                default:
                    return IDatabaseResultCallbackWarning.Unknown;
            }
        };
        IDatabaseResultCallbackWarning.DatabaseExists = new IDatabaseResultCallbackWarning("DatabaseExists");
        IDatabaseResultCallbackWarning.IsOpen = new IDatabaseResultCallbackWarning("IsOpen");
        IDatabaseResultCallbackWarning.Unknown = new IDatabaseResultCallbackWarning("Unknown");
        return IDatabaseResultCallbackWarning;
    })();
    Adaptive.IDatabaseResultCallbackWarning = IDatabaseResultCallbackWarning;
    /**
       Enumeration IDatabaseTableResultCallbackError
    */
    var IDatabaseTableResultCallbackError = (function () {
        function IDatabaseTableResultCallbackError(value) {
            this.value = value;
        }
        IDatabaseTableResultCallbackError.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IDatabaseTableResultCallbackError.toObject = function (object) {
            switch (object.value) {
                case "NoSpace":
                    return IDatabaseTableResultCallbackError.NoSpace;
                case "ReadOnlyTable":
                    return IDatabaseTableResultCallbackError.ReadOnlyTable;
                case "SqlException":
                    return IDatabaseTableResultCallbackError.SqlException;
                case "DatabaseNotFound":
                    return IDatabaseTableResultCallbackError.DatabaseNotFound;
                case "NoTableFound":
                    return IDatabaseTableResultCallbackError.NoTableFound;
                case "Unknown":
                    return IDatabaseTableResultCallbackError.Unknown;
                default:
                    return IDatabaseTableResultCallbackError.Unknown;
            }
        };
        IDatabaseTableResultCallbackError.NoSpace = new IDatabaseTableResultCallbackError("NoSpace");
        IDatabaseTableResultCallbackError.ReadOnlyTable = new IDatabaseTableResultCallbackError("ReadOnlyTable");
        IDatabaseTableResultCallbackError.SqlException = new IDatabaseTableResultCallbackError("SqlException");
        IDatabaseTableResultCallbackError.DatabaseNotFound = new IDatabaseTableResultCallbackError("DatabaseNotFound");
        IDatabaseTableResultCallbackError.NoTableFound = new IDatabaseTableResultCallbackError("NoTableFound");
        IDatabaseTableResultCallbackError.Unknown = new IDatabaseTableResultCallbackError("Unknown");
        return IDatabaseTableResultCallbackError;
    })();
    Adaptive.IDatabaseTableResultCallbackError = IDatabaseTableResultCallbackError;
    /**
       Enumeration IDatabaseTableResultCallbackWarning
    */
    var IDatabaseTableResultCallbackWarning = (function () {
        function IDatabaseTableResultCallbackWarning(value) {
            this.value = value;
        }
        IDatabaseTableResultCallbackWarning.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IDatabaseTableResultCallbackWarning.toObject = function (object) {
            switch (object.value) {
                case "TableExists":
                    return IDatabaseTableResultCallbackWarning.TableExists;
                case "TableLocked":
                    return IDatabaseTableResultCallbackWarning.TableLocked;
                case "NoResults":
                    return IDatabaseTableResultCallbackWarning.NoResults;
                case "Unknown":
                    return IDatabaseTableResultCallbackWarning.Unknown;
                default:
                    return IDatabaseTableResultCallbackWarning.Unknown;
            }
        };
        IDatabaseTableResultCallbackWarning.TableExists = new IDatabaseTableResultCallbackWarning("TableExists");
        IDatabaseTableResultCallbackWarning.TableLocked = new IDatabaseTableResultCallbackWarning("TableLocked");
        IDatabaseTableResultCallbackWarning.NoResults = new IDatabaseTableResultCallbackWarning("NoResults");
        IDatabaseTableResultCallbackWarning.Unknown = new IDatabaseTableResultCallbackWarning("Unknown");
        return IDatabaseTableResultCallbackWarning;
    })();
    Adaptive.IDatabaseTableResultCallbackWarning = IDatabaseTableResultCallbackWarning;
    /**
       Enumeration IFileDataLoadResultCallbackError
    */
    var IFileDataLoadResultCallbackError = (function () {
        function IFileDataLoadResultCallbackError(value) {
            this.value = value;
        }
        IFileDataLoadResultCallbackError.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IFileDataLoadResultCallbackError.toObject = function (object) {
            switch (object.value) {
                case "InexistentFile":
                    return IFileDataLoadResultCallbackError.InexistentFile;
                case "InsufficientSpace":
                    return IFileDataLoadResultCallbackError.InsufficientSpace;
                case "Unauthorized":
                    return IFileDataLoadResultCallbackError.Unauthorized;
                case "Unknown":
                    return IFileDataLoadResultCallbackError.Unknown;
                default:
                    return IFileDataLoadResultCallbackError.Unknown;
            }
        };
        IFileDataLoadResultCallbackError.InexistentFile = new IFileDataLoadResultCallbackError("InexistentFile");
        IFileDataLoadResultCallbackError.InsufficientSpace = new IFileDataLoadResultCallbackError("InsufficientSpace");
        IFileDataLoadResultCallbackError.Unauthorized = new IFileDataLoadResultCallbackError("Unauthorized");
        IFileDataLoadResultCallbackError.Unknown = new IFileDataLoadResultCallbackError("Unknown");
        return IFileDataLoadResultCallbackError;
    })();
    Adaptive.IFileDataLoadResultCallbackError = IFileDataLoadResultCallbackError;
    /**
       Enumeration IFileDataLoadResultCallbackWarning
    */
    var IFileDataLoadResultCallbackWarning = (function () {
        function IFileDataLoadResultCallbackWarning(value) {
            this.value = value;
        }
        IFileDataLoadResultCallbackWarning.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IFileDataLoadResultCallbackWarning.toObject = function (object) {
            switch (object.value) {
                case "ExceedMaximumSize":
                    return IFileDataLoadResultCallbackWarning.ExceedMaximumSize;
                case "Unknown":
                    return IFileDataLoadResultCallbackWarning.Unknown;
                default:
                    return IFileDataLoadResultCallbackWarning.Unknown;
            }
        };
        IFileDataLoadResultCallbackWarning.ExceedMaximumSize = new IFileDataLoadResultCallbackWarning("ExceedMaximumSize");
        IFileDataLoadResultCallbackWarning.Unknown = new IFileDataLoadResultCallbackWarning("Unknown");
        return IFileDataLoadResultCallbackWarning;
    })();
    Adaptive.IFileDataLoadResultCallbackWarning = IFileDataLoadResultCallbackWarning;
    /**
       Enumeration IFileDataStoreResultCallbackError
    */
    var IFileDataStoreResultCallbackError = (function () {
        function IFileDataStoreResultCallbackError(value) {
            this.value = value;
        }
        IFileDataStoreResultCallbackError.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IFileDataStoreResultCallbackError.toObject = function (object) {
            switch (object.value) {
                case "InexistentFile":
                    return IFileDataStoreResultCallbackError.InexistentFile;
                case "InsufficientSpace":
                    return IFileDataStoreResultCallbackError.InsufficientSpace;
                case "Unauthorized":
                    return IFileDataStoreResultCallbackError.Unauthorized;
                case "Unknown":
                    return IFileDataStoreResultCallbackError.Unknown;
                default:
                    return IFileDataStoreResultCallbackError.Unknown;
            }
        };
        IFileDataStoreResultCallbackError.InexistentFile = new IFileDataStoreResultCallbackError("InexistentFile");
        IFileDataStoreResultCallbackError.InsufficientSpace = new IFileDataStoreResultCallbackError("InsufficientSpace");
        IFileDataStoreResultCallbackError.Unauthorized = new IFileDataStoreResultCallbackError("Unauthorized");
        IFileDataStoreResultCallbackError.Unknown = new IFileDataStoreResultCallbackError("Unknown");
        return IFileDataStoreResultCallbackError;
    })();
    Adaptive.IFileDataStoreResultCallbackError = IFileDataStoreResultCallbackError;
    /**
       Enumeration IFileDataStoreResultCallbackWarning
    */
    var IFileDataStoreResultCallbackWarning = (function () {
        function IFileDataStoreResultCallbackWarning(value) {
            this.value = value;
        }
        IFileDataStoreResultCallbackWarning.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IFileDataStoreResultCallbackWarning.toObject = function (object) {
            switch (object.value) {
                case "ExceedMaximumSize":
                    return IFileDataStoreResultCallbackWarning.ExceedMaximumSize;
                case "Unknown":
                    return IFileDataStoreResultCallbackWarning.Unknown;
                default:
                    return IFileDataStoreResultCallbackWarning.Unknown;
            }
        };
        IFileDataStoreResultCallbackWarning.ExceedMaximumSize = new IFileDataStoreResultCallbackWarning("ExceedMaximumSize");
        IFileDataStoreResultCallbackWarning.Unknown = new IFileDataStoreResultCallbackWarning("Unknown");
        return IFileDataStoreResultCallbackWarning;
    })();
    Adaptive.IFileDataStoreResultCallbackWarning = IFileDataStoreResultCallbackWarning;
    /**
       Enumeration IFileListResultCallbackError
    */
    var IFileListResultCallbackError = (function () {
        function IFileListResultCallbackError(value) {
            this.value = value;
        }
        IFileListResultCallbackError.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IFileListResultCallbackError.toObject = function (object) {
            switch (object.value) {
                case "InexistentFile":
                    return IFileListResultCallbackError.InexistentFile;
                case "Unauthorized":
                    return IFileListResultCallbackError.Unauthorized;
                case "Unknown":
                    return IFileListResultCallbackError.Unknown;
                default:
                    return IFileListResultCallbackError.Unknown;
            }
        };
        IFileListResultCallbackError.InexistentFile = new IFileListResultCallbackError("InexistentFile");
        IFileListResultCallbackError.Unauthorized = new IFileListResultCallbackError("Unauthorized");
        IFileListResultCallbackError.Unknown = new IFileListResultCallbackError("Unknown");
        return IFileListResultCallbackError;
    })();
    Adaptive.IFileListResultCallbackError = IFileListResultCallbackError;
    /**
       Enumeration IFileListResultCallbackWarning
    */
    var IFileListResultCallbackWarning = (function () {
        function IFileListResultCallbackWarning(value) {
            this.value = value;
        }
        IFileListResultCallbackWarning.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IFileListResultCallbackWarning.toObject = function (object) {
            switch (object.value) {
                case "PartialResult":
                    return IFileListResultCallbackWarning.PartialResult;
                case "Unknown":
                    return IFileListResultCallbackWarning.Unknown;
                default:
                    return IFileListResultCallbackWarning.Unknown;
            }
        };
        IFileListResultCallbackWarning.PartialResult = new IFileListResultCallbackWarning("PartialResult");
        IFileListResultCallbackWarning.Unknown = new IFileListResultCallbackWarning("Unknown");
        return IFileListResultCallbackWarning;
    })();
    Adaptive.IFileListResultCallbackWarning = IFileListResultCallbackWarning;
    /**
       Enumeration IFileResultCallbackError
    */
    var IFileResultCallbackError = (function () {
        function IFileResultCallbackError(value) {
            this.value = value;
        }
        IFileResultCallbackError.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IFileResultCallbackError.toObject = function (object) {
            switch (object.value) {
                case "FileExists":
                    return IFileResultCallbackError.FileExists;
                case "SourceInexistent":
                    return IFileResultCallbackError.SourceInexistent;
                case "DestionationExists":
                    return IFileResultCallbackError.DestionationExists;
                case "InsufficientSpace":
                    return IFileResultCallbackError.InsufficientSpace;
                case "Unauthorized":
                    return IFileResultCallbackError.Unauthorized;
                case "Unknown":
                    return IFileResultCallbackError.Unknown;
                default:
                    return IFileResultCallbackError.Unknown;
            }
        };
        IFileResultCallbackError.FileExists = new IFileResultCallbackError("FileExists");
        IFileResultCallbackError.SourceInexistent = new IFileResultCallbackError("SourceInexistent");
        IFileResultCallbackError.DestionationExists = new IFileResultCallbackError("DestionationExists");
        IFileResultCallbackError.InsufficientSpace = new IFileResultCallbackError("InsufficientSpace");
        IFileResultCallbackError.Unauthorized = new IFileResultCallbackError("Unauthorized");
        IFileResultCallbackError.Unknown = new IFileResultCallbackError("Unknown");
        return IFileResultCallbackError;
    })();
    Adaptive.IFileResultCallbackError = IFileResultCallbackError;
    /**
       Enumeration IFileResultCallbackWarning
    */
    var IFileResultCallbackWarning = (function () {
        function IFileResultCallbackWarning(value) {
            this.value = value;
        }
        IFileResultCallbackWarning.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IFileResultCallbackWarning.toObject = function (object) {
            switch (object.value) {
                case "SourceNotDeleted":
                    return IFileResultCallbackWarning.SourceNotDeleted;
                case "RootDirectory":
                    return IFileResultCallbackWarning.RootDirectory;
                case "Unknown":
                    return IFileResultCallbackWarning.Unknown;
                default:
                    return IFileResultCallbackWarning.Unknown;
            }
        };
        IFileResultCallbackWarning.SourceNotDeleted = new IFileResultCallbackWarning("SourceNotDeleted");
        IFileResultCallbackWarning.RootDirectory = new IFileResultCallbackWarning("RootDirectory");
        IFileResultCallbackWarning.Unknown = new IFileResultCallbackWarning("Unknown");
        return IFileResultCallbackWarning;
    })();
    Adaptive.IFileResultCallbackWarning = IFileResultCallbackWarning;
    /**
       Enumeration IFileSystemSecurity
    */
    var IFileSystemSecurity = (function () {
        function IFileSystemSecurity(value) {
            this.value = value;
        }
        IFileSystemSecurity.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IFileSystemSecurity.toObject = function (object) {
            switch (object.value) {
                case "Default":
                    return IFileSystemSecurity.Default;
                case "Protected":
                    return IFileSystemSecurity.Protected;
                case "Encrypted":
                    return IFileSystemSecurity.Encrypted;
                case "Unknown":
                    return IFileSystemSecurity.Unknown;
                default:
                    return IFileSystemSecurity.Unknown;
            }
        };
        IFileSystemSecurity.Default = new IFileSystemSecurity("Default");
        IFileSystemSecurity.Protected = new IFileSystemSecurity("Protected");
        IFileSystemSecurity.Encrypted = new IFileSystemSecurity("Encrypted");
        IFileSystemSecurity.Unknown = new IFileSystemSecurity("Unknown");
        return IFileSystemSecurity;
    })();
    Adaptive.IFileSystemSecurity = IFileSystemSecurity;
    /**
       Enumeration IFileSystemStorageType
    */
    var IFileSystemStorageType = (function () {
        function IFileSystemStorageType(value) {
            this.value = value;
        }
        IFileSystemStorageType.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IFileSystemStorageType.toObject = function (object) {
            switch (object.value) {
                case "Application":
                    return IFileSystemStorageType.Application;
                case "Document":
                    return IFileSystemStorageType.Document;
                case "Cloud":
                    return IFileSystemStorageType.Cloud;
                case "Protected":
                    return IFileSystemStorageType.Protected;
                case "Cache":
                    return IFileSystemStorageType.Cache;
                case "External":
                    return IFileSystemStorageType.External;
                case "Unknown":
                    return IFileSystemStorageType.Unknown;
                default:
                    return IFileSystemStorageType.Unknown;
            }
        };
        IFileSystemStorageType.Application = new IFileSystemStorageType("Application");
        IFileSystemStorageType.Document = new IFileSystemStorageType("Document");
        IFileSystemStorageType.Cloud = new IFileSystemStorageType("Cloud");
        IFileSystemStorageType.Protected = new IFileSystemStorageType("Protected");
        IFileSystemStorageType.Cache = new IFileSystemStorageType("Cache");
        IFileSystemStorageType.External = new IFileSystemStorageType("External");
        IFileSystemStorageType.Unknown = new IFileSystemStorageType("Unknown");
        return IFileSystemStorageType;
    })();
    Adaptive.IFileSystemStorageType = IFileSystemStorageType;
    /**
       Enumeration IFileSystemType
    */
    var IFileSystemType = (function () {
        function IFileSystemType(value) {
            this.value = value;
        }
        IFileSystemType.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IFileSystemType.toObject = function (object) {
            switch (object.value) {
                case "Directory":
                    return IFileSystemType.Directory;
                case "File":
                    return IFileSystemType.File;
                case "Unknown":
                    return IFileSystemType.Unknown;
                default:
                    return IFileSystemType.Unknown;
            }
        };
        IFileSystemType.Directory = new IFileSystemType("Directory");
        IFileSystemType.File = new IFileSystemType("File");
        IFileSystemType.Unknown = new IFileSystemType("Unknown");
        return IFileSystemType;
    })();
    Adaptive.IFileSystemType = IFileSystemType;
    /**
       Enumeration IGeolocationListenerError
    */
    var IGeolocationListenerError = (function () {
        function IGeolocationListenerError(value) {
            this.value = value;
        }
        IGeolocationListenerError.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IGeolocationListenerError.toObject = function (object) {
            switch (object.value) {
                case "Disabled":
                    return IGeolocationListenerError.Disabled;
                case "RestrictedAccess":
                    return IGeolocationListenerError.RestrictedAccess;
                case "DeniedAccess":
                    return IGeolocationListenerError.DeniedAccess;
                case "StatusNotDetermined":
                    return IGeolocationListenerError.StatusNotDetermined;
                case "Unknown":
                    return IGeolocationListenerError.Unknown;
                default:
                    return IGeolocationListenerError.Unknown;
            }
        };
        IGeolocationListenerError.Disabled = new IGeolocationListenerError("Disabled");
        IGeolocationListenerError.RestrictedAccess = new IGeolocationListenerError("RestrictedAccess");
        IGeolocationListenerError.DeniedAccess = new IGeolocationListenerError("DeniedAccess");
        IGeolocationListenerError.StatusNotDetermined = new IGeolocationListenerError("StatusNotDetermined");
        IGeolocationListenerError.Unknown = new IGeolocationListenerError("Unknown");
        return IGeolocationListenerError;
    })();
    Adaptive.IGeolocationListenerError = IGeolocationListenerError;
    /**
       Enumeration IGeolocationListenerWarning
    */
    var IGeolocationListenerWarning = (function () {
        function IGeolocationListenerWarning(value) {
            this.value = value;
        }
        IGeolocationListenerWarning.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IGeolocationListenerWarning.toObject = function (object) {
            switch (object.value) {
                case "HighDoP":
                    return IGeolocationListenerWarning.HighDoP;
                case "StaleData":
                    return IGeolocationListenerWarning.StaleData;
                case "Unknown":
                    return IGeolocationListenerWarning.Unknown;
                default:
                    return IGeolocationListenerWarning.Unknown;
            }
        };
        IGeolocationListenerWarning.HighDoP = new IGeolocationListenerWarning("HighDoP");
        IGeolocationListenerWarning.StaleData = new IGeolocationListenerWarning("StaleData");
        IGeolocationListenerWarning.Unknown = new IGeolocationListenerWarning("Unknown");
        return IGeolocationListenerWarning;
    })();
    Adaptive.IGeolocationListenerWarning = IGeolocationListenerWarning;
    /**
       Enumeration ILifecycleListenerError
    */
    var ILifecycleListenerError = (function () {
        function ILifecycleListenerError(value) {
            this.value = value;
        }
        ILifecycleListenerError.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        ILifecycleListenerError.toObject = function (object) {
            switch (object.value) {
                case "Runtime":
                    return ILifecycleListenerError.Runtime;
                case "Implementation":
                    return ILifecycleListenerError.Implementation;
                case "Killed":
                    return ILifecycleListenerError.Killed;
                case "Unknown":
                    return ILifecycleListenerError.Unknown;
                default:
                    return ILifecycleListenerError.Unknown;
            }
        };
        ILifecycleListenerError.Runtime = new ILifecycleListenerError("Runtime");
        ILifecycleListenerError.Implementation = new ILifecycleListenerError("Implementation");
        ILifecycleListenerError.Killed = new ILifecycleListenerError("Killed");
        ILifecycleListenerError.Unknown = new ILifecycleListenerError("Unknown");
        return ILifecycleListenerError;
    })();
    Adaptive.ILifecycleListenerError = ILifecycleListenerError;
    /**
       Enumeration ILifecycleListenerWarning
    */
    var ILifecycleListenerWarning = (function () {
        function ILifecycleListenerWarning(value) {
            this.value = value;
        }
        ILifecycleListenerWarning.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        ILifecycleListenerWarning.toObject = function (object) {
            switch (object.value) {
                case "MemoryLow":
                    return ILifecycleListenerWarning.MemoryLow;
                case "BatteryLow":
                    return ILifecycleListenerWarning.BatteryLow;
                case "Unknown":
                    return ILifecycleListenerWarning.Unknown;
                default:
                    return ILifecycleListenerWarning.Unknown;
            }
        };
        ILifecycleListenerWarning.MemoryLow = new ILifecycleListenerWarning("MemoryLow");
        ILifecycleListenerWarning.BatteryLow = new ILifecycleListenerWarning("BatteryLow");
        ILifecycleListenerWarning.Unknown = new ILifecycleListenerWarning("Unknown");
        return ILifecycleListenerWarning;
    })();
    Adaptive.ILifecycleListenerWarning = ILifecycleListenerWarning;
    /**
       Enumeration ILoggingLogLevel
    */
    var ILoggingLogLevel = (function () {
        function ILoggingLogLevel(value) {
            this.value = value;
        }
        ILoggingLogLevel.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        ILoggingLogLevel.toObject = function (object) {
            switch (object.value) {
                case "DEBUG":
                    return ILoggingLogLevel.DEBUG;
                case "WARN":
                    return ILoggingLogLevel.WARN;
                case "ERROR":
                    return ILoggingLogLevel.ERROR;
                case "INFO":
                    return ILoggingLogLevel.INFO;
                case "Unknown":
                    return ILoggingLogLevel.Unknown;
                default:
                    return ILoggingLogLevel.Unknown;
            }
        };
        ILoggingLogLevel.DEBUG = new ILoggingLogLevel("DEBUG");
        ILoggingLogLevel.WARN = new ILoggingLogLevel("WARN");
        ILoggingLogLevel.ERROR = new ILoggingLogLevel("ERROR");
        ILoggingLogLevel.INFO = new ILoggingLogLevel("INFO");
        ILoggingLogLevel.Unknown = new ILoggingLogLevel("Unknown");
        return ILoggingLogLevel;
    })();
    Adaptive.ILoggingLogLevel = ILoggingLogLevel;
    /**
       Enumeration IMessagingCallbackError
    */
    var IMessagingCallbackError = (function () {
        function IMessagingCallbackError(value) {
            this.value = value;
        }
        IMessagingCallbackError.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IMessagingCallbackError.toObject = function (object) {
            switch (object.value) {
                case "SIMNotPresent":
                    return IMessagingCallbackError.SIMNotPresent;
                case "EmailAccountNotFound":
                    return IMessagingCallbackError.EmailAccountNotFound;
                case "NotSent":
                    return IMessagingCallbackError.NotSent;
                case "WrongParams":
                    return IMessagingCallbackError.WrongParams;
                case "NotSupported":
                    return IMessagingCallbackError.NotSupported;
                case "Unknown":
                    return IMessagingCallbackError.Unknown;
                default:
                    return IMessagingCallbackError.Unknown;
            }
        };
        IMessagingCallbackError.SIMNotPresent = new IMessagingCallbackError("SIMNotPresent");
        IMessagingCallbackError.EmailAccountNotFound = new IMessagingCallbackError("EmailAccountNotFound");
        IMessagingCallbackError.NotSent = new IMessagingCallbackError("NotSent");
        IMessagingCallbackError.WrongParams = new IMessagingCallbackError("WrongParams");
        IMessagingCallbackError.NotSupported = new IMessagingCallbackError("NotSupported");
        IMessagingCallbackError.Unknown = new IMessagingCallbackError("Unknown");
        return IMessagingCallbackError;
    })();
    Adaptive.IMessagingCallbackError = IMessagingCallbackError;
    /**
       Enumeration IMessagingCallbackWarning
    */
    var IMessagingCallbackWarning = (function () {
        function IMessagingCallbackWarning(value) {
            this.value = value;
        }
        IMessagingCallbackWarning.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IMessagingCallbackWarning.toObject = function (object) {
            switch (object.value) {
                case "UnableToSentAll":
                    return IMessagingCallbackWarning.UnableToSentAll;
                case "UnableToFetchAttachment":
                    return IMessagingCallbackWarning.UnableToFetchAttachment;
                case "Unknown":
                    return IMessagingCallbackWarning.Unknown;
                default:
                    return IMessagingCallbackWarning.Unknown;
            }
        };
        IMessagingCallbackWarning.UnableToSentAll = new IMessagingCallbackWarning("UnableToSentAll");
        IMessagingCallbackWarning.UnableToFetchAttachment = new IMessagingCallbackWarning("UnableToFetchAttachment");
        IMessagingCallbackWarning.Unknown = new IMessagingCallbackWarning("Unknown");
        return IMessagingCallbackWarning;
    })();
    Adaptive.IMessagingCallbackWarning = IMessagingCallbackWarning;
    /**
       Enumeration INetworkReachabilityCallbackError
    */
    var INetworkReachabilityCallbackError = (function () {
        function INetworkReachabilityCallbackError(value) {
            this.value = value;
        }
        INetworkReachabilityCallbackError.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        INetworkReachabilityCallbackError.toObject = function (object) {
            switch (object.value) {
                case "Forbidden":
                    return INetworkReachabilityCallbackError.Forbidden;
                case "NotFound":
                    return INetworkReachabilityCallbackError.NotFound;
                case "MethodNotAllowed":
                    return INetworkReachabilityCallbackError.MethodNotAllowed;
                case "NotAllowed":
                    return INetworkReachabilityCallbackError.NotAllowed;
                case "NotAuthenticated":
                    return INetworkReachabilityCallbackError.NotAuthenticated;
                case "TimeOut":
                    return INetworkReachabilityCallbackError.TimeOut;
                case "NoResponse":
                    return INetworkReachabilityCallbackError.NoResponse;
                case "Unreachable":
                    return INetworkReachabilityCallbackError.Unreachable;
                case "Wrong_Params":
                    return INetworkReachabilityCallbackError.Wrong_Params;
                case "MalformedUrl":
                    return INetworkReachabilityCallbackError.MalformedUrl;
                case "DomainUnresolvable":
                    return INetworkReachabilityCallbackError.DomainUnresolvable;
                case "Unknown":
                    return INetworkReachabilityCallbackError.Unknown;
                default:
                    return INetworkReachabilityCallbackError.Unknown;
            }
        };
        INetworkReachabilityCallbackError.Forbidden = new INetworkReachabilityCallbackError("Forbidden");
        INetworkReachabilityCallbackError.NotFound = new INetworkReachabilityCallbackError("NotFound");
        INetworkReachabilityCallbackError.MethodNotAllowed = new INetworkReachabilityCallbackError("MethodNotAllowed");
        INetworkReachabilityCallbackError.NotAllowed = new INetworkReachabilityCallbackError("NotAllowed");
        INetworkReachabilityCallbackError.NotAuthenticated = new INetworkReachabilityCallbackError("NotAuthenticated");
        INetworkReachabilityCallbackError.TimeOut = new INetworkReachabilityCallbackError("TimeOut");
        INetworkReachabilityCallbackError.NoResponse = new INetworkReachabilityCallbackError("NoResponse");
        INetworkReachabilityCallbackError.Unreachable = new INetworkReachabilityCallbackError("Unreachable");
        INetworkReachabilityCallbackError.Wrong_Params = new INetworkReachabilityCallbackError("Wrong_Params");
        INetworkReachabilityCallbackError.MalformedUrl = new INetworkReachabilityCallbackError("MalformedUrl");
        INetworkReachabilityCallbackError.DomainUnresolvable = new INetworkReachabilityCallbackError("DomainUnresolvable");
        INetworkReachabilityCallbackError.Unknown = new INetworkReachabilityCallbackError("Unknown");
        return INetworkReachabilityCallbackError;
    })();
    Adaptive.INetworkReachabilityCallbackError = INetworkReachabilityCallbackError;
    /**
       Enumeration INetworkReachabilityCallbackWarning
    */
    var INetworkReachabilityCallbackWarning = (function () {
        function INetworkReachabilityCallbackWarning(value) {
            this.value = value;
        }
        INetworkReachabilityCallbackWarning.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        INetworkReachabilityCallbackWarning.toObject = function (object) {
            switch (object.value) {
                case "IncorrectScheme":
                    return INetworkReachabilityCallbackWarning.IncorrectScheme;
                case "NotSecure":
                    return INetworkReachabilityCallbackWarning.NotSecure;
                case "NotTrusted":
                    return INetworkReachabilityCallbackWarning.NotTrusted;
                case "Redirected":
                    return INetworkReachabilityCallbackWarning.Redirected;
                case "NotRegisteredService":
                    return INetworkReachabilityCallbackWarning.NotRegisteredService;
                case "Unknown":
                    return INetworkReachabilityCallbackWarning.Unknown;
                default:
                    return INetworkReachabilityCallbackWarning.Unknown;
            }
        };
        INetworkReachabilityCallbackWarning.IncorrectScheme = new INetworkReachabilityCallbackWarning("IncorrectScheme");
        INetworkReachabilityCallbackWarning.NotSecure = new INetworkReachabilityCallbackWarning("NotSecure");
        INetworkReachabilityCallbackWarning.NotTrusted = new INetworkReachabilityCallbackWarning("NotTrusted");
        INetworkReachabilityCallbackWarning.Redirected = new INetworkReachabilityCallbackWarning("Redirected");
        INetworkReachabilityCallbackWarning.NotRegisteredService = new INetworkReachabilityCallbackWarning("NotRegisteredService");
        INetworkReachabilityCallbackWarning.Unknown = new INetworkReachabilityCallbackWarning("Unknown");
        return INetworkReachabilityCallbackWarning;
    })();
    Adaptive.INetworkReachabilityCallbackWarning = INetworkReachabilityCallbackWarning;
    /**
       Enumeration INetworkStatusListenerError
    */
    var INetworkStatusListenerError = (function () {
        function INetworkStatusListenerError(value) {
            this.value = value;
        }
        INetworkStatusListenerError.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        INetworkStatusListenerError.toObject = function (object) {
            switch (object.value) {
                case "NoPermission":
                    return INetworkStatusListenerError.NoPermission;
                case "Unreachable":
                    return INetworkStatusListenerError.Unreachable;
                case "Unknown":
                    return INetworkStatusListenerError.Unknown;
                default:
                    return INetworkStatusListenerError.Unknown;
            }
        };
        INetworkStatusListenerError.NoPermission = new INetworkStatusListenerError("NoPermission");
        INetworkStatusListenerError.Unreachable = new INetworkStatusListenerError("Unreachable");
        INetworkStatusListenerError.Unknown = new INetworkStatusListenerError("Unknown");
        return INetworkStatusListenerError;
    })();
    Adaptive.INetworkStatusListenerError = INetworkStatusListenerError;
    /**
       Enumeration INetworkStatusListenerWarning
    */
    var INetworkStatusListenerWarning = (function () {
        function INetworkStatusListenerWarning(value) {
            this.value = value;
        }
        INetworkStatusListenerWarning.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        INetworkStatusListenerWarning.toObject = function (object) {
            switch (object.value) {
                case "IpAddressNotAssigned":
                    return INetworkStatusListenerWarning.IpAddressNotAssigned;
                case "IpAddressChanged":
                    return INetworkStatusListenerWarning.IpAddressChanged;
                case "Unknown":
                    return INetworkStatusListenerWarning.Unknown;
                default:
                    return INetworkStatusListenerWarning.Unknown;
            }
        };
        INetworkStatusListenerWarning.IpAddressNotAssigned = new INetworkStatusListenerWarning("IpAddressNotAssigned");
        INetworkStatusListenerWarning.IpAddressChanged = new INetworkStatusListenerWarning("IpAddressChanged");
        INetworkStatusListenerWarning.Unknown = new INetworkStatusListenerWarning("Unknown");
        return INetworkStatusListenerWarning;
    })();
    Adaptive.INetworkStatusListenerWarning = INetworkStatusListenerWarning;
    /**
       Enumeration IOSType
    */
    var IOSType = (function () {
        function IOSType(value) {
            this.value = value;
        }
        IOSType.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IOSType.toObject = function (object) {
            switch (object.value) {
                case "iOS":
                    return IOSType.iOS;
                case "OSX":
                    return IOSType.OSX;
                case "Windows":
                    return IOSType.Windows;
                case "WindowsPhone":
                    return IOSType.WindowsPhone;
                case "Android":
                    return IOSType.Android;
                case "Linux":
                    return IOSType.Linux;
                case "Blackberry":
                    return IOSType.Blackberry;
                case "Tizen":
                    return IOSType.Tizen;
                case "FirefoxOS":
                    return IOSType.FirefoxOS;
                case "Chromium":
                    return IOSType.Chromium;
                case "Unspecified":
                    return IOSType.Unspecified;
                case "Unknown":
                    return IOSType.Unknown;
                default:
                    return IOSType.Unknown;
            }
        };
        IOSType.iOS = new IOSType("iOS");
        IOSType.OSX = new IOSType("OSX");
        IOSType.Windows = new IOSType("Windows");
        IOSType.WindowsPhone = new IOSType("WindowsPhone");
        IOSType.Android = new IOSType("Android");
        IOSType.Linux = new IOSType("Linux");
        IOSType.Blackberry = new IOSType("Blackberry");
        IOSType.Tizen = new IOSType("Tizen");
        IOSType.FirefoxOS = new IOSType("FirefoxOS");
        IOSType.Chromium = new IOSType("Chromium");
        IOSType.Unspecified = new IOSType("Unspecified");
        IOSType.Unknown = new IOSType("Unknown");
        return IOSType;
    })();
    Adaptive.IOSType = IOSType;
    /**
       Enumeration ISecurityResultCallbackError
    */
    var ISecurityResultCallbackError = (function () {
        function ISecurityResultCallbackError(value) {
            this.value = value;
        }
        ISecurityResultCallbackError.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        ISecurityResultCallbackError.toObject = function (object) {
            switch (object.value) {
                case "NoPermission":
                    return ISecurityResultCallbackError.NoPermission;
                case "NoMatchesFound":
                    return ISecurityResultCallbackError.NoMatchesFound;
                case "Unknown":
                    return ISecurityResultCallbackError.Unknown;
                default:
                    return ISecurityResultCallbackError.Unknown;
            }
        };
        ISecurityResultCallbackError.NoPermission = new ISecurityResultCallbackError("NoPermission");
        ISecurityResultCallbackError.NoMatchesFound = new ISecurityResultCallbackError("NoMatchesFound");
        ISecurityResultCallbackError.Unknown = new ISecurityResultCallbackError("Unknown");
        return ISecurityResultCallbackError;
    })();
    Adaptive.ISecurityResultCallbackError = ISecurityResultCallbackError;
    /**
       Enumeration ISecurityResultCallbackWarning
    */
    var ISecurityResultCallbackWarning = (function () {
        function ISecurityResultCallbackWarning(value) {
            this.value = value;
        }
        ISecurityResultCallbackWarning.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        ISecurityResultCallbackWarning.toObject = function (object) {
            switch (object.value) {
                case "EntryOverride":
                    return ISecurityResultCallbackWarning.EntryOverride;
                case "Unknown":
                    return ISecurityResultCallbackWarning.Unknown;
                default:
                    return ISecurityResultCallbackWarning.Unknown;
            }
        };
        ISecurityResultCallbackWarning.EntryOverride = new ISecurityResultCallbackWarning("EntryOverride");
        ISecurityResultCallbackWarning.Unknown = new ISecurityResultCallbackWarning("Unknown");
        return ISecurityResultCallbackWarning;
    })();
    Adaptive.ISecurityResultCallbackWarning = ISecurityResultCallbackWarning;
    /**
       Enumeration IServiceProtocolVersion
    */
    var IServiceProtocolVersion = (function () {
        function IServiceProtocolVersion(value) {
            this.value = value;
        }
        IServiceProtocolVersion.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IServiceProtocolVersion.toObject = function (object) {
            switch (object.value) {
                case "HttpProtocolVersion10":
                    return IServiceProtocolVersion.HttpProtocolVersion10;
                case "HttpProtocolVersion11":
                    return IServiceProtocolVersion.HttpProtocolVersion11;
                case "Unknown":
                    return IServiceProtocolVersion.Unknown;
                default:
                    return IServiceProtocolVersion.Unknown;
            }
        };
        IServiceProtocolVersion.HttpProtocolVersion10 = new IServiceProtocolVersion("HttpProtocolVersion10");
        IServiceProtocolVersion.HttpProtocolVersion11 = new IServiceProtocolVersion("HttpProtocolVersion11");
        IServiceProtocolVersion.Unknown = new IServiceProtocolVersion("Unknown");
        return IServiceProtocolVersion;
    })();
    Adaptive.IServiceProtocolVersion = IServiceProtocolVersion;
    /**
       Enumeration IServiceMethod
    */
    var IServiceMethod = (function () {
        function IServiceMethod(value) {
            this.value = value;
        }
        IServiceMethod.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IServiceMethod.toObject = function (object) {
            switch (object.value) {
                case "Post":
                    return IServiceMethod.Post;
                case "Get":
                    return IServiceMethod.Get;
                case "Unknown":
                    return IServiceMethod.Unknown;
                default:
                    return IServiceMethod.Unknown;
            }
        };
        IServiceMethod.Post = new IServiceMethod("Post");
        IServiceMethod.Get = new IServiceMethod("Get");
        IServiceMethod.Unknown = new IServiceMethod("Unknown");
        return IServiceMethod;
    })();
    Adaptive.IServiceMethod = IServiceMethod;
    /**
       Enumeration IServiceType
    */
    var IServiceType = (function () {
        function IServiceType(value) {
            this.value = value;
        }
        IServiceType.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IServiceType.toObject = function (object) {
            switch (object.value) {
                case "ServiceTypeAmfSerialization":
                    return IServiceType.ServiceTypeAmfSerialization;
                case "ServiceTypeGwtRpc":
                    return IServiceType.ServiceTypeGwtRpc;
                case "ServiceTypeOctetBinary":
                    return IServiceType.ServiceTypeOctetBinary;
                case "ServiceTypeRemotingSerialization":
                    return IServiceType.ServiceTypeRemotingSerialization;
                case "ServiceTypeRestJson":
                    return IServiceType.ServiceTypeRestJson;
                case "ServiceTypeRestXml":
                    return IServiceType.ServiceTypeRestXml;
                case "ServiceTypeSoapJson":
                    return IServiceType.ServiceTypeSoapJson;
                case "ServiceTypeSoapXml":
                    return IServiceType.ServiceTypeSoapXml;
                case "ServiceTypeXmlRpcJson":
                    return IServiceType.ServiceTypeXmlRpcJson;
                case "ServiceTypeXmlRpcXml":
                    return IServiceType.ServiceTypeXmlRpcXml;
                case "Unknown":
                    return IServiceType.Unknown;
                default:
                    return IServiceType.Unknown;
            }
        };
        IServiceType.ServiceTypeAmfSerialization = new IServiceType("ServiceTypeAmfSerialization");
        IServiceType.ServiceTypeGwtRpc = new IServiceType("ServiceTypeGwtRpc");
        IServiceType.ServiceTypeOctetBinary = new IServiceType("ServiceTypeOctetBinary");
        IServiceType.ServiceTypeRemotingSerialization = new IServiceType("ServiceTypeRemotingSerialization");
        IServiceType.ServiceTypeRestJson = new IServiceType("ServiceTypeRestJson");
        IServiceType.ServiceTypeRestXml = new IServiceType("ServiceTypeRestXml");
        IServiceType.ServiceTypeSoapJson = new IServiceType("ServiceTypeSoapJson");
        IServiceType.ServiceTypeSoapXml = new IServiceType("ServiceTypeSoapXml");
        IServiceType.ServiceTypeXmlRpcJson = new IServiceType("ServiceTypeXmlRpcJson");
        IServiceType.ServiceTypeXmlRpcXml = new IServiceType("ServiceTypeXmlRpcXml");
        IServiceType.Unknown = new IServiceType("Unknown");
        return IServiceType;
    })();
    Adaptive.IServiceType = IServiceType;
    /**
       Enumeration IServiceResultCallbackError
    */
    var IServiceResultCallbackError = (function () {
        function IServiceResultCallbackError(value) {
            this.value = value;
        }
        IServiceResultCallbackError.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IServiceResultCallbackError.toObject = function (object) {
            switch (object.value) {
                case "Forbidden":
                    return IServiceResultCallbackError.Forbidden;
                case "NotFound":
                    return IServiceResultCallbackError.NotFound;
                case "MethodNotAllowed":
                    return IServiceResultCallbackError.MethodNotAllowed;
                case "NotAllowed":
                    return IServiceResultCallbackError.NotAllowed;
                case "NotAuthenticated":
                    return IServiceResultCallbackError.NotAuthenticated;
                case "TimeOut":
                    return IServiceResultCallbackError.TimeOut;
                case "NoResponse":
                    return IServiceResultCallbackError.NoResponse;
                case "ServerError":
                    return IServiceResultCallbackError.ServerError;
                case "Unreachable":
                    return IServiceResultCallbackError.Unreachable;
                case "MalformedUrl":
                    return IServiceResultCallbackError.MalformedUrl;
                case "NotRegisteredService":
                    return IServiceResultCallbackError.NotRegisteredService;
                case "Unknown":
                    return IServiceResultCallbackError.Unknown;
                default:
                    return IServiceResultCallbackError.Unknown;
            }
        };
        IServiceResultCallbackError.Forbidden = new IServiceResultCallbackError("Forbidden");
        IServiceResultCallbackError.NotFound = new IServiceResultCallbackError("NotFound");
        IServiceResultCallbackError.MethodNotAllowed = new IServiceResultCallbackError("MethodNotAllowed");
        IServiceResultCallbackError.NotAllowed = new IServiceResultCallbackError("NotAllowed");
        IServiceResultCallbackError.NotAuthenticated = new IServiceResultCallbackError("NotAuthenticated");
        IServiceResultCallbackError.TimeOut = new IServiceResultCallbackError("TimeOut");
        IServiceResultCallbackError.NoResponse = new IServiceResultCallbackError("NoResponse");
        IServiceResultCallbackError.ServerError = new IServiceResultCallbackError("ServerError");
        IServiceResultCallbackError.Unreachable = new IServiceResultCallbackError("Unreachable");
        IServiceResultCallbackError.MalformedUrl = new IServiceResultCallbackError("MalformedUrl");
        IServiceResultCallbackError.NotRegisteredService = new IServiceResultCallbackError("NotRegisteredService");
        IServiceResultCallbackError.Unknown = new IServiceResultCallbackError("Unknown");
        return IServiceResultCallbackError;
    })();
    Adaptive.IServiceResultCallbackError = IServiceResultCallbackError;
    /**
       Enumeration IServiceResultCallbackWarning
    */
    var IServiceResultCallbackWarning = (function () {
        function IServiceResultCallbackWarning(value) {
            this.value = value;
        }
        IServiceResultCallbackWarning.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        IServiceResultCallbackWarning.toObject = function (object) {
            switch (object.value) {
                case "NotSecure":
                    return IServiceResultCallbackWarning.NotSecure;
                case "NotTrusted":
                    return IServiceResultCallbackWarning.NotTrusted;
                case "Redirected":
                    return IServiceResultCallbackWarning.Redirected;
                case "Wrong_Params":
                    return IServiceResultCallbackWarning.Wrong_Params;
                case "Unknown":
                    return IServiceResultCallbackWarning.Unknown;
                default:
                    return IServiceResultCallbackWarning.Unknown;
            }
        };
        IServiceResultCallbackWarning.NotSecure = new IServiceResultCallbackWarning("NotSecure");
        IServiceResultCallbackWarning.NotTrusted = new IServiceResultCallbackWarning("NotTrusted");
        IServiceResultCallbackWarning.Redirected = new IServiceResultCallbackWarning("Redirected");
        IServiceResultCallbackWarning.Wrong_Params = new IServiceResultCallbackWarning("Wrong_Params");
        IServiceResultCallbackWarning.Unknown = new IServiceResultCallbackWarning("Unknown");
        return IServiceResultCallbackWarning;
    })();
    Adaptive.IServiceResultCallbackWarning = IServiceResultCallbackWarning;
    /**
       Enumeration ITelephonyStatus
    */
    var ITelephonyStatus = (function () {
        function ITelephonyStatus(value) {
            this.value = value;
        }
        ITelephonyStatus.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        ITelephonyStatus.toObject = function (object) {
            switch (object.value) {
                case "Dialing":
                    return ITelephonyStatus.Dialing;
                case "Failed":
                    return ITelephonyStatus.Failed;
                case "Unknown":
                    return ITelephonyStatus.Unknown;
                default:
                    return ITelephonyStatus.Unknown;
            }
        };
        ITelephonyStatus.Dialing = new ITelephonyStatus("Dialing");
        ITelephonyStatus.Failed = new ITelephonyStatus("Failed");
        ITelephonyStatus.Unknown = new ITelephonyStatus("Unknown");
        return ITelephonyStatus;
    })();
    Adaptive.ITelephonyStatus = ITelephonyStatus;
    /**
       Enumeration LifecycleState
    */
    var LifecycleState = (function () {
        function LifecycleState(value) {
            this.value = value;
        }
        LifecycleState.prototype.toString = function () {
            return this.value;
        };
        /**
           Convert JSON parsed object to enumeration.
        */
        LifecycleState.toObject = function (object) {
            switch (object.value) {
                case "Starting":
                    return LifecycleState.Starting;
                case "Started":
                    return LifecycleState.Started;
                case "Running":
                    return LifecycleState.Running;
                case "Pausing":
                    return LifecycleState.Pausing;
                case "PausedIdle":
                    return LifecycleState.PausedIdle;
                case "PausedRun":
                    return LifecycleState.PausedRun;
                case "Resuming":
                    return LifecycleState.Resuming;
                case "Stopping":
                    return LifecycleState.Stopping;
                case "Unknown":
                    return LifecycleState.Unknown;
                default:
                    return LifecycleState.Unknown;
            }
        };
        LifecycleState.Starting = new LifecycleState("Starting");
        LifecycleState.Started = new LifecycleState("Started");
        LifecycleState.Running = new LifecycleState("Running");
        LifecycleState.Pausing = new LifecycleState("Pausing");
        LifecycleState.PausedIdle = new LifecycleState("PausedIdle");
        LifecycleState.PausedRun = new LifecycleState("PausedRun");
        LifecycleState.Resuming = new LifecycleState("Resuming");
        LifecycleState.Stopping = new LifecycleState("Stopping");
        LifecycleState.Unknown = new LifecycleState("Unknown");
        return LifecycleState;
    })();
    Adaptive.LifecycleState = LifecycleState;
})(Adaptive || (Adaptive = {}));
//# sourceMappingURL=Adaptive.js.map