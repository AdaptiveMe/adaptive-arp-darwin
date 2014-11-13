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

import UIKit
import AdaptiveArpImpl
import AdaptiveArpApi

class ViewController: UIViewController {
    
    /// Webview container
    @IBOutlet weak var webViewContainer: UIView!
    
    /// Logging variable
    let logger:ILogging = LoggingImpl()
    
    /// Webview
    var webView:UIView?
    
    /// Aplication Context Webview
    //var appContextWebview:AppContextWebviewImpl?
    
    /// The view controller calls this method when its view property is requested but is currently nil. This method loads or creates a view and assigns it to the view property.
    override func loadView() {
        super.loadView()
        
        // Create the webview
        self.webView = UIWebView(frame: self.webViewContainer.bounds)
        
        (AppRegistryImpl.sharedInstance.getPlatformContextWeb()! as AppContextWebviewImpl).setWebviewPrimary(self.webView!)
        
        self.webView?.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.webViewContainer.addSubview(self.webView!)
    }
    
    /// This method is called after the view controller has loaded its view hierarchy into memory. This method is called regardless of whether the view hierarchy was loaded from a nib file or created programmatically in the loadView method.
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("index", ofType: ".html", inDirectory: "App.Source/www")
        var req = NSURLRequest(URL: NSURL(string: "http://adaptiveapp/index.html")!)
        (self.webView! as UIWebView).loadRequest(req)

        // MARK: Waiting on Bug fix to support NSProtocol
        /*if (NSClassFromString("WKWebView") != nil) {
            (self.webView! as WKWebView).loadRequest(req)
        } else {
            (self.webView! as UIWebView).loadRequest(req)
        }*/
        

    }
    
    /// Sent to the view controller when the app receives a memory warning.
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
}

