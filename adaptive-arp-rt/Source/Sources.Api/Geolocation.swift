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

/**
   Structure representing the data a single geolocation reading.

   @author Francisco Javier Martin Bueno
   @since ARP1.0
   @version 1.0
*/
public class Geolocation : APIBean {

     /**
        The current device altitude (or Z coordinate). Measured in meters.
     */
     var altitude : Double?
     /**
        The Y coordinate (or latitude). Measured in degrees.
     */
     var latitude : Double?
     /**
        The X coordinate (or longitude). Measured in degrees.
     */
     var longitude : Double?
     /**
        Timestamp of the geolocation reading.
     */
     var timestamp : Int?
     /**
        Dilution of precision on the X measurement. Measured in meters.
     */
     var xDoP : Float?
     /**
        Dilution of precision on the Y measurement. Measured in meters.
     */
     var yDoP : Float?

     /**
        Default constructor

        @since ARP1.0
     */
     public override init() {
          super.init()
     }

     /**
        Constructor with parameters

        @param latitude  Latitude of the measurement
        @param longitude Longitude of the measurement
        @param altitude  Altitude of the measurement
        @param xDoP      Dilution of precision on the X measurement
        @param yDoP      Dilution of precision on the Y measurement
        @param timestamp Timestamp of the measurement
        @since ARP1.0
     */
     public init(latitude: Double, longitude: Double, altitude: Double, xDoP: Float, yDoP: Float, timestamp: Int) {
          super.init()
          self.latitude = latitude
          self.longitude = longitude
          self.altitude = altitude
          self.xDoP = xDoP
          self.yDoP = yDoP
          self.timestamp = timestamp
     }

     /**
        Constructor with parameters

        @param latitude  Latitude of the measurement
        @param longitude Longitude of the measurement
        @param timestamp Timestamp of the measurement
        @since ARP1.0
     */
     public init(latitude: Double, longitude: Double, timestamp: Int) {
          super.init()
          self.latitude = latitude
          self.longitude = longitude
          self.timestamp = timestamp
     }

     /**
        Returns altitude in meters

        @return Altitude of the measurement
        @since ARP1.0
     */
     public func getAltitude() -> Double? {
          return self.altitude
     }

     /**
        Set altitude in meters

        @param altitude Altitude of the measurement
        @since ARP1.0
     */
     public func setAltitude(altitude: Double) {
          self.altitude = altitude
     }

     /**
        Returns the latitude in degrees

        @return Latitude of the measurement
        @since ARP1.0
     */
     public func getLatitude() -> Double? {
          return self.latitude
     }

     /**
        Set the latitude in degrees

        @param latitude Latitude of the measurement
        @since ARP1.0
     */
     public func setLatitude(latitude: Double) {
          self.latitude = latitude
     }

     /**
        Returns the longitude in degrees

        @return Longitude of the measurement
        @since ARP1.0
     */
     public func getLongitude() -> Double? {
          return self.longitude
     }

     /**
        Returns the latitude in degrees

        @param longitude Longitude of the measurement
        @since ARP1.0
     */
     public func setLongitude(longitude: Double) {
          self.longitude = longitude
     }

     /**
        Timestamp Getter

        @return Timestamp
        @since ARP1.0
     */
     public func getTimestamp() -> Int? {
          return self.timestamp
     }

     /**
        Timestamp Setter

        @param timestamp Timestamp
        @since ARP1.0
     */
     public func setTimestamp(timestamp: Int) {
          self.timestamp = timestamp
     }

     /**
        Gets Dilution of precision on the X measurement. Measured in meters.

        @return xDoP Dilution of precision on the X measurement. Measured in meters.
     */
     public func getXDoP() -> Float? {
          return self.xDoP
     }

     /**
        Sets Dilution of precision on the X measurement. Measured in meters.

        @param xDoP Dilution of precision on the X measurement. Measured in meters.
     */
     public func setXDoP(xDoP: Float) {
          self.xDoP = xDoP
     }

     /**
        Gets Dilution of precision on the Y measurement. Measured in meters.

        @return yDoP Dilution of precision on the Y measurement. Measured in meters.
     */
     public func getYDoP() -> Float? {
          return self.yDoP
     }

     /**
        Sets Dilution of precision on the Y measurement. Measured in meters.

        @param yDoP Dilution of precision on the Y measurement. Measured in meters.
     */
     public func setYDoP(yDoP: Float) {
          self.yDoP = yDoP
     }


     /**
        JSON Serialization and deserialization support.
     */
     struct Serializer {
          static func fromJSON(json : String) -> Geolocation {
               var data:NSData = json.dataUsingEncoding(NSUTF8StringEncoding)!
               var jsonError: NSError?
               let dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary
               return fromDictionary(dict)
          }

          static func fromDictionary(dict : NSDictionary) -> Geolocation {
               var resultObject : Geolocation = Geolocation()

               if let value : AnyObject = dict.objectForKey("altitude") {
                    if value as NSString != "<null>" {
                         resultObject.altitude = (value as Double)
                    }
               }

               if let value : AnyObject = dict.objectForKey("latitude") {
                    if value as NSString != "<null>" {
                         resultObject.latitude = (value as Double)
                    }
               }

               if let value : AnyObject = dict.objectForKey("longitude") {
                    if value as NSString != "<null>" {
                         resultObject.longitude = (value as Double)
                    }
               }

               if let value : AnyObject = dict.objectForKey("timestamp") {
                    if value as NSString != "<null>" {
                         resultObject.timestamp = (value as Int)
                    }
               }

               if let value : AnyObject = dict.objectForKey("xDoP") {
                    if value as NSString != "<null>" {
                         resultObject.xDoP = (value as Float)
                    }
               }

               if let value : AnyObject = dict.objectForKey("yDoP") {
                    if value as NSString != "<null>" {
                         resultObject.yDoP = (value as Float)
                    }
               }

               return resultObject
          }

          static func toJSON(object: Geolocation) -> String {
               var jsonString : NSMutableString = NSMutableString()
               // Start Object to JSON
               jsonString.appendString("{ ")

               // Fields.
               object.altitude != nil ? jsonString.appendString("\"altitude\": \(object.altitude!), ") : jsonString.appendString("\"altitude\": null, ")
               object.latitude != nil ? jsonString.appendString("\"latitude\": \(object.latitude!), ") : jsonString.appendString("\"latitude\": null, ")
               object.longitude != nil ? jsonString.appendString("\"longitude\": \(object.longitude!), ") : jsonString.appendString("\"longitude\": null, ")
               object.timestamp != nil ? jsonString.appendString("\"timestamp\": \(object.timestamp!), ") : jsonString.appendString("\"timestamp\": null, ")
               object.xDoP != nil ? jsonString.appendString("\"xDoP\": \(object.xDoP!), ") : jsonString.appendString("\"xDoP\": null, ")
               object.yDoP != nil ? jsonString.appendString("\"yDoP\": \(object.yDoP!)") : jsonString.appendString("\"yDoP\": null")

               // End Object to JSON
               jsonString.appendString(" }")
               return jsonString
          }
     }
}

/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
