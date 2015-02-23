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

    * @version v2.2.0

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Structure representing the basic device information.

   @author Francisco Javier Martin Bueno
   @since v2.0
   @version 1.0
*/
public class DeviceInfo : APIBean {

    /**
       Model of device - equivalent to device release or version.
    */
    var model : String?
    /**
       Name of device - equivalent to brand.
    */
    var name : String?
    /**
       Device identifier - this may not be unique for a device. It may depend on the platform implementation and may
be unique for a specific instance of an application on a specific device.
    */
    var uuid : String?
    /**
       Vendor of the device hardware.
    */
    var vendor : String?

    /**
       Default constructor

       @since v2.0
    */
    public override init() {
        super.init()
    }

    /**
       Constructor for the implementation of the platform.

       @param name   or brand of the device.
       @param model  of the device.
       @param vendor of the device.
       @param uuid   unique* identifier (* platform dependent).
       @since v2.0
    */
    public init(name: String, model: String, vendor: String, uuid: String) {
        super.init()
        self.name = name
        self.model = model
        self.vendor = vendor
        self.uuid = uuid
    }

    /**
       Returns the model of the device.

       @return String with the model of the device.
       @since v2.0
    */
    public func getModel() -> String? {
        return self.model
    }

    /**
       Sets Model of device - equivalent to device release or version.

       @param model Model of device - equivalent to device release or version.
    */
    public func setModel(model: String) {
        self.model = model
    }

    /**
       Returns the name of the device.

       @return String with device name.
       @since v2.0
    */
    public func getName() -> String? {
        return self.name
    }

    /**
       Sets Name of device - equivalent to brand.

       @param name Name of device - equivalent to brand.
    */
    public func setName(name: String) {
        self.name = name
    }

    /**
       Returns the platform dependent UUID of the device.

       @return String with the 128-bit device identifier.
       @since v2.0
    */
    public func getUuid() -> String? {
        return self.uuid
    }

    /**
       Sets Device identifier - this may not be unique for a device. It may depend on the platform implementation and may
be unique for a specific instance of an application on a specific device.

       @param uuid Device identifier - this may not be unique for a device. It may depend on the platform implementation and may
be unique for a specific instance of an application on a specific device.
    */
    public func setUuid(uuid: String) {
        self.uuid = uuid
    }

    /**
       Returns the vendor of the device.

       @return String with the vendor name.
       @since v2.0
    */
    public func getVendor() -> String? {
        return self.vendor
    }

    /**
       Sets Vendor of the device hardware.

       @param vendor Vendor of the device hardware.
    */
    public func setVendor(vendor: String) {
        self.vendor = vendor
    }


    /**
       JSON Serialization and deserialization support.
    */
    struct Serializer {
        static func fromJSON(json : String) -> DeviceInfo {
            var data:NSData = json.dataUsingEncoding(NSUTF8StringEncoding)!
            var jsonError: NSError?
            let dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary
            return fromDictionary(dict)
        }

        static func fromDictionary(dict : NSDictionary) -> DeviceInfo {
            var resultObject : DeviceInfo = DeviceInfo()

            if let value : AnyObject = dict.objectForKey("model") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.model = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("name") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.name = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("uuid") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.uuid = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("vendor") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.vendor = (value as String)
                }
            }

            return resultObject
        }

        static func toJSON(object: DeviceInfo) -> String {
            var jsonString : NSMutableString = NSMutableString()
            // Start Object to JSON
            jsonString.appendString("{ ")

            // Fields.
            object.model != nil ? jsonString.appendString("\"model\": \"\(JSONUtil.escapeString(object.model!))\", ") : jsonString.appendString("\"model\": null, ")
            object.name != nil ? jsonString.appendString("\"name\": \"\(JSONUtil.escapeString(object.name!))\", ") : jsonString.appendString("\"name\": null, ")
            object.uuid != nil ? jsonString.appendString("\"uuid\": \"\(JSONUtil.escapeString(object.uuid!))\", ") : jsonString.appendString("\"uuid\": null, ")
            object.vendor != nil ? jsonString.appendString("\"vendor\": \"\(JSONUtil.escapeString(object.vendor!))\"") : jsonString.appendString("\"vendor\": null")

            // End Object to JSON
            jsonString.appendString(" }")
            return jsonString
        }
    }
}

/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
