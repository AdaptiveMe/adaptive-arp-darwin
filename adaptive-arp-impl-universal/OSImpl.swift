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

public class OSImpl : IOS {
    
    /// Logging variable
    let logger : ILogging = LoggingImpl()
    
    /// Variable to store OSInfo object
    var osInfo : OSInfo
    
    /**
    Class constructor. Loads all information of the operating system
    */
    init() {
        var osName : String
        #if os(iOS)
            osName = "iOS"
        #else
            osName = "OSX"
        #endif
        var processInfoOs : NSOperatingSystemVersion = NSProcessInfo.processInfo().operatingSystemVersion
        var osVersion : String = "\(processInfoOs.majorVersion).\(processInfoOs.minorVersion)"
        if (processInfoOs.patchVersion>0) {
            osVersion+=".\(processInfoOs.patchVersion)"
        }
        self.osInfo = OSInfo(name: osName, version: osVersion, vendor: "Apple")
    }
    
    /**
    Returns the OSInfo for the current operating system.
    
    :returns: OSInfo with name, version and vendor of the OS.
    */
    public func getOSInfo() -> OSInfo {
        
        logger.log(ILoggingLogLevel.INFO, category: "OSImpl", message: "name: \(self.osInfo.getName()), version: \(self.osInfo.getVersion()), vendor: \(self.osInfo.getVendor())")
        
        return self.osInfo
    }
}