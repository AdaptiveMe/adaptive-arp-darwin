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

    * @version v2.1.4

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Interface for Managing the Services operations
   Auto-generated implementation of IServiceResultCallback specification.
*/
public class ServiceResultCallbackImpl : BaseCallbackImpl, IServiceResultCallback {

    /**
       Constructor with callback id.

       @param id  The id of the callback.
    */
    public override init(id : Int64) {
        super.init(id: id)
    }

    /**
       This method is called on Error

       @param error returned by the platform
       @since v2.0
    */
    public func onError(error : IServiceResultCallbackError) { 
        var param0 : String = "Adaptive.IServiceResultCallbackError.toObject(JSON.parse(\"{ \"value\": \"\(error.toString())\"}\"))"
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("Adaptive.handleServiceResultCallbackError( \"\(getId())\", \(param0))")
    }

    /**
       This method is called on Result

       @param response data
       @since v2.0
    */
    public func onResult(response : ServiceResponse) { 
        var param0 : String = "Adaptive.ServiceResponse.toObject(JSON.parse(\"\(JSONUtil.escapeString(ServiceResponse.Serializer.toJSON(response)))\"))"
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("Adaptive.handleServiceResultCallbackResult( \"\(getId())\", \(param0))")
    }

    /**
       This method is called on Warning

       @param response data
       @param warning  returned by the platform
       @since v2.0
    */
    public func onWarning(response : ServiceResponse, warning : IServiceResultCallbackWarning) { 
        var param0 : String = "Adaptive.ServiceResponse.toObject(JSON.parse(\"\(JSONUtil.escapeString(ServiceResponse.Serializer.toJSON(response)))\"))"
        var param1 : String = "Adaptive.IServiceResultCallbackWarning.toObject(JSON.parse(\"{ \"value\": \"\(warning.toString())\"}\"))"
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("Adaptive.handleServiceResultCallbackWarning( \"\(getId())\", \(param0), \(param1))")
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
