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

import Foundation
import Security

/**
*  :see: https://developer.apple.com/library/ios/documentation/Security/Reference/keychainservices/Reference/reference.html for posible return values
*/
public class SecurityImpl : ISecurity {
    
    /// Logging variable
    let logger : ILogging = LoggingImpl()
    
    /// List of common hack apps and files (20140917)
    let listOfCommonHacks: [String] = [
        "/Applications/Cydia.app",
        "/Applications/blackra1n.app",
        "/Applications/FakeCarrier.app",
        "/Applications/Icy.app",
        "/Applications/IntelliScreen.app",
        "/Applications/MxTube.app",
        "/Applications/RockApp.app",
        "/Applications/SBSettings.app",
        "/Applications/WinterBoard.app",
        "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
        "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
        "/private/var/lib/apt",
        "/private/var/lib/cydia",
        "/private/var/mobile/Library/SBSettings/Themes",
        "/private/var/stash",
        "/private/var/tmp/cydia.log",
        "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
        "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
        "/usr/bin/sshd",
        "/usr/libexec/sftp-server",
        "/usr/sbin/sshd"
    ]
    
    /// Foundation expected path
    let foundationPath: String = "/System/Library/Frameworks/Foundation.framework/Foundation"
    
    /// Security key chain default values
    let kSecClassValue = kSecClass as NSString
    let kSecAttrAccountValue = kSecAttrAccount as NSString
    let kSecValueDataValue = kSecValueData as NSString
    let kSecClassGenericPasswordValue = kSecClassGenericPassword as NSString
    let kSecAttrServiceValue = kSecAttrService as NSString
    let kSecMatchLimitValue = kSecMatchLimit as NSString
    let kSecReturnDataValue = kSecReturnData as NSString
    let kSecMatchLimitOneValue = kSecMatchLimitOne as NSString
    
    let securityResponsesErrorCodes = [
        errSecSuccess : 0, /* No error. */
        errSecUnimplemented : -4, /* Function or operation not implemented. */
        errSecParam : -50, /* One or more parameters passed to a function where not valid. */
        errSecAllocate : -108, /* Failed to allocate memory. */
        errSecNotAvailable : -25291, /* No keychain is available. You may need to restart your computer. */
        errSecDuplicateItem : -25299, /* The specified item already exists in the keychain. */
        errSecItemNotFound : -25300, /* The specified item could not be found in the keychain. */
        errSecInteractionNotAllowed : -25308, /* User interaction is not allowed. */
        errSecDecode : -26275, /* Unable to decode the provided data. */
        errSecAuthFailed : -25293, /* The user name or passphrase you entered is not correct. */
    ]
    
    /**
    Class constructor
    */
    init() {
        
    }
    
