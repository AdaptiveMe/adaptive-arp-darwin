//
//  ViewController.swift
//  AdaptiveArpRtOSX
//
//  Created by Carlos Lozano on 30/10/14.
//  Copyright (c) 2014 Carlos Lozano Diez. All rights reserved.
//

import Cocoa
import AdaptiveArpImplOSX
import WebKit

class ViewController: NSViewController {

    var webView : WebView?
    var appContextWebview:AppContextWebviewImpl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        #if os(OSX)
            println("Running on OSX")
            #elseif os(iOS)
            println("Running on iOS")
        #endif
        appContextWebview = AppContextWebviewImpl()
        self.webView = WebView(frame: self.view.bounds)
        appContextWebview!.setWebviewPrimary(self.webView!)
        self.view = self.webView!
        println("Using WKWebView")
        
        println(NSProcessInfo.processInfo().systemUptime)
        println(NSProcessInfo.processInfo().physicalMemory)
        println(NSProcessInfo.processInfo().activeProcessorCount)
        println(NSProcessInfo.processInfo().processorCount)
        println(NSProcessInfo.processInfo().hostName)
        
        // Do any additional setup after loading the view.
        
        var url : NSURL! = NSURL(string:"http://google.com/")
        var req = NSURLRequest(URL:url)
        self.webView!.mainFrame.loadRequest(req)
        //self.webView!.loadRequest(req)
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

