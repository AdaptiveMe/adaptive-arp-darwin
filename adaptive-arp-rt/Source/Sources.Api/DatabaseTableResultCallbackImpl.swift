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

    * @version v2.1.1

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Interface for Managing the Cloud operations
   Auto-generated implementation of IDatabaseTableResultCallback specification.
*/
public class DatabaseTableResultCallbackImpl : BaseCallbackImpl, IDatabaseTableResultCallback {

    /**
       Constructor with callback id.

       @param id  The id of the callback.
    */
    public override init(id : Int) {
        super.init(id: id)
    }

    /**
       Result callback for error responses

       @param error Returned error
       @since v2.0
    */
    public func onError(error : IDatabaseTableResultCallbackError) { 
        var param0 : String = "Adaptive.IDatabaseTableResultCallbackError.toObject(JSON.parse(\"{ \"value\": \"\(error.toString())\"}\"))"
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("Adaptive.handleDatabaseTableResultCallbackError( \"\(getId())\", \(param0))")
    }

    /**
       Result callback for correct responses

       @param databaseTable Returns the databaseTable
       @since v2.0
    */
    public func onResult(databaseTable : DatabaseTable) { 
        var param0 : String = "Adaptive.DatabaseTable.toObject(JSON.parse(\"\(JSONUtil.escapeString(DatabaseTable.Serializer.toJSON(databaseTable)))\"))"
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("Adaptive.handleDatabaseTableResultCallbackResult( \"\(getId())\", \(param0))")
    }

    /**
       Result callback for warning responses

       @param databaseTable Returns the databaseTable
       @param warning       Returned Warning
       @since v2.0
    */
    public func onWarning(databaseTable : DatabaseTable, warning : IDatabaseTableResultCallbackWarning) { 
        var param0 : String = "Adaptive.DatabaseTable.toObject(JSON.parse(\"\(JSONUtil.escapeString(DatabaseTable.Serializer.toJSON(databaseTable)))\"))"
        var param1 : String = "Adaptive.IDatabaseTableResultCallbackWarning.toObject(JSON.parse(\"{ \"value\": \"\(warning.toString())\"}\"))"
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().executeJavaScript("Adaptive.handleDatabaseTableResultCallbackWarning( \"\(getId())\", \(param0), \(param1))")
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
