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
   Object for reporting orientation change events for device and display.

   @author Carlos Lozano Diez
   @since v2.0.5
   @version 1.0
*/
public class RotationEvent : APIBean {

    /**
       The orientation we're rotating to. This is the future orientation when the state of the event is
WillStartRotation. This will be the current orientation when the rotation is finished with the state
DidFinishRotation.
    */
    var destination : ICapabilitiesOrientation?
    /**
       The orientation we're rotating from. This is the current orientation when the state of the event is
WillStartRotation. This will be the previous orientation when the rotation is finished with the state
DidFinishRotation.
    */
    var origin : ICapabilitiesOrientation?
    /**
       The state of the event to indicate the start of the rotation and the end of the rotation event. This allows
for functions to be pre-emptively performed (veto change, re-layout, etc.) before rotation is effected and
concluded.
    */
    var state : RotationEventState?
    /**
       The timestamps in milliseconds when the event was fired.
    */
    var timestamp : Int64?

    /**
       Default constructor.

       @since v2.0.5
    */
    public override init() {
        super.init()
    }

    /**
       Convenience constructor.

       @param origin      Source orientation when the event was fired.
       @param destination Destination orientation when the event was fired.
       @param state       State of the event (WillBegin, DidFinish).
       @param timestamp   Timestamp in milliseconds when the event was fired.
       @since v2.0.5
    */
    public init(origin: ICapabilitiesOrientation, destination: ICapabilitiesOrientation, state: RotationEventState, timestamp: Int64) {
        super.init()
        self.origin = origin
        self.destination = destination
        self.state = state
        self.timestamp = timestamp
    }

    /**
       Gets the destination orientation of the event.

       @return Destination orientation.
       @since v2.0.5
    */
    public func getDestination() -> ICapabilitiesOrientation? {
        return self.destination
    }

    /**
       Sets the destination orientation of the event.

       @param destination Destination orientation.
       @since v2.0.5
    */
    public func setDestination(destination: ICapabilitiesOrientation) {
        self.destination = destination
    }

    /**
       Get the origin orientation of the event.

       @return Origin orientation.
       @since v2.0.5
    */
    public func getOrigin() -> ICapabilitiesOrientation? {
        return self.origin
    }

    /**
       Set the origin orientation of the event.

       @param origin Origin orientation
       @since v2.0.5
    */
    public func setOrigin(origin: ICapabilitiesOrientation) {
        self.origin = origin
    }

    /**
       Gets the current state of the event.

       @return State of the event.
       @since v2.0.5
    */
    public func getState() -> RotationEventState? {
        return self.state
    }

    /**
       Sets the current state of the event.

       @param state The state of the event.
       @since v2.0.5
    */
    public func setState(state: RotationEventState) {
        self.state = state
    }

    /**
       Gets the timestamp in milliseconds of the event.

       @return Timestamp of the event.
       @since v2.0.5
    */
    public func getTimestamp() -> Int64? {
        return self.timestamp
    }

    /**
       Sets the timestamp in milliseconds of the event.

       @param timestamp Timestamp of the event.
       @since v2.0.5
    */
    public func setTimestamp(timestamp: Int64) {
        self.timestamp = timestamp
    }


    /**
       JSON Serialization and deserialization support.
    */
    struct Serializer {
        static func fromJSON(json : String) -> RotationEvent {
            var data:NSData = json.dataUsingEncoding(NSUTF8StringEncoding)!
            var jsonError: NSError?
            let dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary
            return fromDictionary(dict)
        }

        static func fromDictionary(dict : NSDictionary) -> RotationEvent {
            var resultObject : RotationEvent = RotationEvent()

            if let value : AnyObject = dict.objectForKey("destination") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.destination = ICapabilitiesOrientation.toEnum(((value as NSDictionary)["value"]) as NSString)
                }
            }

            if let value : AnyObject = dict.objectForKey("origin") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.origin = ICapabilitiesOrientation.toEnum(((value as NSDictionary)["value"]) as NSString)
                }
            }

            if let value : AnyObject = dict.objectForKey("state") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.state = RotationEventState.toEnum(((value as NSDictionary)["value"]) as NSString)
                }
            }

            if let value : AnyObject = dict.objectForKey("timestamp") {
                if "\(value)" as NSString != "<null>" {
                    var numValue = value as? NSNumber
                    resultObject.timestamp = numValue?.longLongValue
                }
            }

            return resultObject
        }

        static func toJSON(object: RotationEvent) -> String {
            var jsonString : NSMutableString = NSMutableString()
            // Start Object to JSON
            jsonString.appendString("{ ")

            // Fields.
            object.destination != nil ? jsonString.appendString("\"destination\": { \"value\": \"\(object.destination!.toString())\"}, ") : jsonString.appendString("\"destination\": null, ")
            object.origin != nil ? jsonString.appendString("\"origin\": { \"value\": \"\(object.origin!.toString())\"}, ") : jsonString.appendString("\"origin\": null, ")
            object.state != nil ? jsonString.appendString("\"state\": { \"value\": \"\(object.state!.toString())\"}, ") : jsonString.appendString("\"state\": null, ")
            object.timestamp != nil ? jsonString.appendString("\"timestamp\": \(object.timestamp!)") : jsonString.appendString("\"timestamp\": null")

            // End Object to JSON
            jsonString.appendString(" }")
            return jsonString
        }
    }
}

/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
