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

/// This class acts as the application registry that manages (initialize, serve, etc...) all the implementations of the ARP system. The implementations based on system and application, are mandatory, and has to be enabled at the application start
public class AppRegistryImpl : NSObject, IAppRegistry {
    
    /// Singleton instance
    public class var sharedInstance : AppRegistryImpl {
        struct Static {
            static let instance : AppRegistryImpl = AppRegistryImpl()
        }
        return Static.instance
    }
    
    // MARK: the service api implementations must have the name of the interface without the initial "I" in came case in order to compose the getter
    
    /// MADATORY Implementations (Application and System)
    
    // Context
    var context:IAppContext!
    var contextWeb:IAppContextWebview!
    
    // Application
    var analytics:IAnalytics!
    var globalization:IGlobalization!
    var lifecycle:ILifecycle!
    var management:IManagement!
    var printing:IPrinting!
    var settings:ISettings!
    var update:IUpdate!
    
    // System
    var capabilities:ICapabilities!
    var device:IDevice!
    var display:IDisplay!
    var OS:IOS!
    var runtime:IRuntime!
    
    /// OPTIONAL Implementations
    var database:IDatabase?
    var file:IFile?
    var fileSystem:IFileSystem?
    var geolocation:IGeolocation?
    var logging:ILogging?
    var networkReachability:INetworkReachability?
    var security:ISecurity?
    var service:IService?
    var session:ISession?
    
    /// Cosntructor
    override init() {
        
        // Context
        self.context = AppContextImpl()
        self.contextWeb = AppContextWebviewImpl()
        
        // Application
        self.analytics = AnalyticsImpl()
        self.globalization = GlobalizationImpl()
        self.lifecycle = LifecycleImpl()
        self.management = ManagementImpl()
        self.printing = PrintingImpl()
        self.settings = SettingsImpl()
        self.update = UpdateImpl()
        
        // System
        self.capabilities = CapabilitiesImpl()
        self.device = DeviceImpl()
        self.display = DisplayImpl()
        self.OS = OSImpl()
        self.runtime = RuntimeImpl()        
    }
    
    /// Mandatory Getters (Context)
    
    public func getPlatformContext() -> IAppContext? {
        return self.context
    }
    
    public func getPlatformContextWeb() -> IAppContextWebview? {
        return self.contextWeb
    }
    
    /// Mandatory Getters (Application)
    
    public func getApplicationAnalytics() -> IAnalytics? {
        return self.analytics
    }
    
    public func getApplicationGlobalization() -> IGlobalization? {
        return self.globalization
    }
    
    public func getApplicationLifecycle() -> ILifecycle? {
        return self.lifecycle
    }
    
    public func getApplicationManagement() -> IManagement? {
        return self.management
    }
    
    public func getApplicationPrinting() -> IPrinting? {
        return self.printing
    }
    
    public func getApplicationSettings() -> ISettings? {
        return self.settings
    }
    
    public func getApplicationUpdate() -> IUpdate? {
        return self.update
    }
    
    /// Mandatory Getters (System)
    
    public func getSystemCapabilities() -> ICapabilities? {
        return self.capabilities
    }
    
    public func getSystemDevice() -> IDevice? {
        return self.device
    }
    
    public func getSystemDisplay() -> IDisplay? {
        return self.display
    }
    
    public func getSystemOS() -> IOS? {
        return self.OS
    }
    
    public func getSystemRuntime() -> IRuntime? {
        return self.runtime
    }
    
    
    /// Optional Getters and Setters
    
    public func getDataDatabase() -> IDatabase! {
        
        if let instance = self.database {
            return instance
        } else {
            self.database = DatabaseImpl()
            return self.database!
        }
    }
    
    public func getDataFile() -> IFile! {
        
        if let instance = self.file {
            return instance
        } else {
            self.file = FileImpl()
            return self.file!
        }
    }
    
    public func getDataFileSystem() -> IFileSystem! {
        
        if let instance = self.fileSystem {
            return instance
        } else {
            self.fileSystem = FileSystemImpl()
            return self.fileSystem!
        }
    }
    
    public func getSensorGeolocation() -> IGeolocation! {
        
        if let instance = self.geolocation {
            return instance
        } else {
            self.geolocation = GeolocationImpl()
            return self.geolocation!
        }
    }
    
    public func getUtilLogging() -> ILogging! {
        
        if let instance = self.logging {
            return instance
        } else {
            self.logging = LoggingImpl()
            return self.logging!
        }
    }
    
    public func getCommunicationNetworkReachability() -> INetworkReachability! {
        
        if let instance = self.networkReachability {
            return instance
        } else {
            self.networkReachability = NetworkReachabilityImpl()
            return self.networkReachability!
        }
    }
    
    public func getSecuritySecurity() -> ISecurity! {
        
        if let instance = self.security {
            return instance
        } else {
            self.security = SecurityImpl()
            return self.security!
        }
    }
    
    public func getCommunicationService() -> IService! {
        
        if let instance = self.service {
            return instance
        } else {
            self.service = ServiceImpl()
            return self.service!
        }
    }
    
    public func getCommunicationSession() -> ISession! {
        
        if let instance = self.session {
            return instance
        } else {
            self.session = SessionImpl()
            return self.session!
        }
    }
}