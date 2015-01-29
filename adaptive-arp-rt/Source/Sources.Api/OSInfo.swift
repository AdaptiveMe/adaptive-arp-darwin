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
   Represents the basic information about the operating system.

   @author Francisco Javier Martin Bueno
   @since v2.0
   @version 1.0
*/
public class OSInfo : APIBean {

    /**
       The name of the operating system.
    */
    var name : IOSType?
    /**
       The vendor of the operating system.
    */
    var vendor : String?
    /**
       The version/identifier of the operating system.
    */
    var version : String?

    /**
       Default constructor

       @since v2.0
    */
    public override init() {
        super.init()
    }

    /**
       Constructor used by implementation to set the OS information.

       @param name    of the OS.
       @param version of the OS.
       @param vendor  of the OS.
       @since v2.0
    */
    public init(name: IOSType, version: String, vendor: String) {
        super.init()
        self.name = name
        self.version = version
        self.vendor = vendor
    }

    /**
       Returns the name of the operating system.

       @return OS name.
       @since v2.0
    */
    public func getName() -> IOSType? {
        return self.name
    }

    /**
       Sets The name of the operating system.

       @param name The name of the operating system.
    */
    public func setName(name: IOSType) {
        self.name = name
    }

    /**
       Returns the vendor of the operating system.

       @return OS vendor.
       @since v2.0
    */
    public func getVendor() -> String? {
        return self.vendor
    }

    /**
       Sets The vendor of the operating system.

       @param vendor The vendor of the operating system.
    */
    public func setVendor(vendor: String) {
        self.vendor = vendor
    }

    /**
       Returns the version of the operating system.

       @return OS version.
       @since v2.0
    */
    public func getVersion() -> String? {
        return self.version
    }

    /**
       Sets The version/identifier of the operating system.

       @param version The version/identifier of the operating system.
    */
    public func setVersion(version: String) {
        self.version = version
    }


    /**
       JSON Serialization and deserialization support.
    */
    struct Serializer {
        static func fromJSON(json : String) -> OSInfo {
            var data:NSData = json.dataUsingEncoding(NSUTF8StringEncoding)!
            var jsonError: NSError?
            let dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary
            return fromDictionary(dict)
        }

        static func fromDictionary(dict : NSDictionary) -> OSInfo {
            var resultObject : OSInfo = OSInfo()

            if let value : AnyObject = dict.objectForKey("name") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.name = IOSType.toEnum(((value as NSDictionary)["value"]) as NSString)
                }
            }

            if let value : AnyObject = dict.objectForKey("vendor") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.vendor = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("version") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.version = (value as String)
                }
            }

            return resultObject
        }

        static func toJSON(object: OSInfo) -> String {
            var jsonString : NSMutableString = NSMutableString()
            // Start Object to JSON
            jsonString.appendString("{ ")

            // Fields.
            object.name != nil ? jsonString.appendString("\"name\": { \"value\": \"\(object.name!.toString())\"}, ") : jsonString.appendString("\"name\": null, ")
            object.vendor != nil ? jsonString.appendString("\"vendor\": \"\(JSONUtil.escapeString(object.vendor!))\", ") : jsonString.appendString("\"vendor\": null, ")
            object.version != nil ? jsonString.appendString("\"version\": \"\(JSONUtil.escapeString(object.version!))\"") : jsonString.appendString("\"version\": null")

            // End Object to JSON
            jsonString.appendString(" }")
            return jsonString
        }
    }
}

/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
