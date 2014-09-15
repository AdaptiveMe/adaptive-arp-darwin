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

public struct Await<T> {
    
    /// private properties
    let group: dispatch_group_t
    let getResult: () -> T
    
    // public methods
    func await() -> T {
        return getResult()
    }
}

/**
Method for calling async methods in Swift

:param: queue Common queue to execute methods
:param: block Block lines

:returns: Block return value
*/
public func async<T>(queue: dispatch_queue_t, block: () -> T) -> Await<T> {
    
    let group = dispatch_group_create()
    var result: T?
    dispatch_group_async(group, queue) {
        result = block()
    }
    return Await(group: group, getResult: { dispatch_group_wait(group, DISPATCH_TIME_FOREVER); return result! })
}