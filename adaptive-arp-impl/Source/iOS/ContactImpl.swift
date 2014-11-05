/*
* =| ADAPTIVE RUNTIME PLATFORM |=======================================================================================
*
* (C) Copyright 2013-2014 Carlos Lozano Diez t/a Adaptive.me <http://adaptive.me>.
*
* Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with
* the License. You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
* an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the
* specific language governing permissions and limitations under the License.
*
* Original author:
*
*     * Carlos Lozano Diez
*                 <http://github.com/carloslozano>
*                 <http://twitter.com/adaptivecoder>
*                 <mailto:carlos@adaptive.me>
*
* Contributors:
*
*     * Ferran Vila Conesa
*                 <http://github.com/fnva>
*                 <http://twitter.com/ferran_vila>
*                 <mailto:ferran.vila.conesa@gmail.com>
*
* =====================================================================================================================
*/

import Foundation
import AddressBook
import AdaptiveArpApiiOS

public class ContactImpl : NSObject, IContact {
    
    /// Logging variable
    let logger : ILogging = LoggingImpl()
    
    /// Return value used in some functions
    var ret: Bool
    
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
    var PIM_ADDR_LABELS:[(key: String, value: ContactAddress.AddressType)] = [
        ("home",ContactAddress.AddressType.Home),
        ("work",ContactAddress.AddressType.Work),
        ("other",ContactAddress.AddressType.Other)
    ]
    
    /// Dictionary for the relationship between iOS and the API Beans
    var PIM_MAIL_LABELS:[(key: String, value: ContactEmail.EmailType)] = [
        ("home",ContactEmail.EmailType.Personal),
        ("work",ContactEmail.EmailType.Work),
        ("other",ContactEmail.EmailType.Other)
    ]
    
    /// Dictionary for the relationship between iOS and the API Beans
    var PIM_PHONE_LABELS:[(key: String, value: ContactPhone.PhoneType)] = [
        ("mobile",ContactPhone.PhoneType.Mobile),
        ("work",ContactPhone.PhoneType.Work),
        ("home",ContactPhone.PhoneType.Home),
        ("main",ContactPhone.PhoneType.Main),
        ("home fax",ContactPhone.PhoneType.HomeFax),
        ("work fax",ContactPhone.PhoneType.WorkFax),
        ("pager",ContactPhone.PhoneType.Other),
        ("other",ContactPhone.PhoneType.Other)
    ]
    
    /**
    Class constructor
    */
    override public init() {
        
        self.ret = false
    }
    
