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

    * @version v2.0.4

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Interface to retrieve auto-registered service implementation references.
   Auto-generated implementation of IAppRegistry specification.
*/
public class AppRegistryBridge : NSObject, IAppRegistry {

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
    private var delegate : IAppRegistry? = nil

    /**
       Constructor with delegate.

       @param delegate The delegate implementing platform specific functions.
    */
    public init(delegate : IAppRegistry?) {
        super.init()
        self.delegate = delegate
    }
    /**
       Get the delegate implementation.
       @return IAppRegistry delegate that manages platform specific functions..
    */
    public final func getDelegate() -> IAppRegistry? {
        return self.delegate
    }
    /**
       Set the delegate implementation.

       @param delegate The delegate implementing platform specific functions.
    */
    public final func setDelegate(delegate : IAppRegistry) {
        self.delegate = delegate;
    }

    /**
       Singleton instance.
    */
    class var sharedInstance : AppRegistryBridge {
        struct Static {
            static let instance : AppRegistryBridge = AppRegistryBridge(delegate: AppRegistryDelegate())
        }
        return Static.instance
    }

    /**
       Returns a reference to the registered AccelerationBridge.

       @return AccelerationBridge reference or null if a bridge of this type is not registered.
    */
    public final func getAccelerationBridge() -> AccelerationBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : AccelerationBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getAccelerationBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getAccelerationBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getAccelerationBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getAccelerationBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered AdsBridge.

       @return AdsBridge reference or null if a bridge of this type is not registered.
    */
    public final func getAdsBridge() -> AdsBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : AdsBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getAdsBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getAdsBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getAdsBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getAdsBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered AlarmBridge.

       @return AlarmBridge reference or null if a bridge of this type is not registered.
    */
    public final func getAlarmBridge() -> AlarmBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : AlarmBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getAlarmBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getAlarmBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getAlarmBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getAlarmBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered AmbientLightBridge.

       @return AmbientLightBridge reference or null if a bridge of this type is not registered.
    */
    public final func getAmbientLightBridge() -> AmbientLightBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : AmbientLightBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getAmbientLightBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getAmbientLightBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getAmbientLightBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getAmbientLightBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered AnalyticsBridge.

       @return AnalyticsBridge reference or null if a bridge of this type is not registered.
    */
    public final func getAnalyticsBridge() -> AnalyticsBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : AnalyticsBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getAnalyticsBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getAnalyticsBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getAnalyticsBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getAnalyticsBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered AudioBridge.

       @return AudioBridge reference or null if a bridge of this type is not registered.
    */
    public final func getAudioBridge() -> AudioBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : AudioBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getAudioBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getAudioBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getAudioBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getAudioBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered BarcodeBridge.

       @return BarcodeBridge reference or null if a bridge of this type is not registered.
    */
    public final func getBarcodeBridge() -> BarcodeBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : BarcodeBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getBarcodeBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getBarcodeBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getBarcodeBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getBarcodeBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered BarometerBridge.

       @return BarometerBridge reference or null if a bridge of this type is not registered.
    */
    public final func getBarometerBridge() -> BarometerBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : BarometerBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getBarometerBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getBarometerBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getBarometerBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getBarometerBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered BluetoothBridge.

       @return BluetoothBridge reference or null if a bridge of this type is not registered.
    */
    public final func getBluetoothBridge() -> BluetoothBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : BluetoothBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getBluetoothBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getBluetoothBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getBluetoothBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getBluetoothBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered BrowserBridge.

       @return BrowserBridge reference or null if a bridge of this type is not registered.
    */
    public final func getBrowserBridge() -> BrowserBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : BrowserBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getBrowserBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getBrowserBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getBrowserBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getBrowserBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered CalendarBridge.

       @return CalendarBridge reference or null if a bridge of this type is not registered.
    */
    public final func getCalendarBridge() -> CalendarBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : CalendarBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getCalendarBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getCalendarBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getCalendarBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getCalendarBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered CameraBridge.

       @return CameraBridge reference or null if a bridge of this type is not registered.
    */
    public final func getCameraBridge() -> CameraBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : CameraBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getCameraBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getCameraBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getCameraBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getCameraBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered CapabilitiesBridge.

