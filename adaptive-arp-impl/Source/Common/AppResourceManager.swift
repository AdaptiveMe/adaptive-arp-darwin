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

#if os(iOS)
    import Realm
#elseif os(OSX)
    import Realm
#endif
import AdaptiveArpApi

private var resourceManagerInstancePool : [String:AppResourceManager] = [String:AppResourceManager]()

public class AppResourceManager {
    
    var realm : RLMRealm!
    let logger:ILogging = LoggingImpl()
    let logCategory = "AppResourceManager"
    
    /// Singleton instance
    public class var sharedInstance : AppResourceManager {
        var threadSafeInstance : AppResourceManager? = resourceManagerInstancePool[NSThread.currentThread().description]
        
        let logger:ILogging = LoggingImpl()
        let logCategory = "AppResourceManager"
        
        if threadSafeInstance == nil {
            var newInstance = AppResourceManager()
            resourceManagerInstancePool.updateValue(newInstance, forKey: NSThread.currentThread().description)
            logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "Adding instance to pool with id: \(NSThread.currentThread().description)")
            logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "Pool size: \(resourceManagerInstancePool.count)")
            return newInstance
        } else {
            return threadSafeInstance!
        }
    }
    
    init() {
        logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "init start.")
        var realmPath = NSBundle.mainBundle().pathForResource("App/apppack.realm", ofType: nil)
        protectRealmFile(realmPath!)
        realm = RLMRealm(path: realmPath, readOnly: true, error: nil)
        
        logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "init success.")
    }
    
    public func retrieveWebResource(id : String) -> ResourceData? {
        logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "retrieveWebResource('\(id)')")

        var result = ResourceData.objectsInRealm(realm, "id = 'www\(id)'")
        if (result.count == 1) {
            var resourceData = result[0] as? ResourceData
            logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "retrieveWebResource('\(id)') -> type: '\(resourceData!.raw_type)' length: \(resourceData!.raw_length) bytes.")
            return resourceData
        } else {
            logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "retrieveWebResource('\(id)') not found.")
            return nil
        }
    }
    
    public func retrieveConfigResource(id : String) -> ResourceData? {
        logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "retrieveConfigResource('\(id)')")
        
        var result = ResourceData.objectsInRealm(realm, "id = 'config/\(id)'")
        if (result.count == 1) {
            var resourceData = result[0] as? ResourceData
            logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "retrieveConfigResource('\(id)') -> type: '\(resourceData!.raw_type)' length: \(resourceData!.raw_length) bytes.")
            return resourceData
        } else {
            logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "retrieveConfigResource('\(id)') not found.")
            return nil
        }
    }

    private func protectRealmFile(path : String) -> Bool {
        logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "protectRealmFile start.")
        var error: NSError?
        let success = NSFileManager.defaultManager().setAttributes([NSFileProtectionKey: NSFileProtectionComplete],
            ofItemAtPath: path, error: &error)
        if !success {
            logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "protectRealmFile failed. Error: '\(error?.localizedDescription)'")
        } else {
            logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "protectRealmFile success.")
        }
        return success
    }

}