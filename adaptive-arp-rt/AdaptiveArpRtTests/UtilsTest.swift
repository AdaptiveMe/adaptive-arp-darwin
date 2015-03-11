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
import XCTest

let logger:ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge()
let loggerTag:String = "TESTING"

/**
*  Contacts callback test implementation. For testing purposes only
*/
class ContactResultCallbackTest: BaseCallbackImpl, IContactResultCallback {
    
    /**
    Contacts callback error function implementation
    
    :param: error Error produced
    */
    func onError(error : IContactResultCallbackError) {
        logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Error obtaining contacts: \(error)")
        XCTAssert(false, "Error obtaining contacts: \(error.toString())")
    }
    
    /**
    Contacts callback result function implementation
    
    :param: contacts List of contacts
    */
    func onResult(contacts : [Contact]) {
        
        logger.log(ILoggingLogLevel.Info, category: loggerTag, message: "Number of contacts: \(contacts.count)")
        
        for contact:Contact in contacts {
            logger.log(ILoggingLogLevel.Info, category: loggerTag, message: " -> Contact Information: \(contact.getContactId()!) - \(contact.getPersonalInfo()!.getName()!) \(contact.getPersonalInfo()!.getLastName()!) [\(contact.getProfessionalInfo()?.getCompany())]")
        }
        XCTAssert(true, "")
    }
    
    /**
    Contacts callback warning function implementation
    
    :param: contacts List of contacts
    :param: warning  Warning description
    */
    func onWarning(contacts : [Contact], warning : IContactResultCallbackWarning) {
        
        logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "Warning: \(warning.toString())")
        logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "Number of contacts: \(contacts.count)")
        for contact:Contact in contacts {
            logger.log(ILoggingLogLevel.Info, category: loggerTag, message: " -> Contact Information: \(contact.getContactId()!) - \(contact.getPersonalInfo()!.getName()!) \(contact.getPersonalInfo()!.getLastName()!) [\(contact.getProfessionalInfo()?.getCompany())]")
        }
        XCTAssert(true, "")
    }
}

/**
*  Database callback test implementation. For testing purposes only
*/
class DatabaseResultCallbackTest: BaseCallbackImpl, IDatabaseResultCallback {
    
    /**
    Database callback error function
    
    :param: error Error description
    */
    func onError(error : IDatabaseResultCallbackError) {
        
        logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Error: \(error)")
        XCTAssert(false, "Error: \(error.toString())")
    }
    
    /**
    Database callback result function
    
    :param: database Populated database with results
    */
    func onResult(database : Database) {
        
        logger.log(ILoggingLogLevel.Info, category: loggerTag, message: "Database: \(database.getName())")
    }
    
    /**
    Database callback warning event
    
    :param: database Populated database with results
    :param: warning  Warning description
    */
    func onWarning(database : Database, warning : IDatabaseResultCallbackWarning) {
        
        logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "Warning: \(warning.toString())")
        logger.log(ILoggingLogLevel.Info, category: loggerTag, message: "Database: \(database.getName())")
    }
}

/**
*  Table callback test implementation. For testing purposes only
*/
class DatabaseTableResultCallbackTest: BaseCallbackImpl, IDatabaseTableResultCallback {
    
    /**
    Table callback error function
    
    :param: error Error description
    */
    func onError(error : IDatabaseTableResultCallbackError) {
        
        logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Error: \(error)")
        XCTAssert(false, "Error: \(error.toString())")
    }
    
    /**
    Table callback result function
    
    :param: table Populated Table
    */
    func onResult(table : DatabaseTable) {
        
        logger.log(ILoggingLogLevel.Info, category: loggerTag, message: "Number of columns: \(table.getColumnCount()), number of rows: \(table.getRowCount())")
        
        if let rows:[DatabaseRow] = table.getDatabaseRows(){
            for row:DatabaseRow in rows {
                logger.log(ILoggingLogLevel.Info, category: loggerTag, message: "Row: \(row.getValues())")
            }
        }
        XCTAssert(true, "")
    }
    
    /**
    Table callback warning
    
    :param: table   Populated table
    :param: warning Warning description
    */
    func onWarning(table : DatabaseTable, warning : IDatabaseTableResultCallbackWarning) {
        
        logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "Warning: \(warning.toString())")
        logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "Number of columns: \(table.getColumnCount()), number of rows: \(table.getRowCount())")
        
        if let rows:[DatabaseRow] = table.getDatabaseRows(){
            for row:DatabaseRow in rows {
                logger.log(ILoggingLogLevel.Info, category: loggerTag, message: "Row: \(row.getValues())")
            }
        }
        XCTAssert(true, "")
    }
}

/**
*  Security callback test implementation. For testing purposes only
*/
class SecurityResultCallbackTest: BaseCallbackImpl, ISecurityResultCallback {
    
    /**
    Security callback error function
    
    :param: error Error description
    */
    func onError(error : ISecurityResultCallbackError) {
        
        logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Error: \(error)")
        XCTAssert(false, "Error: \(error.toString())")
    }
    
    /**
    Security callback result function
    
    :param: keyValues Array of keyvalues
    */
    func onResult(keyValues : [SecureKeyPair]) {
        
        logger.log(ILoggingLogLevel.Info, category: loggerTag, message: "Number of keypairs: \(keyValues.count)")
        
        for pair:SecureKeyPair in keyValues {
            logger.log(ILoggingLogLevel.Info, category: loggerTag, message: "key: \(pair.getSecureKey()), value: \(pair.getSecureData())")
        }
        XCTAssert(true, "")
    }
    
