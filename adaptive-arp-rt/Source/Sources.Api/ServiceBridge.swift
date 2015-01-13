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

    * @version v2.0.3

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
       Get a reference to a registered service by name.

       @param serviceName Name of service.
       @return A service, if registered, or null of the service does not exist.
       @since ARP1.0
    */
    public func getService(serviceName : String ) -> Service? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "ServiceBridge executing getService({\(serviceName)}).")
        }

        var result : Service? = nil
        if (self.delegate != nil) {
            result = self.delegate!.getService(serviceName)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "ServiceBridge executed 'getService' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "ServiceBridge no delegate for 'getService'.")
            }
        }
        return result!        
    }

    /**
       Request async a service for an Url

       @param serviceRequest Service Request to invoke
       @param service        Service to call
       @param callback       Callback to execute with the result
       @since ARP1.0
    */
    public func invokeService(serviceRequest : ServiceRequest , service : Service , callback : IServiceResultCallback ) {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "ServiceBridge executing invokeService({\(serviceRequest)},{\(service)},{\(callback)}).")
        }

        if (self.delegate != nil) {
            self.delegate!.invokeService(serviceRequest, service: service, callback: callback)
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
       Check whether a service by the given service is already registered.

       @param service Service to check
       @return True if the service is registered, false otherwise.
       @since ARP1.0
    */
    public func isRegistered(service : Service ) -> Bool? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "ServiceBridge executing isRegistered({\(service)}).")
        }

        var result : Bool? = false
        if (self.delegate != nil) {
            result = self.delegate!.isRegistered(service)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "ServiceBridge executed 'isRegistered' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "ServiceBridge no delegate for 'isRegistered'.")
            }
        }
        return result        
    }

    /**
       Check whether a service by the given name is registered.

       @param serviceName Name of service.
       @return True if the service is registered, false otherwise.
       @since ARP1.0
    */
    public func isRegistered(serviceName : String ) -> Bool? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "ServiceBridge executing isRegistered({\(serviceName)}).")
        }

        var result : Bool? = false
        if (self.delegate != nil) {
            result = self.delegate!.isRegistered(serviceName)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "ServiceBridge executed 'isRegistered' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "ServiceBridge no delegate for 'isRegistered'.")
            }
        }
        return result        
    }

    /**
       Register a new service

       @param service to register
       @since ARP1.0
    */
    public func registerService(service : Service ) {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "ServiceBridge executing registerService({\(service)}).")
        }

        if (self.delegate != nil) {
            self.delegate!.registerService(service)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "ServiceBridge executed 'registerService' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "ServiceBridge no delegate for 'registerService'.")
            }
        }
        
    }

    /**
       Unregister a service

       @param service to unregister
       @since ARP1.0
    */
    public func unregisterService(service : Service ) {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "ServiceBridge executing unregisterService({\(service)}).")
        }

        if (self.delegate != nil) {
            self.delegate!.unregisterService(service)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "ServiceBridge executed 'unregisterService' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "ServiceBridge no delegate for 'unregisterService'.")
            }
        }
        
    }

    /**
       Unregister all services.

       @since ARP1.0
    */
    public func unregisterServices() {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "ServiceBridge executing unregisterServices.")
        }

        if (self.delegate != nil) {
            self.delegate!.unregisterServices()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "ServiceBridge executed 'unregisterServices' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "ServiceBridge no delegate for 'unregisterServices'.")
            }
        }
        
    }

    /**
       Invokes the given method specified in the API request object.

       @param request APIRequest object containing method name and parameters.
       @return String with JSON response or a zero length string if the response is asynchronous or null if method not found.
    */
    public override func invoke(request : APIRequest) -> String? {
        var responseJSON : String? = ""
        switch request.getMethodName()! {
            case "getService":
                var serviceName0 : String? = JSONUtil.unescapeString(request.getParameters()![0])
                var response0 : Service? = self.getService(serviceName0!)
                if let response0 = response0 {
                    responseJSON = Service.Serializer.toJSON(response0)
                } else {
                    responseJSON = "{ null }"
                }
            case "invokeService":
                var serviceRequest1 : ServiceRequest? = ServiceRequest.Serializer.fromJSON(request.getParameters()![0])
                var service1 : Service? = Service.Serializer.fromJSON(request.getParameters()![1])
                var callback1 : IServiceResultCallback? =  ServiceResultCallbackImpl(id: request.getAsyncId()!)
                self.invokeService(serviceRequest1!, service: service1!, callback: callback1!);
            case "registerService":
                var service2 : Service? = Service.Serializer.fromJSON(request.getParameters()![0])
                self.registerService(service2!);
            case "unregisterService":
                var service3 : Service? = Service.Serializer.fromJSON(request.getParameters()![0])
                self.unregisterService(service3!);
            case "unregisterServices":
                self.unregisterServices();
            case "isRegistered_service":
                var service5 : Service? = Service.Serializer.fromJSON(request.getParameters()![0])
                var response5 : Bool? = self.isRegistered(service5!)
                if let response5 = response5 {
                    responseJSON = "{ \(response5) }"
                 } else {
                    responseJSON = "{ false }"
                 }
            case "isRegistered_serviceName":
                var serviceName6 : String? = JSONUtil.unescapeString(request.getParameters()![0])
                var response6 : Bool? = self.isRegistered(serviceName6!)
                if let response6 = response6 {
                    responseJSON = "{ \(response6) }"
                 } else {
                    responseJSON = "{ false }"
                 }
            default:
                // 404 - response null.
                responseJSON = nil
        }
        return responseJSON
    }
}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