       @return CapabilitiesBridge reference or null if a bridge of this type is not registered.
    */
    public final func getCapabilitiesBridge() -> CapabilitiesBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : CapabilitiesBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getCapabilitiesBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getCapabilitiesBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getCapabilitiesBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getCapabilitiesBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered CloudBridge.

       @return CloudBridge reference or null if a bridge of this type is not registered.
    */
    public final func getCloudBridge() -> CloudBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : CloudBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getCloudBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getCloudBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getCloudBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getCloudBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered CompressionBridge.

       @return CompressionBridge reference or null if a bridge of this type is not registered.
    */
    public final func getCompressionBridge() -> CompressionBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : CompressionBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getCompressionBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getCompressionBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getCompressionBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getCompressionBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered ConcurrentBridge.

       @return ConcurrentBridge reference or null if a bridge of this type is not registered.
    */
    public final func getConcurrentBridge() -> ConcurrentBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : ConcurrentBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getConcurrentBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getConcurrentBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getConcurrentBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getConcurrentBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered ContactBridge.

       @return ContactBridge reference or null if a bridge of this type is not registered.
    */
    public final func getContactBridge() -> ContactBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : ContactBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getContactBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getContactBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getContactBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getContactBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered CryptoBridge.

       @return CryptoBridge reference or null if a bridge of this type is not registered.
    */
    public final func getCryptoBridge() -> CryptoBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : CryptoBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getCryptoBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getCryptoBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getCryptoBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getCryptoBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered DataStreamBridge.

       @return DataStreamBridge reference or null if a bridge of this type is not registered.
    */
    public final func getDataStreamBridge() -> DataStreamBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : DataStreamBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getDataStreamBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getDataStreamBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getDataStreamBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getDataStreamBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered DatabaseBridge.

       @return DatabaseBridge reference or null if a bridge of this type is not registered.
    */
    public final func getDatabaseBridge() -> DatabaseBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : DatabaseBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getDatabaseBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getDatabaseBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getDatabaseBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getDatabaseBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered DesktopBridge.

       @return DesktopBridge reference or null if a bridge of this type is not registered.
    */
    public final func getDesktopBridge() -> DesktopBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : DesktopBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getDesktopBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getDesktopBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getDesktopBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getDesktopBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered DeviceBridge.

       @return DeviceBridge reference or null if a bridge of this type is not registered.
    */
    public final func getDeviceBridge() -> DeviceBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : DeviceBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getDeviceBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getDeviceBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getDeviceBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getDeviceBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered DisplayBridge.

       @return DisplayBridge reference or null if a bridge of this type is not registered.
    */
    public final func getDisplayBridge() -> DisplayBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : DisplayBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getDisplayBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getDisplayBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getDisplayBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getDisplayBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered FacebookBridge.

       @return FacebookBridge reference or null if a bridge of this type is not registered.
    */
    public final func getFacebookBridge() -> FacebookBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : FacebookBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getFacebookBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getFacebookBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getFacebookBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getFacebookBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered FileBridge.

       @return FileBridge reference or null if a bridge of this type is not registered.
    */
    public final func getFileBridge() -> FileBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : FileBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getFileBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getFileBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getFileBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getFileBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered FileSystemBridge.

       @return FileSystemBridge reference or null if a bridge of this type is not registered.
    */
    public final func getFileSystemBridge() -> FileSystemBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : FileSystemBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getFileSystemBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getFileSystemBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getFileSystemBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getFileSystemBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered GeolocationBridge.

       @return GeolocationBridge reference or null if a bridge of this type is not registered.
    */
    public final func getGeolocationBridge() -> GeolocationBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : GeolocationBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getGeolocationBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getGeolocationBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getGeolocationBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getGeolocationBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered GlobalizationBridge.

       @return GlobalizationBridge reference or null if a bridge of this type is not registered.
    */
    public final func getGlobalizationBridge() -> GlobalizationBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : GlobalizationBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getGlobalizationBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getGlobalizationBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getGlobalizationBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getGlobalizationBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered GooglePlusBridge.