    /**
    Security callback warning
    
    :param: keyValues Array of keyvalues
    :param: warning Warning description
    */
    func onWarning(keyValues : [SecureKeyPair], warning : ISecurityResultCallbackWarning) {
        
        logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "Warning: \(warning.toString())")
        
        
        logger.log(ILoggingLogLevel.Info, category: loggerTag, message: "Number of keypairs: \(keyValues.count)")
        
        for pair:SecureKeyPair in keyValues {
            logger.log(ILoggingLogLevel.Info, category: loggerTag, message: "key: \(pair.getSecureKey()), value: \(pair.getSecureData())")
        }
        XCTAssert(true, "")
    }
}

/**
*  Geolocation listener for testing purposes
*/
class GeolocationListenerTest: BaseListenerImpl, IGeolocationListener {
    
    /**
    Geolocation listener error function
    
    :param: error Error description
    */
    func onError(error : IGeolocationListenerError) {
        logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Error: \(error)")
        XCTAssert(false, "Error: \(error)")
    }
    
    /**
    Geolocation listener for correct results
    
    :param: geolocation Geolocation object with all the information
    */
    func onResult(geolocation : Geolocation) {
        logger.log(ILoggingLogLevel.Info, category: loggerTag, message: "latitude: \(geolocation.getLatitude()), longitude: \(geolocation.getLongitude()), altitude: \(geolocation.getAltitude()), precisionx: \(geolocation.getXDoP()), precisiony: \(geolocation.getYDoP())")
        XCTAssert(true, "")
    }
    
    /**
    Geolocation method for warning results
    
    :param: geolocation Geolocation object with all the information
    :param: warning     Warning description of the event
    */
    func onWarning(geolocation : Geolocation, warning : IGeolocationListenerWarning) {
        
        logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "Warning: \(warning.toString())")
        logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "latitude: \(geolocation.getLatitude()), longitude: \(geolocation.getLongitude()), altitude: \(geolocation.getAltitude()), precisionx: \(geolocation.getXDoP()), precisiony: \(geolocation.getYDoP())")
        XCTAssert(true, "")
    }
}

/**
*  Lifecycle listener for testing purposes
*/
class LilecycleListenerTest: BaseListenerImpl, ILifecycleListener {
    
    /**
    Lifecycle listener error function
    
    :param: error Error description
    */
    func onError(error : ILifecycleListenerError) {
        logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Error: \(error)")
        XCTAssert(false, "Error: \(error)")
    }
    
    /**
    Lifecycle listener for correct results
    
    :param: lifecycle Lifecycle object with all the information
    */
    func onResult(lifecycle : Lifecycle) {
        logger.log(ILoggingLogLevel.Info, category: loggerTag, message: "Lifecycle state: \(lifecycle.getState())")
        XCTAssert(true, "")
    }
    
    /**
    Lifecycle method for warning results
    
    :param: geolocation Geolocation object with all the information
    :param: warning     Warning description of the event
    */
    func onWarning(lifecycle : Lifecycle, warning : ILifecycleListenerWarning) {
        
        logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "Warning: \(warning.toString())")
        logger.log(ILoggingLogLevel.Info, category: loggerTag, message: "Lifecycle state: \(lifecycle.getState())")
        XCTAssert(true, "")
    }
}

/**
*  NetworkStatus listener for testing purposes
*/
class NetworkStatusListenerTest: BaseListenerImpl, INetworkStatusListener {
    
    /**
    NetworkStatus listener error function
    
    :param: error Error description
    */
    func onError(error : INetworkStatusListenerError) {
        logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Error: \(error)")
        XCTAssert(false, "Error: \(error)")
    }
    
    /**
    NetworkStatus listener for correct results
    
    :param: network NetworkStatus object with all the information
    */
    func onResult(network : ICapabilitiesNet) {
        logger.log(ILoggingLogLevel.Info, category: loggerTag, message: "Network type: \(network.toString())")
        XCTAssert(true, "")
    }
    
    /**
    NetworkStatus method for warning results
    
    :param: geolocation Geolocation object with all the information
    :param: warning     Warning description of the event
    */
    func onWarning(network : ICapabilitiesNet, warning : INetworkStatusListenerWarning) {
        
        logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "Warning: \(warning.toString())")
        logger.log(ILoggingLogLevel.Info, category: loggerTag, message: "Network type: \(network.toString())")
        XCTAssert(true, "")
    }
}

/**
*  Acceleration listener for testing purposes
*/
class AccelerationListenerTest: BaseListenerImpl, IAccelerationListener {
    
    /**
    Acceleration listener error function
    
    :param: error Error description
    */
    func onError(error : IAccelerationListenerError) {
        logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Error: \(error)")
        XCTAssert(false, "Error: \(error)")
    }
    
    /**
    Acceleration listener for correct results
    
    :param: acceleration Acceleration object with all the information
    */
    func onResult(acceleration : Acceleration) {
        logger.log(ILoggingLogLevel.Info, category: loggerTag, message: "Acceleration event: \(acceleration.getTimestamp()), x: \(acceleration.getX()), y: \(acceleration.getY()), z: \(acceleration.getZ())")
        XCTAssert(true, "")
    }
    
    /**
    Acceleration method for warning results
    
    :param: geolocation Geolocation object with all the information
    :param: warning     Warning description of the event
    */
    func onWarning(acceleration : Acceleration, warning : IAccelerationListenerWarning) {
        
        logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "Warning: \(warning.toString())")
        logger.log(ILoggingLogLevel.Info, category: loggerTag, message: "Acceleration event: \(acceleration.getTimestamp()), x: \(acceleration.getX()), y: \(acceleration.getY()), z: \(acceleration.getZ())")
        XCTAssert(true, "")
    }
}