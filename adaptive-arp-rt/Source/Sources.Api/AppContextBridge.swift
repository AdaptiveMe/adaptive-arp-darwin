/**
--| ADAPTIVE RUNTIME PLATFORM |----------------------------------------------------------------------------------------

(C) Copyright 2013-2015 Carlos Lozano Diez t/a Adaptive.me <http://adaptive.me>.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the
License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0 . Unless required by appli-
-cable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,  WITHOUT
WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the  License  for the specific language governing
permissions and limitations under the License.

Original author:

    * Carlos Lozano Diez
            <http://github.com/carloslozano>
            <http://twitter.com/adaptivecoder>
            <mailto:carlos@adaptive.me>

Contributors:

    * Ferran Vila Conesa
             <http://github.com/fnva>
             <http://twitter.com/ferran_vila>
             <mailto:ferran.vila.conesa@gmail.com>

    * See source code files for contributors.

Release:

    * @version v2.0.6

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Interface for context management purposes
   Auto-generated implementation of IAppContext specification.
*/
public class AppContextBridge : NSObject, IAppContext {

    /**
       Group of API.
    */
    private var apiGroup : IAdaptiveRPGroup = IAdaptiveRPGroup.Kernel

    public func getAPIGroup() -> IAdaptiveRPGroup? {
        return self.apiGroup
    }

    /**
       API Delegate.
    */
    private var delegate : IAppContext? = nil

    /**
       Constructor with delegate.

       @param delegate The delegate implementing platform specific functions.
    */
    public init(delegate : IAppContext?) {
        super.init()
        self.delegate = delegate
    }
    /**
       Get the delegate implementation.
       @return IAppContext delegate that manages platform specific functions..
    */
    public final func getDelegate() -> IAppContext? {
        return self.delegate
    }
    /**
       Set the delegate implementation.

       @param delegate The delegate implementing platform specific functions.
    */
    public final func setDelegate(delegate : IAppContext) {
        self.delegate = delegate;
    }

    /**
       The main application context. This should be cast to the platform specific implementation.

       @return Object representing the specific singleton application context provided by the OS.
       @since v2.0
    */
    public func getContext() -> AnyObject? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppContextBridge executing getContext.")
        }

        var result : AnyObject? = nil
        if (self.delegate != nil) {
            result = self.delegate!.getContext()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppContextBridge executed 'getContext' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppContextBridge no delegate for 'getContext'.")
            }
        }
        return result!        
    }

    /**
       The type of context provided by the getContext method.

       @return Type of platform context.
       @since v2.0
    */
    public func getContextType() -> IOSType? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppContextBridge executing getContextType.")
        }

        var result : IOSType? = nil
        if (self.delegate != nil) {
            result = self.delegate!.getContextType()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppContextBridge executed 'getContextType' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppContextBridge no delegate for 'getContextType'.")
            }
        }
        return result!        
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
