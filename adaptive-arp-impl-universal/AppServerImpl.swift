//
//  AppListenerImpl.swift
//
//  Created by Carlos Lozano Diez on 08/09/2014.
//  Copyright (c) 2014 Carlos Lozano Diez. All rights reserved.
//

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