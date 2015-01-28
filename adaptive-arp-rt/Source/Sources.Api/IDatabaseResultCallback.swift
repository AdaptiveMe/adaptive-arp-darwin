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
   Interface for Managing the Cloud operations

   @author Ferran Vila Conesa
   @since ARP1.0
   @version 1.0
*/
public protocol IDatabaseResultCallback : IBaseCallback {
    /**
       Result callback for error responses

       @param error Returned error
       @since ARP1.0
    */
    func onError(error : IDatabaseResultCallbackError)

    /**
       Result callback for correct responses

       @param database Returns the database
       @since ARP1.0
    */
    func onResult(database : Database)

    /**
       Result callback for warning responses

       @param database Returns the database
       @param warning  Returned Warning
       @since ARP1.0
    */
    func onWarning(database : Database, warning : IDatabaseResultCallbackWarning)

}

/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
