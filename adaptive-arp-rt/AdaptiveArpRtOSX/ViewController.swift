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
*     * Ferran Vila Conesa
*                 <http://github.com/fnva>
*                 <http://twitter.com/ferran_vila>
*                 <mailto:ferran.vila.conesa@gmail.com>
*
* =====================================================================================================================
*/

import Cocoa
import WebKit

class ViewController: BaseViewController {
    
    var webView : WebView!
    
    /**
    Instantiates a view from a nib file and sets the value of the view property.
    */
    override func loadView() {
        super.loadView()
        
        self.webView = WebView(frame: self.view.bounds)
        self.view = self.webView
        
        // Register the HttpInterceptorprotocol
        NSURLProtocol.registerClass(HttpInterceptorProtocol)
        
    }
    
    /**
    Called after the view controller’s view has been loaded into memory.
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (AppRegistryBridge.sharedInstance.getPlatformContextWeb().getDelegate()! as AppContextWebviewDelegate).setWebviewPrimary(self.webView!)
        
        var req = NSURLRequest(URL: NSURL(string: "https://adaptiveapp/index.html")!)
        self.webView.mainFrame.loadRequest(req)
    }
    
    /**
    Called after the view controller’s view has been loaded into memory is about to be added to the view hierarchy in the window.
    */
    override func viewWillAppear() {
        super.viewWillAppear()
    }
    
    /**
    Called when the view controller’s view is fully transitioned onto the screen.
    */
    override func viewDidAppear() {
        super.viewDidAppear()
    }
    
    /**
    Called after the view controller’s view is removed from the view hierarchy in a window.
    */
    override func viewWillDisappear() {
        super.viewWillDisappear()
    }
    
    /**
    Called when the view controller’s view is about to be removed from the view hierarchy in the window.
    */
    override func viewDidDisappear() {
        super.viewDidDisappear()
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
}

