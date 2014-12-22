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

/**
   Interface for Managing the Contact operations
   Auto-generated implementation of IContact specification.
*/
public class ContactDelegate : BasePIMDelegate, IContact {

     /**
        Register delegate with the Application Registry.
     */
     //static {
          //AppRegistryBridge.getInstance().getContactBridge().setDelegate(new ContactDelegate());
     //}

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
          // TODO: Not implemented.
     }

     /**
        Get the contact photo

        @param contact  id to search for
        @param callback called for return
        @since ARP1.0
     */
     public func getContactPhoto(contact : ContactUid, callback : IContactPhotoResultCallback) {
          // TODO: Not implemented.
     }

     /**
        Get all contacts

        @param callback called for return
        @since ARP1.0
     */
     public func getContacts(callback : IContactResultCallback) {
          // TODO: Not implemented.
     }

     /**
        Get marked fields of all contacts

        @param callback called for return
        @param fields   to get for each Contact
        @since ARP1.0
     */
     public func getContactsForFields(callback : IContactResultCallback, fields : [IContactFieldGroup]) {
          // TODO: Not implemented.
     }

     /**
        Get marked fields of all contacts according to a filter

        @param callback called for return
        @param fields   to get for each Contact
        @param filter   to search for
        @since ARP1.0
     */
     public func getContactsWithFilter(callback : IContactResultCallback, fields : [IContactFieldGroup], filter : [IContactFilter]) {
          // TODO: Not implemented.
     }

     /**
        Search contacts according to a term and send it to the callback

        @param term     string to search
        @param callback called for return
        @since ARP1.0
     */
     public func searchContacts(term : String, callback : IContactResultCallback) {
          // TODO: Not implemented.
     }

     /**
        Search contacts according to a term with a filter and send it to the callback

        @param term     string to search
        @param callback called for return
        @param filter   to search for
        @since ARP1.0
     */
     public func searchContactsWithFilter(term : String, callback : IContactResultCallback, filter : [IContactFilter]) {
          // TODO: Not implemented.
     }

     /**
        Set the contact photo

        @param contact  id to assign the photo
        @param pngImage photo as byte array
        @return true if set is successful;false otherwise
        @since ARP1.0
     */
     public func setContactPhoto(contact : ContactUid, pngImage : [Byte]) -> Bool {
          var response : Bool
          // TODO: Not implemented.
          return false
     }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
