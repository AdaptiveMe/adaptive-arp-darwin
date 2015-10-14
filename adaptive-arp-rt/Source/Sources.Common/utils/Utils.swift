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

public struct Utils {
    
    public static func escapeString(string: String) -> String {
        var resultString : String = string
        resultString = resultString.stringByReplacingOccurrencesOfString("\'", withString: "\\\'", options: NSStringCompareOptions.LiteralSearch, range: nil)
        resultString = resultString.stringByReplacingOccurrencesOfString("\"", withString: "\\\"", options: NSStringCompareOptions.LiteralSearch, range: nil)
        resultString = resultString.stringByReplacingOccurrencesOfString("\n", withString: "\\n", options: NSStringCompareOptions.LiteralSearch, range: nil)
        resultString = resultString.stringByReplacingOccurrencesOfString("\r", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        return resultString
    }
    
    /**
    Function that checks if an url has the correct sintaxis
    
    :param: stringURL url to check
    
    :returns: true if correct, false otherwise
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public static func validateUrl (stringURL : NSString) -> Bool {
        
        return validateRegexp(stringURL as String, regexp: "^https?://.*")
    }
    
    /**
    Function that validates the format of a phone number
    
    :param: phoneNumber Phone number to check
    
    :returns: true if its valid, else otherwise
    */
    public static func isPhoneNumberCorrect(phoneNumber: NSString) -> Bool {
        
        return validateRegexp(phoneNumber as String, regexp: "((\\+[1-9]{3,4}|0[1-9]{4}|00[1-9]{3})\\-?)?\\d{8,20}")
    }
    
    public static func normalizeString(m: String) -> String {
        
        return m.lowercaseString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
    /**
    Method that validates a regular expression
    
    :param: string String to evaluate
    :param: regexp Regular Expression
    
    :returns: Value of the evaluation
    */
    public static func validateRegexp (string:String, regexp:String) -> Bool {
        if Regex(regexp).test(string){
            return true
        } else {
            return false
        }
    }
}

class Regex {
    let internalExpression: NSRegularExpression
    let pattern: String
    
    init(_ pattern: String) {
        self.pattern = pattern
        self.internalExpression = try! NSRegularExpression(pattern: self.pattern, options: NSRegularExpressionOptions.CaseInsensitive)
    }
    
    func test(input: String) -> Bool {
        let matches = self.internalExpression.matchesInString(input, options: NSMatchingOptions.ReportCompletion, range:NSMakeRange(0, (input as NSString).length))
        return matches.count > 0
    }
}

///-- Used by Encryption functions --------------------------------------------------------------- Start
func rotateLeft(v:UInt32, n:UInt32) -> UInt32 {
    return ((v << n) & 0xFFFFFFFF) | (v >> (32 - n))
}

func rotateLeft(x:UInt64, n:UInt64) -> UInt64 {
    return (x << n) | (x >> (64 - n))
}

func rotateRight(x:UInt32, n:UInt32) -> UInt32 {
    return (x >> n) | (x << (32 - n))
}

func rotateRight(x:UInt64, n:UInt64) -> UInt64 {
    return ((x >> n) | (x << (64 - n)))
}
///-- Used by Encryption functions --------------------------------------------------------------- End


