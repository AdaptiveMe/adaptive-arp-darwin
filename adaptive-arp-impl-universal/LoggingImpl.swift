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

class LoggingImpl : ILogging {
    
    func log(level : ILoggingLogLevel, message : String) {
        log(level, category: "GENERAL", message: message);
    }
    
    func log(level : ILoggingLogLevel, category : String, message : String) {
        if (level == ILoggingLogLevel.DEBUG) {
            #if DEBUG
            println("DEBUG - "+category+": "+message)
            #endif
        } else if (level == ILoggingLogLevel.ERROR) {
            println("ERROR - "+category+": "+message)
        } else if (level == ILoggingLogLevel.WARN) {
            println("WARN - "+category+": "+message)
        } else {
            println("INFO - "+category+": "+message)
        }
    }
    
}