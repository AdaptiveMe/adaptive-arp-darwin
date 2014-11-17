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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?
    
    /// Logging variable
    let logger:ILogging = LoggingImpl()
    let logCategory:String = "UIApplication"
    
    /// Use this method (and the corresponding application:didFinishLaunchingWithOptions: method) to initialize your app and prepare it to run. This method is called after your app has been launched and its main storyboard or nib file has been loaded, but before your app’s state has been restored. At the time this method is called, your app is in the inactive state.
    func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "willFinishLaunchingWithOptions")
        logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: AppRegistryImpl.sharedInstance.getSystemOS()!.getOSInfo()!.getVersion()!)
        NSURLProtocol.registerClass(HttpInterceptorProtocol)
        return true
    }

    /// Use this method (and the corresponding application:willFinishLaunchingWithOptions: method) to complete your app’s initialization and make any final tweaks. This method is called after state restoration has occurred but before your app’s window and other UI have been presented. At some point after this method returns, the system calls another of your app delegate’s methods to move the app to the active (foreground) state or the background state.
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "didFinishLaunchingWithOptions")
        return true
    }
    
    /// This method is called to let your app know that it moved from the inactive to active state. This can occur because your app was launched by the user or the system. Apps can also return to the active state if the user chooses to ignore an interruption (such as an incoming phone call or SMS message) that sent the app temporarily to the inactive state.
    func applicationDidBecomeActive(application: UIApplication) {
        logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "applicationDidBecomeActive")
    }

    /// This method is called to let your app know that it is about to move from the active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the app and it begins the transition to the background state. An app in the inactive state continues to run but does not dispatch incoming events to responders.
    func applicationWillResignActive(application: UIApplication) {
        logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "applicationWillResignActive")
    }

    /// Use this method to release shared resources, invalidate timers, and store enough app state information to restore your app to its current state in case it is terminated later. You should also disable updates to your app’s user interface and avoid using some types of shared system resources (such as the user’s contacts database). It is also imperative that you avoid using OpenGL ES in the background.
    func applicationDidEnterBackground(application: UIApplication) {
        logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "applicationDidEnterBackground")
    }

    /// In iOS 4.0 and later, this method is called as part of the transition from the background to the active state. You can use this method to undo many of the changes you made to your app upon entering the background. The call to this method is invariably followed by a call to the applicationDidBecomeActive: method, which then moves the app from the inactive to the active state.
    func applicationWillEnterForeground(application: UIApplication) {
        logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "applicationWillEnterForeground")
    }

    /// This method lets your app know that it is about to be terminated and purged from memory entirely. You should use this method to perform any final clean-up tasks for your app, such as freeing shared resources, saving user data, and invalidating timers. Your implementation of this method has approximately five seconds to perform any tasks and return. If the method does not return before time expires, the system may kill the process altogether.
    func applicationWillTerminate(application: UIApplication) {
        logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "applicationWillTerminate")
        NSURLProtocol.unregisterClass(HttpInterceptorProtocol)
    }
    
    /// Tells the delegate when the interface orientation of the status bar is about to change
    func application(application: UIApplication, willChangeStatusBarOrientation newStatusBarOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "willChangeStatusBarOrientation")
    }
    
    /// Tells the delegate when the interface orientation of the status bar has changed.
    func application(application: UIApplication, didChangeStatusBarOrientation oldStatusBarOrientation: UIInterfaceOrientation) {
        logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "didChangeStatusBarOrientation")
    }
    
}