       @return GooglePlusBridge reference or null if a bridge of this type is not registered.
    */
    public final func getGooglePlusBridge() -> GooglePlusBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : GooglePlusBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getGooglePlusBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getGooglePlusBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getGooglePlusBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getGooglePlusBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered GyroscopeBridge.

       @return GyroscopeBridge reference or null if a bridge of this type is not registered.
    */
    public final func getGyroscopeBridge() -> GyroscopeBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : GyroscopeBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getGyroscopeBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getGyroscopeBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getGyroscopeBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getGyroscopeBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered ImagingBridge.

       @return ImagingBridge reference or null if a bridge of this type is not registered.
    */
    public final func getImagingBridge() -> ImagingBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : ImagingBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getImagingBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getImagingBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getImagingBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getImagingBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered InternalStorageBridge.

       @return InternalStorageBridge reference or null if a bridge of this type is not registered.
    */
    public final func getInternalStorageBridge() -> InternalStorageBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : InternalStorageBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getInternalStorageBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getInternalStorageBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getInternalStorageBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getInternalStorageBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered LifecycleBridge.

       @return LifecycleBridge reference or null if a bridge of this type is not registered.
    */
    public final func getLifecycleBridge() -> LifecycleBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : LifecycleBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getLifecycleBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getLifecycleBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getLifecycleBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getLifecycleBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered LinkedInBridge.

       @return LinkedInBridge reference or null if a bridge of this type is not registered.
    */
    public final func getLinkedInBridge() -> LinkedInBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : LinkedInBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getLinkedInBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getLinkedInBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getLinkedInBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getLinkedInBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered LoggingBridge.

       @return LoggingBridge reference or null if a bridge of this type is not registered.
    */
    public final func getLoggingBridge() -> LoggingBridge {
        var result : LoggingBridge? = nil
        if (self.delegate != nil) {
            result = self.delegate!.getLoggingBridge()
        }
        return result!        
    }

    /**
       Returns a reference to the registered MagnetometerBridge.

       @return MagnetometerBridge reference or null if a bridge of this type is not registered.
    */
    public final func getMagnetometerBridge() -> MagnetometerBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : MagnetometerBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getMagnetometerBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getMagnetometerBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getMagnetometerBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getMagnetometerBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered MailBridge.

       @return MailBridge reference or null if a bridge of this type is not registered.
    */
    public final func getMailBridge() -> MailBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : MailBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getMailBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getMailBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getMailBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getMailBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered ManagementBridge.

       @return ManagementBridge reference or null if a bridge of this type is not registered.
    */
    public final func getManagementBridge() -> ManagementBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : ManagementBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getManagementBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getManagementBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getManagementBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getManagementBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered MapBridge.

       @return MapBridge reference or null if a bridge of this type is not registered.
    */
    public final func getMapBridge() -> MapBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : MapBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getMapBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getMapBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getMapBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getMapBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered MessagingBridge.

       @return MessagingBridge reference or null if a bridge of this type is not registered.
    */
    public final func getMessagingBridge() -> MessagingBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : MessagingBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getMessagingBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getMessagingBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getMessagingBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getMessagingBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered NFCBridge.

       @return NFCBridge reference or null if a bridge of this type is not registered.
    */
    public final func getNFCBridge() -> NFCBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : NFCBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getNFCBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getNFCBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getNFCBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getNFCBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered NetworkInfoBridge.

       @return NetworkInfoBridge reference or null if a bridge of this type is not registered.
    */
    public final func getNetworkInfoBridge() -> NetworkInfoBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : NetworkInfoBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getNetworkInfoBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getNetworkInfoBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getNetworkInfoBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getNetworkInfoBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered NetworkNamingBridge.

       @return NetworkNamingBridge reference or null if a bridge of this type is not registered.
    */
    public final func getNetworkNamingBridge() -> NetworkNamingBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : NetworkNamingBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getNetworkNamingBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getNetworkNamingBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getNetworkNamingBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getNetworkNamingBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered NetworkReachabilityBridge.

       @return NetworkReachabilityBridge reference or null if a bridge of this type is not registered.
    */
    public final func getNetworkReachabilityBridge() -> NetworkReachabilityBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : NetworkReachabilityBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getNetworkReachabilityBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getNetworkReachabilityBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getNetworkReachabilityBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getNetworkReachabilityBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered NetworkStatusBridge.

