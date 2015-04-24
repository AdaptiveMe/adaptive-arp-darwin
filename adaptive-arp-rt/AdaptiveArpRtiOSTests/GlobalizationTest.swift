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

import XCTest
import AdaptiveArpApi

/**
*  Globalization delegate tests class
*  MARK: Maybe this test should be removed when the App.Source folder will be removed.
*/
class GlobalizationTest: XCTestCase {
    
    /**
    Constructor.
    */
    override func setUp() {
        super.setUp()
        
        AppRegistryBridge.sharedInstance.getLoggingBridge().setDelegate(LoggingDelegate())
        AppRegistryBridge.sharedInstance.getPlatformContext().setDelegate(AppContextDelegate())
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().setDelegate(AppContextWebviewDelegate())
        AppRegistryBridge.sharedInstance.getGlobalizationBridge().setDelegate(GlobalizationDelegate())
    }
    
    /**
    Test to try the method get default locale. This should return the locale defined in the i18n config file
    */
    func testGetDefaultLocale() {
        XCTAssert(AppRegistryBridge.sharedInstance.getGlobalizationBridge().getDefaultLocale() != nil, "Error obtaining the default locale. See log for more details")
    }
    
    /**
    Test to try the method to obtain the configured locales
    */
    func testGetLocaleSupportedDescriptors() {
        XCTAssert(AppRegistryBridge.sharedInstance.getGlobalizationBridge().getLocaleSupportedDescriptors()?.count > 0, "Error obtaining the configured locales. See log for more details")
    }
    
    /**
    Test to try the method to obtain a literal resource for the default language
    */
    func testGetResourceLiteral() {
        
        var defaultLocale = AppRegistryBridge.sharedInstance.getGlobalizationBridge().getDefaultLocale()!
        
        // MARK: Maybe the literal for hello-world is not defined
        
        XCTAssert(AppRegistryBridge.sharedInstance.getGlobalizationBridge().getResourceLiteral("hello-world", locale: defaultLocale) != nil, "Error obtaining the literal hello-world for the default locale. See log for more details")
    }
    
    /**
    Test to try the method to obtain all the literals for the default language
    */
    func testGetResourceLiterals() {
        
        var defaultLocale = AppRegistryBridge.sharedInstance.getGlobalizationBridge().getDefaultLocale()!
        
        // MARK: Maybe the literal for hello-world is not defined
        
        XCTAssert(AppRegistryBridge.sharedInstance.getGlobalizationBridge().getResourceLiterals(defaultLocale)?.count > 0, "Error obtaining all the literals for the default locale. See log for more details")
    }
}