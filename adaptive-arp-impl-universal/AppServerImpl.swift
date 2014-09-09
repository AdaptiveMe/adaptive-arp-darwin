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
*     *
*
* =====================================================================================================================
*/

import Foundation

class AppServerImpl : IAppServer {
    
    private var baseURI : String
    private var host : String
    private var path : String
    private var port : Int
    private var scheme : String
    private var manager : IAppServerManager
    
    init(scheme : String, host : String, port : Int, path : String, manager : IAppServerManager) {
        self.scheme = scheme
        self.host = host
        self.port = port
        self.path = path
        self.baseURI = self.scheme+"://"+self.host+":"+String(self.port)+self.path
        self.manager = manager;
    }
    
    func getBaseURI() -> String {
        return self.baseURI
    }
    
    func getHost() -> String {
        return self.host
    }
    
    func getPath() -> String {
        return self.path
    }
    
    func getPort() -> Int {
        return self.port
    }
    
    func getScheme() -> String {
        return self.scheme
    }
    
    func pauseServer() {
        manager.pauseServer(self)
    }
    
    func resumeServer() {
        manager.resumeServer(self)
    }
    
    func stopServer() {
        manager.stopServer(self)
    }
}