       @return NetworkStatusBridge reference or null if a bridge of this type is not registered.
    */
    public final func getNetworkStatusBridge() -> NetworkStatusBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : NetworkStatusBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getNetworkStatusBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getNetworkStatusBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getNetworkStatusBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getNetworkStatusBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered NotificationBridge.

       @return NotificationBridge reference or null if a bridge of this type is not registered.
    */
    public final func getNotificationBridge() -> NotificationBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : NotificationBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getNotificationBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getNotificationBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getNotificationBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getNotificationBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered NotificationLocalBridge.

       @return NotificationLocalBridge reference or null if a bridge of this type is not registered.
    */
    public final func getNotificationLocalBridge() -> NotificationLocalBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : NotificationLocalBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getNotificationLocalBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getNotificationLocalBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getNotificationLocalBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getNotificationLocalBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered OAuthBridge.

       @return OAuthBridge reference or null if a bridge of this type is not registered.
    */
    public final func getOAuthBridge() -> OAuthBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : OAuthBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getOAuthBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getOAuthBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getOAuthBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getOAuthBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered OCRBridge.

       @return OCRBridge reference or null if a bridge of this type is not registered.
    */
    public final func getOCRBridge() -> OCRBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : OCRBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getOCRBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getOCRBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getOCRBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getOCRBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered OSBridge.

       @return OSBridge reference or null if a bridge of this type is not registered.
    */
    public final func getOSBridge() -> OSBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : OSBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getOSBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getOSBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getOSBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getOSBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered OpenIdBridge.

       @return OpenIdBridge reference or null if a bridge of this type is not registered.
    */
    public final func getOpenIdBridge() -> OpenIdBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : OpenIdBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getOpenIdBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getOpenIdBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getOpenIdBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getOpenIdBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered PrintingBridge.

       @return PrintingBridge reference or null if a bridge of this type is not registered.
    */
    public final func getPrintingBridge() -> PrintingBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : PrintingBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getPrintingBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getPrintingBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getPrintingBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getPrintingBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered ProximityBridge.

       @return ProximityBridge reference or null if a bridge of this type is not registered.
    */
    public final func getProximityBridge() -> ProximityBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : ProximityBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getProximityBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getProximityBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getProximityBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getProximityBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered QRCodeBridge.

       @return QRCodeBridge reference or null if a bridge of this type is not registered.
    */
    public final func getQRCodeBridge() -> QRCodeBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : QRCodeBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getQRCodeBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getQRCodeBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getQRCodeBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getQRCodeBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered RSSBridge.

       @return RSSBridge reference or null if a bridge of this type is not registered.
    */
    public final func getRSSBridge() -> RSSBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : RSSBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getRSSBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getRSSBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getRSSBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getRSSBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered RuntimeBridge.

       @return RuntimeBridge reference or null if a bridge of this type is not registered.
    */
    public final func getRuntimeBridge() -> RuntimeBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : RuntimeBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getRuntimeBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getRuntimeBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getRuntimeBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getRuntimeBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered SecurityBridge.

       @return SecurityBridge reference or null if a bridge of this type is not registered.
    */
    public final func getSecurityBridge() -> SecurityBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : SecurityBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getSecurityBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getSecurityBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getSecurityBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getSecurityBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered ServiceBridge.

       @return ServiceBridge reference or null if a bridge of this type is not registered.
    */
    public final func getServiceBridge() -> ServiceBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : ServiceBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getServiceBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getServiceBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getServiceBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getServiceBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered SettingsBridge.

       @return SettingsBridge reference or null if a bridge of this type is not registered.
    */
    public final func getSettingsBridge() -> SettingsBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : SettingsBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getSettingsBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getSettingsBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getSettingsBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getSettingsBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered SocketBridge.

       @return SocketBridge reference or null if a bridge of this type is not registered.
    */
    public final func getSocketBridge() -> SocketBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : SocketBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getSocketBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getSocketBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getSocketBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getSocketBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered StoreBridge.

