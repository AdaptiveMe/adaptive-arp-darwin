//
//  AppDelegate.swift
//  AdaptiveArpRtOSX
//
//  Created by Carlos Lozano on 30/10/14.
//  Copyright (c) 2014 Carlos Lozano Diez. All rights reserved.
//

import Cocoa
import AdaptiveArpImpl
import AdaptiveArpApi

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    /// Logging variable
    let logger:ILogging = LoggingImpl()
    let logCategory:String = "NSApplication"
    
    func applicationWillBecomeActive(notification: NSNotification) {
        logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "applicationWillBecomeActive")
    }
    
    func applicationWillFinishLaunching(notification: NSNotification) {
        logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "applicationWillFinishLaunching")
        NSURLProtocol.registerClass(HttpInterceptorProtocol)
    }

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "applicationDidFinishLaunching")
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
        logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "applicationWillTerminate")
        NSURLProtocol.unregisterClass(HttpInterceptorProtocol)
    }


    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "applicationShouldTerminateAfterLastWindowClosed")
        let response = true
        logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "applicationShouldTerminateAfterLastWindowClosed \(response)")
        return response
    }
    
    func applicationShouldTerminate(sender: NSApplication) -> NSApplicationTerminateReply {
        logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "applicationShouldTerminate")
        let response = NSApplicationTerminateReply.TerminateNow
        logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "applicationShouldTerminate \(response)")
        return response
    }

}

