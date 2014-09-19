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

public class SessionImpl : ISession {
    
    /// Array of cookies
    var cookies: [Cookie]
    
    /// Dictionary of attributes
    var attributes: [String: AnyObject]
    
    /// Logging variable
    let logger : ILogging = LoggingImpl()
    
    /**
    Class constructor. Loads all information of the operating system
    */
    init() {
        
        cookies = [Cookie]()
        attributes = [String: AnyObject]()
    }
    
    /**
    Returns the cookie array
    
    :returns: cookie array
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func getCookies() -> [Cookie] {
        
        logger.log(ILoggingLogLevel.DEBUG, category: "SessionImpl", message: "Returning all cookies: \(self.cookies)")
        
        return self.cookies
    }
    
    /**
    Set a cookie object
    
    :param: cookie coockie
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func setCookie(cookie : Cookie) {
        
        logger.log(ILoggingLogLevel.DEBUG, category: "SessionImpl", message: "Adding a cookie: \(cookie)")
        
        self.cookies.append(cookie)
    }
    
    /**
    Set the cookies array
    
    :param: cookie array of cookies
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func setCookies(cookie : [Cookie]) {
        
        for c: Cookie in cookie {
            self.setCookie(c)
        }
    }
    
    /**
    Remove a cookie
    
    :param: cookie cookie to remove
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func removeCookie(cookie : Cookie) {
        
        for (index, c) in enumerate(self.cookies) {
            if c.getName() == cookie.getName() {
                self.cookies.removeAtIndex(index)
                logger.log(ILoggingLogLevel.DEBUG, category: "SessionImpl", message: "Removing cookie: \(c)")
                return
            }
        }
        logger.log(ILoggingLogLevel.WARN, category: "SessionImpl", message: "The cookie with name \(cookie.getName()) does not exist")
    }
    
    /**
    Remove a cookies array
    
    :param: cookie array of cookies
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func removeCookies(cookie : [Cookie]) {
        
        for c: Cookie in cookie {
            self.removeCookie(c)
        }
    }
    
    /**
    Returns an attribute object
    
    :param: name Name of the attribute
    
    :returns: object attribute
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func getAttribute(name : String) -> AnyObject {
        
        for (key, value) in self.attributes {
            if key == name {
                logger.log(ILoggingLogLevel.DEBUG, category: "SessionImpl", message: "Returning attribute \(key)")
                return value
            }
        }
        
        logger.log(ILoggingLogLevel.WARN, category: "SessionImpl", message: "The attribute with name \(name) does not exist. Returning nil")
        
        // TODO return nil
        return ""
    }
    
    /**
    Returns all Session Attributes
    
    :returns: Array of attributes
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func getAttributes() -> [AnyObject] {
        
        var ret: [AnyObject] = [AnyObject]()
        
        for (key, value) in self.attributes {
            ret.append(value)
        }
        
        logger.log(ILoggingLogLevel.DEBUG, category: "SessionImpl", message: "Returning all attributes: \(ret)")
        
        return ret
    }
    
    /**
    Set an attribute
    
    :param: name  attibute name
    :param: value attribute description
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func setAttribute(name : String, value : AnyObject) {
        
        logger.log(ILoggingLogLevel.DEBUG, category: "SessionImpl", message: "Setting attribute with name: \(name) and value: \(value)")
        
        self.attributes.updateValue(value, forKey: name)!
    }
    
    /**
    Returns all attibute names
    
    :returns: return array of strings
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func listAttributeNames() -> [String] {
        
        var ret: [String] = [String]()
        
        for (key, value) in self.attributes {
            ret.append(key)
        }
        
        logger.log(ILoggingLogLevel.DEBUG, category: "SessionImpl", message: "Returning all keys: \(ret)")
        
        return ret
    }
    
    /**
    Remove an attribute by its name
    
    :param: name name of the attribute
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func removeAttribute(name : String) {
        
        var value: AnyObject? = self.attributes.removeValueForKey(name)
        
        if value == nil {
            logger.log(ILoggingLogLevel.ERROR, category: "SessionImpl", message: "Error removing an attribute: \(name)")
            return
        } else {
            logger.log(ILoggingLogLevel.DEBUG, category: "SessionImpl", message: "Removing an attribute: \(name)")
        }
    }
    
    /**
    Remove all attributes
    
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func removeAttributes() {
        
        logger.log(ILoggingLogLevel.DEBUG, category: "SessionImpl", message: "Removing all attributes")
        
        self.removeAttributes()
    }
}