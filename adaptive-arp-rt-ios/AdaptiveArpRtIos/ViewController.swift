//
//  ViewController.swift
//  AdaptiveArpRtIos
//
//  Created by Carlos Lozano Diez on 08/09/2014.
//  Copyright (c) 2014 Carlos Lozano Diez. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet var containerView : UIView! = nil
    var webView : WKWebView?    
    
    
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
        println(NSProcessInfo.processInfo().isOperatingSystemAtLeastVersion(NSOperatingSystemVersion(majorVersion: 8, minorVersion: 0, patchVersion: 0)))
        var processInfoOs : NSOperatingSystemVersion = NSProcessInfo.processInfo().operatingSystemVersion
        var osVersion : String = "\(processInfoOs.majorVersion).\(processInfoOs.minorVersion)"
        if (processInfoOs.patchVersion>0) {
            osVersion+=".\(processInfoOs.patchVersion)"
        }

        println(osVersion)
        // Do any additional setup after loading the view, typically from a nib.
        var url = NSURL(string:"http://google.com/")
        var req = NSURLRequest(URL:url)
        self.webView!.loadRequest(req)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func loadView() {
        super.loadView()
        self.webView = WKWebView()
        self.view = self.webView!
    }
}

