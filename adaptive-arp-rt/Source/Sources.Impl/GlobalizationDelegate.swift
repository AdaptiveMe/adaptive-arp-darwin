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

/**
   Interface for Managing the Globalization results
   Auto-generated implementation of IGlobalization specification.
*/
public class GlobalizationDelegate : BaseApplicationDelegate, IGlobalization {
    
    /// Logger variable
    let logger : ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge()
    let loggerTag : String = "GlobalizationDelegate"
    
    /**
       Default Constructor.
    */
    public override init() {
        super.init()
    }
    
    /**
    Returns the default locale of the application defined in the configuration file
    
    @return Default Locale of the application
    @since ARP1.0
    */
    public func getDefaultLocale() -> Locale? {
        
        return I18NParser.sharedInstance.getDefaultLocale()
    }

    /**
       List of supported locales for the application

       @return List of locales
       @since ARP1.0
    */
    public func getLocaleSupportedDescriptors() -> [Locale]? {
        
        return I18NParser.sharedInstance.getLocales()
    }

    /**
       Gets the text/message corresponding to the given key and locale.

       @param key    to match text
       @param locale The locale object to get localized message, or the locale desciptor ("language" or "language-country" two-letters ISO codes.
       @return Localized text.
       @since ARP1.0
    */
    public func getResourceLiteral(key : String, locale : Locale) -> String? {
        
        let filePath:String = getLanguageFilePath(locale)
        let resourceData : ResourceData? = AppResourceManager.sharedInstance.retrieveConfigResource(filePath)
        if resourceData == nil {
            logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Error reading i18n LANGUAGE file: \(filePath)")
            return nil
        }
        

        let data: NSData? = resourceData!.data
        
        if data == nil {
            logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Error reading i18n LANGUAGE file: \(filePath)")
            return nil
        }
        
        let dict : AnyObject! = try? NSPropertyListSerialization.propertyListWithData(data!, options: NSPropertyListReadOptions.MutableContainersAndLeaves,format: nil)
        
        if dict != nil {
            if let ocDictionary = dict as? NSDictionary {
                
                //var swiftDict : Dictionary<String,String> = Dictionary<String,String>()
                
                for k : AnyObject in ocDictionary.allKeys{
                    let stringKey : String = k as! String
                    
                    if key == stringKey {
                        
                        logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Returning value: \(ocDictionary[stringKey]) for key: \(stringKey)")
                        return (ocDictionary[stringKey] as! String)
                    }
                }
            } else {
                logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Sorry, couldn't read the file \(filePath)")
                return nil
            }
        }
        
        return nil
    }

    /**
       Gets the full application configured literals (key/message pairs) corresponding to the given locale.

       @param locale The locale object to get localized message, or the locale desciptor ("language" or "language-country" two-letters ISO codes.
       @return Localized texts in the form of an object.
       @since ARP1.0
    */
    public func getResourceLiterals(locale : Locale) -> [KeyPair]? {
        
        var swiftDict : [KeyPair] = [KeyPair]()
        
        let filePath:String = getLanguageFilePath(locale)
        let resourceData : ResourceData? = AppResourceManager.sharedInstance.retrieveConfigResource(filePath)
        if resourceData == nil {
            logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Error reading i18n LANGUAGE file: \(filePath)")
            return nil
        }
        
        let data: NSData? = resourceData!.data
        
        if data == nil {
            logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Error reading i18n LANGUAGE file: \(filePath)")
            return nil
        }
        
        let dict : AnyObject! = try? NSPropertyListSerialization.propertyListWithData(data!, options: NSPropertyListReadOptions.MutableContainersAndLeaves,format: nil)
        
        if dict != nil {
            if let ocDictionary = dict as? NSDictionary {
                
                for k : AnyObject in ocDictionary.allKeys{
                    
                    let stringKey : String = k as! String
                    
                    swiftDict.append(KeyPair(keyName: stringKey, keyValue: ocDictionary[stringKey] as! String))
                }
            } else {
                logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Sorry, couldn't read the file \(filePath)")
                return nil
            }
        }
        
        return swiftDict
    }
    
    /**
    Returns the full path for an specific language file
    
    :param: locale Locale bean
    
    :returns: Full path of language file
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    private func getLanguageFilePath(locale: Locale) -> String {
        return "\(locale.getLanguage()!)-\(locale.getCountry()!)\(I18NParser.I18N_LANG_FILE)"
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
