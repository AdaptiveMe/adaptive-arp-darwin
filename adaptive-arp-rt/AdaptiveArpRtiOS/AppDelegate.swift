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
import AdaptiveArpApi

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?
    
    /// Init method of the AppDelegate
    override init() {
        super.init()
        
        // Register Logging delegate
        AppRegistryBridge.sharedInstance.getLoggingBridge().setDelegate(LoggingDelegate())
        
        // Register the application delegates
        AppRegistryBridge.sharedInstance.getPlatformContext().setDelegate(AppContextDelegate())
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().setDelegate(AppContextWebviewDelegate())
        
        // Register all the delegates
        AppRegistryBridge.sharedInstance.getAccelerationBridge().setDelegate(AccelerationDelegate())
        AppRegistryBridge.sharedInstance.getBrowserBridge().setDelegate(BrowserDelegate())
        AppRegistryBridge.sharedInstance.getCapabilitiesBridge().setDelegate(CapabilitiesDelegate())
        AppRegistryBridge.sharedInstance.getContactBridge().setDelegate(ContactDelegate())
        //AppRegistryBridge.sharedInstance.getDatabaseBridge().setDelegate(DatabaseDelegate())
        AppRegistryBridge.sharedInstance.getDeviceBridge().setDelegate(DeviceDelegate())
        AppRegistryBridge.sharedInstance.getDisplayBridge().setDelegate(DisplayDelegate())
        AppRegistryBridge.sharedInstance.getFileBridge().setDelegate(FileDelegate())
        AppRegistryBridge.sharedInstance.getFileSystemBridge().setDelegate(FileSystemDelegate())
        AppRegistryBridge.sharedInstance.getGeolocationBridge().setDelegate(GeolocationDelegate())
        AppRegistryBridge.sharedInstance.getGlobalizationBridge().setDelegate(GlobalizationDelegate())
        AppRegistryBridge.sharedInstance.getLifecycleBridge().setDelegate(LifecycleDelegate())
        AppRegistryBridge.sharedInstance.getMailBridge().setDelegate(MailDelegate())
        AppRegistryBridge.sharedInstance.getMessagingBridge().setDelegate(MessagingDelegate())
        AppRegistryBridge.sharedInstance.getNetworkReachabilityBridge().setDelegate(NetworkReachabilityDelegate())
        AppRegistryBridge.sharedInstance.getNetworkStatusBridge().setDelegate(NetworkStatusDelegate())
        AppRegistryBridge.sharedInstance.getOSBridge().setDelegate(OSDelegate())
        AppRegistryBridge.sharedInstance.getRuntimeBridge().setDelegate(RuntimeDelegate())
        AppRegistryBridge.sharedInstance.getSecurityBridge().setDelegate(SecurityDelegate())
        AppRegistryBridge.sharedInstance.getServiceBridge().setDelegate(ServiceDelegate())
        AppRegistryBridge.sharedInstance.getTelephonyBridge().setDelegate(TelephonyDelegate())
        AppRegistryBridge.sharedInstance.getVideoBridge().setDelegate(VideoDelegate())
    }
    
    /// Logger variable
    let logger : ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge()
    let loggerTag : String = "AppDelegate"
    
    /// Use this method (and the corresponding application:didFinishLaunchingWithOptions: method) to initialize your app and prepare it to run. This method is called after your app has been launched and its main storyboard or nib file has been loaded, but before your app’s state has been restored. At the time this method is called, your app is in the inactive state.
    func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "willFinishLaunchingWithOptions")
        
        // Register the HttpInterceptorprotocol
        NSURLProtocol.registerClass(HttpInterceptorProtocol)
        
        let lifecycle:Lifecycle = Lifecycle(state: LifecycleState.Starting, timestamp: Int64(NSDate().timeIntervalSince1970*1000))
        (AppRegistryBridge.sharedInstance.getLifecycleBridge().getDelegate()! as! LifecycleDelegate).changeListenersStatus(lifecycle)
        LifecycleDelegate.isBackgroundClassVariable = false
        
        return true
    }

    /// Use this method (and the corresponding application:willFinishLaunchingWithOptions: method) to complete your app’s initialization and make any final tweaks. This method is called after state restoration has occurred but before your app’s window and other UI have been presented. At some point after this method returns, the system calls another of your app delegate’s methods to move the app to the active (foreground) state or the background state.
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "didFinishLaunchingWithOptions")
        
        let lifecycle:Lifecycle = Lifecycle(state: LifecycleState.Started, timestamp: Int64(NSDate().timeIntervalSince1970*1000))
        (AppRegistryBridge.sharedInstance.getLifecycleBridge().getDelegate()! as! LifecycleDelegate).changeListenersStatus(lifecycle)
        LifecycleDelegate.isBackgroundClassVariable = false
        
        return true
    }
    
    /// This method is called to let your app know that it moved from the inactive to active state. This can occur because your app was launched by the user or the system. Apps can also return to the active state if the user chooses to ignore an interruption (such as an incoming phone call or SMS message) that sent the app temporarily to the inactive state.
    func applicationDidBecomeActive(application: UIApplication) {
        
        logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "applicationDidBecomeActive")
        
        let lifecycle:Lifecycle = Lifecycle(state: LifecycleState.Running, timestamp: Int64(NSDate().timeIntervalSince1970*1000))
        (AppRegistryBridge.sharedInstance.getLifecycleBridge().getDelegate()! as! LifecycleDelegate).changeListenersStatus(lifecycle)
        LifecycleDelegate.isBackgroundClassVariable = false
    }

    /// This method is called to let your app know that it is about to move from the active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the app and it begins the transition to the background state. An app in the inactive state continues to run but does not dispatch incoming events to responders.
    func applicationWillResignActive(application: UIApplication) {
        
        logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "applicationWillResignActive")
        
        let lifecycle:Lifecycle = Lifecycle(state: LifecycleState.Pausing, timestamp: Int64(NSDate().timeIntervalSince1970*1000))
        (AppRegistryBridge.sharedInstance.getLifecycleBridge().getDelegate()! as! LifecycleDelegate).changeListenersStatus(lifecycle)
        LifecycleDelegate.isBackgroundClassVariable = true
    }

    /// Use this method to release shared resources, invalidate timers, and store enough app state information to restore your app to its current state in case it is terminated later. You should also disable updates to your app’s user interface and avoid using some types of shared system resources (such as the user’s contacts database). It is also imperative that you avoid using OpenGL ES in the background.
    func applicationDidEnterBackground(application: UIApplication) {
        
        logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "applicationDidEnterBackground")
        
        let lifecycle:Lifecycle = Lifecycle(state: LifecycleState.PausedIdle, timestamp: Int64(NSDate().timeIntervalSince1970*1000))
        (AppRegistryBridge.sharedInstance.getLifecycleBridge().getDelegate()! as! LifecycleDelegate).changeListenersStatus(lifecycle)
        LifecycleDelegate.isBackgroundClassVariable = true
        
        // TODO: check if there is some listener of gps, network acces, etc... to check if the lifecycle
        // state is PausedIdle or PausedRun
    }

    /// In iOS 4.0 and later, this method is called as part of the transition from the background to the active state. You can use this method to undo many of the changes you made to your app upon entering the background. The call to this method is invariably followed by a call to the applicationDidBecomeActive: method, which then moves the app from the inactive to the active state.
    func applicationWillEnterForeground(application: UIApplication) {
        
        logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "applicationWillEnterForeground")
        
        let lifecycle:Lifecycle = Lifecycle(state: LifecycleState.Resuming, timestamp: Int64(NSDate().timeIntervalSince1970*1000))
        (AppRegistryBridge.sharedInstance.getLifecycleBridge().getDelegate()! as! LifecycleDelegate).changeListenersStatus(lifecycle)
        LifecycleDelegate.isBackgroundClassVariable = false
    }

    /// This method lets your app know that it is about to be terminated and purged from memory entirely. You should use this method to perform any final clean-up tasks for your app, such as freeing shared resources, saving user data, and invalidating timers. Your implementation of this method has approximately five seconds to perform any tasks and return. If the method does not return before time expires, the system may kill the process altogether.
    func applicationWillTerminate(application: UIApplication) {
        
        logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "applicationWillTerminate")
        
        let lifecycle:Lifecycle = Lifecycle(state: LifecycleState.Stopping, timestamp: Int64(NSDate().timeIntervalSince1970*1000))
        (AppRegistryBridge.sharedInstance.getLifecycleBridge().getDelegate()! as! LifecycleDelegate).changeListenersStatus(lifecycle)
        LifecycleDelegate.isBackgroundClassVariable = true
        
        NSURLProtocol.unregisterClass(HttpInterceptorProtocol)
    }
    
    /// Tells the delegate when the interface orientation of the status bar is about to change
    func application(application: UIApplication, willChangeStatusBarOrientation newStatusBarOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        
        logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "willChangeStatusBarOrientation")
        
        let displayBridge:IDisplay = AppRegistryBridge.sharedInstance.getDisplayBridge()
        
        let origin:ICapabilitiesOrientation = displayBridge.getOrientationCurrent()!;
        var destination:ICapabilitiesOrientation;
        
        switch newStatusBarOrientation {
            
        case UIInterfaceOrientation.Portrait:
            destination = ICapabilitiesOrientation.PortraitUp
            
        case UIInterfaceOrientation.PortraitUpsideDown:
            destination = ICapabilitiesOrientation.PortraitDown
            
        case UIInterfaceOrientation.LandscapeLeft:
            destination = ICapabilitiesOrientation.LandscapeLeft
            
        case UIInterfaceOrientation.LandscapeRight:
            destination = ICapabilitiesOrientation.LandscapeRight
            
        case UIInterfaceOrientation.Unknown:
            destination = ICapabilitiesOrientation.Unknown
            
        }
        
        ((displayBridge as! DisplayBridge).getDelegate() as! DisplayDelegate).orientationEvent(origin, destinationOrientation: destination, state: RotationEventState.WillStartRotation)
    }
    
    /// Tells the delegate when the interface orientation of the status bar has changed.
    func application(application: UIApplication, didChangeStatusBarOrientation oldStatusBarOrientation: UIInterfaceOrientation) {
        
        logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "didChangeStatusBarOrientation")
        
        let displayBridge:IDisplay = AppRegistryBridge.sharedInstance.getDisplayBridge()
        
        var origin:ICapabilitiesOrientation;
        let destination:ICapabilitiesOrientation = displayBridge.getOrientationCurrent()!
        
        switch oldStatusBarOrientation {
            
        case UIInterfaceOrientation.Portrait:
            origin = ICapabilitiesOrientation.PortraitUp
            
        case UIInterfaceOrientation.PortraitUpsideDown:
            origin = ICapabilitiesOrientation.PortraitDown
            
        case UIInterfaceOrientation.LandscapeLeft:
            origin = ICapabilitiesOrientation.LandscapeLeft
            
        case UIInterfaceOrientation.LandscapeRight:
            origin = ICapabilitiesOrientation.LandscapeRight
            
        case UIInterfaceOrientation.Unknown:
            origin = ICapabilitiesOrientation.Unknown
            
        }
        
        ((displayBridge as! DisplayBridge).getDelegate() as! DisplayDelegate).orientationEvent(origin, destinationOrientation: destination, state: RotationEventState.DidFinishRotation)
    }
    
    /// Tells the delegate when the app receives a memory warning from the system.
    func applicationDidReceiveMemoryWarning(application: UIApplication) {
        
        logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "applicationDidReceiveMemoryWarning")
        
        let lifecycle:Lifecycle = Lifecycle(state: LifecycleState.Stopping, timestamp: Int64(NSDate().timeIntervalSince1970*1000))
        (AppRegistryBridge.sharedInstance.getLifecycleBridge().getDelegate()! as! LifecycleDelegate).changeListenerWarningStatus(lifecycle, warning: ILifecycleListenerWarning.MemoryLow)
    }
    
}
