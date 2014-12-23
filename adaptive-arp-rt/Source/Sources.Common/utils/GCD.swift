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

public class GCD {
    
    /* dispatch_get_queue() */
    class func mainQueue() -> dispatch_queue_t {
        return dispatch_get_main_queue()
        // Could use return dispatch_get_global_queue(qos_class_main().id, 0)
    }
    class func userInteractiveQueue() -> dispatch_queue_t {
        return dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE.id, 0)
    }
    class func userInitiatedQueue() -> dispatch_queue_t {
        return dispatch_get_global_queue(QOS_CLASS_USER_INITIATED.id, 0)
    }
    class func defaultQueue() -> dispatch_queue_t {
        return dispatch_get_global_queue(QOS_CLASS_DEFAULT.id, 0)
    }
    class func utilityQueue() -> dispatch_queue_t {
        return dispatch_get_global_queue(QOS_CLASS_UTILITY.id, 0)
    }
    class func backgroundQueue() -> dispatch_queue_t {
        return dispatch_get_global_queue(QOS_CLASS_BACKGROUND.id, 0)
    }
}

extension qos_class_t {
    
    public var id:Int {
        return Int(self.value)
    }
}

// Convenience
extension qos_class_t {
    
    // Calculated property
    var description: String {
        get {
            switch self.id {
            case qos_class_main().id: return "Main"
            case QOS_CLASS_USER_INTERACTIVE.id: return "User Interactive"
            case QOS_CLASS_USER_INITIATED.id: return "User Initiated"
            case QOS_CLASS_DEFAULT.id: return "Default"
            case QOS_CLASS_UTILITY.id: return "Utility"
            case QOS_CLASS_BACKGROUND.id: return "Background"
            case QOS_CLASS_UNSPECIFIED.id: return "Unspecified"
            default: return "Unknown"
            }
        }
    }
}