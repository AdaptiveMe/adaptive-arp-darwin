import Foundation

public struct JSONUtil {
    
    public static func escapeString(string: String) -> String {
        var resultString : String = string
        // Replace " with \"
        resultString = resultString.stringByReplacingOccurrencesOfString("\"", withString: "\\\"", options: NSStringCompareOptions.LiteralSearch, range: nil)
        return resultString
    }
    
    public static func stringElementToArray(string : String) -> [String] {
        var theResult : [String] = [String]()
        var theString : NSString = string
        theString = theString.substringFromIndex(1)
        theString = theString.substringToIndex(theString.length-1)
        var theStringArr = split(theString as String) {$0 == ","}
        for quotedString in theStringArr {
            var unquotedString : NSString = quotedString
            unquotedString = unquotedString.substringFromIndex(1)
            unquotedString = unquotedString.substringToIndex(unquotedString.length - 1)
            theResult.append(unquotedString as String)
        }
        return theResult
    }
}
/**
Structure representing a HTML5 request to the native API.

@author Carlos Lozano Diez
@since ARP1.0
@version 1.0
*/
public class APIRequest : NSObject {
    
    /**
    Identifier of callback or listener for async operations.
    */
    var asyncId : Int?
    /**
    String representing the method name to call
    */
    var methodName : String?
    /**
    Types of the request parameters
    */
    var parameterTypes : [String]?
    /**
    Parameters of the request as JSON formatted strings.
    */
    var parameters : [String]?
    
    /**
    Default constructor
    
    @since ARP1.0
    */
    public override init() {
        super.init()
    }
    
    /**
    Constructor with method name. No parameters
    
    @param methodName Name of the method
    @since ARP1.0
    */
    public init(methodName: String) {
        super.init()
        self.methodName = methodName
    }
    
    /**
    Constructor with all the parameters
    
    @param methodName     Name of the method
    @param parameters     Array of parameters as JSON formatted strings.
    @param parameterTypes Array of parameters types
    @param asyncId        Id of callback or listener or zero if none for synchronous calls.
    @since ARP1.0
    */
    public init(methodName: String, parameters: [String], parameterTypes: [String], asyncId: Int) {
        super.init()
        self.methodName = methodName
        self.parameters = parameters
        self.parameterTypes = parameterTypes
        self.asyncId = asyncId
    }
    
    /**
    Returns the callback or listener id assigned to this request OR zero if there is no associated callback or
    listener.
    
    @return long with the unique id of the callback or listener, or zero if there is no associated async event.
    */
    public func getAsyncId() -> Int? {
        return self.asyncId
    }
    
    /**
    Sets the callback or listener id to the request.
    
    @param asyncId The unique id of the callback or listener.
    */
    public func setAsyncId(asyncId: Int) {
        self.asyncId = asyncId
    }
    
    /**
    Method name Getter
    
    @return Method name
    @since ARP1.0
    */
    public func getMethodName() -> String? {
        return self.methodName
    }
    
    /**
    Method name Setter
    
    @param methodName Method name
    @since ARP1.0
    */
    public func setMethodName(methodName: String) {
        self.methodName = methodName
    }
    
    /**
    Parameter types Getter
    
    @return Parameter types
    @since ARP1.0
    */
    public func getParameterTypes() -> [String]? {
        return self.parameterTypes
    }
    
    /**
    Parameter types setter
    
    @param parameterTypes Parameter types
    @since ARP1.0
    */
    public func setParameterTypes(parameterTypes: [String]) {
        self.parameterTypes = parameterTypes
    }
    
    /**
    Parameters Getter
    
    @return Parameters
    @since ARP1.0
    */
    public func getParameters() -> [String]? {
        return self.parameters
    }
    
    /**
    Parameters Setter
    
    @param parameters Parameters, JSON formatted strings of objects.
    @since ARP1.0
    */
    public func setParameters(parameters: [String]) {
        self.parameters = parameters
    }
    
    
    /**
    JSON Serialization and deserialization support.
    */
    struct Serializer {
        static func fromJSON(json : String) -> APIRequest {
            var data:NSData = json.dataUsingEncoding(NSUTF8StringEncoding)!
            var jsonError: NSError?
            let dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary
            return fromDictionary(dict)
        }
        
