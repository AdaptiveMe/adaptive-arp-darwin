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

    * @version v2.0.4

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Interface for Managing the Contact operations

   @author Francisco Javier Martin Bueno
   @since ARP1.0
   @version 1.0
*/
public protocol IContact : IBasePIM {
    /**
       Get the contact photo

       @param contact  id to search for
       @param callback called for return
       @since ARP1.0
    */
    func getContactPhoto(contact : ContactUid, callback : IContactPhotoResultCallback)

    /**
       Get all the details of a contact according to its id

       @param contact  id to search for
       @param callback called for return
       @since ARP1.0
    */
    func getContact(contact : ContactUid, callback : IContactResultCallback)

    /**
       Get marked fields of all contacts

       @param callback called for return
       @param fields   to get for each Contact
       @since ARP1.0
    */
    func getContactsForFields(callback : IContactResultCallback, fields : [IContactFieldGroup])

    /**
       Get marked fields of all contacts according to a filter

       @param callback called for return
       @param fields   to get for each Contact
       @param filter   to search for
       @since ARP1.0
    */
    func getContactsWithFilter(callback : IContactResultCallback, fields : [IContactFieldGroup], filter : [IContactFilter])

    /**
       Get all contacts

       @param callback called for return
       @since ARP1.0
    */
    func getContacts(callback : IContactResultCallback)

    /**
       Search contacts according to a term with a filter and send it to the callback

       @param term     string to search
       @param callback called for return
       @param filter   to search for
       @since ARP1.0
    */
    func searchContactsWithFilter(term : String, callback : IContactResultCallback, filter : [IContactFilter])

    /**
       Search contacts according to a term and send it to the callback

       @param term     string to search
       @param callback called for return
       @since ARP1.0
    */
    func searchContacts(term : String, callback : IContactResultCallback)

    /**
       Set the contact photo

       @param contact  id to assign the photo
       @param pngImage photo as byte array
       @return true if set is successful;false otherwise
       @since ARP1.0
    */
    func setContactPhoto(contact : ContactUid, pngImage : [Byte]) -> Bool?

}

/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
