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

public struct JSONUtil {

    public static func escapeString(string: String) -> String {
        var resultString : String = string
        // Replace " with \"
        resultString = resultString.stringByReplacingOccurrencesOfString("\\", withString: "\\\\", options: NSStringCompareOptions.LiteralSearch, range: nil)
        resultString = resultString.stringByReplacingOccurrencesOfString("\"", withString: "\\\"", options: NSStringCompareOptions.LiteralSearch, range: nil)
        return resultString
    }
    
    public static func unescapeString(string: String) -> String {
        var resultString : String = string
        // Replace " with nothing
        resultString = resultString.stringByReplacingOccurrencesOfString("\"", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        return resultString
    }
    
    public static func stringElementToArray(string : String) -> [String] {
        var theResult : [String] = [String]()
        var theString : NSString = string
        theString = theString.substringFromIndex(1)
        theString = theString.substringToIndex(theString.length-1)
        var theStringArr = split(theString as String) {$0 == ","}
        for quotedString in theStringArr {
            var unquotedString : NSString = quotedString
            //unquotedString = unquotedString.substringFromIndex(1)
            //unquotedString = unquotedString.substringToIndex(unquotedString.length - 1)
            theResult.append(unquotedString as String)
        }
        return theResult
    }
    
    public static func dictionifyJSON(string : String) -> NSDictionary {
        var data:NSData = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
        var error: NSError?
        return NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error) as NSDictionary
    }
}