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
    
    /**
    Function that checks if an url has the correct sintaxis
    
    :param: stringURL url to check
    
    :returns: true if correct, false otherwise
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public static func validateUrl (stringURL : NSString) -> Bool {
        
        var urlRegEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[urlRegEx])
        var urlTest = NSPredicate.predicateWithSubstitutionVariables(predicate)
        
        return predicate.evaluateWithObject(stringURL)
    }
    
    /**
    Function that validates the format of a phone number
    
    :param: phoneNumber Phone number to check
    
    :returns: true if its valid, else otherwise
    */
    public static func isPhoneNumberCorrect(phoneNumber: NSString) -> Bool {
        
        var urlRegEx = "((\\+[1-9]{3,4}|0[1-9]{4}|00[1-9]{3})\\-?)?\\d{8,20}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[urlRegEx])
        var urlTest = NSPredicate.predicateWithSubstitutionVariables(predicate)
        
        return predicate.evaluateWithObject(phoneNumber)
        
    }
    
    public static func normalizeString(m: String) -> String {
        
        return m.lowercaseString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
}

extension String {
    func rangesOfString(findStr:String) -> [Range<String.Index>] {
        var arr = [Range<String.Index>]()
        var startInd = self.startIndex
        var i = 0
        // test first of all whether the string is likely to appear at all
        if contains(self, first(findStr)!) {
            startInd = find(self,first(findStr)!)!
        }
        else {
            return arr
        }
        // set starting point for search based on the finding of the first character
        i = distance(self.startIndex, startInd)
        while i<=countElements(self)-countElements(findStr) {
            if self[advance(self.startIndex, i)..<advance(self.startIndex, i+countElements(findStr))] == findStr {
                arr.append(Range(start:advance(self.startIndex, i),end:advance(self.startIndex, i+countElements(findStr))))
                i = i+countElements(findStr)
            }
            i++
        }
        return arr
    } // try further optimization by repeating the initial act of finding first character after each found string
}


