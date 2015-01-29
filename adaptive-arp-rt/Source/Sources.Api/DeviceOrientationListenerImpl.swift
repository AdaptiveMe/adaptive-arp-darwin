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

    * @version v2.1.0

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Interface for handling device orientation change events.
   Auto-generated implementation of IDeviceOrientationListener specification.
*/
public class DeviceOrientationListenerImpl : BaseListenerImpl, IDeviceOrientationListener {

    /**
       Constructor with listener id.

       @param id  The id of the listener.
    */
    public override init(id : Int) {
        super.init(id: id);
    }

    /**
       Although extremely unlikely, this event will be fired if something beyond the control of the
platform impedes the rotation of the device.

       @param error The error condition... generally unknown as it is unexpected!
       @since v2.0.5
    */
    public func onError(error : IDeviceOrientationListenerError) { 
        var param0 : String = "Adaptive.IDeviceOrientationListenerError.toObject(JSON.parse(\"{ \"value\": \"\(error.toString())\"}\"))"
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("Adaptive.handleDeviceOrientationListenerError( \"\(getId())\", \(param0))")
    }

    /**
       Event fired with the successful start and finish of a rotation.

       @param event RotationEvent containing origin, destination and state of the event.
       @since v2.0.5
    */
    public func onResult(event : RotationEvent) { 
        var param0 : String = "Adaptive.RotationEvent.toObject(JSON.parse(\"\(JSONUtil.escapeString(RotationEvent.Serializer.toJSON(event)))\"))"
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("Adaptive.handleDeviceOrientationListenerResult( \"\(getId())\", \(param0))")
    }

    /**
       Event fired with a warning when the rotation is aborted. In specific, this
event may be fired if the devices vetoes the rotation before rotation is completed.

       @param event   RotationEvent containing origin, destination and state of the event.
       @param warning Type of condition that aborted rotation execution.
       @since v2.0.5
    */
    public func onWarning(event : RotationEvent, warning : IDeviceOrientationListenerWarning) { 
        var param0 : String = "Adaptive.RotationEvent.toObject(JSON.parse(\"\(JSONUtil.escapeString(RotationEvent.Serializer.toJSON(event)))\"))"
        var param1 : String = "Adaptive.IDeviceOrientationListenerWarning.toObject(JSON.parse(\"{ \"value\": \"\(warning.toString())\"}\"))"
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("Adaptive.handleDeviceOrientationListenerWarning( \"\(getId())\", \(param0), \(param1))")
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
