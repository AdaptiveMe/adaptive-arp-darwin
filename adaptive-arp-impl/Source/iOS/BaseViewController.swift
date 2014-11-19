//
//  BaseViewController.swift
//  adaptive-arp-rt
//
//  Created by Carlos Lozano Diez on 19/11/14.
//  Copyright (c) 2014 Carlos Lozano Diez. All rights reserved.
//

import UIKit



public class BaseViewController : UIViewController {
    
    struct NavigationProperties {
        var navigationBarHidden : Bool = false
        var navigationBarTitle : String = "Browser"
        var navigationBarBackLabel : String = "Back"
        var navigationUrl : NSURL?
    }
    
    private var navigationProperties : NavigationProperties?
    
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
    
    override public func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if ViewPrevious.getView()==nil && ViewCurrent.getView()==nil {
            ViewCurrent.setView(self)
        } else if (ViewCurrent.getView() != nil) {
            ViewPrevious.setView(ViewCurrent.getView()!)
            ViewCurrent.setView(self)
        }
    }
    
    public func showInternalBrowser(titleLabel:String, backLabel:String, url : NSURL, showNavBar : Bool) -> Bool {
        dispatch_async(dispatch_get_main_queue()) {
            self.navigationProperties = NavigationProperties(navigationBarHidden: showNavBar, navigationBarTitle: titleLabel, navigationBarBackLabel: backLabel, navigationUrl: url)
            self.performSegueWithIdentifier("showBrowser", sender: self)
        }
        return true
    }
    
    public override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showBrowser" && segue.destinationViewController is BrowserViewController) {
            var browserView : BrowserViewController = segue.destinationViewController as BrowserViewController
            var senderView : BaseViewController = sender as BaseViewController
            //self.navigationItem.title = "App"
            if (navigationProperties != nil) {
                browserView.navigationBarBackLabel = senderView.navigationProperties!.navigationBarBackLabel
                browserView.navigationBarHidden = !senderView.navigationProperties!.navigationBarHidden
                browserView.navigationBarTitle = senderView.navigationProperties!.navigationBarTitle
                browserView.navigationUrl = senderView.navigationProperties!.navigationUrl
            }
        }
    }
    
}
