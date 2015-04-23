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

import Foundation
import AdaptiveArpApi
#if os(iOS)
    import AddressBook
#endif


/**
Interface for Managing the Contact operations
Auto-generated implementation of IContact specification.
*/
public class ContactDelegate : BasePIMDelegate, IContact {
    
    /// Logger variable
    let logger : ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge()
    let loggerTag : String = "ContactDelegate"
    
    /// Constants taht defines field labels for PIM management
    var PIM_LABELS:[(key: String, value: String)] = [
        ("_$!<Anniversary>!$_","anniversary"),
        ("_$!<Assistant>!$_","assistant"),
        ("_$!<AssistantPhone>!$_","assistant"),
        ("_$!<Brother>!$_","brother"),
        ("_$!<Car>!$_","car"),
        ("_$!<Child>!$_","child"),
        ("_$!<CompanyMain>!$_","company main"),
        ("_$!<Father>!$_","father"),
        ("_$!<Friend>!$_","friend"),
        ("_$!<Home>!$_","home"),
        ("_$!<HomeFAX>!$_","home fax"),
        ("_$!<HomePage>!$_","home page"),
        ("_$!<Main>!$_","main"),
        ("_$!<Manager>!$_","manager"),
        ("_$!<Mobile>!$_","mobile"),
        ("_$!<Mother>!$_","mother"),
        ("_$!<Other>!$_","other"),
        ("_$!<Pager>!$_","pager"),
        ("_$!<Parent>!$_","parent"),
        ("_$!<Partner>!$_","partner"),
        ("_$!<Radio>!$_","radio"),
        ("_$!<Sister>!$_","sister"),
        ("_$!<Spouse>!$_","spouse"),
        ("_$!<Work>!$_","work"),
        ("_$!<WorkFAX>!$_","work fax")
    ]
    
    /// Dictionary for the relationship between iOS and the API Beans
    var PIM_ADDR_LABELS:[(key: String, value: ContactAddressType)] = [
        ("home",ContactAddressType.Home),
        ("work",ContactAddressType.Work),
        ("other",ContactAddressType.Other)
    ]
    
    /// Dictionary for the relationship between iOS and the API Beans
    var PIM_MAIL_LABELS:[(key: String, value: ContactEmailType)] = [
        ("home",ContactEmailType.Personal),
        ("work",ContactEmailType.Work),
        ("other",ContactEmailType.Other)
    ]
    
    /// Dictionary for the relationship between iOS and the API Beans
    var PIM_PHONE_LABELS:[(key: String, value: ContactPhoneType)] = [
        ("mobile",ContactPhoneType.Mobile),
        ("work",ContactPhoneType.Work),
        ("home",ContactPhoneType.Home),
        ("main",ContactPhoneType.Main),
        ("home fax",ContactPhoneType.HomeFax),
        ("work fax",ContactPhoneType.WorkFax),
        ("pager",ContactPhoneType.Other),
        ("other",ContactPhoneType.Other)
    ]
    
    /**
    Default Constructor.
    */
    public override init() {
        super.init()
    }
    
    /**
    Get all the details of a contact according to its id
    
    @param contact  id to search for
    @param callback called for return
    @since ARP1.0
    */
    public func getContact(contact : ContactUid, callback : IContactResultCallback) {
        
        // fill all tthe group fields to query all the information
        var fields: [IContactFieldGroup] = [IContactFieldGroup.PersonalInfo, IContactFieldGroup.ProfessionalInfo, IContactFieldGroup.Addresses, IContactFieldGroup.Phones, IContactFieldGroup.Emails, IContactFieldGroup.Websites, IContactFieldGroup.Socials, IContactFieldGroup.Tags]
        
        self.checkContactPermissions(callback, contact: contact, fields: fields, filter: nil, term: "")
        //self.getContactsGeneric(callback, contact: contact, fields: fields, filter: nil, term: "")
    }
    