    /**
    Returns if the device has been modified in anyhow
    
    :returns: true if the device has been modified; false otherwise
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func isDeviceModified() -> Bool {
        
        // In order to check the jailbreak we open certain files and if the content is readable, the device is jailbreaked
        for file:String in listOfCommonHacks {
            
            let data: NSData? = NSData(contentsOfFile: file)
            if data != nil {
                logger.log(ILoggingLogLevel.ERROR, category: "SecurityImpl", message: "The device is rooted. Has the file: \(file)")
                return true
            }
        }
        
        // If the Foundation path is not on the expected path, the device is jailbraked
        let data: NSData? = NSData(contentsOfFile: foundationPath)
        if data == nil {
            logger.log(ILoggingLogLevel.ERROR, category: "SecurityImpl", message: "The device is rooted. Because the Foundation Library path is not the expected")
            return true
        }
        
        logger.log(ILoggingLogLevel.DEBUG, category: "SecurityImpl", message: "The device is not rooted.")
        
        return false
    }
    
    /**
    Deletes from the device internal storage the entry/entries containing the specified key names.
    
    :param: keys             Array with the key names to delete.
    :param: publicAccessName The name of the shared internal storage object (if needed).
    :param: callback         callback to be executed upon function result.
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func deleteSecureKeyValuePairs(keys : [String], publicAccessName : String, callback : ISecureKVResultCallback) {
        
        var response: Int
        var successKeypairs: [SecureKeyPair] = [SecureKeyPair]()
        var warningKeypairs: [SecureKeyPair] = [SecureKeyPair]()
        
        // Iterate over all keyvalues provided
        
        for key:String in keys {
            
            // save the key
            response = self.delete(publicAccessName, key: key)
            
            var pair: SecureKeyPair = SecureKeyPair()
            pair.setKey(key)
            
            var tuple: (pair: SecureKeyPair, success: Int) = self.handleSecurityResponse(response, pair: pair, callback: callback)
            
            if tuple.success == 0 {
                successKeypairs.append(tuple.pair)
            } else if tuple.success == 1 {
                warningKeypairs.append(tuple.pair)
            }
            
        }
        
        // Return the success saved keypairs
        if successKeypairs.count > 0 {
            callback.onResult(successKeypairs)
        }
        
        // Return the overrided keypairs
        if warningKeypairs.count > 0 {
            callback.onWarning(warningKeypairs, warning: ISecureKVResultCallbackWarning.EntryOverride)
        }
    }
    
    /**
    Retrieves from the device internal storage the entry/entries containing the specified key names.
    
    :param: keys             Array with the key names to retrieve.
    :param: publicAccessName The name of the shared internal storage object (if needed).
    :param: callback         callback to be executed upon function result.
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func getSecureKeyValuePairs(keys : [String], publicAccessName : String, callback : ISecureKVResultCallback) {
        
        var response: (data: NSString?, status: Int)
        var successKeypairs: [SecureKeyPair] = [SecureKeyPair]()
        var warningKeypairs: [SecureKeyPair] = [SecureKeyPair]()
        
        // Iterate over all keyvalues provided
        
        for key:String in keys {
            
            // save the key
            response = self.load(publicAccessName, key: key)
            
            var pair: SecureKeyPair = SecureKeyPair()
            pair.setKey(key)
            pair.setValue(response.data!)
            
            var tuple: (pair: SecureKeyPair, success: Int) = self.handleSecurityResponse(response.status, pair: pair, callback: callback)
            
            if tuple.success == 0 {
                successKeypairs.append(tuple.pair)
            } else if tuple.success == 1 {
                warningKeypairs.append(tuple.pair)
            }
            
        }
        
        // Return the success saved keypairs
        if successKeypairs.count > 0 {
            callback.onResult(successKeypairs)
        }
        
        // Return the overrided keypairs
        if warningKeypairs.count > 0 {
            callback.onWarning(warningKeypairs, warning: ISecureKVResultCallbackWarning.EntryOverride)
        }
    }
    
    /**
    Stores in the device internal storage the specified item/s.
    
    :param: keyValues        Array containing the items to store on the device internal memory.
    :param: publicAccessName The name of the shared internal storage object (if needed).
    :param: callback         callback to be executed upon function result.
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func setSecureKeyValuePairs(keyValues : [SecureKeyPair], publicAccessName : String, callback : ISecureKVResultCallback) {
        
        var response: Int
        var successKeypairs: [SecureKeyPair] = [SecureKeyPair]()
        var warningKeypairs: [SecureKeyPair] = [SecureKeyPair]()
        
        // Iterate over all keyvalues provided
        
        for pair:SecureKeyPair in keyValues {
            
            // save the key
            response = self.save(publicAccessName, key: pair.getKey(), data: pair.getValue(), callback: callback)
            
            var tuple: (pair: SecureKeyPair, success: Int) = self.handleSecurityResponse(response, pair: pair, callback: callback)
            
            if tuple.success == 0 {
                successKeypairs.append(tuple.pair)
            } else if tuple.success == 1 {
                warningKeypairs.append(tuple.pair)
            }
            
        }
        
        // Return the success saved keypairs
        if successKeypairs.count > 0 {
            callback.onResult(successKeypairs)
        }
        
        // Return the overrided keypairs
        if warningKeypairs.count > 0 {
            callback.onWarning(warningKeypairs, warning: ISecureKVResultCallbackWarning.EntryOverride)
        }
        
    }
    
    /**
    This method handles the response of one interaccion with the security keychain
    
    :param: response response of the SKC
    :param: pair     SecureKeyPair loaded, inserted or deleted
    :param: callback callback for the user response
    
    :returns: 
        :param: pair    response pair
        :param: success result (0:succes, 1: warning, otherwise: error)
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func handleSecurityResponse(response: Int, pair: SecureKeyPair, callback: ISecureKVResultCallback) -> (pair: SecureKeyPair, success: Int) {
        
        var savedPair: SecureKeyPair = SecureKeyPair()
        
        switch(response){
        case securityResponsesErrorCodes[errSecSuccess]!:
            logger.log(ILoggingLogLevel.DEBUG, category: "SecurityImpl", message: "The key: \(pair.getKey()) with value: \(pair.getValue()) was saved.")
            savedPair.setKey(pair.getKey())
            return (savedPair, 0)
            
        case securityResponsesErrorCodes[errSecUnimplemented]!:
            logger.log(ILoggingLogLevel.ERROR, category: "SecurityImpl", message: "Function or operation not implemented.")
            callback.onError(ISecureKVResultCallbackError.NoPermission)
            return (savedPair, -1)
            
        case securityResponsesErrorCodes[errSecParam]!:
            logger.log(ILoggingLogLevel.ERROR, category: "SecurityImpl", message: "One or more parameters passed to the function were not valid.")
            callback.onError(ISecureKVResultCallbackError.NoPermission)
            return (savedPair, -1)
            
        case securityResponsesErrorCodes[errSecAllocate]!:
            logger.log(ILoggingLogLevel.ERROR, category: "SecurityImpl", message: "Failed to allocate memory.")
            callback.onError(ISecureKVResultCallbackError.NoPermission)
            return (savedPair, -1)
            
        case securityResponsesErrorCodes[errSecNotAvailable]!:
            logger.log(ILoggingLogLevel.ERROR, category: "SecurityImpl", message: "No trust results are available.")
            callback.onError(ISecureKVResultCallbackError.NoPermission)
            return (savedPair, -1)
            
        case securityResponsesErrorCodes[errSecAuthFailed]!:
            logger.log(ILoggingLogLevel.ERROR, category: "SecurityImpl", message: "Authorization/Authentication failed.")
            callback.onError(ISecureKVResultCallbackError.NoPermission)
            return (savedPair, -1)
            
        case securityResponsesErrorCodes[errSecDuplicateItem]!:
            logger.log(ILoggingLogLevel.WARN, category: "SecurityImpl", message: "The item already exists.")
            savedPair.setKey(pair.getKey())
            return (savedPair, 1)
            
        case securityResponsesErrorCodes[errSecItemNotFound]!:
            logger.log(ILoggingLogLevel.ERROR, category: "SecurityImpl", message: "The item cannot be found.")
            callback.onError(ISecureKVResultCallbackError.NoMatchesFound)
            return (savedPair, -1)
            
        case securityResponsesErrorCodes[errSecInteractionNotAllowed]!:
            logger.log(ILoggingLogLevel.ERROR, category: "SecurityImpl", message: "Interaction with the Security Server is not allowed.")
            callback.onError(ISecureKVResultCallbackError.NoPermission)
            return (savedPair, -1)
            
        case securityResponsesErrorCodes[errSecDecode]!:
            logger.log(ILoggingLogLevel.ERROR, category: "SecurityImpl", message: "Unable to decode the provided data.")
            callback.onError(ISecureKVResultCallbackError.NoPermission)
            return (savedPair, -1)
        default:
            logger.log(ILoggingLogLevel.ERROR, category: "SecurityImpl", message: "Not supported return value: \(response)")
            callback.onError(ISecureKVResultCallbackError.NoPermission)
            return (savedPair, -1)
        }
    }
    
    /**
    Method that saves a key-value pair in the keychain for the specified service
    
    :param: service Service in order to save the pair
    :param: key     key value
    :param: data    data value
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func save(service: NSString, key: String, data: NSString, callback: ISecureKVResultCallback) -> Int {
        
        var exists:Bool = false
        
        // If the data parameter is empty return errSecParam
        if data == "" {
            return securityResponsesErrorCodes[errSecParam]!
        }
        
        var dataFromString: NSData = data.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
        
        // Instantiate a new default keychain query
        var keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, key, dataFromString], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecValueDataValue])
        
        
        // Check if the entry exists, if exists, delete and the insert, but fire a warning callback
        if self.load(service, key: key).data != "" {
            
            SecItemDelete(keychainQuery as CFDictionaryRef)
            exists = true
        }
        
        // Add the new keychain item
        var status: OSStatus = SecItemAdd(keychainQuery as CFDictionaryRef, nil)
        
        if exists {
            return securityResponsesErrorCodes[errSecDuplicateItem]!
        } else {
            return Int(status)
        }
    }
    
    /**
    Method that retrieves a value from a key and a specified service from the keychain
    
    :param: service Service to check for the key
    :param: key     key value
    
    :returns: Value of the key pair
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func load(service: NSString, key: String) -> (data: NSString?, status: Int) {
        
        // Instantiate a new default keychain query
        // Tell the query to return a result
        // Limit our results to one item
        var keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, key, kCFBooleanTrue, kSecMatchLimitOneValue], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecReturnDataValue, kSecMatchLimitValue])
        
        var dataTypeRef :Unmanaged<AnyObject>?
        
        // Search for the keychain items
        let status: Int = Int(SecItemCopyMatching(keychainQuery, &dataTypeRef))
        
        if status != 0 {
            return (data: "", status: status)
        }
        
        let opaque = dataTypeRef?.toOpaque()
        
        var contentsOfKeychain: NSString?
        
        if let op = opaque? {
            let retrievedData = Unmanaged<NSData>.fromOpaque(op).takeUnretainedValue()
            
            // Convert the data retrieved from the keychain into a string
            contentsOfKeychain = NSString(data: retrievedData, encoding: NSUTF8StringEncoding)
        } else {
            return (data: "", status: status)
        }
        
        return (data: contentsOfKeychain, status: status)
    }
    
    /**
    MEthod that delete a entry from the keychain
    
    :param: service Service to check for the key
    :param: key     key value
    
    :returns: Result of the operation
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func delete(service: NSString, key: String) -> Int {
        
        // Instantiate a new default keychain query
        var keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, key], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecValueDataValue])
        
        var status: OSStatus = SecItemDelete(keychainQuery as CFDictionaryRef)
        
        return Int(status)
    }
}
