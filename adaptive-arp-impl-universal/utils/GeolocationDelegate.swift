//
//  GeolocationDelegate.swift
//  AdaptiveArpImplIos
//
//  Created by Administrator on 29/09/14.
//  Copyright (c) 2014 Carlos Lozano Diez. All rights reserved.
//

import Foundation
import CoreLocation

public class GeolocationDelegate: NSObject, CLLocationManagerDelegate {
    
    /// Logging variable
    let logger: ILogging = LoggingImpl()
    
    /// Geo location manager
    private let listener: IGeolocationListener
    
    /// Location manager
    var locationManager: CLLocationManager!
    
    /**
    Class constructor
    
    :param: listener Geolocation listener
    */
    init(listener: IGeolocationListener) {
        
        self.listener = listener
    }
    
    func initLocationManager() {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization() // The request type for geolocation is always
    }
    
    /**
    This delegate method is launched when a update on the geolocation service is fired
    
    :param: manager   Location Manager
    :param: locations Locations
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
        
        // Create a method Geolocation and send ot to the listener
        var geolocation: Geolocation = Geolocation(latitude: latitude, longitude: longitude, altitude: altitude, xDoP: horizontalAccuracy, yDoP: verticalAccuracy)
        
        logger.log(ILoggingLogLevel.DEBUG, category: "GeolocationDelegate", message: "Updating the geolocation delegate at \(locationObject.timestamp)")
        
        // Fire the listener
        self.listener.onResult(geolocation)
    }
    
    /**
    This delegate method is lanched when an error is produced during the geolocation updates
    
    :param: manager Location manager
    :param: error   Error produced
    */
    public func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        logger.log(ILoggingLogLevel.ERROR, category: "GeolocationDelegate", message: "There is an error in the geolocation update service: \(error.description)")
        
        // Stop the geolocation service
        stopUpdatingLocation()
    }
    
    /**
    This delegate method is executed when the location manager trys to access to the geolocation service
    
    :param: manager Location manager
    :param: status  Status of the location manager start
    */
    public func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
                
        switch status {
        case CLAuthorizationStatus.Restricted:
            
            logger.log(ILoggingLogLevel.ERROR, category: "GeolocationDelegate", message: "Restricted Access to location")
            
            // TODO: launch the listener with the correspondidng error
            // listener.onError(IGeolocationListenerError.RestrictedAccess)
            
        case CLAuthorizationStatus.Denied:
            
            logger.log(ILoggingLogLevel.ERROR, category: "GeolocationDelegate", message: "User denied access to location")
            
            // TODO: launch the listener with the correspondidng error
            // listener.onError(IGeolocationListenerError.DeniedAccess)
            
        case CLAuthorizationStatus.NotDetermined:
            
            logger.log(ILoggingLogLevel.ERROR, category: "GeolocationDelegate", message: "Status not determined")
            
            // TODO: launch the listener with the correspondidng error
            // listener.onError(IGeolocationListenerError.StatusNotDetermined)
            
        case CLAuthorizationStatus.Authorized, CLAuthorizationStatus.AuthorizedWhenInUse:
            
            NSNotificationCenter.defaultCenter().postNotificationName("LabelHasbeenUpdated", object: nil)
            
            // start the geolocation updates
            locationManager.startUpdatingLocation()
            
        default:
            logger.log(ILoggingLogLevel.ERROR, category: "GeolocationDelegate", message: "This status: \(status) is not handled by the manager")
        }
    }
    
    /**
    Method that stops the geolocation updates
    */
    public func stopUpdatingLocation() {
        
        logger.log(ILoggingLogLevel.DEBUG, category: "GeolocationDelegate", message: "Stopping the geolocation updates of \(self.getListener().toString())")
        
        locationManager.stopUpdatingLocation()
    }
    
    /**
    Method that returns the listener of this delegate
    
    :returns: Returns the listener
    */
    public func getListener() -> IGeolocationListener {
        
        return self.listener
    }
}