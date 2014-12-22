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

private var resourceManagerInstancePool : [String:AppResourceManager] = [String:AppResourceManager]()

public class AppResourceManager {
    
    var realm : RLMRealm!
    let logger:ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge().getDelegate()!
    let logCategory = "AppResourceManager"
    
    /// Singleton instance
    public class var sharedInstance : AppResourceManager {
        var threadSafeInstance : AppResourceManager? = resourceManagerInstancePool[NSThread.currentThread().description]
        
        let logger:ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge().getDelegate()!
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
    
    internal func retrieveResource(id : String, rootPath : String, secure : Bool) -> ResourceData? {

        var resourceId : String! = ""
        if secure {
            resourceId = "\(rootPath)\(id)".sha256()
        } else {
            resourceId = "\(rootPath)\(id)"
        }
        
        var result = ResourceData.objectsInRealm(realm, "id = '\(resourceId)'")
        if (result.count == 1) {
            
            var resourceData : ResourceData! = result[0] as? ResourceData
            var resourceRecipe : NSString = NSString(string: "")
            var keyData : NSData? = nil
            var ivData : NSData? = nil
            
            if resourceData.cooked {
                resourceRecipe = resourceData.cooked_type
            }
            
            if secure {
                if resourceRecipe.hasPrefix("") {
                    logger.log(ILoggingLogLevel.ERROR, category: logCategory, message: "retrieveResource('\(rootPath)\(id)') -> Secure resource does not contain cooking recipe. Cowardly refusing to serve.")
                    return nil
                } else {
                    /// Data is encrypted using a combined hashed key and hashed salt.
                    keyData = "\(rootPath)\(id)".md5()!.dataUsingEncoding(NSUTF8StringEncoding)
                    ivData = resourceId.dataUsingEncoding(NSUTF8StringEncoding)
                    
                    var decryptedData : ResourceData! = ResourceData()
                    decryptedData.id = id;
                    
                    if resourceRecipe.hasPrefix("MS") {
                        let setup = (key: keyData!, iv: ivData!)
                        
                        // Decrypt data type
                        var typeData : NSData = NSData(base64EncodedString: resourceData.raw_type, options: nil)!.decrypt(Cipher.ChaCha20(setup))!
                        var typeString : NSString = NSString(data: typeData, encoding: NSUTF8StringEncoding)!
                        decryptedData.raw_type = typeString as String
                        
                        
                        // Encrypted & Compressed or only Encrypted?
                        if resourceRecipe.hasPrefix("MSCZ") {
                            
                            // Data is Encrypted and Zipped
                            logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "retrieveResource('\(rootPath)\(id)') -> Decrypting \(resourceData.cooked_length) bytes.")
                            var payloadDecrypted : NSData = resourceData.data.decrypt(Cipher.ChaCha20(setup))!
                            
                            logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "retrieveResource('\(rootPath)\(id)') -> Inflating \(resourceData.cooked_length) to \(resourceData.raw_length) bytes.")
                            decryptedData.data = payloadDecrypted.gzipInflate()
                            
                        } else if resourceRecipe.hasPrefix("MSC") {
                            
                            // Data is only Encrypted
                            logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "retrieveResource('\(rootPath)\(id)') -> Decrypting \(resourceData.cooked_length) bytes.")
                            decryptedData.data = resourceData.data.decrypt(Cipher.ChaCha20(setup))!
                            
                        } else {
                            
                            logger.log(ILoggingLogLevel.WARN, category: logCategory, message: "retrieveResource('\(rootPath)\(id)') -> Secure resource contains unsupported cooking recipe. Returning raw data.")
                            decryptedData.data = resourceData.data
                            
                        }
                        
                        decryptedData.raw_length = resourceData.raw_length
                        decryptedData.cooked = false
                        decryptedData.cooked_length = resourceData.raw_length
                        decryptedData.cooked_type = ""
                        
                        return decryptedData
                    } else {
                        logger.log(ILoggingLogLevel.ERROR, category: logCategory, message: "retrieveResource('\(rootPath)\(id)') -> Secure resource contains unknown cooking recipe. Nonchalantly refusing to serve.")
                        return nil
                    }
                }
            } else {
                if resourceRecipe.hasPrefix("Z") {
                
                    logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "retrieveResource('\(rootPath)\(id)') -> Inflating \(resourceData.cooked_length) to \(resourceData.raw_length) bytes.")
                    
                    var clonedData : ResourceData = ResourceData()
                    clonedData.id = resourceData.id
                    clonedData.raw_type = resourceData.raw_type
                    clonedData.raw_length = resourceData.raw_length
                    clonedData.cooked = resourceData.cooked
                    clonedData.cooked_length = resourceData.cooked_length
                    clonedData.cooked_type = resourceData.cooked_type
                    clonedData.data = resourceData.data.gzipInflate()
                    resourceData = clonedData
                }
                return resourceData

            }
        } else {
            return nil
        }
    }
    
    public func retrieveWebResource(id : String) -> ResourceData? {
        logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "retrieveWebResource('\(id)')")
        var resourceData : ResourceData? = retrieveResource(id, rootPath: "www", secure: true)
        if resourceData == nil {
            resourceData = retrieveResource(id, rootPath: "www", secure: false)
        }
        if resourceData == nil {
            logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "retrieveWebResource('\(id)') not found.")
        } else {
            logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "retrieveWebResource('\(id)') -> type: '\(resourceData!.raw_type)' length: \(resourceData!.raw_length) bytes.")
        }
        return resourceData
    }
    
    public func retrieveConfigResource(id : String) -> ResourceData? {
        logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "retrieveConfigResource('\(id)')")
        var resourceData : ResourceData? = retrieveResource(id, rootPath: "config/", secure: true)
        if resourceData == nil {
            resourceData = retrieveResource(id, rootPath: "config/", secure: false)
        }
        if resourceData == nil {
            logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "retrieveConfigResource('\(id)') not found.")
        } else {
            logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "retrieveConfigResource('\(id)') -> type: '\(resourceData!.raw_type)' length: \(resourceData!.raw_length) bytes.")
        }
        return resourceData
    }
    
    internal func protectRealmFile(path : String) -> Bool {
        #if os(iOS)
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
        #elseif os(OSX)
        logger.log(ILoggingLogLevel.DEBUG, category: logCategory, message: "protectRealmFile not supported on this platform.")
        return false
        #endif
    }

}