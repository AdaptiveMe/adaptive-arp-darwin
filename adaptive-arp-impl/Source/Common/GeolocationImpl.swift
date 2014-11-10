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
import AdaptiveArpApi


public class GeolocationImpl : NSObject, IGeolocation {
    
    // TODO: in order to work in background, in the plist has to be defined: 
    // <key>UIBackgroundModes</key><array><string>location</string></array>
    
    // TODO: check the functionality on a device.
    // TODO: temporize the updates by a timer
    
    /// Logging variable
    let logger : ILogging = LoggingImpl()
    
    /// Array for saving the registered listeners
    var delegates:[GeolocationDelegate]
    
    /**
    Class constructor
    */
    override init() {
        delegates = [GeolocationDelegate]()
    }
    
    /**
    Register a new listener that will receive geolocation events.
    
    :param: listener listener to be registered.
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func addGeolocationListener(listener : IGeolocationListener) {
        
        // Create a new location manager, add to the list and then initialize the geolocation updates
        var geo: GeolocationDelegate = GeolocationDelegate(listener: listener)
        self.delegates.append(geo)
        geo.initLocationManager()
        
        logger.log(ILoggingLogLevel.DEBUG, category: "GeolocationImpl", message: "Adding listener: \(geo.getListener().toString())")
    }
    
    /**
    De-registers an existing listener from receiving geolocation events.
    
    :param: listener listener listener to be unregistered.
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func removeGeolocationListener(listener : IGeolocationListener) {
        
        for (index,delegate) in enumerate(delegates) {
            
            if delegate.getListener().toString() == listener.toString() {
                
                logger.log(ILoggingLogLevel.DEBUG, category: "GeolocationImpl", message: "Removing listener: \(delegate.getListener().toString())")
                
                // stop the geolocations updates
                delegate.stopUpdatingLocation()
                
                self.delegates.removeAtIndex(index)
            }
        }
    }
    
    /**
    Removed all existing listeners from receiving geolocation events.
    
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func removeGeolocationListeners() {
        
        logger.log(ILoggingLogLevel.DEBUG, category: "GeolocationImpl", message: "Removing all the geolocation listeners")
        
        for (index,delegate) in enumerate(delegates) {
                
            logger.log(ILoggingLogLevel.DEBUG, category: "GeolocationImpl", message: "Removing listener: \(delegate.getListener().toString())")
                
            // stop the geolocations updates
            delegate.stopUpdatingLocation()
                
            self.delegates.removeAtIndex(index)
        }
        
        // Remove all the elements in the array just in case
        self.delegates.removeAll(keepCapacity: false)
    }
}