    /**
    Get Formated label from ios label
    
    :param: nonFormatedLabel ios label for type
    
    :returns: Formated label
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    func getLabel(nonFormatedLabel: String) -> String {
        
        for (key, value) in PIM_LABELS {
            if key == nonFormatedLabel {
                return value
            }
        }
        return "other"
    }
    
    /**
    Get Address formated label from ios label
    
    :param: addressType ios label for address
    
    :returns: API Bean for address type
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    func getAddressTypeLabel(addressType: String) -> ContactAddress.AddressType {
        
        for (key, value) in PIM_ADDR_LABELS {
            if key == addressType {
                return value
            }
        }
        
        return ContactAddress.AddressType.Other
    }
    
    /**
    Get mail formated label from ios label
    
    :param: mailType ios label for mail
    
    :returns: API Bean for mail type
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    func getMailTypeLabel(mailType: String) -> ContactEmail.EmailType {
        
        for (key, value) in PIM_MAIL_LABELS {
            if key == mailType {
                return value
            }
        }
        
        return ContactEmail.EmailType.Other
    }
    
    /**
    Get Phone formated label from ios label
    
    :param: phoneType ios label for phone
    
    :returns: API Bean for phone type
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    func getPhoneTypeLabel(phoneType: String) -> ContactPhone.PhoneType {
        
        for (key, value) in PIM_PHONE_LABELS {
            if key == phoneType {
                return value
            }
        }
        
        return ContactPhone.PhoneType.Other
    }
    
    /**
    Method that returns a reference to the Address Book
    
    :param: abRef Address Book reference
    
    :returns: Address Book reference
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    private func extractABAddressBookRef(abRef: Unmanaged<ABAddressBookRef>!) -> ABAddressBookRef? {
        if let ab = abRef {
            return Unmanaged<NSObject>.fromOpaque(ab.toOpaque()).takeUnretainedValue()
        }
        return nil
    }
    
    /**
    Checks permission to acces to Address Book
    
    :param: callback Callback for error and warning responses
    
    :returns: true if granted access, false otherwise
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    private func checkContactPermissions(callback: IContactResultCallback?, callbackPhoto: IContactPhotoResultCallback?) -> Bool {
        
        //let anyCallback: AnyObject = callback
        
        if (ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.NotDetermined) {
            
            // Authoritzation not determined
            
            var errorRef: Unmanaged<CFError>? = nil
            
            var addressBook: ABAddressBookRef? = extractABAddressBookRef(ABAddressBookCreateWithOptions(nil, &errorRef))
            
            ABAddressBookRequestAccessWithCompletion(addressBook, { (success, error) -> Void in
                if success {
                    self.logger.log(ILoggingLogLevel.DEBUG, category: "ContactImpl", message: "Addres Book authorization NOT DETERMINED but correct")
                    self.ret = true
                }
                else {
                    self.logger.log(ILoggingLogLevel.ERROR, category: "ContactImpl", message: "Addres Book authorization NOT DETERMINED")
                    
                    if let call = callback {
                        call.onError(IContactResultCallbackError.NoPermission)
                    } else if let call = callbackPhoto {
                        call.onError(IContactPhotoResultCallbackError.NoPermission)
                    }
                    
                    self.ret = false
                }
            })
        }
        else if (ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.Denied) {
            
            // Authorization Denied
            
            logger.log(ILoggingLogLevel.ERROR, category: "ContactImpl", message: "Addres Book authorization DENIED")
            
            if let call = callback {
                call.onError(IContactResultCallbackError.NoPermission)
            } else if let call = callbackPhoto {
                call.onError(IContactPhotoResultCallbackError.NoPermission)
            }
            
            self.ret = false
        }
        else if (ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.Restricted) {
            
            // Authorization Restricted
            
            logger.log(ILoggingLogLevel.ERROR, category: "ContactImpl", message: "Addres Book authorization RESTRICTED")
            
            if let call = callback {
                call.onError(IContactResultCallbackError.NoPermission)
            } else if let call = callbackPhoto {
                call.onError(IContactPhotoResultCallbackError.NoPermission)
            }
            
            self.ret = false
        }
        else if (ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.Authorized) {
            
            // Authorization Authorized
            
            logger.log(ILoggingLogLevel.DEBUG, category: "ContactImpl", message: "Addres Book authorization AUTHORIZED")
            self.ret = true
        }
        
        return self.ret
    }
    
    /**
    This function covers all the ways to call the PIM Api, this function is the delegate for all the other functions
    
    :param: callback Callback to launch when the operation finishes
    :param: contact  ContaUid to query all the parameters
    :param: fields   Group of fields to query
    :param: filter   Predefined filters to query to database
    :param: term     Term to find
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    private func getContactsGeneric(callback: IContactResultCallback, contact: ContactUid?, fields: [IContactFieldGroup]?, filter: [IContactFilter]?, term: String) {
        
        if self.checkContactPermissions(callback, callbackPhoto: nil) {
            
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
                var id: ABRecordID = ABRecordGetRecordID(contact.getContactId())
                
                if(ABAddressBookGetPersonWithRecordID(addressBook, id) == nil) {
                    logger.log(ILoggingLogLevel.WARN, category: "ContactImpl", message: "The contact with id: \(id) is not founded in the address book")
                    callback.onWarning([Contact](), warning: IContactResultCallbackWarning.No_Matches)
                    return
                }
                
                var person:ABRecordRef = Unmanaged.fromOpaque(ABAddressBookGetPersonWithRecordID(addressBook, id).toOpaque()).takeUnretainedValue()
                logger.log(ILoggingLogLevel.DEBUG, category: "ContactImpl", message: "Quering for one person id: \(id)")
                
                // Apend only one person into the array
                contactList.append(person)
                
            } else {
                                
                if var filters:[IContactFilter] = filter {
                    
                    /*
                    * PREDEFINED FILTERS
                    */
                    
