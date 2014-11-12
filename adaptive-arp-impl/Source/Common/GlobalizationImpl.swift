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
import Foundation

/*
* = | i18n CONFIG (i18n-config.xml)  |=================================================================================
*
* <?xml version="1.0" encoding="UTF-8"?>
* <i18n-config>
*   <default language="en" country="EN"/>
*   <supportedLanguages>
*       <supportedLanguage language="en" country="EN" />
*       <supportedLanguage language="es" country="ES" />
*   </supportedLanguages>
* </i18n-config>
*
* = | Language file (es-ES.plist)  |===================================================================================
*
* <?xml version="1.0" encoding="UTF-8"?>
* <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
* <plist version="1.0">
*   <dict>
*     <key>hello-world</key>
*     <string>Hola Mundo</string>
*   </dict>
* </plist>
*
* =====================================================================================================================
*/
public class GlobalizationImpl : NSObject, IGlobalization {
    
    /// i18n config file
    let I18N_CONFIG_FILE: String = "i18n-config";
    let I18N_CONFIG_FILE_EXTENSION: String = ".xml";
    let I18N_CONFIG_FILE_DIRECTORY: String = "App.Source/config";
    let I18N_LANG_FILE: String = ".plist";
    
    /// Logging variable
    let logger : ILogging = LoggingImpl()
    
    /**
    Class constructor
    */
    public override init() {
        
    }
    
    /**
    Method that return the full path for the i18n config path
    
    :returns: Full path of config i18n
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    private func getConfigFilePath() -> String {
        return NSBundle.mainBundle().pathForResource(I18N_CONFIG_FILE, ofType: I18N_CONFIG_FILE_EXTENSION, inDirectory: I18N_CONFIG_FILE_DIRECTORY)!
    }
    
    /**
    Returns the full path for an specific language file
    
    :param: locale Locale bean
    
    :returns: Full path of language file
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    private func getLanguageFilePath(locale: AdaptiveArpApi.Locale) -> String {
        return NSBundle.mainBundle().pathForResource("\(locale.getLanguage()!)-\(locale.getCountry()!)", ofType: I18N_LANG_FILE, inDirectory: I18N_CONFIG_FILE_DIRECTORY)!
    }
    
    /**
    List of supported locales for the application
    
    :returns: List of locales (only locale descriptor string, such as "en-US").
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func getLocaleSupportedDescriptors() -> [String]? {
        
        // Read the i18n config file
        let data: Foundation.NSData? = NSData(contentsOfFile: getConfigFilePath())
        if data == nil {
            logger.log(ILoggingLogLevel.ERROR, category: "GlobalizationImpl", message: "Error reading i18n config file: \(getConfigFilePath())")
            return nil
        }
        
        var parserDelegate:I18NParser = I18NParser()
        
        // Create the parser and parse the xml
        var xmlParser = NSXMLParser(data: data)
        xmlParser.delegate = parserDelegate
        
        if xmlParser.parse() {
            logger.log(ILoggingLogLevel.DEBUG, category: "GlobalizationImpl", message: "Returning locales \(parserDelegate.getLocales())")
            return parserDelegate.getLocales()
        } else {
            logger.log(ILoggingLogLevel.ERROR, category: "GlobalizationImpl", message: "Error parsing i18n config file: \(getConfigFilePath())")
            return nil
        }
    }
    
    /**
    Gets the text/message corresponding to the given key and locale.
    
    :param: key    to match text
    :param: locale The locale object to get localized message, or the locale desciptor ("language" or "language-country" two-letters ISO codes.
    
    :returns: Localized text.
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func getResourceLiteral(key : String, locale : AdaptiveArpApi.Locale) -> String? {
        
        var filePath:String = getLanguageFilePath(locale)
        
        var anError : NSError?
        let data: NSData? = NSData(contentsOfFile: filePath)
        
        if data == nil {
            logger.log(ILoggingLogLevel.ERROR, category: "GlobalizationImpl", message: "Error reading i18n LANGUAGE file: \(filePath)")
            return nil
        }
        
        let dict : AnyObject! = NSPropertyListSerialization.propertyListWithData(data!, options: 0,format: nil, error: &anError)
        
        if dict != nil {
            if let ocDictionary = dict as? NSDictionary {
                
                //var swiftDict : Dictionary<String,String> = Dictionary<String,String>()
                
                for k : AnyObject in ocDictionary.allKeys{
                    let stringKey : String = k as String
                    
                    if key == stringKey {
                        
                        logger.log(ILoggingLogLevel.DEBUG, category: "GlobalizationImpl", message: "Returning value: \(ocDictionary[stringKey]) for key: \(stringKey)")
                        return (ocDictionary[stringKey] as String)
                    }
                }
            } else {
                logger.log(ILoggingLogLevel.ERROR, category: "GlobalizationImpl", message: "Sorry, couldn't read the file \(filePath.lastPathComponent)")
                return nil
            }
        } else if let theError = anError {
            logger.log(ILoggingLogLevel.ERROR, category: "GlobalizationImpl", message: "Sorry, couldn't read the file \(filePath.lastPathComponent):\n\t"+theError.localizedDescription)
        }
        
        return nil
    }
    
    /**
    Gets the full application configured literals (key/message pairs) corresponding to the given locale.
    
    :param: locale The locale object to get localized message, or the locale desciptor ("language" or "language-country" two-letters ISO codes.
    
    :returns: Localized texts in the form of an object (you could get the value of a keyed literal using resourceLiteralDictionary.MY_KEY or resourceLiteralDictionary["MY_KEY"]).
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func getResourceLiterals(locale : AdaptiveArpApi.Locale) -> Dictionary<String,String>? {
        
        var swiftDict : Dictionary<String,String> = Dictionary<String,String>()
        
        var filePath:String = getLanguageFilePath(locale)
        
        var anError : NSError?
        let data: NSData? = NSData(contentsOfFile: filePath)
        
        if data == nil {
            logger.log(ILoggingLogLevel.ERROR, category: "GlobalizationImpl", message: "Error reading i18n LANGUAGE file: \(filePath)")
            return nil
        }
        
        let dict : AnyObject! = NSPropertyListSerialization.propertyListWithData(data!, options: 0,format: nil, error: &anError)
        
        if dict != nil {
            if let ocDictionary = dict as? NSDictionary {
                
                for k : AnyObject in ocDictionary.allKeys{
                    
                    let stringKey : String = k as String
                    
                    swiftDict.updateValue(ocDictionary[stringKey] as String, forKey: stringKey)
                }
            } else {
                logger.log(ILoggingLogLevel.ERROR, category: "GlobalizationImpl", message: "Sorry, couldn't read the file \(filePath.lastPathComponent)")
                return nil
            }
        } else if let theError = anError {
            logger.log(ILoggingLogLevel.ERROR, category: "GlobalizationImpl", message: "Sorry, couldn't read the file \(filePath.lastPathComponent):\n\t"+theError.localizedDescription)
        }
        
        return swiftDict
    }
    
}