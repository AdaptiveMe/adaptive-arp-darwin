/*
* =| ADAPTIVE RUNTIME PLATFORM |=======================================================================================
*
* (C) Copyright 2013-2014 Carlos Lozano Diez t/a Adaptive.me <http://adaptive.me>.
*
* Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with
* the License. You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
* an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the
* specific language governing permissions and limitations under the License.
*
* Original author:
*
*     * Carlos Lozano Diez
*                 <http://github.com/carloslozano>
*                 <http://twitter.com/adaptivecoder>
*                 <mailto:carlos@adaptive.me>
*
* Contributors:
*
*     *
*
* =====================================================================================================================
*/

import Foundation

enum HttpResponseBody {
    
    case JSON(AnyObject)
    case XML(AnyObject)
    case PLIST(AnyObject)
    case RAW(String)
    
    func data() -> String? {
        switch self {
        case .JSON(let object):
            if NSJSONSerialization.isValidJSONObject(object) {
                var serializationError: NSError?
                if let json = NSJSONSerialization.dataWithJSONObject(object, options: NSJSONWritingOptions.PrettyPrinted, error: &serializationError) {
                    return NSString(data: json, encoding: NSUTF8StringEncoding)
                }
                return "Serialisation error: \(serializationError)"
            }
            return "Invalid object to serialise."
        case .XML(let data):
            return "XML serialization not supported."
        case .PLIST(let object):
            let format = NSPropertyListFormat.XMLFormat_v1_0
            if NSPropertyListSerialization.propertyList(object, isValidForFormat: format) {
                var serializationError: NSError?
                if let plist = NSPropertyListSerialization.dataWithPropertyList(object, format: format, options: 0, error: &serializationError) {
                    return NSString(data: plist, encoding: NSUTF8StringEncoding)
                }
                return "Serialisation error: \(serializationError)"
            }
            return "Invalid object to serialise."
        case .RAW(let data):
            return data
        }
    }
}

enum HttpResponse {
    
    case OK(HttpResponseBody), Created, Accepted
    case MovedPermanently(String)
    case BadRequest, Unauthorized, Forbidden, NotFound
    case InternalServerError
    case Raw(Int,String)
    
    func statusCode() -> Int {
        switch self {
        case .OK(_)                 : return 200
        case .Created               : return 201
        case .Accepted              : return 202
        case .MovedPermanently      : return 301
        case .BadRequest            : return 400
        case .Unauthorized          : return 401
        case .Forbidden             : return 403
        case .NotFound              : return 404
        case .InternalServerError   : return 500
        case .Raw(let code, _)      : return code
        }
    }
    
    func reasonPhrase() -> String {
        switch self {
        case .OK(_)                 : return "OK"
        case .Created               : return "Created"
        case .Accepted              : return "Accepted"
        case .MovedPermanently      : return "Moved Permanently"
        case .BadRequest            : return "Bad Request"
        case .Unauthorized          : return "Unauthorized"
        case .Forbidden             : return "Forbidden"
        case .NotFound              : return "Not Found"
        case .InternalServerError   : return "Internal Server Error"
        case .Raw(_,_)              : return "Custom"
        }
    }
    
    func headers() -> Dictionary<String, String> {
        switch self {
        case .MovedPermanently(let location) : return [ "Location" : location ]
        default: return Dictionary()
        }
    }
    
    func body() -> String? {
        switch self {
        case .OK(let body)      : return body.data()
        default                 : return nil
        }
    }
}
