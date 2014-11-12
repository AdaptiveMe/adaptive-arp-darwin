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
*     *
*
* =====================================================================================================================
*/

import Foundation
import AdaptiveArpApi
#if os(iOS)
    import UIKit
#elseif os(OSX)
    import Cocoa
#endif

public class AppContextImpl : NSObject, IAppContext {
    
    var context:AnyObject!
    var type:IAppContextType!
    
    /// Singleton instance
    public class var sharedInstance : AppContextImpl {
        struct Static {
            static let instance : AppContextImpl = AppContextImpl()
        }
        return Static.instance
    }
    
    /// init
    override init() {
        #if os(iOS)
            self.type = IAppContextType.iOS
            self.context = UIApplication.sharedApplication()
        #elseif os(OSX)
            self.type = IAppContextType.OSX
            self.context = NSApplication.sharedApplication()
        #endif
    }
    
    /// Returns the main context
    public func getContext() -> AnyObject? {
        return self.context
    }
    
    /// Returns the context type
    public func getContextType() -> IAppContextType {
        return self.type
    }
    
}
