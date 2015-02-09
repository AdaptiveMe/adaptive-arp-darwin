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

    * @version v2.1.5

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Interface for Managing the Cloud operations
   Auto-generated implementation of IDatabaseResultCallback specification.
*/
public class DatabaseResultCallbackImpl : BaseCallbackImpl, IDatabaseResultCallback {

    /**
       Constructor with callback id.

       @param id  The id of the callback.
    */
    public override init(id : Int64) {
        super.init(id: id)
    }

    /**
       Result callback for error responses

       @param error Returned error
       @since v2.0
    */
    public func onError(error : IDatabaseResultCallbackError) { 
        var param0 : String = "Adaptive.IDatabaseResultCallbackError.toObject(JSON.parse(\"{ \\\"value\\\": \\\"\(error.toString())\\\"}\"))"
        var callbackId : Int64 = -1
        if (getId() != nil) {
            callbackId = getId()!
        }
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("Adaptive.handleDatabaseResultCallbackError( \(callbackId), \(param0))")
    }

    /**
       Result callback for correct responses

       @param database Returns the database
       @since v2.0
    */
    public func onResult(database : Database) { 
        var param0 : String = "Adaptive.Database.toObject(JSON.parse(\"\(JSONUtil.escapeString(Database.Serializer.toJSON(database)))\"))"
        var callbackId : Int64 = -1
        if (getId() != nil) {
            callbackId = getId()!
        }
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("Adaptive.handleDatabaseResultCallbackResult( \(callbackId), \(param0))")
    }

    /**
       Result callback for warning responses

       @param database Returns the database
       @param warning  Returned Warning
       @since v2.0
    */
    public func onWarning(database : Database, warning : IDatabaseResultCallbackWarning) { 
        var param0 : String = "Adaptive.Database.toObject(JSON.parse(\"\(JSONUtil.escapeString(Database.Serializer.toJSON(database)))\"))"
        var param1 : String = "Adaptive.IDatabaseResultCallbackWarning.toObject(JSON.parse(\"{ \\\"value\\\": \\\"\(warning.toString())\\\"}\"))"
        var callbackId : Int64 = -1
        if (getId() != nil) {
            callbackId = getId()!
        }
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("Adaptive.handleDatabaseResultCallbackWarning( \(callbackId), \(param0), \(param1))")
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
