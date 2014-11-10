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
import AdaptiveArpApi


public class AppRegistryImpl : NSObject, IAppRegistry {
    
    /*
        Extremely PORK singleton declaration... imho
    */
    class var sharedInstance : IAppRegistry {
        struct Static {
            static let instance : IAppRegistry = AppRegistryImpl()
        }
        return Static.instance
    }
    
    /*
        Optional Implementations
    */
    var analitics : IAnalytics?
    var management : IManagement?
    var printing : IPrinting?
    var settings : ISettings?
    var update : IUpdate?
    
    /*
        Mandatory Implementations
    */
    var globalization : IGlobalization
    var lifecycle : ILifecycle
    var context : IAppContext
    var contextWeb : IAppContextWebview
    var resourceHandler : IAppResourceHandler
    var capabilities : ICapabilities
    var device : IDevice
    var display : IDisplay
    var os : IOS
    var runtime : IRuntime
    
    override init() {
        
        self.globalization = GlobalizationImpl()
        self.lifecycle = LifecycleImpl()
        self.context = AppContextImpl()
        self.contextWeb = AppContextWebviewImpl()
        self.resourceHandler = AppResourceHandlerImpl()
        self.capabilities = CapabilitiesImpl()
        self.device = DeviceImpl()
        self.display = DisplayImpl()
        self.os = OSImpl()
        self.runtime = RuntimeImpl()
    }
    
    public func getApplicationAnalytics() -> IAnalytics? {
        return analitics!
    }
    
    func setApplicationAnalytics(analitics : IAnalytics) {
        self.analitics = analitics
    }
    
    public func getApplicationGlobalization() -> IGlobalization? {
        return globalization
    }
    
    public func getApplicationLifecycle() -> ILifecycle? {
        return lifecycle
    }
    
    public func getApplicationManagement() -> IManagement? {
        return management!
    }
    
    func setApplicationManagement(management : IManagement) {
        self.management = management
    }
    
    public func getApplicationPrinting() -> IPrinting? {
        return printing!
    }
    
    func setApplicationPrinting(printing : IPrinting) {
        self.printing = printing
    }
    
    public func getApplicationSettings() -> ISettings? {
        return settings!
    }
    
    func setApplicationSettings(settings : ISettings) {
        self.settings = settings
    }
    
    public func getApplicationUpdate() -> IUpdate? {
        return update!
    }
    
    func setApplicationUpdate(update : IUpdate) {
        self.update = update
    }
    
    public func getPlatformContext() -> IAppContext? {
        return context
    }
    
    public func getPlatformContextWeb() -> IAppContextWebview? {
        return contextWeb
    }
    
    public func getPlatformResourceHandler() -> IAppResourceHandler? {
        return resourceHandler
    }
    
    public func getSystemCapabilities() -> ICapabilities? {
        return capabilities
    }
    
    public func getSystemDevice() -> IDevice? {
        return device
    }
    
    public func getSystemDisplay() -> IDisplay? {
        return display
    }
    
    public func getSystemOS() -> IOS? {
        return os
    }
    
    public func getSystemRuntime() -> IRuntime? {
        return runtime
    }
}