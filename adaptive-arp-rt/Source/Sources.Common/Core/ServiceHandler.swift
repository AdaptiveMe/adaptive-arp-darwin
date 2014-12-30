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
    
    /// Method that handles the url from the JS and execute the native methods. This method could return some data in the syncronous methods or execute some callback/listeners in the asyncronous ones
    /// :param: url HTML5 url to parse
    /// :return: Data for returning the syncronous responses
    public func handleServiceUrl(apiRequest:APIRequest) -> NSString {
        
        // 1. Get the Service Type // MARK: maybe store inside the APIRequest
        // 2. Obtain the bridge: AppRegistryBridge.sharedInstance.getBridge()
        // 3. Execute the method
        // 3.1 Difference between the sync or async method (asyncId on APIBridge) dispatch_async(GCD.backgroundQueue(),{...});
        // 4 Return the response
        
        return ""
    }
}