    /**
    Get the contact photo
    
    @param contact  id to search for
    @param callback called for return
    @since ARP1.0
    */
    public func getContactPhoto(contact : ContactUid, callback : IContactPhotoResultCallback) {
        
        #if os(iOS)
            
            // Get the address book and the contact list
            var addressBook: ABAddressBookRef? = extractABAddressBookRef(ABAddressBookCreateWithOptions(nil, nil))
            
            // Get the ID for the contact
            var id:Int32 = Int32(contact.getContactId()!.toInt()!)
            
            if(ABAddressBookGetPersonWithRecordID(addressBook, id) == nil) {
                logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "The contact with id: \(id) is not founded in the address book for getting the picture")
                callback.onWarning([UInt8](), warning: IContactPhotoResultCallbackWarning.NoMatches)
                return
            }
            
            var person:ABRecordRef = ABAddressBookGetPersonWithRecordID(addressBook, id).takeUnretainedValue()
            logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Quering for one person id: \(id)")
            
            // If the person has no photo
            if !ABPersonHasImageData(person) {
                logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The contact with id: \(id) has NO photo")
                callback.onError(IContactPhotoResultCallbackError.NoPhoto)
                return
            }
            
            var image:NSData = ABPersonCopyImageData(person).takeUnretainedValue()
            
            // Create an array and get the bytes for the image
            let count = image.length
            var array = [UInt8](count: count, repeatedValue: 0)
            image.getBytes(&array, length:count * sizeof(UInt32))
            
            // call the result callback
            callback.onResult(array)
            
        #endif
        #if os(OSX)
            
            // TODO: implement this for OSX
            
