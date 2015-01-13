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

/**
   Interface for Managing the Globalization results
   Auto-generated implementation of IGlobalization specification.
*/
public class GlobalizationDelegate : BaseApplicationDelegate, IGlobalization {
    
    /// Logger variable
    let logger : ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge()
    let loggerTag : String = "GlobalizationDelegate"
    
    /// i18n config file
    let I18N_CONFIG_FILE: String = "i18n-config.xml";
    let I18N_LANG_FILE: String = ".plist";
    
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
        
        // Read the i18n config file
        var resourceData : ResourceData? = AppResourceManager.sharedInstance.retrieveConfigResource(I18N_CONFIG_FILE)
        if resourceData == nil {
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "Error reading i18n config file: \(I18N_CONFIG_FILE)")
            return nil
        }
        
        let data: Foundation.NSData? = resourceData!.data
        if data == nil {
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "Error reading i18n config file: \(I18N_CONFIG_FILE)")
            return nil
        }
        
        var parserDelegate:I18NParser = I18NParser()
        
        // Create the parser and parse the xml
        var xmlParser = NSXMLParser(data: data)
        xmlParser.delegate = parserDelegate
        
        if xmlParser.parse() {
            logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Returning locales \(parserDelegate.getLocales())")
            return parserDelegate.getDefaultLocale()
        } else {
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "Error parsing i18n config file: \(I18N_CONFIG_FILE)")
            return nil
        }
    }

    /**
       List of supported locales for the application

       @return List of locales
       @since ARP1.0
    */
    public func getLocaleSupportedDescriptors() -> [Locale]? {
        
        // Read the i18n config file
        var resourceData : ResourceData? = AppResourceManager.sharedInstance.retrieveConfigResource(I18N_CONFIG_FILE)
        if resourceData == nil {
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "Error reading i18n config file: \(I18N_CONFIG_FILE)")
            return nil
        }
        
        let data: Foundation.NSData? = resourceData!.data
        if data == nil {
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "Error reading i18n config file: \(I18N_CONFIG_FILE)")
            return nil
        }
        
        var parserDelegate:I18NParser = I18NParser()
        
        // Create the parser and parse the xml
        var xmlParser = NSXMLParser(data: data)
        xmlParser.delegate = parserDelegate
        
        if xmlParser.parse() {
            logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Returning locales \(parserDelegate.getLocales())")
            return parserDelegate.getLocales()
        } else {
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "Error parsing i18n config file: \(I18N_CONFIG_FILE)")
            return nil
        }
    }

    /**
       Gets the text/message corresponding to the given key and locale.

       @param key    to match text
       @param locale The locale object to get localized message, or the locale desciptor ("language" or "language-country" two-letters ISO codes.
       @return Localized text.
       @since ARP1.0
    */
    public func getResourceLiteral(key : String, locale : Locale) -> String? {
        
        var filePath:String = getLanguageFilePath(locale)
        var resourceData : ResourceData? = AppResourceManager.sharedInstance.retrieveConfigResource(filePath)
        if resourceData == nil {
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "Error reading i18n LANGUAGE file: \(filePath)")
            return nil
        }
        
        var anError : NSError?
        let data: NSData? = resourceData!.data
        
        if data == nil {
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "Error reading i18n LANGUAGE file: \(filePath)")
            return nil
        }
        
        let dict : AnyObject! = NSPropertyListSerialization.propertyListWithData(data!, options: 0,format: nil, error: &anError)
        
        if dict != nil {
            if let ocDictionary = dict as? NSDictionary {
                
                //var swiftDict : Dictionary<String,String> = Dictionary<String,String>()
                
                for k : AnyObject in ocDictionary.allKeys{
                    let stringKey : String = k as String
                    
                    if key == stringKey {
                        
                        logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Returning value: \(ocDictionary[stringKey]) for key: \(stringKey)")
                        return (ocDictionary[stringKey] as String)
                    }
                }
            } else {
                logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "Sorry, couldn't read the file \(filePath.lastPathComponent)")
                return nil
            }
        } else if let theError = anError {
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "Sorry, couldn't read the file \(filePath.lastPathComponent):\n\t"+theError.localizedDescription)
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
        
        var filePath:String = getLanguageFilePath(locale)
        var resourceData : ResourceData? = AppResourceManager.sharedInstance.retrieveConfigResource(filePath)
        if resourceData == nil {
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "Error reading i18n LANGUAGE file: \(filePath)")
            return nil
        }
        
        var anError : NSError?
        let data: NSData? = resourceData!.data
        
        if data == nil {
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "Error reading i18n LANGUAGE file: \(filePath)")
            return nil
        }
        
        let dict : AnyObject! = NSPropertyListSerialization.propertyListWithData(data!, options: 0,format: nil, error: &anError)
        
        if dict != nil {
            if let ocDictionary = dict as? NSDictionary {
                
                for k : AnyObject in ocDictionary.allKeys{
                    
                    let stringKey : String = k as String
                    
                    swiftDict.append(KeyPair(keyName: stringKey, keyValue: ocDictionary[stringKey] as String))
                }
            } else {
                logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "Sorry, couldn't read the file \(filePath.lastPathComponent)")
                return nil
            }
        } else if let theError = anError {
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "Sorry, couldn't read the file \(filePath.lastPathComponent):\n\t"+theError.localizedDescription)
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
        return "\(locale.getLanguage()!)-\(locale.getCountry()!)\(I18N_LANG_FILE)"
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
