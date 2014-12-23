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
   Interface defines the response methods of the acceleration operations
   Auto-generated implementation of IAccelerationListener specification.
*/
public class AccelerationListenerImpl : BaseListenerImpl, IAccelerationListener {

    /**
       Constructor with listener id.

       @param id  The id of the listener.
    */
    public override init(id : Int) {
        super.init(id: id);
    }

    /**
       No data received - error condition, not authorized or hardware not available. This will be reported once for the
listener and subsequently, the listener will be deactivated and removed from the internal list of listeners.

       @param error Error fired
       @since ARP1.0
    */
    public func onError(error : IAccelerationListenerError)  {
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("handleAccelerationListenerError( '\(getId())', JSON.parse(\"\")" )
        /** TODO: this.gson.toJson(" + p.getName() + ")**/ 
    }

    /**
       Correct data received.

       @param acceleration Acceleration received
       @since ARP1.0
    */
    public func onResult(acceleration : Acceleration)  {
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("handleAccelerationListenerResult( '\(getId())', JSON.parse(\"\")" )
        /** TODO: this.gson.toJson(" + p.getName() + ")**/ 
    }

    /**
       Data received with warning - ie. Needs calibration.

       @param acceleration Acceleration received
       @param warning      Warning fired
       @since ARP1.0
    */
    public func onWarning(acceleration : Acceleration, warning : IAccelerationListenerWarning)  {
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("handleAccelerationListenerWarning( '\(getId())', JSON.parse(\"\"), JSON.parse(\"\")" )
        /** TODO: this.gson.toJson(" + p.getName() + ")**/ /** TODO: this.gson.toJson(" + p.getName() + ")**/ 
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
