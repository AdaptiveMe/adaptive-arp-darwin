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

    * @version v2.1.0

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Represents a local or remote service response.

   @author Aryslan
   @since v2.0
   @version 1.0
*/
public class ServiceResponse : APIBean {

    /**
       Response data content. The content should be in some well-known web format - in specific, binaries returned
should be encoded in base64.
    */
    var content : String?
    /**
       Encoding of the binary payload - by default assumed to be UTF8.
    */
    var contentEncoding : String?
    /**
       The length in bytes for the Content field.
    */
    var contentLength : Int?
    /**
       The request/response content type (MIME TYPE).
    */
    var contentType : String?
    /**
       The serviceHeaders array (name,value pairs) to be included on the I/O service request.
    */
    var serviceHeaders : [ServiceHeader]?
    /**
       Information about the session.
    */
    var serviceSession : ServiceSession?

    /**
       Default constructor.

       @since v2.0
    */
    public override init() {
        super.init()
    }

    /**
       Constructor with fields

       @param content         Request/Response data content (plain text).
       @param contentType     The request/response content type (MIME TYPE).
       @param contentEncoding Encoding of the binary payload - by default assumed to be UTF8.
       @param contentLength   The length in bytes for the Content field.
       @param serviceHeaders  The serviceHeaders array (name,value pairs) to be included on the I/O service request.
       @param serviceSession  Information about the session
       @since v2.0
    */
    public init(content: String, contentType: String, contentEncoding: String, contentLength: Int, serviceHeaders: [ServiceHeader], serviceSession: ServiceSession) {
        super.init()
        self.content = content
        self.contentType = contentType
        self.contentEncoding = contentEncoding
        self.contentLength = contentLength
        self.serviceHeaders = serviceHeaders
        self.serviceSession = serviceSession
    }

    /**
       Returns the content

       @return content
       @since v2.0
    */
    public func getContent() -> String? {
        return self.content
    }

    /**
       Set the content

       @param content Request/Response data content (plain text).
       @since v2.0
    */
    public func setContent(content: String) {
        self.content = content
    }

    /**
       Returns the content encoding

       @return contentEncoding
       @since v2.0
    */
    public func getContentEncoding() -> String? {
        return self.contentEncoding
    }

    /**
       Set the content encoding

       @param contentEncoding Encoding of the binary payload - by default assumed to be UTF8.
       @since v2.0
    */
    public func setContentEncoding(contentEncoding: String) {
        self.contentEncoding = contentEncoding
    }

    /**
       Returns the content length

       @return contentLength
       @since v2.0
    */
    public func getContentLength() -> Int? {
        return self.contentLength
    }

    /**
       Set the content length

       @param contentLength The length in bytes for the Content field.
       @since v2.0
    */
    public func setContentLength(contentLength: Int) {
        self.contentLength = contentLength
    }

    /**
       Returns the content type

       @return contentType
       @since v2.0
    */
    public func getContentType() -> String? {
        return self.contentType
    }

    /**
       Set the content type

       @param contentType The request/response content type (MIME TYPE).
       @since v2.0
    */
    public func setContentType(contentType: String) {
        self.contentType = contentType
    }

    /**
       Returns the array of ServiceHeader

       @return serviceHeaders
       @since v2.0
    */
    public func getServiceHeaders() -> [ServiceHeader]? {
        return self.serviceHeaders
    }

    /**
       Set the array of ServiceHeader

       @param serviceHeaders The serviceHeaders array (name,value pairs) to be included on the I/O service request.
       @since v2.0
    */
    public func setServiceHeaders(serviceHeaders: [ServiceHeader]) {
        self.serviceHeaders = serviceHeaders
    }

    /**
       Getter for service session

       @return The element service session
       @since v2.0
    */
    public func getServiceSession() -> ServiceSession? {
        return self.serviceSession
    }

    /**
       Setter for service session

       @param serviceSession The element service session
       @since v2.0
    */
    public func setServiceSession(serviceSession: ServiceSession) {
        self.serviceSession = serviceSession
    }


    /**
       JSON Serialization and deserialization support.
    */
    struct Serializer {
        static func fromJSON(json : String) -> ServiceResponse {
            var data:NSData = json.dataUsingEncoding(NSUTF8StringEncoding)!
            var jsonError: NSError?
            let dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary
            return fromDictionary(dict)
        }

        static func fromDictionary(dict : NSDictionary) -> ServiceResponse {
            var resultObject : ServiceResponse = ServiceResponse()

            if let value : AnyObject = dict.objectForKey("content") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.content = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("contentEncoding") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.contentEncoding = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("contentLength") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.contentLength = (value as Int)
                }
            }

            if let value : AnyObject = dict.objectForKey("contentType") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.contentType = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("serviceHeaders") {
                if "\(value)" as NSString != "<null>" {
                    var serviceHeaders : [ServiceHeader] = [ServiceHeader]()
                    for (var i = 0;i < (value as NSArray).count ; i++) {
                        serviceHeaders.append(ServiceHeader.Serializer.fromDictionary((value as NSArray)[i] as NSDictionary))
                    }
                    resultObject.serviceHeaders = serviceHeaders
                }
            }

            if let value : AnyObject = dict.objectForKey("serviceSession") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.serviceSession = ServiceSession.Serializer.fromDictionary(value as NSDictionary)
                }
            }

            return resultObject
        }

        static func toJSON(object: ServiceResponse) -> String {
            var jsonString : NSMutableString = NSMutableString()
            // Start Object to JSON
            jsonString.appendString("{ ")

            // Fields.
            object.content != nil ? jsonString.appendString("\"content\": \"\(JSONUtil.escapeString(object.content!))\", ") : jsonString.appendString("\"content\": null, ")
            object.contentEncoding != nil ? jsonString.appendString("\"contentEncoding\": \"\(JSONUtil.escapeString(object.contentEncoding!))\", ") : jsonString.appendString("\"contentEncoding\": null, ")
            object.contentLength != nil ? jsonString.appendString("\"contentLength\": \(object.contentLength!), ") : jsonString.appendString("\"contentLength\": null, ")
            object.contentType != nil ? jsonString.appendString("\"contentType\": \"\(JSONUtil.escapeString(object.contentType!))\", ") : jsonString.appendString("\"contentType\": null, ")
            if (object.serviceHeaders != nil) {
                // Start array of objects.
                jsonString.appendString("\"serviceHeaders\": [")

                for var i = 0; i < object.serviceHeaders!.count; i++ {
                    jsonString.appendString(ServiceHeader.Serializer.toJSON(object.serviceHeaders![i]))
                    if (i < object.serviceHeaders!.count-1) {
                        jsonString.appendString(", ");
                    }
                }

                // End array of objects.
                jsonString.appendString("], ");
            } else {
                jsonString.appendString("\"serviceHeaders\": null, ")
            }
            object.serviceSession != nil ? jsonString.appendString("\"serviceSession\": \(ServiceSession.Serializer.toJSON(object.serviceSession!))") : jsonString.appendString("\"serviceSession\": null")

            // End Object to JSON
            jsonString.appendString(" }")
            return jsonString
        }
    }
}

/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