        #endif
    }
    
    /**
    Get all contacts
    
    @param callback called for return
    @since ARP1.0
    */
    public func getContacts(callback : IContactResultCallback) {
        
        // fill all tthe group fields to query all the information
        var fields: [IContactFieldGroup] = [IContactFieldGroup.PersonalInfo, IContactFieldGroup.ProfessionalInfo, IContactFieldGroup.Addresses, IContactFieldGroup.Phones, IContactFieldGroup.Emails, IContactFieldGroup.Websites, IContactFieldGroup.Socials, IContactFieldGroup.Tags]
        
        //self.getContactsGeneric(callback, contact: nil, fields: fields, filter: nil, term: "")
        self.checkContactPermissions(callback, contact: nil, fields: fields, filter: nil, term: "")
    }
    
    /**
    Get marked fields of all contacts
    
    @param callback called for return
    @param fields   to get for each Contact
    @since ARP1.0
    */
    public func getContactsForFields(callback : IContactResultCallback, fields : [IContactFieldGroup]) {
        
        //self.getContactsGeneric(callback, contact: nil, fields: fields, filter: nil, term: "")
        self.checkContactPermissions(callback, contact: nil, fields: fields, filter: nil, term: "")
    }
    
    /**
    Get marked fields of all contacts according to a filter
    
    @param callback called for return
    @param fields   to get for each Contact
    @param filter   to search for
    @since ARP1.0
    */
    public func getContactsWithFilter(callback : IContactResultCallback, fields : [IContactFieldGroup], filter : [IContactFilter]) {
        
        //self.getContactsGeneric(callback, contact: nil, fields: fields, filter: filter, term: "")
        self.checkContactPermissions(callback, contact: nil, fields: fields, filter: filter, term: "")
    }
    
    /**
    Search contacts according to a term and send it to the callback
    
    @param term     string to search
    @param callback called for return
    @since ARP1.0
    */
    public func searchContacts(term : String, callback : IContactResultCallback) {
        
        // fill all tthe group fields to query all the information
        var fields: [IContactFieldGroup] = [IContactFieldGroup.PersonalInfo, IContactFieldGroup.ProfessionalInfo, IContactFieldGroup.Addresses, IContactFieldGroup.Phones, IContactFieldGroup.Emails, IContactFieldGroup.Websites, IContactFieldGroup.Socials, IContactFieldGroup.Tags]
        
        //self.getContactsGeneric(callback, contact: nil, fields: fields, filter: nil, term: term)
        self.checkContactPermissions(callback, contact: nil, fields: fields, filter: nil, term: term)
    }
    
    /**
    Search contacts according to a term with a filter and send it to the callback
    
    @param term     string to search
    @param callback called for return
    @param filter   to search for
    @since ARP1.0
    */
    public func searchContactsWithFilter(term : String, callback : IContactResultCallback, filter : [IContactFilter]) {
        
        // fill all tthe group fields to query all the information
        var fields: [IContactFieldGroup] = [IContactFieldGroup.PersonalInfo, IContactFieldGroup.ProfessionalInfo, IContactFieldGroup.Addresses, IContactFieldGroup.Phones, IContactFieldGroup.Emails, IContactFieldGroup.Websites, IContactFieldGroup.Socials, IContactFieldGroup.Tags]
        
        //self.getContactsGeneric(callback, contact: nil, fields: fields, filter: filter, term: term)
        self.checkContactPermissions(callback, contact: nil, fields: fields, filter: filter, term: term)
    }
    
    /**
    Set the contact photo
    
    @param contact  id to assign the photo
    @param pngImage photo as byte array
    @return true if set is successful;false otherwise
    @since ARP1.0
    */
    public func setContactPhoto(contact : ContactUid, pngImage : [UInt8]) -> Bool? {
        
        #if os(iOS)
            
            // Get the address book and the contact list
            var addressBook: ABAddressBookRef? = extractABAddressBookRef(ABAddressBookCreateWithOptions(nil, nil))
            
            // Get the ID for the contact
            var id:Int32 = Int32(contact.getContactId()!.toInt()!)
            
            if(ABAddressBookGetPersonWithRecordID(addressBook, id) == nil) {
                logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "The contact with id: \(id) is not founded in the address book for setting the picture")
                return false
            }
            
            var person:ABRecordRef = ABAddressBookGetPersonWithRecordID(addressBook, id).takeUnretainedValue()
            logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Quering for one person id: \(id)")
            
            var data: NSData = NSData(bytes: pngImage, length: pngImage.count)
            
            
            if ABPersonSetImageData(person, data, nil) {
                
                if ABAddressBookHasUnsavedChanges(addressBook){
                    
                    if ABAddressBookSave(addressBook, nil) {
                        return true
                    } else {
                        logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "There is an error saving the address book")
                        return false
                    }
                } else {
                    logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "There are no changes to save in the address book")
                    return false
                }
            } else {
                
                logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "There is an error trying to set the image for a contact")
                return false
            }
            
        #endif
        #if os(OSX)
            
            // TODO: implement this for OSX
            return false
            
        #endif
    }
    
    
    
    /**
    Get Formated label from ios label
    
    @param nonFormatedLabel ios label for type
    @return Formated label
    */
    private func getLabel(nonFormatedLabel: String?) -> String {
        
        if let label = nonFormatedLabel {
            for (key, value) in PIM_LABELS {
                if key == nonFormatedLabel {
                    return value
                }
            }
            return "other"
        } else {
            return "other"
        }
    }
    
    /**
    Get Address formated label from ios label
    
    @param  addressType ios label for address
    @return API Bean for address type
    */
    private func getAddressTypeLabel(addressType: String) -> ContactAddressType {
        
        for (key, value) in PIM_ADDR_LABELS {
            if key == addressType {
                return value
            }
        }
        
        return ContactAddressType.Other
    }
    
    /**
    Get mail formated label from ios label
    
    @param  mailType ios label for mail
    @return API Bean for mail type
    */
    private func getMailTypeLabel(mailType: String) -> ContactEmailType {
        
        for (key, value) in PIM_MAIL_LABELS {
            if key == mailType {
                return value
            }
        }
        
        return ContactEmailType.Other
    }
    
    /**
    Get Phone formated label from ios label
    
    @param  phoneType ios label for phone
    @return API Bean for phone type
    */
    private func getPhoneTypeLabel(phoneType: String) -> ContactPhoneType {
        
        for (key, value) in PIM_PHONE_LABELS {
            if key == phoneType {
                return value
            }
        }
        
        return ContactPhoneType.Other
    }
    
    /**
    Method that returns a reference to the Address Book
    
    @param  abRef Address Book reference
    @return Address Book reference
    */
    #if os(iOS)
    private func extractABAddressBookRef(abRef: Unmanaged<ABAddressBookRef>!) -> ABAddressBookRef? {
        
        if let ab = abRef {
            return ab.takeUnretainedValue()
        }
        return nil
    }
    #endif
    
    /**
    Checks permission to acces to Address Book
    
    @param  callback Callback for error and warning responses
    @return true if granted access, false otherwise
    */
    private func checkContactPermissions(callback: IContactResultCallback, contact: ContactUid?, fields: [IContactFieldGroup]?, filter: [IContactFilter]?, term: String) {
        
        #if os(iOS)
            
            //let anyCallback: AnyObject = callback
            
            if (ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.NotDetermined) {
                
                // Authoritzation not determined
                
                var errorRef: Unmanaged<CFError>? = nil
                
                var addressBook: ABAddressBookRef? = extractABAddressBookRef(ABAddressBookCreateWithOptions(nil, &errorRef))
                
                ABAddressBookRequestAccessWithCompletion(addressBook, { (success, error) -> Void in
                    if success {
                        self.logger.log(ILoggingLogLevel.Debug, category: self.loggerTag, message: "Addres Book authorization AUTHORIZED")
                        self.getContactsGeneric(callback, contact: contact, fields: fields, filter: filter, term: term)
                    }
                    else {
                        self.logger.log(ILoggingLogLevel.Error, category: self.loggerTag, message: "Addres Book authorization DENIED")
                        callback.onError(IContactResultCallbackError.NoPermission)
                    }
                })
            }
            else if (ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.Denied) {
                
                // Authorization Denied
                
                logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Addres Book authorization DENIED")
                callback.onError(IContactResultCallbackError.NoPermission)
            }
            else if (ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.Restricted) {
                
                // Authorization Restricted
                
                logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Addres Book authorization RESTRICTED")
                callback.onError(IContactResultCallbackError.NoPermission)
            }
            else if (ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.Authorized) {
                
                // Authorization Authorized
                
                logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Addres Book authorization AUTHORIZED")
                self.getContactsGeneric(callback, contact: contact, fields: fields, filter: filter, term: term)
            }
            
        #endif
        #if os(OSX)
            
            // TODO: implement this for OSX
            
        #endif
        
    }
    
    /**
    This function covers all the ways to call the PIM Api, this function is the delegate for all the other functions
    
    @param callback Callback to launch when the operation finishes
    @param contact  ContaUid to query all the parameters
    @param fields   Group of fields to query
    @param filter   Predefined filters to query to database
    @param term     Term to find
    */
    private func getContactsGeneric(callback: IContactResultCallback, contact: ContactUid?, fields: [IContactFieldGroup]?, filter: [IContactFilter]?, term: String) {
        
        #if os(iOS)
            
            // Get the address book and the contact list
            var addressBook: ABAddressBookRef? = extractABAddressBookRef(ABAddressBookCreateWithOptions(nil, nil))
            
            // Array for storing the contacts
            var contactList: [ABRecordRef] = [ABRecordRef]()
            
            var contacts: [Contact] = [Contact]()
            
            if var contact:ContactUid = contact {
                
                /*
                * ONE CONTACT
                */
                
                // Query only for one contact
                var id:Int32 = Int32(contact.getContactId()!.toInt()!)
                
                if(ABAddressBookGetPersonWithRecordID(addressBook, id) == nil) {
                    logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "The contact with id: \(id) is not founded in the address book")
                    callback.onWarning([Contact](), warning: IContactResultCallbackWarning.NoMatches)
                    return
                }
                
                var person:ABRecordRef = ABAddressBookGetPersonWithRecordID(addressBook, id).takeUnretainedValue()
                logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Quering for one person id: \(id)")
                
                // Apend only one person into the array
                contactList.append(person)
                
            } else {
                
                if var filters:[IContactFilter] = filter {
                    
                    /*
                    * PREDEFINED FILTERS
                    */
                    
                    // Query for all the contacts
                    var allContacts:[ABRecordRef] = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue() as [ABRecordRef]
                    var filteredContacts: [ABRecordRef] = [ABRecordRef]()
                    
                    for record:ABRecordRef in allContacts {
                        
                        var addrNum: Int = ABMultiValueGetCount(ABRecordCopyValue(record, kABPersonAddressProperty).takeUnretainedValue() as ABMultiValueRef)
                        var mailNum: Int = ABMultiValueGetCount(ABRecordCopyValue(record, kABPersonEmailProperty).takeUnretainedValue() as ABMultiValueRef)
                        var phonNum: Int = ABMultiValueGetCount(ABRecordCopyValue(record, kABPersonPhoneProperty).takeUnretainedValue() as ABMultiValueRef)
                        
                        
                        // Look for all the possible filters combinations and the number of ocurrences
                        // If the filter combination matches and the record has values for this combination, add to the iteration list
                        var a = find(filters, IContactFilter.HasAddress)
                        var m = find(filters, IContactFilter.HasEmail)
                        var p = find(filters, IContactFilter.HasPhone)
                        
                        if a != nil && m != nil && p != nil {
                            if addrNum > 0 && mailNum > 0 && phonNum > 0 { filteredContacts.append(record) }
                        } else if a != nil && m != nil {
                            if addrNum > 0 && mailNum > 0 { filteredContacts.append(record) }
                        } else if a != nil && p != nil {
                            if addrNum > 0 && phonNum > 0 { filteredContacts.append(record) }
                        } else if m != nil && p != nil {
                            if mailNum > 0 && phonNum > 0 { filteredContacts.append(record) }
                        } else if a != nil {
                            if addrNum > 0 { filteredContacts.append(record) }
                        } else if m != nil {
                            if mailNum > 0 { filteredContacts.append(record) }
                        } else if p != nil {
                            if phonNum > 0 { filteredContacts.append(record) }
                        }
                    }
                    
                    /*
                    * PREDEFINED FILTERS TERM TO FIND
                    */
                    
                    if term != "" {
                        
                        for record:ABRecordRef in filteredContacts {
                            
                            // Iterate all the contacts and check if the term exists in the display Name
                            var displayName: String = ABRecordCopyCompositeName(record).takeRetainedValue() as String
                            
                            if Utils.normalizeString(displayName).rangeOfString(Utils.normalizeString(term)) != nil{
                                contactList.append(record)
                            }
                        }
                        
                    } else {
                        
                        contactList = filteredContacts
                    }
                    
                } else {
                    
                    if term != "" {
                        
                        /*
                        * TERM TO FIND
                        */
                        
                        // Query for all the contacts
                        var allContacts:[ABRecordRef] = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue() as [ABRecordRef]
                        
                        for record:ABRecordRef in allContacts {
                            
                            // Iterate all the contacts and check if the term exists in the display Name
                            var displayName: String = ABRecordCopyCompositeName(record).takeRetainedValue() as String
                            
                            if Utils.normalizeString(displayName).rangeOfString(Utils.normalizeString(term)) != nil{
                                contactList.append(record)
                            }
                        }
                        
                    } else {
                        
                        /*
                        * ALL CONTACTS
                        */
                        
                        // Query for all the contacts
                        contactList = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue() as [ABRecordRef]
                        
                    }
                }
            }
            
            logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Number of all contacts: \(contactList.count)")
            
            // If there are no contacts
            if(contactList.count == 0) {
                logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "There are no contacts in the Address Book")
                callback.onWarning([Contact](), warning: IContactResultCallbackWarning.NoMatches)
                return
            }
            
            // Iterate all over contacts
            for record:ABRecordRef in contactList {
                
                //logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Getting information from: \(ABRecordCopyCompositeName(record).takeRetainedValue())")
                
                var contact: Contact = Contact()
                
                /*
                * UID
                */
                
                var uid: Int32 = ABRecordGetRecordID(record)
                contact.setContactId(String(uid))
                
                /*
                * Addresses
                */
                
                if var group = fields {
                    if ((find(group,IContactFieldGroup.Addresses)) != nil) {
                        
                        var contactAddressList: [ContactAddress] = [ContactAddress]()
                        
                        if let addresses = ABRecordCopyValue(record, kABPersonAddressProperty) {
                            
                            for (var i:Int=0; i < ABMultiValueGetCount(addresses.takeUnretainedValue()); i++) {
                                
                                var contactAddress: ContactAddress = ContactAddress()
                                
                                if let address = ABMultiValueCopyValueAtIndex(addresses.takeUnretainedValue(), i) {
                                    
                                    var fullAddress:String = ""
                                    
                                    if let street:String = address.takeUnretainedValue()["Street"] as? String {
                                        fullAddress += street + " "
                                    }
                                    if let zip:String = address.takeUnretainedValue()["ZIP"] as? String {
                                        fullAddress += zip + ", "
                                    }
                                    if let city:String = address.takeUnretainedValue()["City"] as? String {
                                        fullAddress += city + " "
                                    }
                                    if let country:String = address.takeUnretainedValue()["Country"] as? String {
                                        fullAddress += country + " "
                                    }
                                    if let countryCode:String = address.takeUnretainedValue()["CountryCode"] as? String {
                                        fullAddress += "(" + countryCode + ")"
                                    }
                                    
                                    contactAddress.setAddress(fullAddress)
                                    
                                }
                                
                                if let addressLabel = ABMultiValueCopyLabelAtIndex(addresses.takeUnretainedValue(), i) {
                                    contactAddress.setType(self.getAddressTypeLabel(addressLabel.takeUnretainedValue() as String))
                                }
                                
                                contactAddressList.append(contactAddress)
                            }
                            contact.setContactAddresses(contactAddressList)
                        }
                    }
                }
                
                /*
                * Emails
                */
                
                if var group = fields {
                    if ((find(group,IContactFieldGroup.Emails)) != nil) {
                        
                        var contactEmailsList: [ContactEmail] = [ContactEmail]()
                        
                        if let emails = ABRecordCopyValue(record, kABPersonEmailProperty) {
                            
                            for (var i:Int=0; i < ABMultiValueGetCount(emails.takeUnretainedValue()); i++) {
                                
                                var contactEmail: ContactEmail = ContactEmail()
                                
                                if let email = ABMultiValueCopyValueAtIndex(emails.takeUnretainedValue(), i) {
                                    contactEmail.setEmail(email.takeUnretainedValue() as! String)
                                }
                                
                                if let emailLabel = ABMultiValueCopyLabelAtIndex(emails.takeUnretainedValue(), i) {
                                    contactEmail.setType(self.getMailTypeLabel(emailLabel.takeUnretainedValue() as String))
                                }
                                
                                contactEmailsList.append(contactEmail)
                            }
                            contact.setContactEmails(contactEmailsList)
                        }
                    }
                }
                
                /*
                * Phones
                */
                
                if var group = fields {
                    if ((find(group,IContactFieldGroup.Phones)) != nil) {
                        
                        var contactPhoneList: [ContactPhone] = [ContactPhone]()
                        
                        if let phones = ABRecordCopyValue(record, kABPersonPhoneProperty) {
                            
                            for (var i:Int=0; i < ABMultiValueGetCount(phones.takeUnretainedValue()); i++) {
                                
                                var contactPhone: ContactPhone = ContactPhone()
                                
                                if let phone = ABMultiValueCopyValueAtIndex(phones.takeUnretainedValue(), i) {
                                    contactPhone.setPhone(phone.takeUnretainedValue() as! String)
                                }
                                
                                if let phoneLabel = ABMultiValueCopyLabelAtIndex(phones.takeUnretainedValue(), i) {
                                    contactPhone.setPhoneType(self.getPhoneTypeLabel(phoneLabel.takeUnretainedValue() as String))
                                }
                                
                                contactPhoneList.append(contactPhone)
                            }
                            
                            contact.setContactPhones(contactPhoneList)
                            
                        }
                    }
                }
                
                /*
                * Socials
                */
                
                if var group = fields {
                    if ((find(group,IContactFieldGroup.Socials)) != nil) {
                        
                        var contactSocialList: [ContactSocial] = [ContactSocial]()
                        
                        if let socials = ABRecordCopyValue(record, kABPersonSocialProfileProperty) {
                            
                            for (var i:Int=0; i < ABMultiValueGetCount(socials.takeUnretainedValue()); i++) {
                                
                                var contactSocial:ContactSocial = ContactSocial()
                                
                                if let social = ABMultiValueCopyValueAtIndex(socials.takeUnretainedValue(), i) {
                                    var socialNetwork:String = social.takeUnretainedValue()["service"] as! String
                                    switch(socialNetwork){
                                    case "facebook":
                                        contactSocial.setSocialNetwork(ContactSocialNetwork.Facebook)
                                    case "flickr":
                                        contactSocial.setSocialNetwork(ContactSocialNetwork.Flickr)
                                    case "google+":
                                        contactSocial.setSocialNetwork(ContactSocialNetwork.GooglePlus)
                                    case "linkedin":
                                        contactSocial.setSocialNetwork(ContactSocialNetwork.LinkedIn)
                                    case "twitter":
                                        contactSocial.setSocialNetwork(ContactSocialNetwork.Twitter)
                                    default:
                                        logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "The social network: \(socialNetwork) is not supported by the system")
                                    }
                                    
                                    var socialURl:String = social.takeUnretainedValue()["url"] as! String
                                    contactSocial.setProfileUrl(socialURl)
                                }
                                
                                contactSocialList.append(contactSocial)
                            }
                        }
                        
                        contact.setContactSocials(contactSocialList)
                    }
                }
                
                /*
                * WEBSITES
                */
                
                if var group = fields {
                    if ((find(group,IContactFieldGroup.Websites)) != nil) {
                        
                        var contactWebsiteList: [ContactWebsite] = [ContactWebsite]()
                        
                        if let websites = ABRecordCopyValue(record, kABPersonURLProperty) {
                            
                            for (var i:Int=0; i < ABMultiValueGetCount(websites.takeUnretainedValue()); i++) {
                                
                                var contactWebsite: ContactWebsite = ContactWebsite()
                                
                                if let url = ABMultiValueCopyValueAtIndex(websites.takeUnretainedValue(), i) {
                                    contactWebsite.setUrl(url.takeUnretainedValue() as! String)
                                }
                                
                                contactWebsiteList.append(contactWebsite)
                            }
                            
                        }
                        
                        contact.setContactWebsites(contactWebsiteList)
                    }
                }
                
                /*
                * PERSONAL INFO
                */
                
                if var group = fields {
                    if ((find(group,IContactFieldGroup.PersonalInfo)) != nil) {
                        
                        var contactPersonalInfo:ContactPersonalInfo = ContactPersonalInfo()
                        
                        if let firstName = ABRecordCopyValue(record, kABPersonFirstNameProperty) {
                            contactPersonalInfo.setName(firstName.takeUnretainedValue() as! String)
                        }
                        if let lastName = ABRecordCopyValue(record, kABPersonLastNameProperty) {
                            contactPersonalInfo.setLastName(lastName.takeUnretainedValue() as! String)
                        }
                        if let middleName = ABRecordCopyValue(record, kABPersonMiddleNameProperty) {
                            contactPersonalInfo.setMiddleName(middleName.takeUnretainedValue() as! String)
                        }
                        if let prefix = ABRecordCopyValue(record, kABPersonPrefixProperty) {
                            switch(prefix.takeUnretainedValue() as! String){
                            case "Dr":
                                contactPersonalInfo.setTitle(ContactPersonalInfoTitle.Dr)
                            case "Mr":
                                contactPersonalInfo.setTitle(ContactPersonalInfoTitle.Mr)
                            case "Mrs":
                                contactPersonalInfo.setTitle(ContactPersonalInfoTitle.Mrs)
                            case "Ms":
                                contactPersonalInfo.setTitle(ContactPersonalInfoTitle.Ms)
                            default:
                                contactPersonalInfo.setTitle(ContactPersonalInfoTitle.Unknown)
                            }
                        }
                        
                        contact.setPersonalInfo(contactPersonalInfo)
                    }
                }
                
                /*
                * PROFESSIONAL INFO
                */
                
                if var group = fields {
                    if ((find(group,IContactFieldGroup.ProfessionalInfo)) != nil) {
                        
                        var contactProfessionalInfo:ContactProfessionalInfo = ContactProfessionalInfo()
                        
                        if let company = ABRecordCopyValue(record, kABPersonOrganizationProperty) {
                            contactProfessionalInfo.setCompany(company.takeUnretainedValue() as! String)
                        }
                        if let department = ABRecordCopyValue(record, kABPersonDepartmentProperty) {
                            contactProfessionalInfo.setJobDescription(department.takeUnretainedValue() as! String)
                        }
                        if let jobTitle = ABRecordCopyValue(record, kABPersonJobTitleProperty) {
                            contactProfessionalInfo.setJobTitle(jobTitle.takeUnretainedValue() as! String)
                        }
                        
                        contact.setProfessionalInfo(contactProfessionalInfo)
                    }
                }
                
                // Save the contact in the return list
                contacts.append(contact)
                
            } // for record:ABRecordRef in contactList
            
            // Fire the correct result with all the contacts
            callback.onResult(contacts)
            
        #endif
        #if os(OSX)
            
            // TODO: implement this for OSX
            
        #endif
        
    }
    
}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
