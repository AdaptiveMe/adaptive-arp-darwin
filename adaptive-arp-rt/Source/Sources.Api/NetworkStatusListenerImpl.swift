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

    * @version v2.1.3

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Interface for Managing the Network status listener events
   Auto-generated implementation of INetworkStatusListener specification.
*/
public class NetworkStatusListenerImpl : BaseListenerImpl, INetworkStatusListener {

    /**
       Constructor with listener id.

       @param id  The id of the listener.
    */
    public override init(id : Int64) {
        super.init(id: id);
    }

    /**
       No data received - error condition, not authorized or hardware not available.

       @param error Type of error encountered during reading.
       @since v2.0
    */
    public func onError(error : INetworkStatusListenerError) { 
        var param0 : String = "Adaptive.INetworkStatusListenerError.toObject(JSON.parse(\"{ \"value\": \"\(error.toString())\"}\"))"
        var listenerId : Int64 = -1
        if (getId() != nil) {
            listenerId = getId()!
        }
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("Adaptive.handleNetworkStatusListenerError( \"\(listenerId)\", \(param0))")
    }

    /**
       Called when network connection changes somehow.

       @param network Change to this network.
       @since v2.0
    */
    public func onResult(network : ICapabilitiesNet) { 
        var param0 : String = "Adaptive.ICapabilitiesNet.toObject(JSON.parse(\"{ \"value\": \"\(network.toString())\"}\"))"
        var listenerId : Int64 = -1
        if (getId() != nil) {
            listenerId = getId()!
        }
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("Adaptive.handleNetworkStatusListenerResult( \"\(listenerId)\", \(param0))")
    }

    /**
       Status received with warning

       @param network Change to this network.
       @param warning Type of warning encountered during reading.
       @since v2.0
    */
    public func onWarning(network : ICapabilitiesNet, warning : INetworkStatusListenerWarning) { 
        var param0 : String = "Adaptive.ICapabilitiesNet.toObject(JSON.parse(\"{ \"value\": \"\(network.toString())\"}\"))"
        var param1 : String = "Adaptive.INetworkStatusListenerWarning.toObject(JSON.parse(\"{ \"value\": \"\(warning.toString())\"}\"))"
        var listenerId : Int64 = -1
        if (getId() != nil) {
            listenerId = getId()!
        }
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("Adaptive.handleNetworkStatusListenerWarning( \"\(listenerId)\", \(param0), \(param1))")
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
