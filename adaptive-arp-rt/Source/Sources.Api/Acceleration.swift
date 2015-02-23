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
   Structure representing the data of a single acceleration reading.

   @author Carlos Lozano Diez
   @since v2.0
   @version 1.0
*/
public class Acceleration : APIBean {

    /**
       Timestamp of the acceleration reading.
    */
    var timestamp : Int64?
    /**
       X-axis component of the acceleration.
    */
    var x : Double?
    /**
       Y-axis component of the acceleration.
    */
    var y : Double?
    /**
       Z-axis component of the acceleration.
    */
    var z : Double?

    /**
       Default constructor

       @since v2.0
    */
    public override init() {
        super.init()
    }

    /**
       Constructor with fields

       @param x         X Coordinate
       @param y         Y Coordinate
       @param z         Z Coordinate
       @param timestamp Timestamp
       @since v2.0
    */
    public init(x: Double, y: Double, z: Double, timestamp: Int64) {
        super.init()
        self.x = x
        self.y = y
        self.z = z
        self.timestamp = timestamp
    }

    /**
       Timestamp Getter

       @return Timestamp
       @since v2.0
    */
    public func getTimestamp() -> Int64? {
        return self.timestamp
    }

    /**
       Timestamp Setter

       @param timestamp Timestamp
       @since v2.0
    */
    public func setTimestamp(timestamp: Int64) {
        self.timestamp = timestamp
    }

    /**
       X Coordinate Getter

       @return X-axis component of the acceleration.
       @since v2.0
    */
    public func getX() -> Double? {
        return self.x
    }

    /**
       X Coordinate Setter

       @param x X-axis component of the acceleration.
       @since v2.0
    */
    public func setX(x: Double) {
        self.x = x
    }

    /**
       Y Coordinate Getter

       @return Y-axis component of the acceleration.
       @since v2.0
    */
    public func getY() -> Double? {
        return self.y
    }

    /**
       Y Coordinate Setter

       @param y Y-axis component of the acceleration.
       @since v2.0
    */
    public func setY(y: Double) {
        self.y = y
    }

    /**
       Z Coordinate Getter

       @return Z-axis component of the acceleration.
       @since v2.0
    */
    public func getZ() -> Double? {
        return self.z
    }

    /**
       Z Coordinate Setter

       @param z Z Coordinate
       @since v2.0
    */
    public func setZ(z: Double) {
        self.z = z
    }


    /**
       JSON Serialization and deserialization support.
    */
    struct Serializer {
        static func fromJSON(json : String) -> Acceleration {
            var data:NSData = json.dataUsingEncoding(NSUTF8StringEncoding)!
            var jsonError: NSError?
            let dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary
            return fromDictionary(dict)
        }

        static func fromDictionary(dict : NSDictionary) -> Acceleration {
            var resultObject : Acceleration = Acceleration()

            if let value : AnyObject = dict.objectForKey("timestamp") {
                if "\(value)" as NSString != "<null>" {
                    var numValue = value as? NSNumber
                    resultObject.timestamp = numValue?.longLongValue
                }
            }

            if let value : AnyObject = dict.objectForKey("x") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.x = (value as Double)
                }
            }

            if let value : AnyObject = dict.objectForKey("y") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.y = (value as Double)
                }
            }

            if let value : AnyObject = dict.objectForKey("z") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.z = (value as Double)
                }
            }

            return resultObject
        }

        static func toJSON(object: Acceleration) -> String {
            var jsonString : NSMutableString = NSMutableString()
            // Start Object to JSON
            jsonString.appendString("{ ")

            // Fields.
            object.timestamp != nil ? jsonString.appendString("\"timestamp\": \(object.timestamp!), ") : jsonString.appendString("\"timestamp\": null, ")
            object.x != nil ? jsonString.appendString("\"x\": \(object.x!), ") : jsonString.appendString("\"x\": null, ")
            object.y != nil ? jsonString.appendString("\"y\": \(object.y!), ") : jsonString.appendString("\"y\": null, ")
            object.z != nil ? jsonString.appendString("\"z\": \(object.z!)") : jsonString.appendString("\"z\": null")

            // End Object to JSON
            jsonString.appendString(" }")
            return jsonString
        }
    }
}

/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
