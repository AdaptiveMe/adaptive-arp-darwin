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
    
    /// Logging variable
    let logger : ILogging = LoggingImpl()
    
    /// Locales supported (filled by the getLocaleSupportedDescriptors method)
    var locales: [String]
    
    let I18N_SUPLANG_ELEM: String = "supportedLanguage"
    let I18N_SUPLANG_ATTR_LANG: String = "language"
    let I18N_SUPLANG_ATTR_CNTR: String = "country"
    
    /**
    Class constructor
    */
    override init(){
        locales = [String]()
    }
    
    /**
    Method involved in the xml parse response
    
    :param: parser        XML parser
    :param: elementName   name of the element
    :param: namespaceURI  namespace uri of the element
    :param: qName         qName of the element
    :param: attributeDict dictionary of attributes
    */
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: NSDictionary!) {
        
        // Store
        if elementName == I18N_SUPLANG_ELEM {
            logger.log(ILoggingLogLevel.DEBUG, category: "GlobalizationImpl", message: "Reading language: \(attributeDict[I18N_SUPLANG_ATTR_LANG])")
            locales.append("\(attributeDict[I18N_SUPLANG_ATTR_LANG]!)-\(attributeDict[I18N_SUPLANG_ATTR_CNTR]!)")
        }
    }
    
    /**
    Return the locales parsed
    
    :returns: List of locales
    */
    public func getLocales() -> [String] {
        return locales
    }
}