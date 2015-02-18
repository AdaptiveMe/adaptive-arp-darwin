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

    * @version v2.1.6

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Interface for Managing the Services operations
   Auto-generated implementation of IService specification.
*/
public class ServiceBridge : BaseCommunicationBridge, IService, APIBridge {

    /**
       API Delegate.
    */
    private var delegate : IService? = nil

    /**
       Constructor with delegate.

       @param delegate The delegate implementing platform specific functions.
    */
    public init(delegate : IService?) {
        super.init()
        self.delegate = delegate
    }
    /**
       Get the delegate implementation.
       @return IService delegate that manages platform specific functions..
    */
    public final func getDelegate() -> IService? {
        return self.delegate
    }
    /**
       Set the delegate implementation.

       @param delegate The delegate implementing platform specific functions.
    */
    public final func setDelegate(delegate : IService) {
        self.delegate = delegate;
    }

    /**
       Create a service request for the given ServiceToken. This method creates the request, populating
existing headers and cookies for the same service. The request is populated with all the defaults
for the service being invoked and requires only the request body to be set. Headers and cookies may be
manipulated as needed by the application before submitting the ServiceRequest via invokeService.

       @param serviceToken ServiceToken to be used for the creation of the request.
       @return ServiceRequest with pre-populated headers, cookies and defaults for the service.
       @since v2.0.6
    */
    public func getServiceRequest(serviceToken : ServiceToken ) -> ServiceRequest? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "ServiceBridge executing getServiceRequest('\(serviceToken)').")
        }

        var result : ServiceRequest? = nil
        if (self.delegate != nil) {
            result = self.delegate!.getServiceRequest(serviceToken)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "ServiceBridge executed 'getServiceRequest' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "ServiceBridge no delegate for 'getServiceRequest'.")
            }
        }
        return result        
    }

    /**
       Obtains a ServiceToken for the given parameters to be used for the creation of requests.

       @param serviceName  Service name.
       @param endpointName Endpoint name.
       @param functionName Function name.
       @param method       Method type.
       @return ServiceToken to create a service request or null if the given parameter combination is not
configured in the platform's XML service definition file.
       @since v2.0.6
    */
    public func getServiceToken(serviceName : String , endpointName : String , functionName : String , method : IServiceMethod ) -> ServiceToken? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "ServiceBridge executing getServiceToken('\(serviceName)','\(endpointName)','\(functionName)','\(method)').")
        }

        var result : ServiceToken? = nil
        if (self.delegate != nil) {
            result = self.delegate!.getServiceToken(serviceName, endpointName: endpointName, functionName: functionName, method: method)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "ServiceBridge executed 'getServiceToken' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "ServiceBridge no delegate for 'getServiceToken'.")
            }
        }
        return result        
    }

    /**
       Obtains a Service token by a concrete uri (http://domain.com/path). This method would be useful when
a service response is a redirect (3XX) and it is necessary to make a request to another host and we
don't know by advance the name of the service.

       @param uri Unique Resource Identifier for a Service-Endpoint-Path-Method
       @return ServiceToken to create a service request or null if the given parameter is not
configured in the platform's XML service definition file.
       @since v2.1.4
    */
    public func getServiceTokenByUri(uri : String ) -> ServiceToken? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "ServiceBridge executing getServiceTokenByUri('\(uri)').")
        }

        var result : ServiceToken? = nil
        if (self.delegate != nil) {
            result = self.delegate!.getServiceTokenByUri(uri)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "ServiceBridge executed 'getServiceTokenByUri' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "ServiceBridge no delegate for 'getServiceTokenByUri'.")
            }
        }
        return result        
    }

    /**
       Returns all the possible service tokens configured in the platform's XML service definition file.

       @return Array of service tokens configured.
       @since v2.0.6
    */
    public func getServicesRegistered() -> [ServiceToken]? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "ServiceBridge executing getServicesRegistered.")
        }

        var result : [ServiceToken]? = nil
        if (self.delegate != nil) {
            result = self.delegate!.getServicesRegistered()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "ServiceBridge executed 'getServicesRegistered' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "ServiceBridge no delegate for 'getServicesRegistered'.")
            }
        }
        return result        
    }

    /**
       Executes the given ServiceRequest and provides responses to the given callback handler.

       @param serviceRequest ServiceRequest with the request body.
       @param callback       IServiceResultCallback to handle the ServiceResponse.
       @since v2.0.6
    */
    public func invokeService(serviceRequest : ServiceRequest , callback : IServiceResultCallback ) {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "ServiceBridge executing invokeService('\(serviceRequest)','\(callback)').")
        }

        if (self.delegate != nil) {
            self.delegate!.invokeService(serviceRequest, callback: callback)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "ServiceBridge executed 'invokeService' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "ServiceBridge no delegate for 'invokeService'.")
            }
        }
        
    }

    /**
       Checks whether a specific service, endpoint, function and method type is configured in the platform's
XML service definition file.

       @param serviceName  Service name.
       @param endpointName Endpoint name.
       @param functionName Function name.
       @param method       Method type.
       @return Returns true if the service is configured, false otherwise.
       @since v2.0.6
    */
    public func isServiceRegistered(serviceName : String , endpointName : String , functionName : String , method : IServiceMethod ) -> Bool? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "ServiceBridge executing isServiceRegistered('\(serviceName)','\(endpointName)','\(functionName)','\(method)').")
        }

        var result : Bool? = false
        if (self.delegate != nil) {
            result = self.delegate!.isServiceRegistered(serviceName, endpointName: endpointName, functionName: functionName, method: method)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "ServiceBridge executed 'isServiceRegistered' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "ServiceBridge no delegate for 'isServiceRegistered'.")
            }
        }
        return result        
    }

    /**
       Invokes the given method specified in the API request object.

       @param request APIRequest object containing method name and parameters.
       @return APIResponse with status code, message and JSON response or a JSON null string for void functions. Status code 200 is OK, all others are HTTP standard error conditions.
    */
    public override func invoke(request : APIRequest) -> APIResponse? {
        var response : APIResponse = APIResponse()
        var responseCode : Int32 = 200
        var responseMessage : String = "OK"
        var responseJSON : String? = "null"
        switch request.getMethodName()! {
            case "getServiceRequest":
                var serviceToken0 : ServiceToken? = ServiceToken.Serializer.fromJSON(request.getParameters()![0])
                var response0 : ServiceRequest? = self.getServiceRequest(serviceToken0!)
                if let response0 = response0 {
                    responseJSON = ServiceRequest.Serializer.toJSON(response0)
                } else {
                    responseJSON = "null"
                }
            case "getServiceToken":
                var serviceName1 : String? = JSONUtil.unescapeString(request.getParameters()![0])
                var endpointName1 : String? = JSONUtil.unescapeString(request.getParameters()![1])
                var functionName1 : String? = JSONUtil.unescapeString(request.getParameters()![2])
                var method1 : IServiceMethod? = IServiceMethod.toEnum(JSONUtil.dictionifyJSON(request.getParameters()![3])["value"] as String!)
                var response1 : ServiceToken? = self.getServiceToken(serviceName1!, endpointName: endpointName1!, functionName: functionName1!, method: method1!)
                if let response1 = response1 {
                    responseJSON = ServiceToken.Serializer.toJSON(response1)
                } else {
                    responseJSON = "null"
                }
            case "getServiceTokenByUri":
                var uri2 : String? = JSONUtil.unescapeString(request.getParameters()![0])
                var response2 : ServiceToken? = self.getServiceTokenByUri(uri2!)
                if let response2 = response2 {
                    responseJSON = ServiceToken.Serializer.toJSON(response2)
                } else {
                    responseJSON = "null"
                }
            case "getServicesRegistered":
                var response3 : [ServiceToken]? = self.getServicesRegistered()
                if let response3 = response3 {
                    var response3JSONArray : NSMutableString = NSMutableString()
                    response3JSONArray.appendString("[ ")
                    for (index, obj) in enumerate(response3) {
                        response3JSONArray.appendString(ServiceToken.Serializer.toJSON(obj))
                        if index < response3.count-1 {
                            response3JSONArray.appendString(", ")
                        }
                    }
                    response3JSONArray.appendString(" ]")
                    responseJSON = response3JSONArray as String
                } else {
                    responseJSON = "null"
                }
            case "invokeService":
                var serviceRequest4 : ServiceRequest? = ServiceRequest.Serializer.fromJSON(request.getParameters()![0])
                var callback4 : IServiceResultCallback? =  ServiceResultCallbackImpl(id: request.getAsyncId()!)
                self.invokeService(serviceRequest4!, callback: callback4!);
            case "isServiceRegistered":
                var serviceName5 : String? = JSONUtil.unescapeString(request.getParameters()![0])
                var endpointName5 : String? = JSONUtil.unescapeString(request.getParameters()![1])
                var functionName5 : String? = JSONUtil.unescapeString(request.getParameters()![2])
                var method5 : IServiceMethod? = IServiceMethod.toEnum(JSONUtil.dictionifyJSON(request.getParameters()![3])["value"] as String!)
                var response5 : Bool? = self.isServiceRegistered(serviceName5!, endpointName: endpointName5!, functionName: functionName5!, method: method5!)
                if let response5 = response5 {
                    responseJSON = "\(response5)"
                 } else {
                    responseJSON = "false"
                 }
            default:
                // 404 - response null.
                responseCode = 404
                responseMessage = "ServiceBridge does not provide the function '\(request.getMethodName()!)' Please check your client-side API version; should be API version >= v2.1.6."
        }
        response.setResponse(responseJSON!)
        response.setStatusCode(responseCode)
        response.setStatusMessage(responseMessage)
        return response
    }
}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
