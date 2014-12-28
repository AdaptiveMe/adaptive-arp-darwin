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
*     * Ferran Vila Conesa
*                 <http://github.com/fnva>
*                 <http://twitter.com/ferran_vila>
*                 <mailto:ferran.vila.conesa@gmail.com>
*
* =====================================================================================================================
*/

import ObjectiveC
import Foundation

public class ServiceHandler:NSObject {
    
    /// Logging variable
    let logger:ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge()
    let loggerTag:String = "ServiceHandler"
    
    /// Queue for executing async tasks
    var queue:dispatch_queue_t!
    let queueLabel = "AdaptiveAsync"
    
    let callbackIdentifierKey:String = "id"
    
    /// Singleton instance
    public class var sharedInstance : ServiceHandler {
        struct Static {
            static let instance : ServiceHandler = ServiceHandler()
        }
        return Static.instance
    }
    
    /// Constructor
    public override init() {
        
        // Create a queue for executing async methods
        queue = dispatch_queue_create(queueLabel, nil)
    }
    
    /// Method that handles the url from the JS and execute the native methods. This method could return some data in the syncronous methods or execute some callback/listeners in the asyncronous ones
    /// :param: url HTML5 url to parse
    /// :return: Data for returning the syncronous responses
    public func handleServiceUrl(request:NSMutableURLRequest) -> NSData? {
        
        // The url format is: [SCHEMA]://adaptiveapp/[BASE_CLASS]/[GROUP]/[TYPE]/[METHOD]?id=idCallback/listener
        
        var url = request.URL!.absoluteString!
        
        var nsurl:NSURL = NSURL(string: url)!
        var parameters:String? = nsurl.query
        var callbackIdentifier:Int?
        var isAsync:Bool = false
        
        // URL parameters
        
        if let parameters = parameters {
            
            // ASYNCRONOUS REQUESTS : The url has parameters, so there is a callback or a listener
            
            isAsync = true
            
            var paramArr:[String] = parameters.componentsSeparatedByString("&")
            
            for parameter:String in paramArr {
                var kvArr:[String] = parameter.componentsSeparatedByString("=")
                
                if kvArr[0] == callbackIdentifierKey {
                    callbackIdentifier = kvArr[1].toInt()
                }
            }
            
            if callbackIdentifier == nil {
                logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "Executing a asyncronous API method without the \"\(callbackIdentifierKey)\" parameter in the URL")
                return nil
            }
            
        }
        
        // URL PATH: obtain method and class and base class
        
        // This works even if the url has parameters or not
        var path:String = url.componentsSeparatedByString("?")[0]
        var pathArray:[String] = path.componentsSeparatedByString("/")
        
        var method:String = pathArray[pathArray.count-1]
        var type:String = pathArray[pathArray.count-2]
        var group:String = pathArray[pathArray.count-3]
        
        if method.isEmpty || type.isEmpty {
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "Error trying to obtain the method and the type for executing the native call")
            return nil
        }
        
        // PARSE THE PARAMETERS
                
        // EXECUTE THE METHOD
        
        logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Executing \"\(method)\" method defined in \"\(type)\" api interface based on \"\(group)\" class")
            
        if isAsync {
            
            dispatch_async(GCD.backgroundQueue(),{
                
                // TODO: Get the class from the registry and execute the method and return the value
                
            });
            
        } else {
            
            var ret:NSData?
            
            dispatch_sync(GCD.mainQueue(),{
                
                // TODO: Get the class from the registry and execute the method and return the value
            });
            
            return ret
        }
        
        return nil
    }
}

