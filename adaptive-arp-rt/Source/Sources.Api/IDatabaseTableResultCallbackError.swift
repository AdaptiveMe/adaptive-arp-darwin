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

    * @version v2.0.8

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Enumeration IDatabaseTableResultCallbackError
*/
public enum IDatabaseTableResultCallbackError {

    case NoSpace
    case ReadOnlyTable
    case SqlException
    case DatabaseNotFound
    case NoTableFound
    case Unknown

    /**
    Convert current enum to its string representation value.
    */
    public func toString() -> String {
        switch self {
            case .NoSpace: return "NoSpace"
            case .ReadOnlyTable: return "ReadOnlyTable"
            case .SqlException: return "SqlException"
            case .DatabaseNotFound: return "DatabaseNotFound"
            case .NoTableFound: return "NoTableFound"
            case .Unknown: return "Unknown"
        }
    }

    /**
    Create enum from its string representation value.
    */
    public static func toEnum(string:String?) -> IDatabaseTableResultCallbackError {
        if let validString = string {
            switch validString {
                case "NoSpace": return .NoSpace
                case "ReadOnlyTable": return .ReadOnlyTable
                case "SqlException": return .SqlException
                case "DatabaseNotFound": return .DatabaseNotFound
                case "NoTableFound": return .NoTableFound
                case "Unknown": return .Unknown
            default: return .Unknown
            }
        } else {
            return .Unknown
        }
    }

}
