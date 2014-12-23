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
   Interface for testing the Capabilities operations

   @author Carlos Lozano Diez
   @since ARP1.0
   @version 1.0
*/
public protocol ICapabilities : IBaseSystem {
    /**
       Determines whether a specific hardware button is supported for interaction.

       @param type Type of feature to check.
       @return true is supported, false otherwise.
       @since ARP1.0
    */
    func hasButtonSupport(type : ICapabilitiesButton) -> Bool 

    /**
       Determines whether a specific Communication capability is supported by
the device.

       @param type Type of feature to check.
       @return true if supported, false otherwise.
       @since ARP1.0
    */
    func hasCommunicationSupport(type : ICapabilitiesCommunication) -> Bool 

    /**
       Determines whether a specific Data capability is supported by the device.

       @param type Type of feature to check.
       @return true if supported, false otherwise.
       @since ARP1.0
    */
    func hasDataSupport(type : ICapabilitiesData) -> Bool 

    /**
       Determines whether a specific Media capability is supported by the
device.

       @param type Type of feature to check.
       @return true if supported, false otherwise.
       @since ARP1.0
    */
    func hasMediaSupport(type : ICapabilitiesMedia) -> Bool 

    /**
       Determines whether a specific Net capability is supported by the device.

       @param type Type of feature to check.
       @return true if supported, false otherwise.
       @since ARP1.0
    */
    func hasNetSupport(type : ICapabilitiesNet) -> Bool 

    /**
       Determines whether a specific Notification capability is supported by the
device.

       @param type Type of feature to check.
       @return true if supported, false otherwise.
       @since ARP1.0
    */
    func hasNotificationSupport(type : ICapabilitiesNotification) -> Bool 

    /**
       Determines whether a specific Sensor capability is supported by the
device.

       @param type Type of feature to check.
       @return true if supported, false otherwise.
       @since ARP1.0
    */
    func hasSensorSupport(type : ICapabilitiesSensor) -> Bool 

}

/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
