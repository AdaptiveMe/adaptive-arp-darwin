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
#if os(iOS)
    import UIKit
#endif
#if os(OSX)
    import Cocoa
#endif

/**
   Interface for context management purposes
   Auto-generated implementation of IAppContext specification.
*/
public class AppContextDelegate : NSObject, IAppContext {
    
    
    var context:AnyObject!
    var type:IOSType!

    /**
       Default Constructor.
    */
    public override init() {
        super.init()
        #if os(iOS)
            self.type = IOSType.iOS
            self.context = UIApplication.sharedApplication()
        #endif
        #if os(OSX)
            self.type = IOSType.OSX
            self.context = NSApplication.sharedApplication()
        #endif
    }

    /**
       The main application context. This should be cast to the platform specific implementation.

       @return Object representing the specific singleton application context provided by the OS.
       @since ARP1.0
    */
    public func getContext() -> AnyObject? {
        return self.context
    }

    /**
       The type of context provided by the getContext method.

       @return Type of platform context.
       @since ARP1.0
    */
    public func getContextType() -> IOSType? {
        return self.type
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
