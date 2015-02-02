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

    * @version v2.0.2

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation
#if os(iOS)
    import CoreMotion
#endif

/**
   Interface defining methods about the acceleration sensor
   Auto-generated implementation of IAcceleration specification.
*/
public class AccelerationDelegate : BaseSensorDelegate, IAcceleration {
    
    /// Logger variable
    let logger : ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge()
    let loggerTag : String = "AccelerationDelegate"
    
    #if os(iOS)
        var motionManager: CMMotionManager!
        var listeners:[IAccelerationListener]!
    #endif

    /**
       Default Constructor.
    */
    public override init() {
        super.init()
        #if os(iOS)
            motionManager = CMMotionManager()
            listeners = [IAccelerationListener]()
        #endif
    }

    /**
       Register a new listener that will receive acceleration events.

       @param listener to be registered.
       @since ARP1.0
    */
    public func addAccelerationListener(listener : IAccelerationListener) {
        
        #if os(iOS)
            if motionManager.accelerometerAvailable {
                
                // check if listener exists
                for (index, l:IAccelerationListener) in enumerate(listeners) {
                    if listener.getId() == l.getId() {
                        logger.log(ILoggingLogLevel.WARN, category: loggerTag, message: "The listener is alredy on the pull. Replacing...")
                        self.removeAccelerationListener(listener)
                    }
                }
                
                // add the listener
                listeners.append(listener)
                logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Adding \(listener) to the acceleration listeners pull")
                
                let queue = NSOperationQueue()
                
                motionManager.startAccelerometerUpdatesToQueue(
                    queue,
                    withHandler:{(data: CMAccelerometerData!, error: NSError!) in
                        
                        // Create the accelerometer object and send it to the listener
                        
                        var date = NSDate()
                        var timestamp:Int64 = Int64(date.timeIntervalSince1970*1000)
                        
                        var a:Acceleration = Acceleration(x: data.acceleration.x, y: data.acceleration.y, z: data.acceleration.z, timestamp: timestamp)
                        listener.onResult(a)
                    }
                )
            } else {
                logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "The Accelerometer is not available")
                listener.onError(IAccelerationListenerError.Unavailable)
            }
        #endif
        #if os(OSX)
            
            logger.log(ILoggingLogLevel.WARN, category: loggerTag, message: "The Accelerometer is not supported by the current Operating System")
            
        #endif
    }

    /**
       De-registers an existing listener from receiving acceleration events.

       @param listener to be registered.
       @since ARP1.0
    */
    public func removeAccelerationListener(listener : IAccelerationListener) {
        
        #if os(iOS)
            
            for (index, l:IAccelerationListener) in enumerate(listeners) {
                
                if(listener.getId() == l.getId()) {
                    
                    listeners.removeAtIndex(index)
                    
                    logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Removing \(listener) from the listeners pull")
                    
                    return
                }
            }
            
            logger.log(ILoggingLogLevel.WARN, category: loggerTag, message: "\(listener) is not founded in the pull for removing")
            
        #endif
        #if os(OSX)
            
            logger.log(ILoggingLogLevel.WARN, category: loggerTag, message: "The Accelerometer is not supported by the current Operating System")
            
        #endif
        
    }

    /**
       Removed all existing listeners from receiving acceleration events.

       @since ARP1.0
    */
    public func removeAccelerationListeners() {
        
        #if os(iOS)
            
            logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Removing all the acceleration listeners...")
            listeners.removeAll(keepCapacity: false)
            
        #endif
        #if os(OSX)
            
            logger.log(ILoggingLogLevel.WARN, category: loggerTag, message: "The Accelerometer is not supported by the current Operating System")
            
        #endif
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