                    // Query for all the contacts
                    var allContacts:[ABRecordRef] = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue()
                    var filteredContacts: [ABRecordRef] = [ABRecordRef]()
                    
                    for record:ABRecordRef in contactList {
                        
                        var addrNum: Int = ABMultiValueGetCount(Unmanaged.fromOpaque(ABRecordCopyValue(record, kABPersonAddressProperty).toOpaque()).takeUnretainedValue() as NSObject as ABMultiValueRef)
                        var mailNum: Int = ABMultiValueGetCount(Unmanaged.fromOpaque(ABRecordCopyValue(record, kABPersonEmailProperty).toOpaque()).takeUnretainedValue() as NSObject as ABMultiValueRef)
                        var phonNum: Int = ABMultiValueGetCount(Unmanaged.fromOpaque(ABRecordCopyValue(record, kABPersonPhoneProperty).toOpaque()).takeUnretainedValue() as NSObject as ABMultiValueRef)
                        
                        
                        // Look for all the possible filters combinations and the number of ocurrences
                        // If the filter combination matches and the record has values for this combination, add to the iteration list
                        if ((find(filters, IContactFilter.HAS_ADDRESS)) != nil) {
                            if addrNum > 0 {
                                filteredContacts.append(record)
                            }
                            
                        } else if ((find(filters, IContactFilter.HAS_EMAIL)) != nil) {
                            if mailNum > 0 {
                                filteredContacts.append(record)
                            }
                            
                        } else if ((find(filters, IContactFilter.HAS_PHONE)) != nil) {
                            if phonNum > 0 {
                                filteredContacts.append(record)
                            }
                            
                        } else if ((find(filters, IContactFilter.HAS_ADDRESS)) != nil && (find(filters, IContactFilter.HAS_EMAIL)) != nil) {
                            if addrNum > 0 && mailNum > 0 {
                                filteredContacts.append(record)
                            }
                            
                        } else if ((find(filters, IContactFilter.HAS_ADDRESS)) != nil && (find(filters, IContactFilter.HAS_PHONE)) != nil) {
                            if addrNum > 0 && phonNum > 0 {
                                filteredContacts.append(record)
                            }
                            
                        } else if ((find(filters, IContactFilter.HAS_EMAIL)) != nil && (find(filters, IContactFilter.HAS_PHONE)) != nil) {
                            if mailNum > 0 && phonNum > 0 {
                                filteredContacts.append(record)
                            }
                            
                        } else {
                            if addrNum > 0 && mailNum > 0 && phonNum > 0 {
                                filteredContacts.append(record)
                            }
                            
                        }
                    }
                    
                    /*
                    * PREDEFINED FILTERS TERM TO FIND
                    */
                    
                    if term != "" {
                        
                        for record:ABRecordRef in filteredContacts {
                            
                            // Iterate all the contacts and check if the term exists in the display Name
                            var displayName: String = ABRecordCopyCompositeName(record).takeRetainedValue()
                            
                            if displayName.rangeOfString(term) != nil{
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
                        var allContacts:[ABRecordRef] = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue()
                        
                        for record:ABRecordRef in contactList {
                            
                            // Iterate all the contacts and check if the term exists in the display Name
                            var displayName: String = ABRecordCopyCompositeName(record).takeRetainedValue()
                            
                            if displayName.rangeOfString(term) != nil{
                                contactList.append(record)
                            }
                        }
                        
                    } else {
                        
                        /*
                        * ALL CONTACTS
                        */
                        
                        // Query for all the contacts
                        contactList = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue()
                        
                    }
                }
            }
            
