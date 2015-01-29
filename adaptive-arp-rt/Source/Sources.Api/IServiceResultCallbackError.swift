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
   Enumeration IServiceResultCallbackError
*/
public enum IServiceResultCallbackError {

    case Forbidden
    case NotFound
    case MethodNotAllowed
    case NotAllowed
    case NotAuthenticated
    case PaymentRequired
    case TimeOut
    case NoResponse
    case ServerError
    case Unreachable
    case MalformedUrl
    case NotRegisteredService
    case Unknown

    /**
    Convert current enum to its string representation value.
    */
    public func toString() -> String {
        switch self {
            case .Forbidden: return "Forbidden"
            case .NotFound: return "NotFound"
            case .MethodNotAllowed: return "MethodNotAllowed"
            case .NotAllowed: return "NotAllowed"
            case .NotAuthenticated: return "NotAuthenticated"
            case .PaymentRequired: return "PaymentRequired"
            case .TimeOut: return "TimeOut"
            case .NoResponse: return "NoResponse"
            case .ServerError: return "ServerError"
            case .Unreachable: return "Unreachable"
            case .MalformedUrl: return "MalformedUrl"
            case .NotRegisteredService: return "NotRegisteredService"
            case .Unknown: return "Unknown"
        }
    }

    /**
    Create enum from its string representation value.
    */
    public static func toEnum(string:String?) -> IServiceResultCallbackError {
        if let validString = string {
            switch validString {
                case "Forbidden": return .Forbidden
                case "NotFound": return .NotFound
                case "MethodNotAllowed": return .MethodNotAllowed
                case "NotAllowed": return .NotAllowed
                case "NotAuthenticated": return .NotAuthenticated
                case "PaymentRequired": return .PaymentRequired
                case "TimeOut": return .TimeOut
                case "NoResponse": return .NoResponse
                case "ServerError": return .ServerError
                case "Unreachable": return .Unreachable
                case "MalformedUrl": return .MalformedUrl
                case "NotRegisteredService": return .NotRegisteredService
                case "Unknown": return .Unknown
            default: return .Unknown
            }
        } else {
            return .Unknown
        }
    }

}
