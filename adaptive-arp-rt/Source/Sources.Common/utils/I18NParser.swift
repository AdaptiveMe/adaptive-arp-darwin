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
import AdaptiveArpApi

public class I18NParser : NSObject, NSXMLParserDelegate {
    
    
    /// Singleton instance
    public class var sharedInstance : I18NParser {
        struct Static {
            static let instance : I18NParser = I18NParser()
        }
        return Static.instance
    }
    
    /// Logging variable
    let logger : ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge()
    let loggerTag : String = "I18NParser"
    
    /// Locales supported (filled by the getLocaleSupportedDescriptors method)
    var localesArray:[Locale]? = nil
    
    /// Default Locale
    var defaultLocale:Locale?
    
    /// i18n config file
    public class var I18N_CONFIG_FILE: String {
        return "i18n-config.xml";
    }
    public class var I18N_LANG_FILE: String {
        return ".plist";
    }
    
    let I18N_SUPLANG_ELEM: String = "supportedLanguage"
    let I18N_SUPLANG_DEFAULT: String = "default"
    let I18N_SUPLANG_ATTR_LANG: String = "language"
    let I18N_SUPLANG_ATTR_CNTR: String = "country"
    
    /**
    Class constructor
    */
    public override init(){
        
        super.init()
        
        // Read the i18n config file
        if let resourceData:ResourceData = AppResourceManager.sharedInstance.retrieveConfigResource(I18NParser.I18N_CONFIG_FILE) {
            
            let xmlParser = NSXMLParser(data: resourceData.data)
            xmlParser.delegate = self
            
            localesArray = []
            defaultLocale = Locale()
            
            if !xmlParser.parse() {
                logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Error parsing i18n config file: \(I18NParser.I18N_CONFIG_FILE)")
            }
            
        } else {
            logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Error reading i18n config file: \(I18NParser.I18N_CONFIG_FILE)")
        }
    }
    
    /**
    Method involved in the xml parse response
    
    :param: parser        XML parser
    :param: elementName   name of the element
    :param: namespaceURI  namespace uri of the element
    :param: qName         qName of the element
    :param: attributeDict dictionary of attributes
    */   
    public func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        // Store
        if elementName == I18N_SUPLANG_ELEM {
            
            logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Reading language: \(attributeDict[I18N_SUPLANG_ATTR_LANG])")
            
            let locale:Locale = Locale()
            locale.setLanguage("\(attributeDict[I18N_SUPLANG_ATTR_LANG]!)")
            locale.setCountry("\(attributeDict[I18N_SUPLANG_ATTR_CNTR]!)")
            localesArray!.append(locale)
            
        } else if elementName == I18N_SUPLANG_DEFAULT {
            
            logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Reading default language: \(attributeDict[I18N_SUPLANG_ATTR_LANG])")
            
            defaultLocale!.setLanguage("\(attributeDict[I18N_SUPLANG_ATTR_LANG]!)")
            defaultLocale!.setCountry("\(attributeDict[I18N_SUPLANG_ATTR_CNTR]!)")
        }
    }
    
    /**
    Return the locales parsed
    
    :returns: List of locales
    */
    public func getLocales() -> [Locale]? {
        return localesArray
    }
    
    /**
    Returns the deault locale of the application
    
    :returns: Default Locale
    */
    public func getDefaultLocale() -> Locale? {
        return defaultLocale
    }
}