            logger.log(ILoggingLogLevel.DEBUG, category: "ContactImpl", message: "Number of all contacts: \(contactList.count)")
            
            // If there are no contacts
            if(contactList.count == 0) {
                logger.log(ILoggingLogLevel.WARN, category: "ContactImpl", message: "There are no contacts in the Address Book")
                callback.onWarning([Contact](), warning: IContactResultCallbackWarning.No_Matches)
                return
            }
            
            // Iterate all over contacts
            for record:ABRecordRef in contactList {
                
                logger.log(ILoggingLogLevel.WARN, category: "ContactImpl", message: "Getting information from: \(ABRecordCopyCompositeName(record).takeRetainedValue())")
                
                var contact: Contact = Contact()
                
                /*
                * UID
                */

                var uid: Int32 = ABRecordGetRecordID(record)
                contact.setContactId(String(uid))
                
                /*
                * ADDRESSES
                */
                
                if var group = fields {
                    if ((find(group,IContactFieldGroup.ADDRESSES)) != nil) {
                        
                        var contactAddressList: [ContactAddress] = [ContactAddress]()
                        
                        var addresses: ABMultiValueRef = Unmanaged.fromOpaque(ABRecordCopyValue(record, kABPersonAddressProperty).toOpaque()).takeUnretainedValue() as NSObject as ABMultiValueRef
                        
                        for (var i:Int=0; i < ABMultiValueGetCount(addresses); i++) {
                            
                            var contactAddress: ContactAddress = ContactAddress()
                            
                            var address = Unmanaged.fromOpaque(ABMultiValueCopyValueAtIndex(addresses, i).toOpaque()).takeUnretainedValue() as NSDictionary
                            var addressLabel:String = self.getLabel(Unmanaged.fromOpaque(ABMultiValueCopyLabelAtIndex(addresses, i).toOpaque()).takeUnretainedValue() as NSObject as String)
                            
                            var city:String = (address["City"] != nil) ? address["City"] as String:""
                            var country:String = (address["Country"] != nil) ? address["Country"] as String:""
                            var countryCode:String = (address["CountryCode"] != nil) ? address["CountryCode"] as String:""
                            var state:String = (address["State"] != nil) ? address["State"] as String:""
                            var street:String = (address["Street"] != nil) ? address["Street"] as String:""
                            var zip:String = (address["ZIP"] != nil) ? address["ZIP"] as String:""
                            
                            var fullAddress:String = (street + " " + zip + ", " + city + " " + country + " (" + countryCode + ")")
                            
                            contactAddress.setType(self.getAddressTypeLabel(addressLabel))
                            contactAddress.setAddress(fullAddress)
                            contactAddressList.append(contactAddress)
                        }
                        
                        contact.setContactAddresses(contactAddressList)
                    }
                }
                
                /*
                * EMAILS
                */
                
                if var group = fields {
                    if ((find(group,IContactFieldGroup.EMAILS)) != nil) {
                        
                        var contactEmailsList: [ContactEmail] = [ContactEmail]()
                        
                        var emails: ABMultiValueRef = Unmanaged.fromOpaque(ABRecordCopyValue(record, kABPersonEmailProperty).toOpaque()).takeUnretainedValue() as NSObject as ABMultiValueRef
                        
                        for (var i:Int=0; i < ABMultiValueGetCount(emails); i++) {
                            
                            var contactEmail: ContactEmail = ContactEmail()
                            
                            var email:String = Unmanaged.fromOpaque(ABMultiValueCopyValueAtIndex(emails, i).toOpaque()).takeUnretainedValue() as NSObject as String
                            var emailLabel:String = self.getLabel(Unmanaged.fromOpaque(ABMultiValueCopyLabelAtIndex(emails, i).toOpaque()).takeUnretainedValue() as NSObject as String)
                            
                            contactEmail.setEmail(email)
                            // in ios there is no primary email (we put the first apperance)
                            i == 0 ? contactEmail.setPrimary(true) : contactEmail.setPrimary(false)
                            contactEmail.setType(self.getMailTypeLabel(emailLabel))
                            contactEmailsList.append(contactEmail)
                        }
                        
                        contact.setContactEmails(contactEmailsList)
                    }
                }
                
                /*
                * PHONES
                */
                
                if var group = fields {
                    if ((find(group,IContactFieldGroup.PHONES)) != nil) {
                        
                        
                        var contactPhoneList: [ContactPhone] = [ContactPhone]()
                        
                        var phones: ABMultiValueRef = Unmanaged.fromOpaque(ABRecordCopyValue(record, kABPersonPhoneProperty).toOpaque()).takeUnretainedValue() as NSObject as ABMultiValueRef
                        
                        for (var i:Int=0; i < ABMultiValueGetCount(phones); i++) {
                            
                            var contactPhone: ContactPhone = ContactPhone()
                            
                            var phone:String = Unmanaged.fromOpaque(ABMultiValueCopyValueAtIndex(phones, i).toOpaque()).takeUnretainedValue() as NSObject as String
                            var phoneLabel:String = self.getLabel(Unmanaged.fromOpaque(ABMultiValueCopyLabelAtIndex(phones, i).toOpaque()).takeUnretainedValue() as NSObject as String)
                            
                            contactPhone.setPhone(phone)
                            contactPhone.setPhoneType(self.getPhoneTypeLabel(phoneLabel))
                            contactPhoneList.append(contactPhone)
                        }
                        
                        contact.setContactPhones(contactPhoneList)
                    }
                }
                
                /*
                * SOCIALS
                */
                
                if var group = fields {
                    if ((find(group,IContactFieldGroup.SOCIALS)) != nil) {
                        
                        
                        var contactSocialList: [ContactSocial] = [ContactSocial]()
                        
                        var socials: ABMultiValueRef = Unmanaged.fromOpaque(ABRecordCopyValue(record, kABPersonSocialProfileProperty).toOpaque()).takeUnretainedValue() as NSObject as ABMultiValueRef
                        
                        for (var i:Int=0; i < ABMultiValueGetCount(socials); i++) {
                            
                            var contactSocial:ContactSocial = ContactSocial()
                            
                            var social = Unmanaged.fromOpaque(ABMultiValueCopyValueAtIndex(socials, i).toOpaque()).takeUnretainedValue() as NSDictionary
                            
                            var socialNetwork:String = social["service"] as String
                            var socialURl:String = social["url"] as String
                            
                            contactSocial.setProfileUrl(socialURl)
                            
                            switch(socialNetwork){
                            case "facebook":
                                contactSocial.setSocialNetwork(ContactSocial.SocialNetwork.Facebook)
                            case "flickr":
                                contactSocial.setSocialNetwork(ContactSocial.SocialNetwork.Flickr)
                            case "google+":
                                contactSocial.setSocialNetwork(ContactSocial.SocialNetwork.GooglePlus)
                            case "linkedin":
                                contactSocial.setSocialNetwork(ContactSocial.SocialNetwork.LinkedIn)
                            case "twitter":
                                contactSocial.setSocialNetwork(ContactSocial.SocialNetwork.Twitter)
                            default:
                                logger.log(ILoggingLogLevel.WARN, category: "ContactImpl", message: "The social network: \(socialNetwork) is not supported by the system")
                            }
                            
                            contactSocialList.append(contactSocial)
                        }
                        
                        contact.setContactSocials(contactSocialList)
                    }
                }
                
                /*
                * TAGS
                * The API for accessing the contacts in iOS and OSX does not provide such information
                */
                
                // var contactTagsList: [ContactTag] = [ContactTag]()
                // var contactTag:ContactTag = ContactTag()
                // contactTag.setName("")
                // contactTag.setValue("")
                // contactTagsList.append(contactTag)
                // contact.setContactTags(contactTagsList)
                
                /*
                * WEBSITES
                */
                
                if var group = fields {
                    if ((find(group,IContactFieldGroup.WEBSITES)) != nil) {
                        
                        
                        var contactWebsiteList: [ContactWebsite] = [ContactWebsite]()
                        
                        var websites: ABMultiValueRef = Unmanaged.fromOpaque(ABRecordCopyValue(record, kABPersonURLProperty).toOpaque()).takeUnretainedValue() as NSObject as ABMultiValueRef
                        
                        for (var i:Int=0; i < ABMultiValueGetCount(websites); i++) {
                            
                            var contactWebsite: ContactWebsite = ContactWebsite()
                            
                            var url:String = Unmanaged.fromOpaque(ABMultiValueCopyValueAtIndex(websites, i).toOpaque()).takeUnretainedValue() as NSObject as String
                            
                            contactWebsite.setUrl(url)
                            contactWebsiteList.append(contactWebsite)
                        }
                        
                        contact.setContactWebsites(contactWebsiteList)
                    }
                }
                
                /*
                * PERSONAL INFO
                */
                
                if var group = fields {
                    if ((find(group,IContactFieldGroup.PERSONAL_INFO)) != nil) {
                        
                        
                        var contactPersonalInfo:ContactPersonalInfo = ContactPersonalInfo()
                        
                        // The title (Dr, Mr, Mrs, Ms) information is not provided by the iOS and OSX API
                        
                        var firstNameValue = ABRecordCopyValue(record, kABPersonFirstNameProperty).toOpaque()
                        var firstName: String = (firstNameValue != nil) ? Unmanaged.fromOpaque(firstNameValue).takeUnretainedValue() as NSObject as String : ""
                        
                        contactPersonalInfo.setName(firstName)
                        
                        var lastNameValue = ABRecordCopyValue(record, kABPersonLastNameProperty).toOpaque()
                        var lastName: String = (lastNameValue != nil) ? Unmanaged.fromOpaque(lastNameValue).takeUnretainedValue() as NSObject as String : ""
                        
                        contactPersonalInfo.setLastName(lastName)
                        
                        var middleNameValue = ABRecordCopyValue(record, kABPersonMiddleNameProperty).toOpaque()
                        var middleName: String = (middleNameValue != nil) ? Unmanaged.fromOpaque(middleNameValue).takeUnretainedValue() as NSObject as String : ""
                        
                        contactPersonalInfo.setMiddleName(middleName)
                        
                        contact.setPersonalInfo(contactPersonalInfo)
                    }
                }
                
                /*
                * PROFESSIONAL INFO
                */
                
                if var group = fields {
                    if ((find(group,IContactFieldGroup.PROFESSIONAL_INFO)) != nil) {
                        
                        
                        var contactProfessionalInfo:ContactProfessionalInfo = ContactProfessionalInfo()
                        
                        var companyValue = ABRecordCopyValue(record, kABPersonOrganizationProperty).toOpaque()
                        var company: String = (companyValue != nil) ? Unmanaged.fromOpaque(companyValue).takeUnretainedValue() as NSObject as String : ""
                        
                        contactProfessionalInfo.setCompany(company)
                        
                        var departmentValue = ABRecordCopyValue(record, kABPersonDepartmentProperty).toOpaque()
                        var department: String = (departmentValue != nil) ? Unmanaged.fromOpaque(departmentValue).takeUnretainedValue() as NSObject as String : ""
                        
                        contactProfessionalInfo.setJobDescription(department)
                        
                        var jobTitleValue = ABRecordCopyValue(record, kABPersonJobTitleProperty).toOpaque()
                        var jobTitle: String = (jobTitleValue != nil) ? Unmanaged.fromOpaque(jobTitleValue).takeUnretainedValue() as NSObject as String : ""
                        
                        contactProfessionalInfo.setJobTitle(jobTitle)
                        
                        contact.setProfessionalInfo(contactProfessionalInfo)
                        
                        // Save the contact in the return list
                        contacts.append(contact)
                    }
                }
                
            } // for record:ABRecordRef in contactList
            
