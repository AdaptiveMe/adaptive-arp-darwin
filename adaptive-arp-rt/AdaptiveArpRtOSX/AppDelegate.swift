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

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
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
        AppRegistryBridge.sharedInstance.getDatabaseBridge().setDelegate(DatabaseDelegate())
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
    
    
    /**
    Sent by the default notification center immediately before the application object is initialized.
    
    :param: notification A notification named NSApplicationWillFinishLaunchingNotification. Calling the object method of this notification returns the NSApplication object itself.
    */
    func applicationWillFinishLaunching(notification: NSNotification) {
        
        logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "applicationWillFinishLaunching")
        
        // Register the HttpInterceptorprotocol
        // fnva: in OSX the ViewController Method is launched before this method at application starts
        // NSURLProtocol.registerClass(HttpInterceptorProtocol)
        
        var lifecycle:Lifecycle = Lifecycle(state: LifecycleState.Starting)
        (AppRegistryBridge.sharedInstance.getLifecycleBridge().getDelegate()! as LifecycleDelegate).changeListenersStatus(lifecycle)
        LifecycleDelegate.isBackgroundClassVariable = false
    }
    
    /**
    Sent by the default notification center after the application has been launched and initialized but before it has received its first event.
    
    :param: aNotification A notification named NSApplicationDidFinishLaunchingNotification. Calling the object method of this notification returns the NSApplication object itself.
    */
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "applicationDidFinishLaunching")
        
        var lifecycle:Lifecycle = Lifecycle(state: LifecycleState.Started)
        (AppRegistryBridge.sharedInstance.getLifecycleBridge().getDelegate()! as LifecycleDelegate).changeListenersStatus(lifecycle)
        LifecycleDelegate.isBackgroundClassVariable = false
    }
    
    /**
    Sent to the delegate before the specified application presents an error message to the user.
    
    :param: application The application object associated with the delegate.
    :param: error       The error object that is used to construct the error message. Your implementation of this method can return a new NSError object or the same one in this parameter.
    
    :returns: The error object to display.
    */
    func application(application: NSApplication, willPresentError error: NSError) -> NSError {
        
        logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "error: \(error.debugDescription)")
        return error
    }
    
    /**
    Sent to notify the delegate that the application is about to terminate.
    
    :param: sender The application object that is about to be terminated.
    
    :returns: One of the values defined in NSApplicationTerminateReply constants indicating whether the application should terminate. For compatibility reasons, a return value of false is equivalent to NSTerminateCancel, and a return value of true is equivalent to NSTerminateNow.
    */
    func applicationShouldTerminate(sender: NSApplication) -> NSApplicationTerminateReply {
        
        logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "applicationShouldTerminate")
        return NSApplicationTerminateReply.TerminateNow
    }
    
    /**
    Invoked when the user closes the last window the application has open.
    
    :param: sender The application object whose last window was closed.
    
    :returns: false if the application should not be terminated when its last window is closed; otherwise, true to terminate the application.
    */
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        
        logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "applicationShouldTerminateAfterLastWindowClosed")
        return true
    }
    
    /**
    Sent by the default notification center immediately before the application terminates.
    
    :param: aNotification A notification named NSApplicationWillTerminateNotification. Calling the object method of this notification returns the NSApplication object itself.
    */
    func applicationWillTerminate(aNotification: NSNotification) {
        
        logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "applicationWillTerminate")
        
        var lifecycle:Lifecycle = Lifecycle(state: LifecycleState.Stopping)
        (AppRegistryBridge.sharedInstance.getLifecycleBridge().getDelegate()! as LifecycleDelegate).changeListenersStatus(lifecycle)
        LifecycleDelegate.isBackgroundClassVariable = true
        
        NSURLProtocol.unregisterClass(HttpInterceptorProtocol)
    }

}

