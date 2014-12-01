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
import AdaptiveArpImpl
import AdaptiveArpApi

class ServiceTest: XCTestCase {
    
    var iService:IService!
    var callback:IServiceResultCallback!
    
    override func setUp() {
        super.setUp()
        
        iService = ServiceImpl()
        callback = IServiceResultCallbackImpl()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /// Test the service manipulation
    func testService() {
        var endpoint:Endpoint = Endpoint(host: "petstore.swagger.wordnik.com", path: "/api/pet", port: 80, proxy: "", scheme: "http")
        var service:Service = Service(endpoint: endpoint, name: "geonames", method: Service.ServiceMethod.POST, type: Service.ServiceType.SERVICETYPE_REST_JSON)
        
        iService.registerService(service)
        
        XCTAssert(iService.getService(service.getName()!) != nil, "The service is not registered correctly")
        XCTAssert(iService.isRegistered(service), "The service is not registered correctly")
        XCTAssert(iService.isRegistered(service.getName()!), "The service is not registered correctly")
        
        iService.unregisterService(service)
        iService.unregisterServices()
        
        XCTAssertFalse(iService.isRegistered(service), "The service is not unregistered correctly")
        XCTAssertFalse(iService.isRegistered(service.getName()!), "The service is not unregistered correctly")
    }
    
    // Test the invoke service
    func testInvoque(){
        
        var endpoint:Endpoint = Endpoint(host: "petstore.swagger.wordnik.com", path: "/api/pet", port: 80, proxy: "", scheme: "http")
        var service:Service = Service(endpoint: endpoint, name: "geonames", method: Service.ServiceMethod.POST, type: Service.ServiceType.SERVICETYPE_REST_JSON)
        
        var session:ISession = SessionImpl()
        
        var header1:Header = Header(name: "Accept", data: "application/json")
        var header2:Header = Header(name: "Accept-Encoding", data: "gzip, deflate")
        var header3:Header = Header(name: "Accept-Language", data: "en-US,en;q=0.8")
        var header5:Header = Header(name: "Connection", data: "keep-alive")
        var header6:Header = Header(name: "Host", data: "petstore.swagger.wordnik.com")
        var header7:Header = Header(name: "Origin", data: "http://petstore.swagger.wordnik.com")
        var header8:Header = Header(name: "Referer", data: "http://petstore.swagger.wordnik.com/")
        var header9:Header = Header(name: "User-Agent", data: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.62 Safari/537.36")
        
        // Post parameters in content
        var content:String = "{\"id\":65,\"category\":{\"id\":0,\"name\":\"\"},\"name\":\"\",\"photoUrls\":[\"\"],\"tags\":[{\"id\":0,\"name\":\"\"}],\"status\":\"\"}"
        
        var request:ServiceRequest = ServiceRequest(content: content, contentType: "application/json", contentLength: content.lengthOfBytesUsingEncoding(NSUTF8StringEncoding), rawContent: [], headers: [header1, header2, header3, header5, header6, header7, header8, header9], method: Service.ServiceMethod.POST.toString(), protocolVersion: ServiceRequest.ProtocolVersion.HTTP_PROTOCOL_VERSION_1_1, session: session, contentEncoding: String(NSUTF8StringEncoding))
        
        iService.registerService(service)
        iService.invokeService(request, service: service, callback: callback)
    }
}

/// Dummy implementation of the callback in order to run the tests
class IServiceResultCallbackImpl: NSObject, IServiceResultCallback {
    func onError(error: AdaptiveArpApi.IServiceResultCallbackError) {println("ERROR: \(error.toString())")}
    func onResult(response: AdaptiveArpApi.ServiceResponse) {println("RESPONSE: \(response.description)")}
    func onWarning(response: AdaptiveArpApi.ServiceResponse, warning: AdaptiveArpApi.IServiceResultCallbackWarning) {println("WARNING: \(warning.toString()) \nRESPONSE: \(response.description)")}
    func toString() -> String? {return ""}
    func getId() -> Int64 {return 0}
}