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

public class LoggingImpl : NSObject, ILogging {
    
    /**
    Class constructor
    */
    override init() {
        
    }
    
    /**
    Logs the given message, with the given log level if specified, to the standard platform/environment.
    
    :param: level   Log level
    :param: message Message to be logged
    :author: Carlos Lozano Diez
    :since: ARP1.0
    */
    public func log(level : ILoggingLogLevel, message : String) {
        
        log(level, category: "GENERAL", message: message);
    }
    
    /**
    Logs the given message, with the given log level if specified, to the standard platform/environment.
    
    :param: level    Log level
    :param: category Category/tag name to identify/filter the log.
    :param: message  Message to be logged
    :author: Carlos Lozano Diez
    :since: ARP1.0
    */
    public func log(level : ILoggingLogLevel, category : String, message : String) {
        
        switch level {
            
        case ILoggingLogLevel.DEBUG:
            #if Debug
                NSLog("[DEBUG - \(category)] \(message)")
            #endif
            
        case ILoggingLogLevel.INFO:
            NSLog("[INFO - \(category)] \(message)")
            
        case ILoggingLogLevel.WARN:
            NSLog("[WARN - \(category)] \(message)")
            
        case ILoggingLogLevel.ERROR:
            NSLog("[ERROR - \(category)] \(message)")
        }
    }
    
}