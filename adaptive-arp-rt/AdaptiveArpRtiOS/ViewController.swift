//
//  ViewController.swift
//  AdaptiveArpRtIos
//
//  Created by Carlos Lozano Diez on 08/09/2014.
//  Copyright (c) 2014 Carlos Lozano Diez. All rights reserved.
//

import UIKit
import WebKit
import AdaptiveArpImpliOS

class ViewController: UIViewController {
    
    var webView : UIView?
    var appContextWebview:AppContextWebviewImpl?
    
    @IBOutlet weak var webViewContainer: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        #if os(OSX)
            println("Running on OSX")
        #elseif os(iOS)
            println("Running on iOS")
        #endif
        
        println(NSProcessInfo.processInfo().systemUptime)
        println(NSProcessInfo.processInfo().physicalMemory)
        println(NSProcessInfo.processInfo().activeProcessorCount)
        println(NSProcessInfo.processInfo().processorCount)
        println(NSProcessInfo.processInfo().hostName)
        /*
        println(NSProcessInfo.processInfo().isOperatingSystemAtLeastVersion(NSOperatingSystemVersion(majorVersion: 8, minorVersion: 0, patchVersion: 0)))

        var processInfoOs : NSOperatingSystemVersion = NSProcessInfo.processInfo().operatingSystemVersion
        var osVersion : String = "\(processInfoOs.majorVersion).\(processInfoOs.minorVersion)"
        if (processInfoOs.patchVersion>0) {
            osVersion+=".\(processInfoOs.patchVersion)"
        }

        println(osVersion)
        */
        
        // Do any additional setup after loading the view, typically from a nib.
        var url : NSURL! = NSURL(string:"http://google.com/")
        var req = NSURLRequest(URL:url)

        // TODO: Waiting on Bug fix to support NSProtocol
        //if (NSClassFromString("WKWebView") != nil) {
        //    (self.webView! as WKWebView).loadRequest(req)
        //} else {
            (self.webView! as UIWebView).loadRequest(req)
        //}
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func loadView() {
        super.loadView()
        
        appContextWebview = AppContextWebviewImpl()
        // TODO: Waiting on Bug fix to support NSProtocol
        //if (NSClassFromString("WKWebView") != nil) {
        //    self.webView = WKWebView(frame: self.webViewContainer.bounds)
        //    appContextWebview!.setWebviewPrimary(self.webView!)
        //    println("Using WKWebView")
        //} else {
            self.webView = UIWebView(frame: self.webViewContainer.bounds)
            appContextWebview!.setWebviewPrimary(self.webView!)
            println("Using UIWebView")
        //}
        
        

        self.webView?.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.webViewContainer.addSubview(self.webView!)
        
        //self.view = self.webView!
    }
}

