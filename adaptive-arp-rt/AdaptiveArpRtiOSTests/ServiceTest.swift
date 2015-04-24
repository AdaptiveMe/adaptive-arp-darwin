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

import XCTest
import AdaptiveArpApi

/**
*  Service delegate tests class
*/
class ServiceTest: XCTestCase {
    
    /// Callback for results
    var callback:ServiceResultCallbackTest!
    
    /**
    Constructor.
    */
    override func setUp() {
        super.setUp()
        
        AppRegistryBridge.sharedInstance.getLoggingBridge().setDelegate(LoggingDelegate())
        AppRegistryBridge.sharedInstance.getPlatformContext().setDelegate(AppContextDelegate())
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().setDelegate(AppContextWebviewDelegate())
        AppRegistryBridge.sharedInstance.getServiceBridge().setDelegate(ServiceDelegate())
        
        callback = ServiceResultCallbackTest(id: 0)
    }
    
    /**
    This method tests all the methods for the service delegate implementation
    */
    func testService() {
        
        // MARK: it is necessary to define a service endpoint in the io-services config file
        
        /*var token:ServiceToken? = AppRegistryBridge.sharedInstance.getServiceBridge().getServiceTokenByUri("http://api.geonames.org/postalCodeLookupJSON")
        XCTAssertNotNil(token, "It is necessary to define a service endpoint in the io-services config file")
        
        var token2:ServiceToken? = AppRegistryBridge.sharedInstance.getServiceBridge().getServiceToken("petstore", endpointName: "http://petstore.swagger.wordnik.com", functionName: "/api/pet/15", method: IServiceMethod.Post)
        XCTAssertNotNil(token2, "It is necessary to define a service endpoint in the io-services config file")
                
        var request:ServiceRequest? = AppRegistryBridge.sharedInstance.getServiceBridge().getServiceRequest(token!)
        XCTAssertNotNil(request, "There is a problem obtaining the request for this request token")
        
        var params:[ServiceRequestParameter] = [ServiceRequestParameter]()
        params.append(ServiceRequestParameter(keyName: "postalcode", keyData: "6600"));
        params.append(ServiceRequestParameter(keyName: "country", keyData: "AT"));
        params.append(ServiceRequestParameter(keyName: "username", keyData: "demo"));
        request!.setQueryParameters(params);
        
        AppRegistryBridge.sharedInstance.getServiceBridge().invokeService(request!, callback: callback)*/
    }
}