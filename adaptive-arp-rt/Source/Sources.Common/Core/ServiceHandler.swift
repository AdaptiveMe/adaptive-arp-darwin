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

import Foundation

public class ServiceHandler:NSObject {
    
    /// Logging variable
    let logger:ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge()
    let loggerTag:String = "ServiceHandler"
    
    /// Singleton instance
    public class var sharedInstance : ServiceHandler {
        struct Static {
            static let instance : ServiceHandler = ServiceHandler()
        }
        return Static.instance
    }
    
    /// Constructor
    public override init() {
    }
    
    /// Method that executes the method with the parameters from the APIRequest object send it by the Typescript. This method could return some data in the syncronous methods or execute some callback/listeners in the asyncronous ones
    /// :param: apiRequest API Request object
    /// :return: Data for returning the syncronous responses
    public func handleServiceUrl(apiRequest:APIRequest) -> APIResponse {
        
        if let bridgeType:String = apiRequest.getBridgeType() {
            
            // Get the bridge
            if let bridge:APIBridge = AppRegistryBridge.sharedInstance.getBridge(bridgeType) {
                
                //logger.log(ILoggingLogLevel.INFO, category: loggerTag, message: "ASYNC ID: \(apiRequest.getAsyncId())")
                
                if apiRequest.getAsyncId() != -1 {
                    
                    let asyncId:Int64? = apiRequest.getAsyncId()
                    
                    // async methods (executed in a background queue)
                    dispatch_async(GCD.backgroundQueue(), {
                        
                        if let result:APIResponse = bridge.invoke(apiRequest) {
                        } else {
                            self.logger.log(ILoggingLogLevel.ERROR, category: self.loggerTag, message: "There is an error executing the asyncronous method: \(apiRequest.getMethodName())")
                        }
                    })
                    
                } else {
                    
                    // sync methods (executed in the main queue)
                    if let result:APIResponse = bridge.invoke(apiRequest) {
                        //logger.log(ILoggingLogLevel.INFO, category: loggerTag, message: "SYNC SERVICE RESULT: \(result)")
                        return result
                    } else {
                        self.logger.log(ILoggingLogLevel.ERROR, category: self.loggerTag, message: "There is an error executing the syncronous method: \(apiRequest.getMethodName())")
                    }
                }
                
            } else {
                logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "There is no bridge with the identifier: \(bridgeType)")
            }
            
        } else {
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "There is no bridge type inside the API Request object")
        }
        
        // Asynchronous responses
        return APIResponse(response: "", statusCode: 200, statusMessage: "Please see native platform log for details.")
    }
}