        static func fromDictionary(dict : NSDictionary) -> APIRequest {
            var resultObject : APIRequest = APIRequest()
            
            if let value : AnyObject = dict.objectForKey("asyncId") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.asyncId = (value as Int)
                }
            }
            
            if let value : AnyObject = dict.objectForKey("methodName") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.methodName = (value as String)
                }
            }
            
            if let value : AnyObject = dict.objectForKey("parameterTypes") {
                if "\(value)" as NSString != "<null>" {
                    var parameterTypes : [String] = [String]()
                    for (var i = 0;i < (value as NSArray).count ; i++) {
                        parameterTypes.append((value as NSArray)[i] as String)
                    }
                    resultObject.parameterTypes = parameterTypes
                }
            }
            
            if let value : AnyObject = dict.objectForKey("parameters") {
                if "\(value)" as NSString != "<null>" {
                    var parameters : [String] = [String]()
                    for (var i = 0;i < (value as NSArray).count ; i++) {
                        parameters.append((value as NSArray)[i] as String)
                    }
                    resultObject.parameters = parameters
                }
            }
            
            return resultObject
        }
        
        static func toJSON(object: APIRequest) -> String {
            var jsonString : NSMutableString = NSMutableString()
            // Start Object to JSON
            jsonString.appendString("{ ")
            
            // Fields.
            object.asyncId != nil ? jsonString.appendString("\"asyncId\": \(object.asyncId!), ") : jsonString.appendString("\"asyncId\": null, ")
            object.methodName != nil ? jsonString.appendString("\"methodName\": \"\(object.methodName!)\", ") : jsonString.appendString("\"methodName\": null, ")
            if (object.parameterTypes != nil) {
                // Start array of objects.
                jsonString.appendString("\"parameterTypes\": [");
                
                for var i = 0; i < object.parameterTypes!.count; i++ {
                    jsonString.appendString("\"\(JSONUtil.escapeString(object.parameterTypes![i]))\"");
                    if (i < object.parameterTypes!.count-1) {
                        jsonString.appendString(", ");
                    }
                }
                
                // End array of objects.
                jsonString.appendString("], ");
            } else {
                jsonString.appendString("\"parameterTypes\": null, ")
            }
            if (object.parameters != nil) {
                // Start array of objects.
                jsonString.appendString("\"parameters\": [");
                
                for var i = 0; i < object.parameters!.count; i++ {
                    jsonString.appendString("\"\(JSONUtil.escapeString(object.parameters![i]))\"");
                    if (i < object.parameters!.count-1) {
                        jsonString.appendString(", ");
                    }
                }
                
                // End array of objects.
                jsonString.appendString("]");
            } else {
                jsonString.appendString("\"parameters\": null")
            }
            
            // End Object to JSON
            jsonString.appendString(" }")
            return jsonString
        }
    }
}



var request : APIRequest = APIRequest()
request.setAsyncId(10)
request.setMethodName("methodName")
request.setParameters(["Param1", "Param2","[\"A1\",\"A2\",\"&%/&(/&)Ò💩💩💩💩\"]"])
request.setParameterTypes(["String", "String", "String[]"])
println("BEFORE Param 3 is \(request.getParameters()![2])")

var json = APIRequest.Serializer.toJSON(request)
println(json)
var request2 = APIRequest.Serializer.fromJSON(json)
println("AFTER  Param 3 is \(request2.getParameters()![2])")
println(APIRequest.Serializer.toJSON(request2))
println(APIRequest.Serializer.toJSON(APIRequest.Serializer.fromJSON(APIRequest.Serializer.toJSON(request2))))


var nsString : NSString = request2.getParameters()![2]
println(JSONUtil.stringElementToArray(nsString)[2])

var b : Byte = Byte(("255" as NSString).intValue)
println(b)
