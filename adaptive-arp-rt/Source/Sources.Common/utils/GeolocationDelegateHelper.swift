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
import CoreLocation


public class GeolocationDelegateHelper: NSObject, CLLocationManagerDelegate {
    
    /// Logging variable
    let logger: ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge()
    let loggerTag: String = "GeolocationDelegateHelper"
    
    /// Geo location manager
    private let listener: IGeolocationListener!
    
    /// Location manager
    var locationManager: CLLocationManager!
    
    /**
    Class constructor
    
    :param: listener Geolocation listener
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    init(listener: IGeolocationListener) {
        
        self.listener = listener
    }
    
    /**
    Starts the Location Manager
    
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    func initLocationManager() {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        #if os(iOS)
            locationManager.requestAlwaysAuthorization() // The request type for geolocation is always
        #endif
    }
    
    /**
    This delegate method is launched when a update on the geolocation service is fired
    
    :param: manager   Location Manager
    :param: locations Locations
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func locationManager(manager: CLLocationManager, didUpdateLocations locations: [AnyObject]) {
        
        var locationArray = locations as NSArray
        var locationObject = locationArray.lastObject as CLLocation
        var coordinates = locationObject.coordinate
        
        var latitude:Double = coordinates.latitude
        var longitude:Double = coordinates.longitude
        var altitude:Double = locationObject.altitude
        var horizontalAccuracy:Float = Float(locationObject.horizontalAccuracy)
        var verticalAccuracy:Float = Float(locationObject.verticalAccuracy)
        
        var date = NSDate()
        var timestamp:Int64 = Int64(date.timeIntervalSince1970*1000)
        
        // Create a method Geolocation and send ot to the listener
        var geolocation: Geolocation = Geolocation(latitude: latitude, longitude: longitude, altitude: altitude, xDoP: horizontalAccuracy, yDoP: verticalAccuracy, timestamp: timestamp)
        
        logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Updating the geolocation delegate at \(locationObject.timestamp)")
        
        // Fire the listener
        self.listener.onResult(geolocation)
    }
    
    /**
    This delegate method is lanched when an error is produced during the geolocation updates
    
    :param: manager Location manager
    :param: error   Error produced
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "There is an error in the geolocation update service: \(error.description)")
        
        // Stop the geolocation service
        stopUpdatingLocation()
    }
    
    /**
    This delegate method is executed when the location manager trys to access to the geolocation service
    
    :param: manager Location manager
    :param: status  Status of the location manager start
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
                
        switch status {
        case CLAuthorizationStatus.Restricted:
            
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "Restricted Access to location")
            listener.onError(IGeolocationListenerError.RestrictedAccess)
            
        case CLAuthorizationStatus.Denied:
            
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "User denied access to location")
            listener.onError(IGeolocationListenerError.DeniedAccess)
            
        case CLAuthorizationStatus.NotDetermined:
            
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "Status not determined")
            listener.onError(IGeolocationListenerError.StatusNotDetermined)
            
        case CLAuthorizationStatus.Authorized:
            
            NSNotificationCenter.defaultCenter().postNotificationName("LabelHasbeenUpdated", object: nil)
            
            // start the geolocation updates
            locationManager.startUpdatingLocation()
            
            logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Status Authorized")
            
        default:
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "This status: \(status) is not handled by the manager")
        }
        
        #if os(iOS)
        // Special switch for iOS permissions
        switch status {
        case CLAuthorizationStatus.AuthorizedWhenInUse:
            
            NSNotificationCenter.defaultCenter().postNotificationName("LabelHasbeenUpdated", object: nil)
            
            // start the geolocation updates
            locationManager.startUpdatingLocation()
            
            logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Status AuthorizedWhenInUse")
            
        default:
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "This status: \(status) is not handled by the manager")
        }
        #endif
    }
    
    /**
    Method that stops the geolocation updates
    
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func stopUpdatingLocation() {
        
        logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Stopping the geolocation updates of \(self.getListener().description)")
        
        locationManager.stopUpdatingLocation()
    }
    
    /**
    Method that returns the listener of this delegate
    
    :returns: Returns the listener
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func getListener() -> IGeolocationListener {
        
        return self.listener
    }
}