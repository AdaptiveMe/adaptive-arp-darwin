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
   Enumeration IAdaptiveRPGroup
*/
public enum IAdaptiveRPGroup {

    case Application
    case Commerce
    case Communication
    case Data
    case Media
    case Notification
    case PIM
    case Reader
    case Security
    case Sensor
    case Social
    case System
    case UI
    case Util
    case Kernel
    case Unknown

    /**
    Convert current enum to its string representation value.
    */
    public func toString() -> String {
        switch self {
            case .Application: return "Application"
            case .Commerce: return "Commerce"
            case .Communication: return "Communication"
            case .Data: return "Data"
            case .Media: return "Media"
            case .Notification: return "Notification"
            case .PIM: return "PIM"
            case .Reader: return "Reader"
            case .Security: return "Security"
            case .Sensor: return "Sensor"
            case .Social: return "Social"
            case .System: return "System"
            case .UI: return "UI"
            case .Util: return "Util"
            case .Kernel: return "Kernel"
            case .Unknown: return "Unknown"
        }
    }

    /**
    Create enum from its string representation value.
    */
    public static func toEnum(string:String?) -> IAdaptiveRPGroup {
        if let validString = string {
            switch validString {
                case "Application": return .Application
                case "Commerce": return .Commerce
                case "Communication": return .Communication
                case "Data": return .Data
                case "Media": return .Media
                case "Notification": return .Notification
                case "PIM": return .PIM
                case "Reader": return .Reader
                case "Security": return .Security
                case "Sensor": return .Sensor
                case "Social": return .Social
                case "System": return .System
                case "UI": return .UI
                case "Util": return .Util
                case "Kernel": return .Kernel
                case "Unknown": return .Unknown
            default: return .Unknown
            }
        } else {
            return .Unknown
        }
    }

}
