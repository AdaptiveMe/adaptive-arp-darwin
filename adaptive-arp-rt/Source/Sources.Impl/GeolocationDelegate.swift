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

/**
   Interface for Managing the Geolocation operations
   Auto-generated implementation of IGeolocation specification.
*/
public class GeolocationDelegate : BaseSensorDelegate, IGeolocation {
    
    /// Logger variable
    let logger : ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge()
    let loggerTag : String = "GeolocationDelegate"
    
    /// Array for saving the registered listeners
    var delegates:[GeolocationDelegateHelper]!

    /**
       Default Constructor.
    */
    public override init() {
        super.init()
        delegates = [GeolocationDelegateHelper]()
    }

    /**
       Register a new listener that will receive geolocation events.

       @param listener to be registered.
       @since ARP1.0
    */
    public func addGeolocationListener(listener : IGeolocationListener) {
        
        // Create a new location manager, add to the list and then initialize the geolocation updates
        var geo:GeolocationDelegateHelper = GeolocationDelegateHelper(listener: listener)
        self.delegates.append(geo)
        geo.initLocationManager()
        
        logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Adding listener: \(geo.getListener())")
    }

    /**
       De-registers an existing listener from receiving geolocation events.

       @param listener to be registered.
       @since ARP1.0
    */
    public func removeGeolocationListener(listener : IGeolocationListener) {
        
        for (index,delegate:GeolocationDelegateHelper) in enumerate(delegates) {
            
            if delegate.getListener().getId() == listener.getId() {
                
                logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Removing listener: \(delegate.getListener())")
                
                // stop the geolocations updates
                delegate.stopUpdatingLocation()
                
                self.delegates.removeAtIndex(index)
            }
        }
    }

    /**
       Removed all existing listeners from receiving geolocation events.

       @since ARP1.0
    */
    public func removeGeolocationListeners() {
        
        logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Removing all the geolocation listeners")
        
        for (index,delegate) in enumerate(delegates) {
            
            logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Removing listener: \(delegate.getListener())")
            
            // stop the geolocations updates
            delegate.stopUpdatingLocation()
            
            self.delegates.removeAtIndex(index)
        }
        
        // Remove all the elements in the array just in case
        self.delegates.removeAll(keepCapacity: false)
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
