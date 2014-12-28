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

    * @version v2.0.2

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Interface for Managing the Services operations
   Auto-generated implementation of IService specification.
*/
public class ServiceDelegate : BaseCommunicationDelegate, IService {
    
    /// Logger variable
    let logger : ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge()
    let loggerTag : String = "ServiceDelegate"
    
    /// Array of registered services
    var services : [Service]!

    /**
       Default Constructor.
    */
    public override init() {
        super.init()
        
        services = [Service]()
    }

    /**
       Get a reference to a registered service by name.

       @param serviceName Name of service.
       @return A service, if registered, or null of the service does not exist.
       @since ARP1.0
    */
    public func getService(serviceName : String) -> Service {
        
        for service in services {
            
            if(service.getName() == serviceName) {
                
                logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Returning \(service.getName()!) from the service pull")
                return service
            }
        }
        
        logger.log(ILoggingLogLevel.WARN, category: loggerTag, message: "\(serviceName) is not founded on the pull")
        
        // TODO: Return nil when the return value will be optional
        return Service()
    }

    /**
       Request async a service for an Url

       @param serviceRequest Service Request to invoke
       @param service        Service to call
       @param callback       Callback to execute with the result
       @since ARP1.0
    */
    public func invokeService(serviceRequest : ServiceRequest, service : Service, callback : IServiceResultCallback) {
        // TODO: Not implemented. Find the previous version without Alamofire
    }

    /**
       Check whether a service by the given service is already registered.

       @param service Service to check
       @return True if the service is registered, false otherwise.
       @since ARP1.0
    */
    public func isRegistered(service : Service) -> Bool {
        
        // TODO: Return this when the return value will be optional
        // return self.getService(service.getName()!) != nil ? true : false
        return false
    }

    /**
       Check whether a service by the given name is registered.

       @param serviceName Name of service.
       @return True if the service is registered, false otherwise.
       @since ARP1.0
    */
    public func isRegistered(serviceName : String) -> Bool {
        
        // TODO: Return this when the return value will be optional
        // return self.getService(serviceName) != nil ? true : false
        return false
    }

    /**
       Register a new service

       @param service to register
       @since ARP1.0
    */
    public func registerService(service : Service) {
        
        if service.getName() == "" || service.getName()!.isEmpty {
            
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "The service has no name. Impossible to add to the pull")
        } else {
            
            services.append(service)
            logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Adding \(service.getName()!) to the service pull")
        }
    }

    /**
       Unregister a service

       @param service to unregister
       @since ARP1.0
    */
    public func unregisterService(service : Service) {
        
        for (index, s) in enumerate(services) {
            
            if(s == service) {
                
                services.removeAtIndex(index)
                
                logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Removing \(service.getName()!) to the service pull")
                
                return
            }
        }
        
        logger.log(ILoggingLogLevel.WARN, category: loggerTag, message: "\(service.getName()!) is not founded in the pull for removing")
    }

    /**
       Unregister all services.

       @since ARP1.0
    */
    public func unregisterServices() {
        
        logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Removing all services from thee service pull")
        
        services.removeAll(keepCapacity: false)
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