       @return StoreBridge reference or null if a bridge of this type is not registered.
    */
    public final func getStoreBridge() -> StoreBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : StoreBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getStoreBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getStoreBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getStoreBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getStoreBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered TelephonyBridge.

       @return TelephonyBridge reference or null if a bridge of this type is not registered.
    */
    public final func getTelephonyBridge() -> TelephonyBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : TelephonyBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getTelephonyBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getTelephonyBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getTelephonyBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getTelephonyBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered TimerBridge.

       @return TimerBridge reference or null if a bridge of this type is not registered.
    */
    public final func getTimerBridge() -> TimerBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : TimerBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getTimerBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getTimerBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getTimerBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getTimerBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered TwitterBridge.

       @return TwitterBridge reference or null if a bridge of this type is not registered.
    */
    public final func getTwitterBridge() -> TwitterBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : TwitterBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getTwitterBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getTwitterBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getTwitterBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getTwitterBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered UIBridge.

       @return UIBridge reference or null if a bridge of this type is not registered.
    */
    public final func getUIBridge() -> UIBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : UIBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getUIBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getUIBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getUIBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getUIBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered UpdateBridge.

       @return UpdateBridge reference or null if a bridge of this type is not registered.
    */
    public final func getUpdateBridge() -> UpdateBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : UpdateBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getUpdateBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getUpdateBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getUpdateBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getUpdateBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered VibrationBridge.

       @return VibrationBridge reference or null if a bridge of this type is not registered.
    */
    public final func getVibrationBridge() -> VibrationBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : VibrationBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getVibrationBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getVibrationBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getVibrationBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getVibrationBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered VideoBridge.

       @return VideoBridge reference or null if a bridge of this type is not registered.
    */
    public final func getVideoBridge() -> VideoBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : VideoBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getVideoBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getVideoBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getVideoBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getVideoBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered WalletBridge.

       @return WalletBridge reference or null if a bridge of this type is not registered.
    */
    public final func getWalletBridge() -> WalletBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : WalletBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getWalletBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getWalletBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getWalletBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getWalletBridge'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the registered XMLBridge.

       @return XMLBridge reference or null if a bridge of this type is not registered.
    */
    public final func getXMLBridge() -> XMLBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : XMLBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getXMLBridge().")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getXMLBridge()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getXMLBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getXMLBridge'.")
            }
        }
        return result!        
    }

    /**
       Provides a bridge to handle API calls for the given interface name.

       @param bridgeType String with the interface name required.
       @return APIBridge That handles calls for the specified interface or null if the given bridge is not registered.
    */
    public final func getBridge(bridgeType : String) -> APIBridge? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()
        var result : APIBridge? = nil

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getBridge(\(bridgeType)).")
        }

        if (self.delegate != nil) {
            result = self.delegate!.getBridge(bridgeType)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getBridge' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
            }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getBridge'.")
            }
        }
        return result!        
    }

    /**
       Method that returns the API version of the implementation.

       @return API Version string.
       @since ARP1.0
    */
    public func getAPIVersion() -> String? {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getAPIVersion.")
        }

        var result : String? = nil
        if (self.delegate != nil) {
            result = self.delegate!.getAPIVersion()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getAPIVersion' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getAPIVersion'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the Platform Context

       @return Reference to the platform context
       @since ARP1.0
    */
    public func getPlatformContext() -> AppContextBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getPlatformContext.")
        }

        var result : AppContextBridge? = nil
        if (self.delegate != nil) {
            result = self.delegate!.getPlatformContext()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getPlatformContext' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getPlatformContext'.")
            }
        }
        return result!        
    }

    /**
       Returns a reference to the Webview platform context

       @return Reference to the Webview Context
       @since ARP1.0
    */
    public func getPlatformContextWeb() -> AppContextWebviewBridge {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executing getPlatformContextWeb.")
        }

        var result : AppContextWebviewBridge? = nil
        if (self.delegate != nil) {
            result = self.delegate!.getPlatformContextWeb()
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "AppRegistryBridge executed 'getPlatformContextWeb' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "AppRegistryBridge no delegate for 'getPlatformContextWeb'.")
            }
        }
        return result!        
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
