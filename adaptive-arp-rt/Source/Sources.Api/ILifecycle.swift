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
   Interface for Managing the Lifecycle listeners

   @author Carlos Lozano Diez
   @since ARP1.0
   @version 1.0
*/
public protocol ILifecycle : IBaseApplication {
    /**
       Add the listener for the lifecycle of the app

       @param listener Lifecycle listener
       @since ARP1.0
    */
    func addLifecycleListener(listener : ILifecycleListener)

    /**
       Whether the application is in background or not

       @return true if the application is in background;false otherwise
       @since ARP1.0
    */
    func isBackground() -> Bool?

    /**
       Un-registers an existing listener from receiving lifecycle events.

       @param listener Lifecycle listener
       @since ARP1.0
    */
    func removeLifecycleListener(listener : ILifecycleListener)

    /**
       Removes all existing listeners from receiving lifecycle events.

       @since ARP1.0
    */
    func removeLifecycleListeners()

}

/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
