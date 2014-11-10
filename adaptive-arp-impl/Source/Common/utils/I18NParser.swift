//
//  I18NParser.swift
//  AdaptiveArpImplIos
//
//  Created by Administrator on 19/09/14.
//  Copyright (c) 2014 Carlos Lozano Diez. All rights reserved.
//

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
            locales.append("\(attributeDict[I18N_SUPLANG_ATTR_LANG]) - \(attributeDict[I18N_SUPLANG_ATTR_CNTR])")
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