            // Fire the correct result with all the contacts
            callback.onResult(contacts)
            
        } // if self.checkContactPermissions(callback)
        
    }
    
    /**
    Get all contacts
    
    :param: callback called for return
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func getContacts(callback : IContactResultCallback) {
        
        // fill all tthe group fields to query all the information
        var fields: [IContactFieldGroup] = [IContactFieldGroup.PERSONAL_INFO, IContactFieldGroup.PROFESSIONAL_INFO, IContactFieldGroup.ADDRESSES, IContactFieldGroup.PHONES, IContactFieldGroup.EMAILS, IContactFieldGroup.WEBSITES, IContactFieldGroup.SOCIALS, IContactFieldGroup.TAGS]
        
        self.getContactsGeneric(callback, contact: nil, fields: fields, filter: nil, term: "")
    }
    
    /**
    Get all the details of a contact according to its id
    
    :param: contact  id to search for
    :param: callback called for return
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func getContact(contact : ContactUid, callback : IContactResultCallback) {
        
        // fill all tthe group fields to query all the information
        var fields: [IContactFieldGroup] = [IContactFieldGroup.PERSONAL_INFO, IContactFieldGroup.PROFESSIONAL_INFO, IContactFieldGroup.ADDRESSES, IContactFieldGroup.PHONES, IContactFieldGroup.EMAILS, IContactFieldGroup.WEBSITES, IContactFieldGroup.SOCIALS, IContactFieldGroup.TAGS]
        
        self.getContactsGeneric(callback, contact: contact, fields: fields, filter: nil, term: "")
    }
    
    /**
    Get marked fields of all contacts
    
    :param: callback called for return
    :param: fields   to get for each Contact
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func getContacts(callback : IContactResultCallback, fields : [IContactFieldGroup]) {
        
        self.getContactsGeneric(callback, contact: nil, fields: fields, filter: nil, term: "")
    }
    
    /**
    Get marked fields of all contacts according to a filter
    
    :param: callback called for return
    :param: fields   to get for each Contact
    :param: filter   to search for
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func getContacts(callback : IContactResultCallback, fields : [IContactFieldGroup], filter : [IContactFilter]) {
        
        self.getContactsGeneric(callback, contact: nil, fields: fields, filter: filter, term: "")
    }
    
    /**
    Search contacts according to a term and send it to the callback
    
    :param: term     string to search
    :param: callback called for return
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func searchContacts(term : String, callback : IContactResultCallback) {
        
        // fill all tthe group fields to query all the information
        var fields: [IContactFieldGroup] = [IContactFieldGroup.PERSONAL_INFO, IContactFieldGroup.PROFESSIONAL_INFO, IContactFieldGroup.ADDRESSES, IContactFieldGroup.PHONES, IContactFieldGroup.EMAILS, IContactFieldGroup.WEBSITES, IContactFieldGroup.SOCIALS, IContactFieldGroup.TAGS]
        
        self.getContactsGeneric(callback, contact: nil, fields: fields, filter: nil, term: term)
    }
    
    /**
    Search contacts according to a term with a filter and send it to the callback
    
    :param: term     string to search
    :param: callback called for return
    :param: filter   to search for
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func searchContacts(term : String, callback : IContactResultCallback, filter : [IContactFilter]) {
        
        // fill all tthe group fields to query all the information
        var fields: [IContactFieldGroup] = [IContactFieldGroup.PERSONAL_INFO, IContactFieldGroup.PROFESSIONAL_INFO, IContactFieldGroup.ADDRESSES, IContactFieldGroup.PHONES, IContactFieldGroup.EMAILS, IContactFieldGroup.WEBSITES, IContactFieldGroup.SOCIALS, IContactFieldGroup.TAGS]
        
        
        self.getContactsGeneric(callback, contact: nil, fields: fields, filter: filter, term: term)
    }
    
    /**
    Get the contact photo
    
    :param: contact  id to search for
    :param: callback called for return
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func getContactPhoto(contact : ContactUid, callback : IContactPhotoResultCallback) {
        
        if self.checkContactPermissions(nil, callbackPhoto: callback) {
            
            // Get the address book and the contact list
            var addressBook: ABAddressBookRef? = extractABAddressBookRef(ABAddressBookCreateWithOptions(nil, nil))
        
            // Get the ID for the contact
            var id: ABRecordID = ABRecordGetRecordID(contact.getContactId())
        
            if(ABAddressBookGetPersonWithRecordID(addressBook, id) == nil) {
                logger.log(ILoggingLogLevel.WARN, category: "ContactImpl", message: "The contact with id: \(id) is not founded in the address book for getting the picture")
                callback.onWarning([Byte](), warning: IContactPhotoResultCallbackWarning.No_Matches)
                return
            }
        
            var person:ABRecordRef = Unmanaged.fromOpaque(ABAddressBookGetPersonWithRecordID(addressBook, id).toOpaque()).takeUnretainedValue()
            logger.log(ILoggingLogLevel.DEBUG, category: "ContactImpl", message: "Quering for one person id: \(id)")
            
            // If the person has no photo
            if !ABPersonHasImageData(person) {
                logger.log(ILoggingLogLevel.ERROR, category: "ContactImpl", message: "The contact with id: \(id) has NO photo")
                callback.onError(IContactPhotoResultCallbackError.No_Photo)
                return
            }
            
            var image:NSData = Unmanaged.fromOpaque(ABPersonCopyImageData(person).toOpaque()).takeUnretainedValue()
            
            // Create an array and get the bytes for the image
            var array:[Byte] = [Byte]()
            image.getBytes(&array, length: image.length)
            
            // call the result callback
            callback.onResult(array)
        }
    }
    
    /**
    Set the contact photo
    
    :param: contact  id to assign the photo
    :param: pngImage photo as byte array
    
    :returns: true if set is successful;false otherwise
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func setContactPhoto(contact : ContactUid, pngImage : [Byte]) -> Bool {
        
        if self.checkContactPermissions(nil, callbackPhoto: nil) {
            
            // Get the address book and the contact list
            var addressBook: ABAddressBookRef? = extractABAddressBookRef(ABAddressBookCreateWithOptions(nil, nil))
            
            // Get the ID for the contact
            var id: ABRecordID = ABRecordGetRecordID(contact.getContactId())
            
            if(ABAddressBookGetPersonWithRecordID(addressBook, id) == nil) {
                logger.log(ILoggingLogLevel.WARN, category: "ContactImpl", message: "The contact with id: \(id) is not founded in the address book for setting the picture")
                return false
            }
            
            var person:ABRecordRef = Unmanaged.fromOpaque(ABAddressBookGetPersonWithRecordID(addressBook, id).toOpaque()).takeUnretainedValue()
            logger.log(ILoggingLogLevel.DEBUG, category: "ContactImpl", message: "Quering for one person id: \(id)")
            
            var data: NSData = NSData(bytes: pngImage as [Byte], length: pngImage.count)
            
            var result:Bool = ABPersonSetImageData(person, data, nil)
            
            if !result {
                logger.log(ILoggingLogLevel.ERROR, category: "ContactImpl", message: "There is an error trying to set the image for a contact")
            }
            
            return result
            
        } else {
            
            logger.log(ILoggingLogLevel.ERROR, category: "ContactImpl", message: "There was an error trying to open the address book")
            return false
        }
    }
}
