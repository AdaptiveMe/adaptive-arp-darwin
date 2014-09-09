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

