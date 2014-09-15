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

public class AppServerManagerImpl : IAppServerManager {
    
    var listenerList : [IAppServerListener]
    var serverList : [IAppServer]
    var serverRegistry : Dictionary<String, HttpServer>
    let logger : ILogging = LoggingImpl()
    
    init() {
        self.listenerList = []
        self.serverList = []
        self.serverRegistry = Dictionary<String, HttpServer>()
    }
    
    public func addServerListener(listener : IAppServerListener) {
        var exists : Bool = false
        for existingListener in self.listenerList {
            if (existingListener.toString() == listener.toString()) {
                exists = true;
                break
            }
        }
        if (!exists) {
            debug("addServerListener "+listener.toString()+".")
            self.listenerList.append(listener)
        }
    }
    
    public func getServers() -> [IAppServer] {
        let servers : [IAppServer] = self.serverList
        return servers
    }
    
    public func removeServerListener(listener : IAppServerListener) {
        var index : Int = 0
        var exists : Bool = false;
        for existingListener in listenerList {
            if (existingListener.toString() == listener.toString()) {
                exists = true
                break
            } else {
                index++
            }
        }
        if (exists) {
            debug("removeServerListener "+listener.toString()+".")
            listenerList.removeAtIndex(index)
        }
    }
    
    public func removeServerListeners() {
        debug("removeServerListeners.")
        listenerList.removeAll(keepCapacity: false)
    }
    
    
    public func startServer() {
        // Before Start
        var httpServer : HttpServer = HttpServer()
        var httpError : NSErrorPointer = NSErrorPointer()
        var appServer : IAppServer?
        for port in 1025...22000 {
            if (httpServer.start(listenPort: UInt16(port), error: httpError)) {
                appServer = AppServerImpl(scheme: "http", host: "127.0.0.1", port: port, path: "/", manager: self)
                debug("startServer "+appServer!.getBaseURI()+".")
            }
        }
        // After Start
        if (appServer != nil) {
            self.serverRegistry[appServer!.getBaseURI()] = httpServer
            for listener in listenerList {
                debug("startServer onStart notify listener "+listener.toString()+".")
                listener.onStart(appServer!)
            }
        }
    }
    
    public func stopServer(server : IAppServer) {
        // Before
        for listener in listenerList {
            debug("stopServer "+server.getBaseURI()+".")
            listener.onStopping(server)
        }
        
        // Stop Server
        debug("stopServer "+server.getBaseURI()+".")
        var httpServer : HttpServer? = self.serverRegistry.removeValueForKey(server.getBaseURI())
        while (httpServer!.activeRequests()>0) {
            sleep(100)
            debug("stopServer - waiting - "+String(httpServer!.activeRequests())+" pending.")
        }
        httpServer!.stop()

        // After
        for listener in listenerList {
            debug("stopServer onStopped notify listener "+listener.toString()+".")
            listener.onStopped(server)
            
        }
    }
    
    public func pauseServer(server : IAppServer) {
        // Before
        for listener in listenerList {
            debug("pauseServer onPausing notify listener "+listener.toString()+".")
            listener.onPausing(server)
        }
        
        // Stop Server
        debug("pauseServer "+server.getBaseURI()+".")
        var httpServer : HttpServer? = self.serverRegistry[server.getBaseURI()]
        while (httpServer!.activeRequests()>0) {
            sleep(100)
            debug("pauseServer - waiting - "+String(httpServer!.activeRequests())+" pending.")
        }
        httpServer!.stop()
        
        // After
        for listener in listenerList {
            debug("pauseServer onPaused notify listener "+listener.toString()+".")
            listener.onPaused(server)
        }
    }
    
    public func resumeServer(server: IAppServer) {
        // Before
        for listener in listenerList {
            debug("resumeServer onResuming notify listener "+listener.toString()+".")
            listener.onResuming(server)
        }
        
        var httpServer : HttpServer = HttpServer()
        var httpError : NSErrorPointer = NSErrorPointer()
        var appServer : IAppServer?
        for port in 1025...22000 {
            if (httpServer.start(listenPort: UInt16(port), error: httpError)) {
                appServer = AppServerImpl(scheme: "http", host: "127.0.0.1", port: port, path: "/", manager: self)
                debug("resumeServer "+server.getBaseURI()+".")
            }
        }
        // After Start
        if (appServer != nil) {
            self.serverRegistry[appServer!.getBaseURI()] = httpServer
        }
        
        // After
        for listener in listenerList {
            debug("resumeServer onResumed notify listener "+listener.toString()+".")
            listener.onResumed(appServer!)
        }
    }
    
    public func stopServers() {
        for server in serverList {
            stopServer(server)
        }
    }
    
    private func debug(message : String!) {
        logger.log(ILoggingLogLevel.DEBUG, category: "IAppServerManager", message: message)
    }
}