/**
--| ADAPTIVE RUNTIME PLATFORM |----------------------------------------------------------------------------------------

(C) Copyright 2013-2015 Carlos Lozano Diez t/a Adaptive.me <http://adaptive.me>.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the
License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0 . Unless required by appli-
-cable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,  WITHOUT
WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the  License  for the specific language governing
permissions and limitations under the License.

Original author:

    * Carlos Lozano Diez
            <http://github.com/carloslozano>
            <http://twitter.com/adaptivecoder>
            <mailto:carlos@adaptive.me>

Contributors:

    * Ferran Vila Conesa
             <http://github.com/fnva>
             <http://twitter.com/ferran_vila>
             <mailto:ferran.vila.conesa@gmail.com>

    * See source code files for contributors.

Release:

    * @version v2.0.2

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation
import AdaptiveArpApi
import KeychainSwift

/**
   Interface for Managing the Security operations
   Auto-generated implementation of ISecurity specification.
*/
public class SecurityDelegate : BaseSecurityDelegate, ISecurity {
    
    /// Logger variable
    let logger : ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge()
    let loggerTag : String = "SecurityDelegate"
    
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
    //let foundationPath: String = "/System/Library/Frameworks/Foundation.framework/Foundation"
    
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
       Default Constructor.
    */
    public override init() {
        super.init()
    }
    
    /**
    Returns if the device has been modified in anyhow
    
    @return true if the device has been modified; false otherwise
    @since ARP1.0
    */
    public func isDeviceModified() -> Bool? {
        
        // In order to check the jailbreak we open certain files and if the content is readable, the device is jailbreaked
        for file:String in listOfCommonHacks {
            
            let data: NSData? = NSData(contentsOfFile: file)
            if data != nil {
                logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The device is rooted. Has the file: \(file)")
                return true
            }
        }
        
        // If the Foundation path is not on the expected path, the device is jailbraked
        /*let data: NSData? = NSData(contentsOfFile: foundationPath)
        if data == nil {
        logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The device is rooted. Because the Foundation Library path is not the expected")
        return true
        }*/
        
        logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "The device is not rooted.")
        
        return false
    }

    /**
       Deletes from the device internal storage the entry/entries containing the specified key names.

       @param keys             Array with the key names to delete.
       @param publicAccessName The name of the shared internal storage object (if needed).
       @param callback         callback to be executed upon function result.
       @since ARP 1.0
    */
    public func deleteSecureKeyValuePairs(keys : [String], publicAccessName : String, callback : ISecurityResultCallback) {
        
        var successKeypairs: [SecureKeyPair] = [SecureKeyPair]()
        var warningKeypairs: [SecureKeyPair] = [SecureKeyPair]()
        
        let keychain = KeychainSwift(keyPrefix: publicAccessName as String)
        
        // Iterate over all keyvalues provided
        
        for key:String in keys {
            
            if keychain.delete(key) {
                successKeypairs.append(SecureKeyPair(secureKey: key, secureData: ""))
            } else {
                warningKeypairs.append(SecureKeyPair(secureKey: key, secureData: ""))
            }
            
        }
        
        // Return the success saved keypairs
        if successKeypairs.count > 0 {
            callback.onResult(successKeypairs)
        }
        
        // Return the overrided keypairs
        if warningKeypairs.count > 0 {
            callback.onWarning(warningKeypairs, warning: ISecurityResultCallbackWarning.Unknown)
        }
    }

    /**
       Retrieves from the device internal storage the entry/entries containing the specified key names.

       @param keys             Array with the key names to retrieve.
       @param publicAccessName The name of the shared internal storage object (if needed).
       @param callback         callback to be executed upon function result.
       @since ARP 1.0
    */
    public func getSecureKeyValuePairs(keys : [String], publicAccessName : String, callback : ISecurityResultCallback) {
        
        var successKeypairs: [SecureKeyPair] = [SecureKeyPair]()
        var warningKeypairs: [SecureKeyPair] = [SecureKeyPair]()
        
        let keychain = KeychainSwift(keyPrefix: publicAccessName as String)
        
        // Iterate over all keyvalues provided
        for key:String in keys {
            
            let data = keychain.get(key)
            
            if data != nil {
                successKeypairs.append(SecureKeyPair(secureKey: key, secureData: data!))
            } else {
                warningKeypairs.append(SecureKeyPair(secureKey: key, secureData: ""))
            }
        }
        
        // Return the success saved keypairs
        if successKeypairs.count > 0 {
            callback.onResult(successKeypairs)
        }
        
        // Return the overrided keypairs
        if warningKeypairs.count > 0 {
            callback.onWarning(warningKeypairs, warning: ISecurityResultCallbackWarning.Unknown)
        }
    }

    /**
       Stores in the device internal storage the specified item/s.

       @param keyValues        Array containing the items to store on the device internal memory.
       @param publicAccessName The name of the shared internal storage object (if needed).
       @param callback         callback to be executed upon function result.
       @since ARP 1.0
    */
    public func setSecureKeyValuePairs(keyValues : [SecureKeyPair], publicAccessName : String, callback : ISecurityResultCallback) {
        
        var successKeypairs: [SecureKeyPair] = [SecureKeyPair]()
        var warningKeypairs: [SecureKeyPair] = [SecureKeyPair]()
        
        let keychain = KeychainSwift(keyPrefix: publicAccessName as String)
        
        for pair:SecureKeyPair in keyValues {
            
            let data: NSData = pair.getSecureData()!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
            keychain.set(data, forKey: pair.getSecureKey()!)
            
            if keychain.get(pair.getSecureKey()!) != nil {
                successKeypairs.append(pair)
            } else {
                warningKeypairs.append(pair)
            }
        }
        
        // Return the success saved keypairs
        if successKeypairs.count > 0 {
            callback.onResult(successKeypairs)
        }
        
        // Return the overrided keypairs
        if warningKeypairs.count > 0 {
            callback.onWarning(warningKeypairs, warning: ISecurityResultCallbackWarning.EntryOverride)
        }
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
