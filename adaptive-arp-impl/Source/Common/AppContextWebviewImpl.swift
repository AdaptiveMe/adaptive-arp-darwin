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
*     *
*
* =====================================================================================================================
*/

import Foundation
import WebKit
import AdaptiveArpApi

public class AppContextWebviewImpl : NSObject, IAppContextWebview {
    
    var primaryView:AnyObject?
    var webViewList:[AnyObject]
    
    /// Singleton instance
    public class var sharedInstance : AppContextWebviewImpl {
        struct Static {
            static let instance : AppContextWebviewImpl = AppContextWebviewImpl()
        }
        return Static.instance
    }
    
    /// Constructor
    override public init() {
        webViewList = [AnyObject]()
    }
    
    /// Set the primary webview
    public func setWebviewPrimary(webView : AnyObject) {
        self.primaryView = webView
    }
    
    /// Get the primary webview
    public func getWebviewPrimary() -> AnyObject? {
        return self.primaryView!
    }
    
    /// Add a webview in the list
    public func addWebview(webViewInstance : AnyObject) {
        
        var exists = false;
        
        // Check if the webview is alredy in the array
        if let instance:AnyObject = webViewInstance as AnyObject? {
            for w in webViewList {
                if (w as NSObject == instance as NSObject) {
                    exists = true
                    break
                }
            }
        }
        
        // Avoid duplicate entries.
        if !exists {
           webViewList.append(webViewInstance)
        }
    }
    
    /// Returns all the webviews
    public func getWebviews() -> [AnyObject]? {
        
        var webViewListFull:[AnyObject] = [AnyObject]()
        
        // Primary webview
        if (self.primaryView != nil) {
           webViewListFull.append(self.primaryView!)
        }
        
        // Other webviews
        for webView in self.webViewList {
           webViewListFull.append(webView)
        }
        
        return webViewListFull
    }
    
    /// Remove one webview
    public func removeWebview(webViewInstance : AnyObject) {
        
        for (index, webView) in enumerate(self.webViewList) {
            if (webView as NSObject == webViewInstance as NSObject) {
                self.webViewList.removeAtIndex(index)
                return
            }
        }
    }
    
}