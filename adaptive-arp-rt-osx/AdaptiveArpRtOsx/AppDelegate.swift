//
//  AppDelegate.swift
//  AdaptiveArpRtOsx
//
//  Created by Carlos Lozano Diez on 05/09/2014.
//  Copyright (c) 2014 Carlos Lozano Diez. All rights reserved.
//

import Cocoa
import WebKit

class AppDelegate: NSObject, NSApplicationDelegate {
                            
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var webview: WebView!
    let application = NSApplication.sharedApplication();
    let windowDelegate = WindowDelegate();

    
    override init() {
        println("init");
        application.setActivationPolicy(NSApplicationActivationPolicy.Regular)
    }
    
    
    func applicationWillBecomeActive(notification: NSNotification!) {
        println("applicationWillBecomeActive");
    }
    
    func applicationWillFinishLaunching(notification: NSNotification!) {
        println("applicationWillFinishLaunching");
        //window.setContentSize(NSSize(width: 800, height: 600))
        window.contentMinSize = NSSize(width: 320, height: 480)
        //println(window.contentMaxSize);
        //println(window.screen.frame.size);

        window.title = "Adaptive Minimal Container"
        //window.center()
        window.makeKeyAndOrderFront(window)
        window.delegate = windowDelegate
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        // Insert code here to initialize your application
        println("applicationDidFinishLaunching");
        var requestUrl : NSURL! = NSURL(string : "http://google.com")
        var request : NSURLRequest = NSURLRequest(URL: requestUrl)
        //webview.customUserAgent = "Mozilla/5.0 (Windows; U; MSIE 9.0; WIndows NT 10.0; en-US))"
        webview.mainFrame.loadRequest(request)
    }

    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
        println("applicationWillTerminate");
       
    }
    
    func applicationShouldTerminate(sender: NSApplication!) -> NSApplicationTerminateReply {
        println("applicationShouldTerminate")
        return NSApplicationTerminateReply.TerminateNow;
    }

}

