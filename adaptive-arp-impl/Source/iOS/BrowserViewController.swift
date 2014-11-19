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

public class BrowserViewController: BaseViewController, UIWebViewDelegate {
    
    var webView: UIWebView?
    /// Defaults
    public var navigationBarHidden : Bool = false
    public var navigationBarTitle : String = "Browser"
    public var navigationBarBackLabel : String = "Back"
    public var navigationUrl : NSURL?
    private var navigationInitialized = false
    
    init(navigationBarHidden: Bool, navigationBarTitle: String, navigationBarBackLabel: String, navigationUrl: NSURL) {
        super.init()
        self.navigationBarHidden = navigationBarHidden
        self.navigationBarTitle = navigationBarTitle
        self.navigationBarBackLabel = navigationBarBackLabel
        self.navigationUrl = navigationUrl
        self.configureNavigation()
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override public func loadView() {
        super.loadView()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        webView = UIWebView()
        webView?.delegate = self
        self.view = webView
    }
    
    override public func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigation()
        dispatch_async(dispatch_get_main_queue()) {
            if (self.navigationUrl != nil && !self.navigationInitialized) {
                self.webView!.loadRequest(NSURLRequest(URL: self.navigationUrl!))
                self.navigationInitialized = true
            }
        }
    }
    
    private func configureNavigation() {
        self.navigationController?.navigationBarHidden = navigationBarHidden
        self.navigationItem.title = navigationBarTitle
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: navigationBarBackLabel, style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
    }
    
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.sharedApplication().setStatusBarHidden(self.navigationBarHidden, withAnimation: UIStatusBarAnimation.Fade)
    }
    
    public override func prefersStatusBarHidden() -> Bool {
        if super.prefersStatusBarHidden() {
            return true
        } else {
            return self.navigationBarHidden
        }
    }
    
    public func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    public func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
}