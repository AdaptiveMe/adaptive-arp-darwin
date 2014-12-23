//
//  ViewController.swift
//  AdaptiveArpRtOSX
//
//  Created by Carlos Lozano on 30/10/14.
//  Copyright (c) 2014 Carlos Lozano Diez. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController {

    var webView : WebView?
    //var appContextWebview:AppContextWebviewImpl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var req = NSURLRequest(URL: NSURL(string: "https://adaptiveapp/index.html")!)
        self.webView!.mainFrame.loadRequest(req)
    }
    
    override func loadView() {
        super.loadView()
        self.webView = WebView(frame: self.view.bounds)
        //(AppRegistryImpl.sharedInstance.getPlatformContextWeb()! as AppContextWebviewImpl).setWebviewPrimary(self.webView!)
        self.view = self.webView!
        NSURLProtocol.registerClass(HttpInterceptorProtocol)
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    


}

