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

    * @version v2.1.8

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Represents a local or remote service request.

   @author Aryslan
   @since v2.0
   @version 1.0
*/
public class ServiceRequest : APIBean {

    /**
       Encoding of the content - by default assumed to be UTF8. This may be populated by the application, the platform
populates this field with defaults for the service.
    */
    var contentEncoding : IServiceContentEncoding?
    /**
       Body parameters to be included in the body of the request to a service. These may be applied
during GET/POST operations. No body parameters are included if this array is null or length zero.
    */
    var bodyParameters : [ServiceRequestParameter]?
    /**
       Request data content (plain text). This should be populated by the application. The content should be
in some well-known web format - in specific, binaries submitted should be encoded to base64 and the content
type should be set respectively by the application.
    */
    var content : String?
    /**
       The length in bytes of the content. This may be populated by the application, the platform
calculates this length automatically if a specific contentLength is not specified.
    */
    var contentLength : Int32?
    /**
       The request content type (MIME TYPE). This may be populated by the application, the platform
populates this field with defaults for the service.
    */
    var contentType : String?
    /**
       Query string parameters to be appended to the service URL when making the request. These may be applied
during GET/POST operations. No query parameters are appended if this array is null or length zero.
    */
    var queryParameters : [ServiceRequestParameter]?
    /**
       This host indicates the origin host of the request. This, could be useful in case of redirected requests.
    */
    var refererHost : String?
    /**
       The serviceHeaders array (name,value pairs) to be included in the request. This may be populated by the
application, the platform populates this field with defaults for the service and the previous headers.
In specific, the platform maintains request and response state automatically.
    */
    var serviceHeaders : [ServiceHeader]?
    /**
       Session attributes and cookies. This may be populated by the application, the platform populates
this field with defaults for the service and the previous state information. In specific, the platform
maintains request and response state automatically.
    */
    var serviceSession : ServiceSession?
    /**
       Token used for the creation of the request with the destination service, endpoint, function and method
identifiers. This should not be manipulated by the application directly.
    */
    var serviceToken : ServiceToken?
    /**
       This attribute allows for the default user-agent string to be overridden by the application.
    */
    var userAgent : String?

    /**
       Default constructor.

       @since v2.0
    */
    public override init() {
        super.init()
    }

    /**
       Convenience constructor.

       @param content      Content payload.
       @param serviceToken ServiceToken for the request.
       @since v2.0.6
    */
    public init(content: String, serviceToken: ServiceToken) {
        super.init()
        self.content = content
        self.serviceToken = serviceToken
    }

    /**
       Returns the content encoding

       @return contentEncoding
       @since v2.0
    */
    public func getContentEncoding() -> IServiceContentEncoding? {
        return self.contentEncoding
    }

    /**
       Set the content encoding

       @param contentEncoding Encoding of the binary payload - by default assumed to be UTF8.
       @since v2.0
    */
    public func setContentEncoding(contentEncoding: IServiceContentEncoding) {
        self.contentEncoding = contentEncoding
    }

    /**
       Gets the body parameters of the request.

       @return ServiceRequestParameter array or null if none are specified.
       @since v2.0.6
    */
    public func getBodyParameters() -> [ServiceRequestParameter]? {
        return self.bodyParameters
    }

