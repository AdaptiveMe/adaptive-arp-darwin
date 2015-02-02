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
import AVKit

public class BaseViewController : UIViewController {
    
    /// Maintain a static reference to current and previous views
    public struct ViewCurrent {
        private static var instance : UIViewController?
        public static func getView() -> UIViewController? {
            return instance
        }
        static func setView(view : UIViewController) {
            instance = view
        }
        
    }
    
    public struct ViewPrevious {
        private static var instance : UIViewController?
        public static func getView() -> UIViewController? {
            return instance
        }
        static func setView(view : UIViewController) {
            instance = view
        }
        
    }
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if ViewPrevious.getView()==nil && ViewCurrent.getView()==nil {
            ViewCurrent.setView(self)
        } else if (ViewCurrent.getView() != nil) {
            ViewPrevious.setView(ViewCurrent.getView()!)
            ViewCurrent.setView(self)
        }
    }
    
    override public func supportedInterfaceOrientations() -> Int {
        /// TODO - delegate to HTML app
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
    override public func shouldAutorotate() -> Bool {
        /// TODO - delegate to HTML app
        return false
    }
    
    public func showInternalBrowser(titleLabel:String, backLabel:String, url : NSURL, showNavBar : Bool, showAnimated : Bool = true, modal : Bool = false) -> Bool {
        objc_sync_enter(self)
        
        var properties = NavigationProperties(navigationBarHidden: showNavBar, navigationBarTitle: titleLabel, navigationBarBackLabel: backLabel, navigationUrl: url)
        
        dispatch_async(dispatch_get_main_queue()) {
            var browserView : BrowserViewController = BrowserViewController(navigationBarHidden: !properties.navigationBarHidden, navigationBarTitle: properties.navigationBarTitle, navigationBarBackLabel: properties.navigationBarBackLabel, navigationUrl: properties.navigationUrl!)
            
            if modal {
                // TODO: present the top bar when presenting modal view controllers
                self.navigationController!.presentViewController(browserView, animated: true, completion: nil)
            } else {
                self.navigationController!.pushViewController(browserView, animated: showAnimated)
            }
            
        }
        if showAnimated {
            NSThread.sleepForTimeInterval(0.750)
        }
        
        objc_sync_exit(self)
        return true
    }
    
    public func showInternalMedia(url : NSURL, showAnimated : Bool = true) -> Bool {
        objc_sync_enter(self)
        
        dispatch_async(dispatch_get_main_queue()) {
            
            var mediaView : MediaViewController = MediaViewController(url: url)
            self.navigationController!.presentViewController(mediaView, animated: showAnimated, completion: nil)
        }
        if showAnimated {
            NSThread.sleepForTimeInterval(0.750)
        }
        
        objc_sync_exit(self)
        return true
    }
    
    public override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "showBrowser" && segue.destinationViewController is BrowserViewController) {
            
            var browserView : BrowserViewController = segue.destinationViewController as BrowserViewController
            ViewCurrent.setView(browserView)
            var properties : NavigationProperties = sender as NavigationProperties
            browserView.navigationBarBackLabel = properties.navigationBarBackLabel
            browserView.navigationBarHidden = !properties.navigationBarHidden
            browserView.navigationBarTitle = properties.navigationBarTitle
            browserView.navigationUrl = properties.navigationUrl
            
        } else if (segue.identifier == "showMedia" && segue.destinationViewController is MediaViewController) {
            
            var mediaView : MediaViewController = segue.destinationViewController as MediaViewController
            ViewCurrent.setView(mediaView)
        }
    }
}