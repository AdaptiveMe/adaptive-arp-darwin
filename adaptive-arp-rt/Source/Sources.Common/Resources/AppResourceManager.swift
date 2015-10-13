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

import AdaptiveArpApi

private var resourceManagerInstancePool : AppResourceManager = AppResourceManager()

public class AppResourceManager {
    
    var realm : ResourceReader
    let logger:ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge()
    let logCategory = "AppResourceManager" 
    
    /// Singleton instance
    public class var sharedInstance : AppResourceManager {
        return resourceManagerInstancePool
    }
    
    init() {
        realm = ResourceReader()
        
        if let realmPath = NSBundle.mainBundle().pathForResource("App/apppack.realm", ofType: nil) {
            protectRealmFile(realmPath)
            realm.setPath(realmPath)
        } else {
            logger.log(ILoggingLogLevel.Error, category: logCategory, message: "Error reading App/apppack.realm")
        }
    }
    
    internal func retrieveResource(id : String, rootPath : String, secure : Bool) -> ResourceData? {
        
        var resourceId : String! = ""
        if secure {
            resourceId = "\(rootPath)\(id)".sha256()
        } else {
            resourceId = "\(rootPath)\(id)"
        }
        
        return realm.getResource(resourceId)
    }
    
    public func retrieveWebResource(id : String) -> ResourceData? {
        //logger.log(ILoggingLogLevel.Debug, category: logCategory, message: "retrieveWebResource('\(id)')")
        var resourceData : ResourceData? = retrieveResource(id, rootPath: "www", secure: true)
        if resourceData == nil {
            resourceData = retrieveResource(id, rootPath: "www", secure: false)
        }
        if resourceData == nil {
            logger.log(ILoggingLogLevel.Debug, category: logCategory, message: "retrieveWebResource('\(id)') not found.")
        } else {
            logger.log(ILoggingLogLevel.Debug, category: logCategory, message: "retrieveWebResource('\(id)') -> type: '\(resourceData!.raw_type)' length: \(resourceData!.raw_length) bytes.")
        }
        return resourceData
    }
    
    public func retrieveConfigResource(id : String) -> ResourceData? {
        logger.log(ILoggingLogLevel.Debug, category: logCategory, message: "retrieveConfigResource('\(id)')")
        var resourceData : ResourceData? = retrieveResource(id, rootPath: "config/", secure: true)
        if resourceData == nil {
            resourceData = retrieveResource(id, rootPath: "config/", secure: false)
        }
        if resourceData == nil {
            logger.log(ILoggingLogLevel.Debug, category: logCategory, message: "retrieveConfigResource('\(id)') not found.")
        } else {
            logger.log(ILoggingLogLevel.Debug, category: logCategory, message: "retrieveConfigResource('\(id)') -> type: '\(resourceData!.raw_type)' length: \(resourceData!.raw_length) bytes.")
        }
        return resourceData
    }
    
    internal func protectRealmFile(path : String) -> Bool {
        #if os(iOS)
            logger.log(ILoggingLogLevel.Debug, category: logCategory, message: "protectRealmFile start.")
            
            do {
                try NSFileManager.defaultManager().setAttributes([NSFileProtectionKey: NSFileProtectionComplete], ofItemAtPath: path)
                logger.log(ILoggingLogLevel.Debug, category: logCategory, message: "protectRealmFile success.")
                return true
            } catch {
                logger.log(ILoggingLogLevel.Debug, category: logCategory, message: "protectRealmFile failed.")
                return false
            }
            
            /*var success:Bool = try? NSFileManager.defaultManager().setAttributes([NSFileProtectionKey: NSFileProtectionComplete], ofItemAtPath: path)
            if !(success != nil) {
            logger.log(ILoggingLogLevel.Debug, category: logCategory, message: "protectRealmFile failed. Error: '\(error?.localizedDescription)'")
            } else {
            logger.log(ILoggingLogLevel.Debug, category: logCategory, message: "protectRealmFile success.")
            }
            return success*/
        #endif
        #if os(OSX)
            logger.log(ILoggingLogLevel.Debug, category: logCategory, message: "protectRealmFile not supported on this platform.")
            return false
        #endif
    }

}