    /**
       Sets the body parameters of the request.

       @param bodyParameters ServiceRequestParameter array or null if none are specified.
       @since v2.0.6
    */
    public func setBodyParameters(bodyParameters: [ServiceRequestParameter]) {
        self.bodyParameters = bodyParameters
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

       @param content Request/Response data content (plain text)
       @since v2.0
    */
    public func setContent(content: String) {
        self.content = content
    }

    /**
       Returns the content length

       @return contentLength
       @since v2.0
    */
    public func getContentLength() -> Int32? {
        return self.contentLength
    }

    /**
       Set the content length

       @param contentLength The length in bytes for the Content field.
       @since v2.0
    */
    public func setContentLength(contentLength: Int32) {
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
       Gets the query parameters of the request.

       @return ServiceRequestParameter array or null if none are specified.
       @since v2.0.6
    */
    public func getQueryParameters() -> [ServiceRequestParameter]? {
        return self.queryParameters
    }

    /**
       Sets the query parameters of the request.

       @param queryParameters ServiceRequestParameter array or null if none are specified.
       @since v2.0.6
    */
    public func setQueryParameters(queryParameters: [ServiceRequestParameter]) {
        self.queryParameters = queryParameters
    }

    /**
       Returns the referer host (origin) of the request.

       @return Referer host of the request
       @since v2.1.4
    */
    public func getRefererHost() -> String? {
        return self.refererHost
    }

    /**
       Sets the value for the referer host of the request.

       @param refererHost Referer host of the request
       @since v2.1.4
    */
    public func setRefererHost(refererHost: String) {
        self.refererHost = refererHost
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
       Gets the ServiceToken of the request.

       @return ServiceToken.
       @since v2.0.6
    */
    public func getServiceToken() -> ServiceToken? {
        return self.serviceToken
    }

    /**
       Sets the ServiceToken of the request.

       @param serviceToken ServiceToken to be used for the invocation.
       @since v2.0.6
    */
    public func setServiceToken(serviceToken: ServiceToken) {
        self.serviceToken = serviceToken
    }

    /**
       Gets the overridden user-agent string.

       @return User-agent string.
       @since v2.0.6
    */
    public func getUserAgent() -> String? {
        return self.userAgent
    }

    /**
       Sets the user-agent to override the default user-agent string.

       @param userAgent User-agent string.
       @since v2.0.6
    */
    public func setUserAgent(userAgent: String) {
        self.userAgent = userAgent
    }


    /**
       JSON Serialization and deserialization support.
    */
    struct Serializer {
        static func fromJSON(json : String) -> ServiceRequest {
            var data:NSData = json.dataUsingEncoding(NSUTF8StringEncoding)!
            var jsonError: NSError?
            let dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary
            return fromDictionary(dict)
        }

        static func fromDictionary(dict : NSDictionary) -> ServiceRequest {
            var resultObject : ServiceRequest = ServiceRequest()

            if let value : AnyObject = dict.objectForKey("bodyParameters") {
                if "\(value)" as NSString != "<null>" {
                    var bodyParameters : [ServiceRequestParameter] = [ServiceRequestParameter]()
                    for (var i = 0;i < (value as NSArray).count ; i++) {
                        bodyParameters.append(ServiceRequestParameter.Serializer.fromDictionary((value as NSArray)[i] as NSDictionary))
                    }
                    resultObject.bodyParameters = bodyParameters
                }
            }

            if let value : AnyObject = dict.objectForKey("content") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.content = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("contentEncoding") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.contentEncoding = IServiceContentEncoding.toEnum(((value as NSDictionary)["value"]) as NSString)
                }
            }

            if let value : AnyObject = dict.objectForKey("contentLength") {
                if "\(value)" as NSString != "<null>" {
                    var numValue = value as Int
                    resultObject.contentLength = Int32(numValue)
                }
            }

            if let value : AnyObject = dict.objectForKey("contentType") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.contentType = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("queryParameters") {
                if "\(value)" as NSString != "<null>" {
                    var queryParameters : [ServiceRequestParameter] = [ServiceRequestParameter]()
                    for (var i = 0;i < (value as NSArray).count ; i++) {
                        queryParameters.append(ServiceRequestParameter.Serializer.fromDictionary((value as NSArray)[i] as NSDictionary))
                    }
                    resultObject.queryParameters = queryParameters
                }
            }

            if let value : AnyObject = dict.objectForKey("refererHost") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.refererHost = (value as String)
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

            if let value : AnyObject = dict.objectForKey("serviceToken") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.serviceToken = ServiceToken.Serializer.fromDictionary(value as NSDictionary)
                }
            }

            if let value : AnyObject = dict.objectForKey("userAgent") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.userAgent = (value as String)
                }
            }

            return resultObject
        }

        static func toJSON(object: ServiceRequest) -> String {
            var jsonString : NSMutableString = NSMutableString()
            // Start Object to JSON
            jsonString.appendString("{ ")

            // Fields.
            if (object.bodyParameters != nil) {
                // Start array of objects.
                jsonString.appendString("\"bodyParameters\": [")

                for var i = 0; i < object.bodyParameters!.count; i++ {
                    jsonString.appendString(ServiceRequestParameter.Serializer.toJSON(object.bodyParameters![i]))
                    if (i < object.bodyParameters!.count-1) {
                        jsonString.appendString(", ");
                    }
                }

                // End array of objects.
                jsonString.appendString("], ");
            } else {
                jsonString.appendString("\"bodyParameters\": null, ")
            }
            object.content != nil ? jsonString.appendString("\"content\": \"\(JSONUtil.escapeString(object.content!))\", ") : jsonString.appendString("\"content\": null, ")
            object.contentEncoding != nil ? jsonString.appendString("\"contentEncoding\": { \"value\": \"\(object.contentEncoding!.toString())\"}, ") : jsonString.appendString("\"contentEncoding\": null, ")
            object.contentLength != nil ? jsonString.appendString("\"contentLength\": \(object.contentLength!), ") : jsonString.appendString("\"contentLength\": null, ")
            object.contentType != nil ? jsonString.appendString("\"contentType\": \"\(JSONUtil.escapeString(object.contentType!))\", ") : jsonString.appendString("\"contentType\": null, ")
            if (object.queryParameters != nil) {
                // Start array of objects.
                jsonString.appendString("\"queryParameters\": [")

                for var i = 0; i < object.queryParameters!.count; i++ {
                    jsonString.appendString(ServiceRequestParameter.Serializer.toJSON(object.queryParameters![i]))
                    if (i < object.queryParameters!.count-1) {
                        jsonString.appendString(", ");
                    }
                }

                // End array of objects.
                jsonString.appendString("], ");
            } else {
                jsonString.appendString("\"queryParameters\": null, ")
            }
            object.refererHost != nil ? jsonString.appendString("\"refererHost\": \"\(JSONUtil.escapeString(object.refererHost!))\", ") : jsonString.appendString("\"refererHost\": null, ")
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
            object.serviceSession != nil ? jsonString.appendString("\"serviceSession\": \(ServiceSession.Serializer.toJSON(object.serviceSession!)), ") : jsonString.appendString("\"serviceSession\": null, ")
            object.serviceToken != nil ? jsonString.appendString("\"serviceToken\": \(ServiceToken.Serializer.toJSON(object.serviceToken!)), ") : jsonString.appendString("\"serviceToken\": null, ")
            object.userAgent != nil ? jsonString.appendString("\"userAgent\": \"\(JSONUtil.escapeString(object.userAgent!))\"") : jsonString.appendString("\"userAgent\": null")

            // End Object to JSON
            jsonString.appendString(" }")
            return jsonString
        }
    }
}

/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
