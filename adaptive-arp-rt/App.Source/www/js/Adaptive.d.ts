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

    * @version v2.0.3

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/
declare module Adaptive {
    /**
       Global unique id for listeners and callbacks.
    */
    var registeredCounter: number;
    /**
       Base url for for http/https JSON requests.
    */
    var bridgePath: string;
    /**
       Utility class for Dictionary type support.
    */
    interface IDictionary<V> {
        add(key: string, value: V): void;
        remove(key: string): void;
        containsKey(key: string): boolean;
        keys(): string[];
        values(): V[];
    }
    class Dictionary<V> implements IDictionary<V> {
        _keys: string[];
        _values: V[];
        constructor(init: {
            key: string;
            value: V;
        }[]);
        add(key: string, value: V): void;
        remove(key: string): void;
        keys(): string[];
        values(): V[];
        containsKey(key: string): boolean;
        toLookup(): IDictionary<V>;
    }
    /**
       This is a marker interface for bridge classes that invoke delegates.

       @author Carlos Lozano Diez
       @since 1.0
       @version 1.0
    */
    interface APIBridge {
        /**
           Invokes the given method specified in the API request object.
           @param request APIRequest object containing method name and parameters.
           @return Object with JSON response or a zero length string is the response is asynchronous.
        */
        invoke(request: APIRequest): APIResponse;
    }
    /**
       Master interface for all the Groups and Types of Interfaces os the Project

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IAdaptiveRP {
        /**
           Method that returns the API group of the implementation
           @return API Group name.
           @since ARP1.0
        */
        getAPIGroup(): IAdaptiveRPGroup;
        /**
           Method that returns the API version of the implementation.
           @return API Version string.
           @since ARP1.0
        */
        getAPIVersion(): string;
    }
    /**
       Interface to retrieve auto-registered service implementation references.

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IAppRegistry {
        /**
           Returns a reference to the registered AccelerationBridge.

           @return AccelerationBridge reference or null if a bridge of this type is not registered.
        */
        getAccelerationBridge(): IAcceleration;
        /**
           Returns a reference to the registered AdsBridge.

           @return AdsBridge reference or null if a bridge of this type is not registered.
        */
        getAdsBridge(): IAds;
        /**
           Returns a reference to the registered AlarmBridge.

           @return AlarmBridge reference or null if a bridge of this type is not registered.
        */
        getAlarmBridge(): IAlarm;
        /**
           Returns a reference to the registered AmbientLightBridge.

           @return AmbientLightBridge reference or null if a bridge of this type is not registered.
        */
        getAmbientLightBridge(): IAmbientLight;
        /**
           Returns a reference to the registered AnalyticsBridge.

           @return AnalyticsBridge reference or null if a bridge of this type is not registered.
        */
        getAnalyticsBridge(): IAnalytics;
        /**
           Returns a reference to the registered AudioBridge.

           @return AudioBridge reference or null if a bridge of this type is not registered.
        */
        getAudioBridge(): IAudio;
        /**
           Returns a reference to the registered BarcodeBridge.

           @return BarcodeBridge reference or null if a bridge of this type is not registered.
        */
        getBarcodeBridge(): IBarcode;
        /**
           Returns a reference to the registered BarometerBridge.

           @return BarometerBridge reference or null if a bridge of this type is not registered.
        */
        getBarometerBridge(): IBarometer;
        /**
           Returns a reference to the registered BluetoothBridge.

           @return BluetoothBridge reference or null if a bridge of this type is not registered.
        */
        getBluetoothBridge(): IBluetooth;
        /**
           Returns a reference to the registered BrowserBridge.

           @return BrowserBridge reference or null if a bridge of this type is not registered.
        */
        getBrowserBridge(): IBrowser;
        /**
           Returns a reference to the registered CalendarBridge.

           @return CalendarBridge reference or null if a bridge of this type is not registered.
        */
        getCalendarBridge(): ICalendar;
        /**
           Returns a reference to the registered CameraBridge.

           @return CameraBridge reference or null if a bridge of this type is not registered.
        */
        getCameraBridge(): ICamera;
        /**
           Returns a reference to the registered CapabilitiesBridge.

           @return CapabilitiesBridge reference or null if a bridge of this type is not registered.
        */
        getCapabilitiesBridge(): ICapabilities;
        /**
           Returns a reference to the registered CloudBridge.

           @return CloudBridge reference or null if a bridge of this type is not registered.
        */
        getCloudBridge(): ICloud;
        /**
           Returns a reference to the registered CompressionBridge.

           @return CompressionBridge reference or null if a bridge of this type is not registered.
        */
        getCompressionBridge(): ICompression;
        /**
           Returns a reference to the registered ConcurrentBridge.

           @return ConcurrentBridge reference or null if a bridge of this type is not registered.
        */
        getConcurrentBridge(): IConcurrent;
        /**
           Returns a reference to the registered ContactBridge.

           @return ContactBridge reference or null if a bridge of this type is not registered.
        */
        getContactBridge(): IContact;
        /**
           Returns a reference to the registered CryptoBridge.

           @return CryptoBridge reference or null if a bridge of this type is not registered.
        */
        getCryptoBridge(): ICrypto;
        /**
           Returns a reference to the registered DataStreamBridge.

           @return DataStreamBridge reference or null if a bridge of this type is not registered.
        */
        getDataStreamBridge(): IDataStream;
        /**
           Returns a reference to the registered DatabaseBridge.

           @return DatabaseBridge reference or null if a bridge of this type is not registered.
        */
        getDatabaseBridge(): IDatabase;
        /**
           Returns a reference to the registered DesktopBridge.

           @return DesktopBridge reference or null if a bridge of this type is not registered.
        */
        getDesktopBridge(): IDesktop;
        /**
           Returns a reference to the registered DeviceBridge.

           @return DeviceBridge reference or null if a bridge of this type is not registered.
        */
        getDeviceBridge(): IDevice;
        /**
           Returns a reference to the registered DisplayBridge.

           @return DisplayBridge reference or null if a bridge of this type is not registered.
        */
        getDisplayBridge(): IDisplay;
        /**
           Returns a reference to the registered FacebookBridge.

           @return FacebookBridge reference or null if a bridge of this type is not registered.
        */
        getFacebookBridge(): IFacebook;
        /**
           Returns a reference to the registered FileBridge.

           @return FileBridge reference or null if a bridge of this type is not registered.
        */
        getFileBridge(): IFile;
        /**
           Returns a reference to the registered FileSystemBridge.

           @return FileSystemBridge reference or null if a bridge of this type is not registered.
        */
        getFileSystemBridge(): IFileSystem;
        /**
           Returns a reference to the registered GeolocationBridge.

           @return GeolocationBridge reference or null if a bridge of this type is not registered.
        */
        getGeolocationBridge(): IGeolocation;
        /**
           Returns a reference to the registered GlobalizationBridge.

           @return GlobalizationBridge reference or null if a bridge of this type is not registered.
        */
        getGlobalizationBridge(): IGlobalization;
        /**
           Returns a reference to the registered GooglePlusBridge.

           @return GooglePlusBridge reference or null if a bridge of this type is not registered.
        */
        getGooglePlusBridge(): IGooglePlus;
        /**
           Returns a reference to the registered GyroscopeBridge.

           @return GyroscopeBridge reference or null if a bridge of this type is not registered.
        */
        getGyroscopeBridge(): IGyroscope;
        /**
           Returns a reference to the registered ImagingBridge.

           @return ImagingBridge reference or null if a bridge of this type is not registered.
        */
        getImagingBridge(): IImaging;
        /**
           Returns a reference to the registered InternalStorageBridge.

           @return InternalStorageBridge reference or null if a bridge of this type is not registered.
        */
        getInternalStorageBridge(): IInternalStorage;
        /**
           Returns a reference to the registered LifecycleBridge.

           @return LifecycleBridge reference or null if a bridge of this type is not registered.
        */
        getLifecycleBridge(): ILifecycle;
        /**
           Returns a reference to the registered LinkedInBridge.

           @return LinkedInBridge reference or null if a bridge of this type is not registered.
        */
        getLinkedInBridge(): ILinkedIn;
        /**
           Returns a reference to the registered LoggingBridge.

           @return LoggingBridge reference or null if a bridge of this type is not registered.
        */
        getLoggingBridge(): ILogging;
        /**
           Returns a reference to the registered MagnetometerBridge.

           @return MagnetometerBridge reference or null if a bridge of this type is not registered.
        */
        getMagnetometerBridge(): IMagnetometer;
        /**
           Returns a reference to the registered MailBridge.

           @return MailBridge reference or null if a bridge of this type is not registered.
        */
        getMailBridge(): IMail;
        /**
           Returns a reference to the registered ManagementBridge.

           @return ManagementBridge reference or null if a bridge of this type is not registered.
        */
        getManagementBridge(): IManagement;
        /**
           Returns a reference to the registered MapBridge.

           @return MapBridge reference or null if a bridge of this type is not registered.
        */
        getMapBridge(): IMap;
        /**
           Returns a reference to the registered MessagingBridge.

           @return MessagingBridge reference or null if a bridge of this type is not registered.
        */
        getMessagingBridge(): IMessaging;
        /**
           Returns a reference to the registered NFCBridge.

           @return NFCBridge reference or null if a bridge of this type is not registered.
        */
        getNFCBridge(): INFC;
        /**
           Returns a reference to the registered NetworkInfoBridge.

           @return NetworkInfoBridge reference or null if a bridge of this type is not registered.
        */
        getNetworkInfoBridge(): INetworkInfo;
        /**
           Returns a reference to the registered NetworkNamingBridge.

           @return NetworkNamingBridge reference or null if a bridge of this type is not registered.
        */
        getNetworkNamingBridge(): INetworkNaming;
        /**
           Returns a reference to the registered NetworkReachabilityBridge.

           @return NetworkReachabilityBridge reference or null if a bridge of this type is not registered.
        */
        getNetworkReachabilityBridge(): INetworkReachability;
        /**
           Returns a reference to the registered NetworkStatusBridge.

           @return NetworkStatusBridge reference or null if a bridge of this type is not registered.
        */
        getNetworkStatusBridge(): INetworkStatus;
        /**
           Returns a reference to the registered NotificationBridge.

           @return NotificationBridge reference or null if a bridge of this type is not registered.
        */
        getNotificationBridge(): INotification;
        /**
           Returns a reference to the registered NotificationLocalBridge.

           @return NotificationLocalBridge reference or null if a bridge of this type is not registered.
        */
        getNotificationLocalBridge(): INotificationLocal;
        /**
           Returns a reference to the registered OAuthBridge.

           @return OAuthBridge reference or null if a bridge of this type is not registered.
        */
        getOAuthBridge(): IOAuth;
        /**
           Returns a reference to the registered OCRBridge.

           @return OCRBridge reference or null if a bridge of this type is not registered.
        */
        getOCRBridge(): IOCR;
        /**
           Returns a reference to the registered OSBridge.

           @return OSBridge reference or null if a bridge of this type is not registered.
        */
        getOSBridge(): IOS;
        /**
           Returns a reference to the registered OpenIdBridge.

           @return OpenIdBridge reference or null if a bridge of this type is not registered.
        */
        getOpenIdBridge(): IOpenId;
        /**
           Returns a reference to the registered PrintingBridge.

           @return PrintingBridge reference or null if a bridge of this type is not registered.
        */
        getPrintingBridge(): IPrinting;
        /**
           Returns a reference to the registered ProximityBridge.

           @return ProximityBridge reference or null if a bridge of this type is not registered.
        */
        getProximityBridge(): IProximity;
        /**
           Returns a reference to the registered QRCodeBridge.

           @return QRCodeBridge reference or null if a bridge of this type is not registered.
        */
        getQRCodeBridge(): IQRCode;
        /**
           Returns a reference to the registered RSSBridge.

           @return RSSBridge reference or null if a bridge of this type is not registered.
        */
        getRSSBridge(): IRSS;
        /**
           Returns a reference to the registered RuntimeBridge.

           @return RuntimeBridge reference or null if a bridge of this type is not registered.
        */
        getRuntimeBridge(): IRuntime;
        /**
           Returns a reference to the registered SecurityBridge.

           @return SecurityBridge reference or null if a bridge of this type is not registered.
        */
        getSecurityBridge(): ISecurity;
        /**
           Returns a reference to the registered ServiceBridge.

           @return ServiceBridge reference or null if a bridge of this type is not registered.
        */
        getServiceBridge(): IService;
        /**
           Returns a reference to the registered SettingsBridge.

           @return SettingsBridge reference or null if a bridge of this type is not registered.
        */
        getSettingsBridge(): ISettings;
        /**
           Returns a reference to the registered SocketBridge.

           @return SocketBridge reference or null if a bridge of this type is not registered.
        */
        getSocketBridge(): ISocket;
        /**
           Returns a reference to the registered StoreBridge.

           @return StoreBridge reference or null if a bridge of this type is not registered.
        */
        getStoreBridge(): IStore;
        /**
           Returns a reference to the registered TelephonyBridge.

           @return TelephonyBridge reference or null if a bridge of this type is not registered.
        */
        getTelephonyBridge(): ITelephony;
        /**
           Returns a reference to the registered TimerBridge.

           @return TimerBridge reference or null if a bridge of this type is not registered.
        */
        getTimerBridge(): ITimer;
        /**
           Returns a reference to the registered TwitterBridge.

           @return TwitterBridge reference or null if a bridge of this type is not registered.
        */
        getTwitterBridge(): ITwitter;
        /**
           Returns a reference to the registered UIBridge.

           @return UIBridge reference or null if a bridge of this type is not registered.
        */
        getUIBridge(): IUI;
        /**
           Returns a reference to the registered UpdateBridge.

           @return UpdateBridge reference or null if a bridge of this type is not registered.
        */
        getUpdateBridge(): IUpdate;
        /**
           Returns a reference to the registered VibrationBridge.

           @return VibrationBridge reference or null if a bridge of this type is not registered.
        */
        getVibrationBridge(): IVibration;
        /**
           Returns a reference to the registered VideoBridge.

           @return VideoBridge reference or null if a bridge of this type is not registered.
        */
        getVideoBridge(): IVideo;
        /**
           Returns a reference to the registered WalletBridge.

           @return WalletBridge reference or null if a bridge of this type is not registered.
        */
        getWalletBridge(): IWallet;
        /**
           Returns a reference to the registered XMLBridge.

           @return XMLBridge reference or null if a bridge of this type is not registered.
        */
        getXMLBridge(): IXML;
        /**
           Return the API version for the given interface.

           @return {String} The version of the API.
        */
        getAPIVersion(): string;
    }
    /**
       Base application for Application purposes

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IBaseApplication extends IAdaptiveRP {
    }
    /**
       Base application for Callback purposes

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IBaseCallback extends IAdaptiveRP {
        /**
           Retrieve unique id of callback/listener.

           @return Callback/listener unique id.
        */
        getId(): number;
    }
    /**
       Base application for Commerce purposes

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IBaseCommerce extends IAdaptiveRP {
    }
    /**
       Base application for Communication purposes

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IBaseCommunication extends IAdaptiveRP {
    }
    /**
       Base application for Data purposes

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IBaseData extends IAdaptiveRP {
    }
    /**
       Base application for Listener purposes

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IBaseListener extends IAdaptiveRP {
        /**
           Retrieve unique id of callback/listener.

           @return Callback/listener unique id.
        */
        getId(): number;
    }
    /**
       Base application for Media purposes

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IBaseMedia extends IAdaptiveRP {
    }
    /**
       Base application for Notification purposes

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IBaseNotification extends IAdaptiveRP {
    }
    /**
       Base application for PIM purposes

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IBasePIM extends IAdaptiveRP {
    }
    /**
       Base application for Reader purposes

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IBaseReader extends IAdaptiveRP {
    }
    /**
       Base application for Security purposes

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IBaseSecurity extends IAdaptiveRP {
    }
    /**
       Base application for Sensor purposes

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IBaseSensor extends IAdaptiveRP {
    }
    /**
       Base application for Social purposes

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IBaseSocial extends IAdaptiveRP {
    }
    /**
       Base application for System purposes

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IBaseSystem extends IAdaptiveRP {
    }
    /**
       Base application for UI purposes

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IBaseUI extends IAdaptiveRP {
    }
    /**
       Base application for Utility purposes

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IBaseUtil extends IAdaptiveRP {
    }
    /**
       Interface for Analytics purposes

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IAnalytics extends IBaseApplication {
    }
    /**
       Interface for Managing the Globalization results

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    interface IGlobalization extends IBaseApplication {
        /**
           Returns the default locale of the application defined in the configuration file
           @return Default Locale of the application
           @since ARP1.0
        */
        getDefaultLocale(): Locale;
        /**
           List of supported locales for the application defined in the configuration file
           @return List of locales
           @since ARP1.0
        */
        getLocaleSupportedDescriptors(): Locale[];
        /**
           Gets the text/message corresponding to the given key and locale.
           @param key    to match text
           @param locale The locale object to get localized message, or the locale desciptor ("language" or "language-country" two-letters ISO codes.
           @return Localized text.
           @since ARP1.0
        */
        getResourceLiteral(key: string, locale: Locale): string;
        /**
           Gets the full application configured literals (key/message pairs) corresponding to the given locale.
           @param locale The locale object to get localized message, or the locale desciptor ("language" or "language-country" two-letters ISO codes.
           @return Localized texts in the form of an object.
           @since ARP1.0
        */
        getResourceLiterals(locale: Locale): KeyPair[];
    }
    /**
       Interface for Managing the Lifecycle listeners

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface ILifecycle extends IBaseApplication {
        /**
           Add the listener for the lifecycle of the app
           @param listener Lifecycle listener
           @since ARP1.0
        */
        addLifecycleListener(listener: ILifecycleListener): any;
        /**
           Whether the application is in background or not
           @return true if the application is in background;false otherwise
           @since ARP1.0
        */
        isBackground(): boolean;
        /**
           Un-registers an existing listener from receiving lifecycle events.
           @param listener Lifecycle listener
           @since ARP1.0
        */
        removeLifecycleListener(listener: ILifecycleListener): any;
        /**
           Removes all existing listeners from receiving lifecycle events.
           @since ARP1.0
        */
        removeLifecycleListeners(): any;
    }
    /**
       Interface for Managing the Management operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IManagement extends IBaseApplication {
    }
    /**
       Interface for Managing the Printing operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IPrinting extends IBaseApplication {
    }
    /**
       Interface for Managing the Settings operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface ISettings extends IBaseApplication {
    }
    /**
       Interface for Managing the Update operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IUpdate extends IBaseApplication {
    }
    /**
       Interface for Managing the Contact operations

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    interface IContactPhotoResultCallback extends IBaseCallback {
        /**
           This method is called on Error
           @param error returned by the platform
           @since ARP1.0
        */
        onError(error: IContactPhotoResultCallbackError): any;
        /**
           This method is called on Result
           @param contactPhoto returned by the platform
           @since ARP1.0
        */
        onResult(contactPhoto: number[]): any;
        /**
           This method is called on Warning
           @param contactPhoto returned by the platform
           @param warning      returned by the platform
           @since ARP1.0
        */
        onWarning(contactPhoto: number[], warning: IContactPhotoResultCallbackWarning): any;
    }
    /**
       Interface for Managing the Contact operations

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    interface IContactResultCallback extends IBaseCallback {
        /**
           This method is called on Error
           @param error returned by the platform
           @since ARP1.0
        */
        onError(error: IContactResultCallbackError): any;
        /**
           This method is called on Result
           @param contacts returned by the platform
           @since ARP1.0
        */
        onResult(contacts: Contact[]): any;
        /**
           This method is called on Warning
           @param contacts returned by the platform
           @param warning  returned by the platform
           @since ARP1.0
        */
        onWarning(contacts: Contact[], warning: IContactResultCallbackWarning): any;
    }
    /**
       Interface for Managing the Cloud operations

       @author Ferran Vila Conesa
       @since ARP1.0
       @version 1.0
    */
    interface IDatabaseResultCallback extends IBaseCallback {
        /**
           Result callback for error responses
           @param error Returned error
           @since ARP1.0
        */
        onError(error: IDatabaseResultCallbackError): any;
        /**
           Result callback for correct responses
           @param database Returns the database
           @since ARP1.0
        */
        onResult(database: Database): any;
        /**
           Result callback for warning responses
           @param database Returns the database
           @param warning  Returned Warning
           @since ARP1.0
        */
        onWarning(database: Database, warning: IDatabaseResultCallbackWarning): any;
    }
    /**
       Interface for Managing the Cloud operations

       @author Ferran Vila Conesa
       @since ARP1.0
       @version 1.0
    */
    interface IDatabaseTableResultCallback extends IBaseCallback {
        /**
           Result callback for error responses
           @param error Returned error
           @since ARP1.0
        */
        onError(error: IDatabaseTableResultCallbackError): any;
        /**
           Result callback for correct responses
           @param databaseTable Returns the databaseTable
           @since ARP1.0
        */
        onResult(databaseTable: DatabaseTable): any;
        /**
           Result callback for warning responses
           @param databaseTable Returns the databaseTable
           @param warning       Returned Warning
           @since ARP1.0
        */
        onWarning(databaseTable: DatabaseTable, warning: IDatabaseTableResultCallbackWarning): any;
    }
    /**
       Interface for Managing the File loading callback responses

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IFileDataLoadResultCallback extends IBaseCallback {
        /**
           Error processing data retrieval/storage operation.
           @param error Error condition encountered.
           @since ARP1.0
        */
        onError(error: IFileDataLoadResultCallbackError): any;
        /**
           Result of data retrieval operation.
           @param data Data loaded.
           @since ARP1.0
        */
        onResult(data: number[]): any;
        /**
           Result with warning of data retrieval/storage operation.
           @param data    File being loaded.
           @param warning Warning condition encountered.
           @since ARP1.0
        */
        onWarning(data: number[], warning: IFileDataLoadResultCallbackWarning): any;
    }
    /**
       Interface for Managing the File store operations callback

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IFileDataStoreResultCallback extends IBaseCallback {
        /**
           Error processing data retrieval/storage operation.
           @param error Error condition encountered.
           @since ARP1.0
        */
        onError(error: IFileDataStoreResultCallbackError): any;
        /**
           Result of data storage operation.
           @param file File reference to stored data.
           @since ARP1.0
        */
        onResult(file: FileDescriptor): any;
        /**
           Result with warning of data retrieval/storage operation.
           @param file    File being loaded/stored.
           @param warning Warning condition encountered.
           @since ARP1.0
        */
        onWarning(file: FileDescriptor, warning: IFileDataStoreResultCallbackWarning): any;
    }
    /**
       Interface for Managing the File result operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IFileListResultCallback extends IBaseCallback {
        /**
           On error result of a file operation.
           @param error Error processing the request.
           @since ARP1.0
        */
        onError(error: IFileListResultCallbackError): any;
        /**
           On correct result of a file operation.
           @param files Array of resulting files/folders.
           @since ARP1.0
        */
        onResult(files: FileDescriptor[]): any;
        /**
           On partial result of a file operation, containing a warning.
           @param files   Array of resulting files/folders.
           @param warning Warning condition encountered.
           @since ARP1.0
        */
        onWarning(files: FileDescriptor[], warning: IFileListResultCallbackWarning): any;
    }
    /**
       Interface for Managing the File operations callback

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IFileResultCallback extends IBaseCallback {
        /**
           On error result of a file operation.
           @param error Error processing the request.
           @since ARP1.0
        */
        onError(error: IFileResultCallbackError): any;
        /**
           On correct result of a file operation.
           @param storageFile Reference to the resulting file.
           @since ARP1.0
        */
        onResult(storageFile: FileDescriptor): any;
        /**
           On partial result of a file operation, containing a warning.
           @param file    Reference to the offending file.
           @param warning Warning processing the request.
           @since ARP1.0
        */
        onWarning(file: FileDescriptor, warning: IFileResultCallbackWarning): any;
    }
    /**
       Interface for Managing the Messaging responses

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    interface IMessagingCallback extends IBaseCallback {
        /**
           This method is called on Error
           @param error returned by the platform
           @since ARP1.0
        */
        onError(error: IMessagingCallbackError): any;
        /**
           This method is called on Result
           @param success true if sent;false otherwise
           @since ARP1.0
        */
        onResult(success: boolean): any;
        /**
           This method is called on Warning
           @param success true if sent;false otherwise
           @param warning returned by the platform
           @since ARP1.0
        */
        onWarning(success: boolean, warning: IMessagingCallbackWarning): any;
    }
    /**
       Interface for Managing the Network reachability callback result

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface INetworkReachabilityCallback extends IBaseCallback {
        /**
           No data received - error condition, not authorized .
           @param error Error value
           @since ARP1.0
        */
        onError(error: INetworkReachabilityCallbackError): any;
        /**
           Correct data received.
           @param reachable Indicates if the host is reachable
           @since ARP1.0
        */
        onResult(reachable: boolean): any;
        /**
           Data received with warning - ie Found entries with existing key and values have been overriden
           @param reachable Indicates if the host is reachable
           @param warning   Warning value
           @since ARP1.0
        */
        onWarning(reachable: boolean, warning: INetworkReachabilityCallbackWarning): any;
    }
    /**
       Interface for Managing the Security result callback

       @author Aryslan
       @since ARP1.0
       @version 1.0
    */
    interface ISecurityResultCallback extends IBaseCallback {
        /**
           No data received - error condition, not authorized .
           @param error Error values
           @since ARP1.0
        */
        onError(error: ISecurityResultCallbackError): any;
        /**
           Correct data received.
           @param keyValues key and values
           @since ARP1.0
        */
        onResult(keyValues: SecureKeyPair[]): any;
        /**
           Data received with warning - ie Found entries with existing key and values have been overriden
           @param keyValues key and values
           @param warning   Warning values
           @since ARP1.0
        */
        onWarning(keyValues: SecureKeyPair[], warning: ISecurityResultCallbackWarning): any;
    }
    /**
       Interface for Managing the Services operations

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    interface IServiceResultCallback extends IBaseCallback {
        /**
           This method is called on Error
           @param error returned by the platform
           @since ARP1.0
        */
        onError(error: IServiceResultCallbackError): any;
        /**
           This method is called on Result
           @param response data
           @since ARP1.0
        */
        onResult(response: ServiceResponse): any;
        /**
           This method is called on Warning
           @param response data
           @param warning  returned by the platform
           @since ARP1.0
        */
        onWarning(response: ServiceResponse, warning: IServiceResultCallbackWarning): any;
    }
    /**
       Interface for Advertising purposes

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IAds extends IBaseCommerce {
    }
    /**
       Interface for Managing the Store operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IStore extends IBaseCommerce {
    }
    /**
       Interface for Managing the Wallet operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IWallet extends IBaseCommerce {
    }
    /**
       Interface for Bluetooth purposes

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IBluetooth extends IBaseCommunication {
    }
    /**
       Interface for Managing the Network information operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface INetworkInfo extends IBaseCommunication {
    }
    /**
       Interface for Managing the Network naming operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface INetworkNaming extends IBaseCommunication {
    }
    /**
       Interface for Managing the Network reachability operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface INetworkReachability extends IBaseCommunication {
        /**
           Whether there is connectivity to a host, via domain name or ip address, or not.
           @param host     domain name or ip address of host.
           @param callback Callback called at the end.
           @since ARP1.0
        */
        isNetworkReachable(host: string, callback: INetworkReachabilityCallback): any;
        /**
           Whether there is connectivity to an url of a service or not.
           @param url      to look for
           @param callback Callback called at the end
           @since ARP1.0
        */
        isNetworkServiceReachable(url: string, callback: INetworkReachabilityCallback): any;
    }
    /**
       Interface for Managing the Network status

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface INetworkStatus extends IBaseCommunication {
        /**
           Add the listener for network status changes of the app
           @param listener Listener with the result
           @since ARP1.0
        */
        addNetworkStatusListener(listener: INetworkStatusListener): any;
        /**
           Un-registers an existing listener from receiving network status events.
           @param listener Listener with the result
           @since ARP1.0
        */
        removeNetworkStatusListener(listener: INetworkStatusListener): any;
        /**
           Removes all existing listeners from receiving network status events.
           @since ARP1.0
        */
        removeNetworkStatusListeners(): any;
    }
    /**
       Interface for Managing the Services operations

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    interface IService extends IBaseCommunication {
        /**
           Get a reference to a registered service by name.
           @param serviceName Name of service.
           @return A service, if registered, or null of the service does not exist.
           @since ARP1.0
        */
        getService(serviceName: string): Service;
        /**
           Request async a service for an Url
           @param serviceRequest Service Request to invoke
           @param service        Service to call
           @param callback       Callback to execute with the result
           @since ARP1.0
        */
        invokeService(serviceRequest: ServiceRequest, service: Service, callback: IServiceResultCallback): any;
        /**
           Register a new service
           @param service to register
           @since ARP1.0
        */
        registerService(service: Service): any;
        /**
           Unregister all services.
           @since ARP1.0
        */
        unregisterServices(): any;
        /**
           Unregister a service
           @param service to unregister
           @since ARP1.0
        */
        unregisterService(service: Service): any;
        /**
           Check whether a service by the given name is registered.
           @param serviceName Name of service.
           @return True if the service is registered, false otherwise.
           @since ARP1.0
        */
        isRegistered_serviceName(serviceName: string): boolean;
        /**
           Check whether a service by the given name is registered.
           @param serviceName Name of service.
           @return True if the service is registered, false otherwise.
           @since ARP1.0
        */
        isRegistered_service(service: Service): boolean;
    }
    /**
       Interface for Managing the Socket operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface ISocket extends IBaseCommunication {
    }
    /**
       Interface for Managing the Telephony operations

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    interface ITelephony extends IBaseCommunication {
        /**
           Invoke a phone call
           @param number to call
           @return Status of the call
           @since ARP1.0
        */
        call(number: string): ITelephonyStatus;
    }
    /**
       Interface for Managing the Cloud operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface ICloud extends IBaseData {
    }
    /**
       Interface for Managing the DataStream operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IDataStream extends IBaseData {
    }
    /**
       Interface for Managing the Cloud operations

       @author Ferran Vila Conesa
       @since ARP1.0
       @version 1.0
    */
    interface IDatabase extends IBaseData {
        /**
           Creates a database on default path for every platform.
           @param callback Asynchronous callback
           @param database Database object to create
           @since ARP1.0
        */
        createDatabase(database: Database, callback: IDatabaseResultCallback): any;
        /**
           Creates a databaseTable inside a database for every platform.
           @param database      Database for databaseTable creating.
           @param databaseTable DatabaseTable object with the name of the databaseTable inside.
           @param callback      DatabaseTable callback with the response
           @since ARP1.0
        */
        createTable(database: Database, databaseTable: DatabaseTable, callback: IDatabaseTableResultCallback): any;
        /**
           Deletes a database on default path for every platform.
           @param database Database object to delete
           @param callback Asynchronous callback
           @since ARP1.0
        */
        deleteDatabase(database: Database, callback: IDatabaseResultCallback): any;
        /**
           Deletes a databaseTable inside a database for every platform.
           @param database      Database for databaseTable removal.
           @param databaseTable DatabaseTable object with the name of the databaseTable inside.
           @param callback      DatabaseTable callback with the response
           @since ARP1.0
        */
        deleteTable(database: Database, databaseTable: DatabaseTable, callback: IDatabaseTableResultCallback): any;
        /**
           Executes SQL statement into the given database. The replacements
should be passed as a parameter
           @param database     The database object reference.
           @param statement    SQL statement.
           @param replacements List of SQL statement replacements.
           @param callback     DatabaseTable callback with the response.
           @since ARP1.0
        */
        executeSqlStatement(database: Database, statement: string, replacements: string[], callback: IDatabaseTableResultCallback): any;
        /**
           Executes SQL transaction (some statements chain) inside given database.
           @param database     The database object reference.
           @param statements   The statements to be executed during transaction.
           @param rollbackFlag Indicates if rollback should be performed when any
                  statement execution fails.
           @param callback     DatabaseTable callback with the response.
           @since ARP1.0
        */
        executeSqlTransactions(database: Database, statements: string[], rollbackFlag: boolean, callback: IDatabaseTableResultCallback): any;
        /**
           Checks if database exists by given database name.
           @param database Database Object to check if exists
           @return True if exists, false otherwise
           @since ARP1.0
        */
        existsDatabase(database: Database): boolean;
        /**
           Checks if databaseTable exists by given database name.
           @param database      Database for databaseTable consulting.
           @param databaseTable DatabaseTable object with the name of the databaseTable inside.
           @return True if exists, false otherwise
           @since ARP1.0
        */
        existsTable(database: Database, databaseTable: DatabaseTable): boolean;
    }
    /**
       Interface for Managing the File operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IFile extends IBaseData {
        /**
           Determine whether the current file/folder can be read from.
           @param descriptor File descriptor of file or folder used for operation.
           @return True if the folder/file is readable, false otherwise.
           @since ARP1.0
        */
        canRead(descriptor: FileDescriptor): boolean;
        /**
           Determine whether the current file/folder can be written to.
           @param descriptor File descriptor of file or folder used for operation.
           @return True if the folder/file is writable, false otherwise.
           @since ARP1.0
        */
        canWrite(descriptor: FileDescriptor): boolean;
        /**
           Creates a file with the specified name.
           @param descriptor File descriptor of file or folder used for operation.
           @param callback   Result of the operation.
           @since ARP1.0
        */
        create(descriptor: FileDescriptor, callback: IFileResultCallback): any;
        /**
           Deletes the given file or path. If the file is a directory and contains files and or subdirectories, these will be
deleted if the cascade parameter is set to true.
           @param descriptor File descriptor of file or folder used for operation.
           @param cascade    Whether to delete sub-files and sub-folders.
           @return True if files (and sub-files and folders) whether deleted.
           @since ARP1.0
        */
        delete(descriptor: FileDescriptor, cascade: boolean): boolean;
        /**
           Check whether the file/path exists.
           @param descriptor File descriptor of file or folder used for operation.
           @return True if the file exists in the filesystem, false otherwise.
           @since ARP1.0
        */
        exists(descriptor: FileDescriptor): boolean;
        /**
           Loads the content of the file.
           @param descriptor File descriptor of file or folder used for operation.
           @param callback   Result of the operation.
           @since ARP1.0
        */
        getContent(descriptor: FileDescriptor, callback: IFileDataLoadResultCallback): any;
        /**
           Returns the file storage type of the file
           @param descriptor File descriptor of file or folder used for operation.
           @return Storage Type file
           @since ARP1.0
        */
        getFileStorageType(descriptor: FileDescriptor): IFileSystemStorageType;
        /**
           Returns the file type
           @param descriptor File descriptor of file or folder used for operation.
           @return Returns the file type of the file
           @since ARP1.0
        */
        getFileType(descriptor: FileDescriptor): IFileSystemType;
        /**
           Returns the security type of the file
           @param descriptor File descriptor of file or folder used for operation.
           @return Security Level of the file
           @since ARP1.0
        */
        getSecurityType(descriptor: FileDescriptor): IFileSystemSecurity;
        /**
           Check whether this is a path of a file.
           @param descriptor File descriptor of file or folder used for operation.
           @return true if this is a path to a folder/directory, false if this is a path to a file.
           @since ARP1.0
        */
        isDirectory(descriptor: FileDescriptor): boolean;
        /**
           List all the files matching the speficied regex filter within this file/path reference. If the reference
is a file, it will not yield any results.
           @param descriptor File descriptor of file or folder used for operation.
           @param regex      Filter (eg. *.jpg, *.png, Fil*) name string.
           @param callback   Result of operation.
           @since ARP1.0
        */
        listFilesForRegex(descriptor: FileDescriptor, regex: string, callback: IFileListResultCallback): any;
        /**
           List all the files contained within this file/path reference. If the reference is a file, it will not yield
any results.
           @param descriptor File descriptor of file or folder used for operation.
           @param callback   Result of operation.
           @since ARP1.0
        */
        listFiles(descriptor: FileDescriptor, callback: IFileListResultCallback): any;
        /**
           Creates the parent path (or paths, if recursive) to the given file/path if it doesn't already exist.
           @param descriptor File descriptor of file or folder used for operation.
           @param recursive  Whether to create all parent path elements.
           @return True if the path was created, false otherwise (or it exists already).
           @since ARP1.0
        */
        mkDir(descriptor: FileDescriptor, recursive: boolean): boolean;
        /**
           Moves the current file to the given file destination, optionally overwriting and creating the path to the
new destination file.
           @param source      File descriptor of file or folder used for operation as source.
           @param destination File descriptor of file or folder used for operation as destination.
           @param createPath  True to create the path if it does not already exist.
           @param callback    Result of the operation.
           @param overwrite   True to create the path if it does not already exist.
           @since ARP1.0
        */
        move(source: FileDescriptor, destination: FileDescriptor, createPath: boolean, overwrite: boolean, callback: IFileResultCallback): any;
        /**
           Sets the content of the file.
           @param descriptor File descriptor of file or folder used for operation.
           @param content    Binary content to store in the file.
           @param callback   Result of the operation.
           @since ARP1.0
        */
        setContent(descriptor: FileDescriptor, content: number[], callback: IFileDataStoreResultCallback): any;
    }
    /**
       Interface for Managing the File System operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IFileSystem extends IBaseData {
        /**
           Creates a new reference to a new or existing location in the filesystem.
This method does not create the actual file in the specified folder.
           @param parent Parent directory.
           @param name   Name of new file or directory.
           @return A reference to a new or existing location in the filesystem.
           @since ARP1.0
        */
        createFileDescriptor(parent: FileDescriptor, name: string): FileDescriptor;
        /**
           Returns a reference to the cache folder for the current application.
This path must always be writable by the current application.
This path is volatile and may be cleaned by the OS periodically.
           @return Path to the application's cache folder.
           @since ARP1.0
        */
        getApplicationCacheFolder(): FileDescriptor;
        /**
           Returns a reference to the cloud synchronizable folder for the current application.
This path must always be writable by the current application.
           @return Path to the application's cloud storage folder.
           @since ARP1.0
        */
        getApplicationCloudFolder(): FileDescriptor;
        /**
           Returns a reference to the documents folder for the current application.
This path must always be writable by the current application.
           @return Path to the application's documents folder.
           @since ARP1.0
        */
        getApplicationDocumentsFolder(): FileDescriptor;
        /**
           Returns a reference to the application installation folder.
This path may or may not be directly readable or writable - it usually contains the app binary and data.
           @return Path to the application folder.
           @since ARP1.0
        */
        getApplicationFolder(): FileDescriptor;
        /**
           Returns a reference to the protected storage folder for the current application.
This path must always be writable by the current application.
           @return Path to the application's protected storage folder.
           @since ARP1.0
        */
        getApplicationProtectedFolder(): FileDescriptor;
        /**
           Returns the file system dependent file separator.
           @return char with the directory/file separator.
           @since ARP1.0
        */
        getSeparator(): string;
        /**
           Returns a reference to the external storage folder provided by the OS. This may
be an external SSD card or similar. This type of storage is removable and by
definition, not secure.
This path may or may not be writable by the current application.
           @return Path to the application's documents folder.
           @since ARP1.0
        */
        getSystemExternalFolder(): FileDescriptor;
    }
    /**
       Interface for Managing the Internal Storage operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IInternalStorage extends IBaseData {
    }
    /**
       Interface for Managing the XML operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IXML extends IBaseData {
    }
    /**
       Interface defines the response methods of the acceleration operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IAccelerationListener extends IBaseListener {
        /**
           No data received - error condition, not authorized or hardware not available. This will be reported once for the
listener and subsequently, the listener will be deactivated and removed from the internal list of listeners.
           @param error Error fired
           @since ARP1.0
        */
        onError(error: IAccelerationListenerError): any;
        /**
           Correct data received.
           @param acceleration Acceleration received
           @since ARP1.0
        */
        onResult(acceleration: Acceleration): any;
        /**
           Data received with warning - ie. Needs calibration.
           @param acceleration Acceleration received
           @param warning      Warning fired
           @since ARP1.0
        */
        onWarning(acceleration: Acceleration, warning: IAccelerationListenerWarning): any;
    }
    /**
       Interface for Managing the button  operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IButtonListener extends IBaseListener {
        /**
           No data received
           @param error occurred
           @since ARP1.0
        */
        onError(error: IButtonListenerError): any;
        /**
           Called on button pressed
           @param button pressed
           @since ARP1.0
        */
        onResult(button: Button): any;
        /**
           Data received with warning
           @param button  pressed
           @param warning happened
           @since ARP1.0
        */
        onWarning(button: Button, warning: IButtonListenerWarning): any;
    }
    /**
       Interface for Managing the Geolocation results

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    interface IGeolocationListener extends IBaseListener {
        /**
           No data received - error condition, not authorized or hardware not available.
           @param error Type of error encountered during reading.
           @since ARP1.0
        */
        onError(error: IGeolocationListenerError): any;
        /**
           Correct data received.
           @param geolocation Geolocation Bean
           @since ARP1.0
        */
        onResult(geolocation: Geolocation): any;
        /**
           Data received with warning - ie. HighDoP
           @param geolocation Geolocation Bean
           @param warning     Type of warning encountered during reading.
           @since ARP1.0
        */
        onWarning(geolocation: Geolocation, warning: IGeolocationListenerWarning): any;
    }
    /**
       Interface for Managing the Lifecycle listeners

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface ILifecycleListener extends IBaseListener {
        /**
           No data received - error condition, not authorized or hardware not available.
           @param error Type of error encountered during reading.
           @since ARP1.0
        */
        onError(error: ILifecycleListenerError): any;
        /**
           Called when lifecycle changes somehow.
           @param lifecycle Lifecycle element
           @since ARP1.0
        */
        onResult(lifecycle: Lifecycle): any;
        /**
           Data received with warning
           @param lifecycle Lifecycle element
           @param warning   Type of warning encountered during reading.
           @since ARP1.0
        */
        onWarning(lifecycle: Lifecycle, warning: ILifecycleListenerWarning): any;
    }
    /**
       Interface for Managing the Network status listener events

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface INetworkStatusListener extends IBaseListener {
        /**
           No data received - error condition, not authorized or hardware not available.
           @param error Type of error encountered during reading.
           @since ARP1.0
        */
        onError(error: INetworkStatusListenerError): any;
        /**
           Called when network connection changes somehow.
           @param network Change to this network.
           @since ARP1.0
        */
        onResult(network: ICapabilitiesNet): any;
        /**
           Status received with warning
           @param network Change to this network.
           @param warning Type of warning encountered during reading.
           @since ARP1.0
        */
        onWarning(network: ICapabilitiesNet, warning: INetworkStatusListenerWarning): any;
    }
    /**
       Interface for Audio purposes

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IAudio extends IBaseMedia {
    }
    /**
       Interface for Managing the camera operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface ICamera extends IBaseMedia {
    }
    /**
       Interface for Managing the Imaging operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IImaging extends IBaseMedia {
    }
    /**
       Interface for Managing the Video operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IVideo extends IBaseMedia {
        /**
           Play url video stream
           @param url of the video
           @since ARP1.0
        */
        playStream(url: string): any;
    }
    /**
       Interface for Alarm purposes

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IAlarm extends IBaseNotification {
    }
    /**
       Interface for Managing the Notification operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface INotification extends IBaseNotification {
    }
    /**
       Interface for Managing the Local Notifications operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface INotificationLocal extends IBaseNotification {
    }
    /**
       Interface for Managing the Vibration operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IVibration extends IBaseNotification {
    }
    /**
       Interface for Managing the Calendar operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface ICalendar extends IBasePIM {
    }
    /**
       Interface for Managing the Contact operations

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    interface IContact extends IBasePIM {
        /**
           Get the contact photo
           @param contact  id to search for
           @param callback called for return
           @since ARP1.0
        */
        getContactPhoto(contact: ContactUid, callback: IContactPhotoResultCallback): any;
        /**
           Get all the details of a contact according to its id
           @param contact  id to search for
           @param callback called for return
           @since ARP1.0
        */
        getContact(contact: ContactUid, callback: IContactResultCallback): any;
        /**
           Get marked fields of all contacts
           @param callback called for return
           @param fields   to get for each Contact
           @since ARP1.0
        */
        getContactsForFields(callback: IContactResultCallback, fields: IContactFieldGroup[]): any;
        /**
           Get marked fields of all contacts according to a filter
           @param callback called for return
           @param fields   to get for each Contact
           @param filter   to search for
           @since ARP1.0
        */
        getContactsWithFilter(callback: IContactResultCallback, fields: IContactFieldGroup[], filter: IContactFilter[]): any;
        /**
           Get all contacts
           @param callback called for return
           @since ARP1.0
        */
        getContacts(callback: IContactResultCallback): any;
        /**
           Search contacts according to a term with a filter and send it to the callback
           @param term     string to search
           @param callback called for return
           @param filter   to search for
           @since ARP1.0
        */
        searchContactsWithFilter(term: string, callback: IContactResultCallback, filter: IContactFilter[]): any;
        /**
           Search contacts according to a term and send it to the callback
           @param term     string to search
           @param callback called for return
           @since ARP1.0
        */
        searchContacts(term: string, callback: IContactResultCallback): any;
        /**
           Set the contact photo
           @param contact  id to assign the photo
           @param pngImage photo as byte array
           @return true if set is successful;false otherwise
           @since ARP1.0
        */
        setContactPhoto(contact: ContactUid, pngImage: number[]): boolean;
    }
    /**
       Interface for Managing the Mail operations

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    interface IMail extends IBasePIM {
        /**
           Send an Email
           @param data     Payload of the email
           @param callback Result callback of the operation
           @since ARP1.0
        */
        sendEmail(data: Email, callback: IMessagingCallback): any;
    }
    /**
       Interface for Managing the Messaging operations

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    interface IMessaging extends IBasePIM {
        /**
           Send text SMS
           @param number   to send
           @param text     to send
           @param callback with the result
           @since ARP1.0
        */
        sendSMS(number: string, text: string, callback: IMessagingCallback): any;
    }
    /**
       Interface for Barcode Reading purposes

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IBarcode extends IBaseReader {
    }
    /**
       Interface for Managing the NFC operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface INFC extends IBaseReader {
    }
    /**
       Interface for Managing the OCR operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IOCR extends IBaseReader {
    }
    /**
       Interface for Managing the QR Code operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IQRCode extends IBaseReader {
    }
    /**
       Interface for Managing the OAuth operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IOAuth extends IBaseSecurity {
    }
    /**
       Interface for Managing the OpenID operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IOpenId extends IBaseSecurity {
    }
    /**
       Interface for Managing the Security operations

       @author Aryslan
       @since ARP1.0
       @version 1.0
    */
    interface ISecurity extends IBaseSecurity {
        /**
           Deletes from the device internal storage the entry/entries containing the specified key names.
           @param keys             Array with the key names to delete.
           @param publicAccessName The name of the shared internal storage object (if needed).
           @param callback         callback to be executed upon function result.
           @since ARP 1.0
        */
        deleteSecureKeyValuePairs(keys: string[], publicAccessName: string, callback: ISecurityResultCallback): any;
        /**
           Retrieves from the device internal storage the entry/entries containing the specified key names.
           @param keys             Array with the key names to retrieve.
           @param publicAccessName The name of the shared internal storage object (if needed).
           @param callback         callback to be executed upon function result.
           @since ARP 1.0
        */
        getSecureKeyValuePairs(keys: string[], publicAccessName: string, callback: ISecurityResultCallback): any;
        /**
           Returns if the device has been modified in anyhow
           @return true if the device has been modified; false otherwise
           @since ARP1.0
        */
        isDeviceModified(): boolean;
        /**
           Stores in the device internal storage the specified item/s.
           @param keyValues        Array containing the items to store on the device internal memory.
           @param publicAccessName The name of the shared internal storage object (if needed).
           @param callback         callback to be executed upon function result.
           @since ARP 1.0
        */
        setSecureKeyValuePairs(keyValues: SecureKeyPair[], publicAccessName: string, callback: ISecurityResultCallback): any;
    }
    /**
       Interface defining methods about the acceleration sensor

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IAcceleration extends IBaseSensor {
        /**
           Register a new listener that will receive acceleration events.
           @param listener to be registered.
           @since ARP1.0
        */
        addAccelerationListener(listener: IAccelerationListener): any;
        /**
           De-registers an existing listener from receiving acceleration events.
           @param listener to be registered.
           @since ARP1.0
        */
        removeAccelerationListener(listener: IAccelerationListener): any;
        /**
           Removed all existing listeners from receiving acceleration events.
           @since ARP1.0
        */
        removeAccelerationListeners(): any;
    }
    /**
       Interface for managinf the Ambient Light

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IAmbientLight extends IBaseSensor {
    }
    /**
       Interface for Barometer management purposes

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IBarometer extends IBaseSensor {
    }
    /**
       Interface for Managing the Geolocation operations

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    interface IGeolocation extends IBaseSensor {
        /**
           Register a new listener that will receive geolocation events.
           @param listener to be registered.
           @since ARP1.0
        */
        addGeolocationListener(listener: IGeolocationListener): any;
        /**
           De-registers an existing listener from receiving geolocation events.
           @param listener to be registered.
           @since ARP1.0
        */
        removeGeolocationListener(listener: IGeolocationListener): any;
        /**
           Removed all existing listeners from receiving geolocation events.
           @since ARP1.0
        */
        removeGeolocationListeners(): any;
    }
    /**
       Interface for Managing the Giroscope operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IGyroscope extends IBaseSensor {
    }
    /**
       Interface for Managing the Magnetometer operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IMagnetometer extends IBaseSensor {
    }
    /**
       Interface for Managing the Proximity operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IProximity extends IBaseSensor {
    }
    /**
       Interface for Managing the Facebook operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IFacebook extends IBaseSocial {
    }
    /**
       Interface for Managing the Google Plus operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IGooglePlus extends IBaseSocial {
    }
    /**
       Interface for Managing the Linkedin operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface ILinkedIn extends IBaseSocial {
    }
    /**
       Interface for Managing the RSS operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IRSS extends IBaseSocial {
    }
    /**
       Interface for Managing the Twitter operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface ITwitter extends IBaseSocial {
    }
    /**
       Interface for testing the Capabilities operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface ICapabilities extends IBaseSystem {
        /**
           Determines whether a specific hardware button is supported for interaction.
           @param type Type of feature to check.
           @return true is supported, false otherwise.
           @since ARP1.0
        */
        hasButtonSupport(type: ICapabilitiesButton): boolean;
        /**
           Determines whether a specific Communication capability is supported by
the device.
           @param type Type of feature to check.
           @return true if supported, false otherwise.
           @since ARP1.0
        */
        hasCommunicationSupport(type: ICapabilitiesCommunication): boolean;
        /**
           Determines whether a specific Data capability is supported by the device.
           @param type Type of feature to check.
           @return true if supported, false otherwise.
           @since ARP1.0
        */
        hasDataSupport(type: ICapabilitiesData): boolean;
        /**
           Determines whether a specific Media capability is supported by the
device.
           @param type Type of feature to check.
           @return true if supported, false otherwise.
           @since ARP1.0
        */
        hasMediaSupport(type: ICapabilitiesMedia): boolean;
        /**
           Determines whether a specific Net capability is supported by the device.
           @param type Type of feature to check.
           @return true if supported, false otherwise.
           @since ARP1.0
        */
        hasNetSupport(type: ICapabilitiesNet): boolean;
        /**
           Determines whether a specific Notification capability is supported by the
device.
           @param type Type of feature to check.
           @return true if supported, false otherwise.
           @since ARP1.0
        */
        hasNotificationSupport(type: ICapabilitiesNotification): boolean;
        /**
           Determines whether a specific Sensor capability is supported by the
device.
           @param type Type of feature to check.
           @return true if supported, false otherwise.
           @since ARP1.0
        */
        hasSensorSupport(type: ICapabilitiesSensor): boolean;
    }
    /**
       Interface for Managing the Device operations

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    interface IDevice extends IBaseSystem {
        /**
           Register a new listener that will receive button events.
           @param listener to be registered.
           @since ARP1.0
        */
        addButtonListener(listener: IButtonListener): any;
        /**
           Returns the device information for the current device executing the runtime.
           @return DeviceInfo for the current device.
           @since ARP1.0
        */
        getDeviceInfo(): DeviceInfo;
        /**
           Gets the current Locale for the device.
           @return The current Locale information.
           @since ARP1.0
        */
        getLocaleCurrent(): Locale;
        /**
           De-registers an existing listener from receiving button events.
           @param listener to be removed.
           @since ARP1.0
        */
        removeButtonListener(listener: IButtonListener): any;
        /**
           Removed all existing listeners from receiving button events.
           @since ARP1.0
        */
        removeButtonListeners(): any;
    }
    /**
       Interface for Managing the Display operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IDisplay extends IBaseSystem {
    }
    /**
       Interface for Managing the OS operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IOS extends IBaseSystem {
        /**
           Returns the OSInfo for the current operating system.
           @return OSInfo with name, version and vendor of the OS.
           @since ARP1.0
        */
        getOSInfo(): OSInfo;
    }
    /**
       Interface for Managing the Runtime operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IRuntime extends IBaseSystem {
        /**
           Dismiss the current Application
           @since ARP1.0
        */
        dismissApplication(): any;
        /**
           Whether the application dismiss the splash screen successfully or not
           @return true if the application has dismissed the splash screen;false otherwise
           @since ARP1.0
        */
        dismissSplashScreen(): boolean;
    }
    /**
       Interface for Managing the browser operations

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    interface IBrowser extends IBaseUI {
        /**
           Method for opening a URL like a link in the native default browser
           @param url Url to open
           @return The result of the operation
           @since ARP1.0
        */
        openExtenalBrowser(url: string): boolean;
        /**
           Method for opening a browser embedded into the application in a modal window
           @param url            Url to open
           @param title          Title of the Navigation bar
           @param backButtonText Title of the Back button bar
           @return The result of the operation
           @since ARP1.0
        */
        openInternalBrowserModal(url: string, title: string, backButtonText: string): boolean;
        /**
           Method for opening a browser embedded into the application
           @param url            Url to open
           @param title          Title of the Navigation bar
           @param backButtonText Title of the Back button bar
           @return The result of the operation
           @since ARP1.0
        */
        openInternalBrowser(url: string, title: string, backButtonText: string): boolean;
    }
    /**
       Interface for Managing the Desktop operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IDesktop extends IBaseUI {
    }
    /**
       Interface for Managing the Map operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IMap extends IBaseUI {
    }
    /**
       Interface for Managing the UI operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IUI extends IBaseUI {
    }
    /**
       Interface for Managing the Compression operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface ICompression extends IBaseUtil {
    }
    /**
       Interface for Managing the Concurrent operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface IConcurrent extends IBaseUtil {
    }
    /**
       Interface for Managing the Cloud operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface ICrypto extends IBaseUtil {
    }
    /**
       Interface for Managing the Logging operations

       @author Ferran Vila Conesa
       @since ARP1.0
       @version 1.0
    */
    interface ILogging extends IBaseUtil {
        /**
           Logs the given message, with the given log level if specified, to the standard platform/environment.
           @param level    Log level
           @param category Category/tag name to identify/filter the log.
           @param message  Message to be logged
           @since ARP1.0
        */
        log_level_category_message(level: ILoggingLogLevel, category: string, message: string): any;
        /**
           Logs the given message, with the given log level if specified, to the standard platform/environment.
           @param level   Log level
           @param message Message to be logged
           @since ARP1.0
        */
        log_level_message(level: ILoggingLogLevel, message: string): any;
    }
    /**
       Interface for Managing the Timer operations

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    interface ITimer extends IBaseUtil {
    }
    /**
       Structure representing a native response to the HTML5

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    class APIBean {
        /**
           Default constructor

           @since ARP1.0
        */
        constructor();
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): APIBean;
    }
    /**
       Structure representing a HTML5 request to the native API.

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    class APIRequest {
        /**
           Identifier of callback or listener for async operations.
        */
        asyncId: number;
        /**
           String representing the bridge type to obtain.
        */
        bridgeType: string;
        /**
           String representing the method name to call.
        */
        methodName: string;
        /**
           Parameters of the request as JSON formatted strings.
        */
        parameters: string[];
        /**
           Constructor with all the parameters

           @param bridgeType Name of the bridge to be invoked.
           @param methodName Name of the method
           @param parameters Array of parameters as JSON formatted strings.
           @param asyncId    Id of callback or listener or zero if none for synchronous calls.
           @since ARP1.0
        */
        constructor(bridgeType: string, methodName: string, parameters: string[], asyncId: number);
        /**
           Returns the callback or listener id assigned to this request OR zero if there is no associated callback or
listener.

           @return long with the unique id of the callback or listener, or zero if there is no associated async event.
        */
        getAsyncId(): number;
        /**
           Sets the callback or listener id to the request.

           @param asyncId The unique id of the callback or listener.
        */
        setAsyncId(asyncId: number): void;
        /**
           Bridge Type Getter

           @return Bridge Type
           @since ARP1.0
        */
        getBridgeType(): string;
        /**
           Bridge Type Setter

           @param bridgeType Bridge Type
           @since ARP1.0
        */
        setBridgeType(bridgeType: string): void;
        /**
           Method name Getter

           @return Method name
           @since ARP1.0
        */
        getMethodName(): string;
        /**
           Method name Setter

           @param methodName Method name
           @since ARP1.0
        */
        setMethodName(methodName: string): void;
        /**
           Parameters Getter

           @return Parameters
           @since ARP1.0
        */
        getParameters(): string[];
        /**
           Parameters Setter

           @param parameters Parameters, JSON formatted strings of objects.
           @since ARP1.0
        */
        setParameters(parameters: string[]): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): APIRequest;
    }
    /**
       Structure representing a JSON response to the HTML5 layer.

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    class APIResponse {
        /**
           String representing the JavaScript value or JSON object representation of the response.
        */
        response: string;
        /**
           Status code of the response
        */
        statusCode: number;
        /**
           Status message of the response
        */
        statusMessage: string;
        /**
           Constructor with parameters.

           @param response      String representing the JavaScript value or JSON object representation of the response.
           @param statusCode    Status code of the response (200 = OK, others are warning or error conditions).
           @param statusMessage Status message of the response.
        */
        constructor(response: string, statusCode: number, statusMessage: string);
        /**
           Response getter

           @return String representing the JavaScript value or JSON object representation of the response.
           @since ARP1.0
        */
        getResponse(): string;
        /**
           Response setter

           @param response String representing the JavaScript value or JSON object representation of the response.
        */
        setResponse(response: string): void;
        /**
           Status code getter

           @return Status code of the response (200 = OK, others are warning or error conditions).
        */
        getStatusCode(): number;
        /**
           Status code setter

           @param statusCode Status code of the response  (200 = OK, others are warning or error conditions).
        */
        setStatusCode(statusCode: number): void;
        /**
           Status message getter

           @return Status message of the response.
        */
        getStatusMessage(): string;
        /**
           Status message setter.

           @param statusMessage Status message of the response
        */
        setStatusMessage(statusMessage: string): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): APIResponse;
    }
    /**
       Structure representing the data of a single acceleration reading.

       @author Carlos Lozano Diez
       @since ARP1.0
       @version 1.0
    */
    class Acceleration extends APIBean {
        /**
           Timestamp of the acceleration reading.
        */
        timestamp: number;
        /**
           X-axis component of the acceleration.
        */
        x: number;
        /**
           Y-axis component of the acceleration.
        */
        y: number;
        /**
           Z-axis component of the acceleration.
        */
        z: number;
        /**
           Constructor with fields

           @param x         X Coordinate
           @param y         Y Coordinate
           @param z         Z Coordinate
           @param timestamp Timestamp
           @since ARP1.0
        */
        constructor(x: number, y: number, z: number, timestamp: number);
        /**
           Timestamp Getter

           @return Timestamp
           @since ARP1.0
        */
        getTimestamp(): number;
        /**
           Timestamp Setter

           @param timestamp Timestamp
           @since ARP1.0
        */
        setTimestamp(timestamp: number): void;
        /**
           X Coordinate Getter

           @return X-axis component of the acceleration.
           @since ARP1.0
        */
        getX(): number;
        /**
           X Coordinate Setter

           @param x X-axis component of the acceleration.
           @since ARP1.0
        */
        setX(x: number): void;
        /**
           Y Coordinate Getter

           @return Y-axis component of the acceleration.
           @since ARP1.0
        */
        getY(): number;
        /**
           Y Coordinate Setter

           @param y Y-axis component of the acceleration.
           @since ARP1.0
        */
        setY(y: number): void;
        /**
           Z Coordinate Getter

           @return Z-axis component of the acceleration.
           @since ARP1.0
        */
        getZ(): number;
        /**
           Z Coordinate Setter

           @param z Z Coordinate
           @since ARP1.0
        */
        setZ(z: number): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): Acceleration;
    }
    /**
       Structure representing the a physical or logical button on a device.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    class Button extends APIBean {
        /**
           Button type
        */
        type: ICapabilitiesButton;
        /**
           Constructor with fields

           @param type Button type.
           @since ARP1.0
        */
        constructor(type: ICapabilitiesButton);
        /**
           Returns the button type

           @return type Button type.
           @since ARP1.0
        */
        getType(): ICapabilitiesButton;
        /**
           Setter for the button type

           @param type Button Type
           @since ARP1.0
        */
        setType(type: ICapabilitiesButton): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): Button;
    }
    /**
       Structure representing the address data elements of a contact.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    class ContactAddress extends APIBean {
        /**
           The address type
        */
        type: ContactAddressType;
        /**
           The Contact address
        */
        address: string;
        /**
           Constructor with fields

           @param address Address data.
           @param type    Address type.
           @since ARP1.0
        */
        constructor(address: string, type: ContactAddressType);
        /**
           Returns the type of the address

           @return AddressType Address type.
           @since ARP1.0
        */
        getType(): ContactAddressType;
        /**
           Set the address type

           @param type Address type.
           @since ARP1.0
        */
        setType(type: ContactAddressType): void;
        /**
           Returns the Contact address

           @return address Address data.
           @since ARP1.0
        */
        getAddress(): string;
        /**
           Set the address of the Contact

           @param address Address data.
           @since ARP1.0
        */
        setAddress(address: string): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): ContactAddress;
    }
    /**
       Structure representing the email data elements of a contact.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    class ContactEmail extends APIBean {
        /**
           The type of the email
        */
        type: ContactEmailType;
        /**
           Email of the Contact
        */
        email: string;
        /**
           Whether the email is the primary one or not
        */
        primary: boolean;
        /**
           Constructor used by the implementation

           @param type    Type of the email
           @param primary Is email primary
           @param email   Email of the contact
           @since ARP1.0
        */
        constructor(type: ContactEmailType, primary: boolean, email: string);
        /**
           Returns the type of the email

           @return EmailType
           @since ARP1.0
        */
        getType(): ContactEmailType;
        /**
           Set the type of the email

           @param type Type of the email
           @since ARP1.0
        */
        setType(type: ContactEmailType): void;
        /**
           Returns the email of the Contact

           @return email
           @since ARP1.0
        */
        getEmail(): string;
        /**
           Set the email of the Contact

           @param email Email of the contact
           @since ARP1.0
        */
        setEmail(email: string): void;
        /**
           Returns if the email is primary

           @return true if the email is primary; false otherwise
           @since ARP1.0
        */
        getPrimary(): boolean;
        /**
           Set if the email

           @param primary true if the email is primary; false otherwise
           @since ARP1.0
        */
        setPrimary(primary: boolean): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): ContactEmail;
    }
    /**
       Structure representing the personal info data elements of a contact.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    class ContactPersonalInfo extends APIBean {
        /**
           The title of the Contact
        */
        title: ContactPersonalInfoTitle;
        /**
           The last name of the Contact
        */
        lastName: string;
        /**
           The middle name of the Contact if it proceeds
        */
        middleName: string;
        /**
           The name of the Contact
        */
        name: string;
        /**
           The Constructor used by the implementation

           @param name       of the Contact
           @param middleName of the Contact
           @param lastName   of the Contact
           @param title      of the Contact
           @since ARP1.0
        */
        constructor(name: string, middleName: string, lastName: string, title: ContactPersonalInfoTitle);
        /**
           Returns the title of the Contact

           @return Title
           @since ARP1.0
        */
        getTitle(): ContactPersonalInfoTitle;
        /**
           Set the Title of the Contact

           @param title of the Contact
           @since ARP1.0
        */
        setTitle(title: ContactPersonalInfoTitle): void;
        /**
           Returns the last name of the Contact

           @return lastName
           @since ARP1.0
        */
        getLastName(): string;
        /**
           Set the last name of the Contact

           @param lastName of the Contact
           @since ARP1.0
        */
        setLastName(lastName: string): void;
        /**
           Returns the middle name of the Contact

           @return middelName
           @since ARP1.0
        */
        getMiddleName(): string;
        /**
           Set the middle name of the Contact

           @param middleName of the Contact
           @since ARP1.0
        */
        setMiddleName(middleName: string): void;
        /**
           Returns the name of the Contact

           @return name
           @since ARP1.0
        */
        getName(): string;
        /**
           Set the name of the Contact

           @param name of the Contact
           @since ARP1.0
        */
        setName(name: string): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): ContactPersonalInfo;
    }
    /**
       Structure representing the phone data elements of a contact.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    class ContactPhone extends APIBean {
        /**
           The phone number phoneType
        */
        phoneType: ContactPhoneType;
        /**
           The phone number
        */
        phone: string;
        /**
           Constructor used by implementation to set the contact Phone

           @param phone     Phone number
           @param phoneType Type of Phone number
           @since ARP1.0
        */
        constructor(phone: string, phoneType: ContactPhoneType);
        /**
           Returns the phone phoneType

           @return phoneType
           @since ARP1.0
        */
        getPhoneType(): ContactPhoneType;
        /**
           Set the phoneType of the phone number

           @param phoneType Type of Phone number
           @since ARP1.0
        */
        setPhoneType(phoneType: ContactPhoneType): void;
        /**
           Returns the phone number

           @return phone number
           @since ARP1.0
        */
        getPhone(): string;
        /**
           Set the phone number

           @param phone number
           @since ARP1.0
        */
        setPhone(phone: string): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): ContactPhone;
    }
    /**
       Structure representing the professional info data elements of a contact.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    class ContactProfessionalInfo extends APIBean {
        /**
           The company of the job
        */
        company: string;
        /**
           The job description
        */
        jobDescription: string;
        /**
           The job title
        */
        jobTitle: string;
        /**
           Constructor used by implementation to set the ContactProfessionalInfo.

           @param jobTitle       The job title
           @param jobDescription The job description
           @param company        The company of the job
           @since ARP1.0
        */
        constructor(jobTitle: string, jobDescription: string, company: string);
        /**
           Returns the company of the job

           @return company
           @since ARP1.0
        */
        getCompany(): string;
        /**
           Set the company of the job

           @param company The company of the job
           @since ARP1.0
        */
        setCompany(company: string): void;
        /**
           Returns the description of the job

           @return description
           @since ARP1.0
        */
        getJobDescription(): string;
        /**
           Set the description of the job

           @param jobDescription The job description
           @since ARP1.0
        */
        setJobDescription(jobDescription: string): void;
        /**
           Returns the title of the job

           @return title
           @since ARP1.0
        */
        getJobTitle(): string;
        /**
           Set the title of the job

           @param jobTitle The job title
           @since ARP1.0
        */
        setJobTitle(jobTitle: string): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): ContactProfessionalInfo;
    }
    /**
       Structure representing the social data elements of a contact.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    class ContactSocial extends APIBean {
        /**
           The social network
        */
        socialNetwork: ContactSocialNetwork;
        /**
           The profileUrl
        */
        profileUrl: string;
        /**
           Constructor used by the implementation

           @param socialNetwork of the profile
           @param profileUrl    of the user
           @since ARP1.0
        */
        constructor(socialNetwork: ContactSocialNetwork, profileUrl: string);
        /**
           Returns the social network

           @return socialNetwork
           @since ARP1.0
        */
        getSocialNetwork(): ContactSocialNetwork;
        /**
           Set the social network

           @param socialNetwork of the profile
           @since ARP1.0
        */
        setSocialNetwork(socialNetwork: ContactSocialNetwork): void;
        /**
           Returns the profile url of the user

           @return profileUrl
           @since ARP1.0
        */
        getProfileUrl(): string;
        /**
           Set the profile url of the iser

           @param profileUrl of the user
           @since ARP1.0
        */
        setProfileUrl(profileUrl: string): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): ContactSocial;
    }
    /**
       Structure representing the assigned tags data elements of a contact.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    class ContactTag extends APIBean {
        /**
           The tagName of the Tag
        */
        tagName: string;
        /**
           The tagValue of the Tag
        */
        tagValue: string;
        /**
           Constructor used by the implementation

           @param tagValue Value of the tag
           @param tagName  Name of the tag
           @since ARP1.0
        */
        constructor(tagName: string, tagValue: string);
        /**
           Returns the tagName of the Tag

           @return tagName
           @since ARP1.0
        */
        getTagName(): string;
        /**
           Set the tagName of the Tag

           @param tagName Name of the tag
           @since ARP1.0
        */
        setTagName(tagName: string): void;
        /**
           Returns the tagValue of the Tag

           @return tagValue
           @since ARP1.0
        */
        getTagValue(): string;
        /**
           Set the tagValue of the Tag

           @param tagValue Value of the tag
           @since ARP1.0
        */
        setTagValue(tagValue: string): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): ContactTag;
    }
    /**
       Structure representing the internal unique identifier data elements of a contact.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    class ContactUid extends APIBean {
        /**
           The id of the Contact
        */
        contactId: string;
        /**
           Constructor used by implementation to set the Contact id.

           @param contactId Internal unique contact id.
           @since ARP1.0
        */
        constructor(contactId: string);
        /**
           Returns the contact id

           @return Contactid Internal unique contact id.
           @since ARP1.0
        */
        getContactId(): string;
        /**
           Set the id of the Contact

           @param contactId Internal unique contact id.
           @since ARP1.0
        */
        setContactId(contactId: string): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): ContactUid;
    }
    /**
       Structure representing the website data elements of a contact.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    class ContactWebsite extends APIBean {
        /**
           The url of the website
        */
        url: string;
        /**
           Constructor used by the implementation

           @param url Url of the website
           @since ARP1.0
        */
        constructor(url: string);
        /**
           Returns the url of the website

           @return website url
           @since ARP1.0
        */
        getUrl(): string;
        /**
           Set the url of the website

           @param url Url of the website
           @since ARP1.0
        */
        setUrl(url: string): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): ContactWebsite;
    }
    /**
       Structure representing a database reference.

       @author Ferran Vila Conesa
       @since ARP1.0
       @version 1.0
    */
    class Database extends APIBean {
        /**
           Indicates if database was created or needs to be created as Compressed.
        */
        compress: boolean;
        /**
           Database Name (name of the .db local file).
        */
        name: string;
        /**
           Constructor using fields.

           @param name     Name of the DatabaseTable.
           @param compress Compression enabled.
           @since ARP1.0
        */
        constructor(name: string, compress: boolean);
        /**
           Returns if the table is compressed

           @return Compression enabled
           @since ARP1.0
        */
        getCompress(): boolean;
        /**
           Sets if the table is compressed or not.

           @param compress Compression enabled
           @since ARP1.0
        */
        setCompress(compress: boolean): void;
        /**
           Returns the name.

           @return The name of the table.
           @since ARP1.0
        */
        getName(): string;
        /**
           Sets the name of the table.

           @param name The name of the table.
           @since ARP1.0
        */
        setName(name: string): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): Database;
    }
    /**
       Structure representing the column specification of a data column.

       @author Ferran Vila Conesa
       @since ARP1.0
       @version 1.0
    */
    class DatabaseColumn extends APIBean {
        /**
           Name of the column
        */
        name: string;
        /**
           Constructor with fields

           @param name Name of the column
           @since ARP1.0
        */
        constructor(name: string);
        /**
           Returns the name of the column.

           @return The name of the column.
           @since ARP1.0
        */
        getName(): string;
        /**
           Sets the name of the column.

           @param name The name of the column.
           @since ARP1.0
        */
        setName(name: string): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): DatabaseColumn;
    }
    /**
       Structure representing a row for a data table.

       @author Ferran Vila Conesa
       @since ARP1.0
       @version 1.0
    */
    class DatabaseRow extends APIBean {
        /**
           The values of the row.
        */
        values: string[];
        /**
           Constructor for implementation using.

           @param values The values of the row
           @since ARP1.0
        */
        constructor(values: string[]);
        /**
           Returns the values of the row.

           @return The values of the row.
           @since ARP1.0
        */
        getValues(): string[];
        /**
           Sets the values of the row.

           @param values The values of the row.
           @since ARP1.0
        */
        setValues(values: string[]): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): DatabaseRow;
    }
    /**
       Represents a data table composed of databaseColumns and databaseRows.

       @author Ferran Vila Conesa
       @since ARP1.0
       @version 1.0
    */
    class DatabaseTable extends APIBean {
        /**
           Number of databaseColumns.
        */
        columnCount: number;
        /**
           Definition of databaseColumns.
        */
        databaseColumns: DatabaseColumn[];
        /**
           Rows of the table containing the data.
        */
        databaseRows: DatabaseRow[];
        /**
           Name of the table.
        */
        name: string;
        /**
           Number of databaseRows.
        */
        rowCount: number;
        /**
           Constructor using fields

           @param name            The name of the table
           @param columnCount     The number of databaseColumns
           @param rowCount        The number of databaseRows
           @param databaseColumns The databaseColumns of the table
           @param databaseRows    The databaseRows of the table
           @since ARP1.0
        */
        constructor(name: string, columnCount: number, rowCount: number, databaseColumns: DatabaseColumn[], databaseRows: DatabaseRow[]);
        /**
           Get the number of databaseColumns

           @return The number of databaseColumns
           @since ARP1.0
        */
        getColumnCount(): number;
        /**
           Sets the number of databaseColumns

           @param columnCount The number of databaseColumns
           @since ARP1.0
        */
        setColumnCount(columnCount: number): void;
        /**
           Get the databaseColumns

           @return The databaseColumns
           @since ARP1.0
        */
        getDatabaseColumns(): DatabaseColumn[];
        /**
           Sets the databaseColumns of the table

           @param databaseColumns The databaseColumns of the table
           @since ARP1.0
        */
        setDatabaseColumns(databaseColumns: DatabaseColumn[]): void;
        /**
           Get the databaseRows of the table

           @return The databaseRows of the table
           @since ARP1.0
        */
        getDatabaseRows(): DatabaseRow[];
        /**
           Sets the databaseRows of the table

           @param databaseRows The databaseRows of the table
           @since ARP1.0
        */
        setDatabaseRows(databaseRows: DatabaseRow[]): void;
        /**
           Returns the name of the table

           @return The name of the table
           @since ARP1.0
        */
        getName(): string;
        /**
           Sets the name of the table

           @param name The name of the table
           @since ARP1.0
        */
        setName(name: string): void;
        /**
           Get the number of databaseRows

           @return The number of databaseRows
           @since ARP1.0
        */
        getRowCount(): number;
        /**
           Sets the number of databaseRows

           @param rowCount The number of databaseRows
           @since ARP1.0
        */
        setRowCount(rowCount: number): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): DatabaseTable;
    }
    /**
       Structure representing the basic device information.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    class DeviceInfo extends APIBean {
        /**
           Model of device - equivalent to device release or version.
        */
        model: string;
        /**
           Name of device - equivalent to brand.
        */
        name: string;
        /**
           Device identifier - this may not be unique for a device. It may depend on the platform implementation and may
be unique for a specific instance of an application on a specific device.
        */
        uuid: string;
        /**
           Vendor of the device hardware.
        */
        vendor: string;
        /**
           Constructor for the implementation of the platform.

           @param name   or brand of the device.
           @param model  of the device.
           @param vendor of the device.
           @param uuid   unique* identifier (* platform dependent).
           @since ARP1.0
        */
        constructor(name: string, model: string, vendor: string, uuid: string);
        /**
           Returns the model of the device.

           @return String with the model of the device.
           @since ARP1.0
        */
        getModel(): string;
        /**
           Sets Model of device - equivalent to device release or version.

           @param model Model of device - equivalent to device release or version.
        */
        setModel(model: string): void;
        /**
           Returns the name of the device.

           @return String with device name.
           @since ARP1.0
        */
        getName(): string;
        /**
           Sets Name of device - equivalent to brand.

           @param name Name of device - equivalent to brand.
        */
        setName(name: string): void;
        /**
           Returns the platform dependent UUID of the device.

           @return String with the 128-bit device identifier.
           @since ARP1.0
        */
        getUuid(): string;
        /**
           Sets Device identifier - this may not be unique for a device. It may depend on the platform implementation and may
be unique for a specific instance of an application on a specific device.

           @param uuid Device identifier - this may not be unique for a device. It may depend on the platform implementation and may
be unique for a specific instance of an application on a specific device.
        */
        setUuid(uuid: string): void;
        /**
           Returns the vendor of the device.

           @return String with the vendor name.
           @since ARP1.0
        */
        getVendor(): string;
        /**
           Sets Vendor of the device hardware.

           @param vendor Vendor of the device hardware.
        */
        setVendor(vendor: string): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): DeviceInfo;
    }
    /**
       Structure representing the data elements of an email.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    class Email extends APIBean {
        /**
           Array of Email Blind Carbon Copy recipients
        */
        bccRecipients: EmailAddress[];
        /**
           Array of Email Carbon Copy recipients
        */
        ccRecipients: EmailAddress[];
        /**
           Array of attatchments
        */
        emailAttachmentData: EmailAttachmentData[];
        /**
           Message body
        */
        messageBody: string;
        /**
           Message body mime type
        */
        messageBodyMimeType: string;
        /**
           Subject of the email
        */
        subject: string;
        /**
           Array of Email recipients
        */
        toRecipients: EmailAddress[];
        /**
           Constructor used by the implementation

           @param toRecipients        array of recipients
           @param ccRecipients        array of cc recipients
           @param bccRecipients       array of bcc recipients
           @param emailAttachmentData array of attatchments
           @param messageBody         body of the email
           @param messageBodyMimeType mime type of the body
           @param subject             of the email
           @since ARP1.0
        */
        constructor(toRecipients: EmailAddress[], ccRecipients: EmailAddress[], bccRecipients: EmailAddress[], emailAttachmentData: EmailAttachmentData[], messageBody: string, messageBodyMimeType: string, subject: string);
        /**
           Returns the array of recipients

           @return bccRecipients array of bcc recipients
           @since ARP1.0
        */
        getBccRecipients(): EmailAddress[];
        /**
           Set the array of recipients

           @param bccRecipients array of bcc recipients
           @since ARP1.0
        */
        setBccRecipients(bccRecipients: EmailAddress[]): void;
        /**
           Returns the array of recipients

           @return ccRecipients array of cc recipients
           @since ARP1.0
        */
        getCcRecipients(): EmailAddress[];
        /**
           Set the array of recipients

           @param ccRecipients array of cc recipients
           @since ARP1.0
        */
        setCcRecipients(ccRecipients: EmailAddress[]): void;
        /**
           Returns an array of attachments

           @return emailAttachmentData array with the email attachments
           @since ARP1.0
        */
        getEmailAttachmentData(): EmailAttachmentData[];
        /**
           Set the email attachment data array

           @param emailAttachmentData array of email attatchments
           @since ARP1.0
        */
        setEmailAttachmentData(emailAttachmentData: EmailAttachmentData[]): void;
        /**
           Returns the message body of the email

           @return message Body string of the email
           @since ARP1.0
        */
        getMessageBody(): string;
        /**
           Set the message body of the email

           @param messageBody message body of the email
           @since ARP1.0
        */
        setMessageBody(messageBody: string): void;
        /**
           Returns the myme type of the message body

           @return mime type string of the message boddy
           @since ARP1.0
        */
        getMessageBodyMimeType(): string;
        /**
           Set the mime type for the message body

           @param messageBodyMimeType type of the body message
           @since ARP1.0
        */
        setMessageBodyMimeType(messageBodyMimeType: string): void;
        /**
           Returns the subject of the email

           @return subject string of the email
           @since ARP1.0
        */
        getSubject(): string;
        /**
           Set the subject of the email

           @param subject of the email
           @since ARP1.0
        */
        setSubject(subject: string): void;
        /**
           Returns the array of recipients

           @return toRecipients array of recipients
           @since ARP1.0
        */
        getToRecipients(): EmailAddress[];
        /**
           Set the array of recipients

           @param toRecipients array of recipients
           @since ARP1.0
        */
        setToRecipients(toRecipients: EmailAddress[]): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): Email;
    }
    /**
       Structure representing the data elements of an email addressee.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    class EmailAddress extends APIBean {
        /**
           The Email address
        */
        address: string;
        /**
           Constructor used by implementation

           @param address of the Email
           @since ARP1.0
        */
        constructor(address: string);
        /**
           Returns the email address

           @return address of the Email
           @since ARP1.0
        */
        getAddress(): string;
        /**
           Set the Email address

           @param address of the Email
           @since ARP1.0
        */
        setAddress(address: string): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): EmailAddress;
    }
    /**
       Structure representing the binary attachment data.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    class EmailAttachmentData extends APIBean {
        /**
           The raw data for the current file attachment (byte array)
        */
        data: number[];
        /**
           The name of the current file attachment
        */
        fileName: string;
        /**
           The mime type of the current attachment
        */
        mimeType: string;
        /**
           The relative path where the contents for the attachment file could be located.
        */
        referenceUrl: string;
        /**
           The data size (in bytes) of the current file attachment
        */
        size: number;
        /**
           Constructor with fields

           @param data         raw data of the file attachment
           @param size         size of the file attachment
           @param fileName     name of the file attachment
           @param mimeType     mime type of the file attachment
           @param referenceUrl relative url of the file attachment
           @since ARP1.0
        */
        constructor(data: number[], size: number, fileName: string, mimeType: string, referenceUrl: string);
        /**
           Returns the raw data in byte[]

           @return data Octet-binary content of the attachment payload.
           @since ARP1.0
        */
        getData(): number[];
        /**
           Set the data of the attachment as a byte[]

           @param data Sets the octet-binary content of the attachment.
           @since ARP1.0
        */
        setData(data: number[]): void;
        /**
           Returns the filename of the attachment

           @return fileName Name of the attachment.
           @since ARP1.0
        */
        getFileName(): string;
        /**
           Set the name of the file attachment

           @param fileName Name of the attachment.
           @since ARP1.0
        */
        setFileName(fileName: string): void;
        /**
           Returns the mime type of the attachment

           @return mimeType
           @since ARP1.0
        */
        getMimeType(): string;
        /**
           Set the mime type of the attachment

           @param mimeType Mime-type of the attachment.
           @since ARP1.0
        */
        setMimeType(mimeType: string): void;
        /**
           Returns the absolute url of the file attachment

           @return referenceUrl Absolute URL of the file attachment for either file:// or http:// access.
           @since ARP1.0
        */
        getReferenceUrl(): string;
        /**
           Set the absolute url of the attachment

           @param referenceUrl Absolute URL of the file attachment for either file:// or http:// access.
           @since ARP1.0
        */
        setReferenceUrl(referenceUrl: string): void;
        /**
           Returns the size of the attachment as a long

           @return size Length in bytes of the octet-binary content.
           @since ARP1.0
        */
        getSize(): number;
        /**
           Set the size of the attachment as a long

           @param size Length in bytes of the octet-binary content ( should be same as data array length.)
           @since ARP1.0
        */
        setSize(size: number): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): EmailAttachmentData;
    }
    /**
       Implementation of FileDescriptor bean.

       @author Carlos Lozano Diez
       @since 1.0
       @version 1.0
    */
    class FileDescriptor extends APIBean {
        dateCreated: number;
        dateModified: number;
        name: string;
        path: string;
        pathAbsolute: string;
        size: number;
        /**
           Default constructor.
        */
        constructor();
        /**
           Returns the milliseconds passed since 1/1/1970 since the file was created.

           @return Timestamp in milliseconds.
           @since ARP1.0
        */
        getDateCreated(): number;
        /**
           Sets the creation timestamp in milliseconds. Used internally.

           @param dateCreated Timestamp of file creation or -1 if the file or folder doesn't exist.
        */
        setDateCreated(dateCreated: number): void;
        /**
           Returns the milliseconds passed since 1/1/1970 since the file was modified.

           @return Timestamp in milliseconds.
           @since ARP1.0
        */
        getDateModified(): number;
        /**
           Sets the file or folder modification timestamp in milliseconds. Used internally.

           @param dateModified Timestamp of file modification or -1 if the file or folder doesn't exist.
        */
        setDateModified(dateModified: number): void;
        /**
           Returns the name of the file if the reference is a file or the last path element of the folder.

           @return The name of the file.
           @since ARP1.0
        */
        getName(): string;
        /**
           Sets the name of the file. Used internally.

           @param name Name of the file or last folder path element.
        */
        setName(name: string): void;
        /**
           Returns the path element of the file or folder (excluding the last path element if it's a directory).

           @return The path to the file.
           @since ARP1.0
        */
        getPath(): string;
        /**
           Sets the path of the file or folder. Used internally.

           @param path The path element of the file or folder.
        */
        setPath(path: string): void;
        /**
           Returns the resolved absolute path elements of the file and/or folders (including the last path element).

           @return The absolute path to the file.
           @since ARP1.0
        */
        getPathAbsolute(): string;
        /**
           Sets the absolute path of the file or folder. Used internally.

           @param pathAbsolute String with the absolute path of file or folder.
        */
        setPathAbsolute(pathAbsolute: string): void;
        /**
           Returns the size in bytes of the file or -1 if the reference is a folder.

           @return Size in bytes of file.
           @since ARP1.0
        */
        getSize(): number;
        /**
           Sets the file size in bytes of the file. If the file is a folder, this will be 0. If the file
doesn't exist, this will be -1. Used internally.

           @param size The size in bytes of the file.
        */
        setSize(size: number): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): FileDescriptor;
    }
    /**
       Structure representing the data a single geolocation reading.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    class Geolocation extends APIBean {
        /**
           The current device altitude (or Z coordinate). Measured in meters.
        */
        altitude: number;
        /**
           The Y coordinate (or latitude). Measured in degrees.
        */
        latitude: number;
        /**
           The X coordinate (or longitude). Measured in degrees.
        */
        longitude: number;
        /**
           Timestamp of the geolocation reading.
        */
        timestamp: number;
        /**
           Dilution of precision on the X measurement. Measured in meters.
        */
        xDoP: number;
        /**
           Dilution of precision on the Y measurement. Measured in meters.
        */
        yDoP: number;
        /**
           Constructor with parameters

           @param latitude  Latitude of the measurement
           @param longitude Longitude of the measurement
           @param altitude  Altitude of the measurement
           @param xDoP      Dilution of precision on the X measurement
           @param yDoP      Dilution of precision on the Y measurement
           @param timestamp Timestamp of the measurement
           @since ARP1.0
        */
        constructor(latitude: number, longitude: number, altitude: number, xDoP: number, yDoP: number, timestamp: number);
        /**
           Returns altitude in meters

           @return Altitude of the measurement
           @since ARP1.0
        */
        getAltitude(): number;
        /**
           Set altitude in meters

           @param altitude Altitude of the measurement
           @since ARP1.0
        */
        setAltitude(altitude: number): void;
        /**
           Returns the latitude in degrees

           @return Latitude of the measurement
           @since ARP1.0
        */
        getLatitude(): number;
        /**
           Set the latitude in degrees

           @param latitude Latitude of the measurement
           @since ARP1.0
        */
        setLatitude(latitude: number): void;
        /**
           Returns the longitude in degrees

           @return Longitude of the measurement
           @since ARP1.0
        */
        getLongitude(): number;
        /**
           Returns the latitude in degrees

           @param longitude Longitude of the measurement
           @since ARP1.0
        */
        setLongitude(longitude: number): void;
        /**
           Timestamp Getter

           @return Timestamp
           @since ARP1.0
        */
        getTimestamp(): number;
        /**
           Timestamp Setter

           @param timestamp Timestamp
           @since ARP1.0
        */
        setTimestamp(timestamp: number): void;
        /**
           Gets Dilution of precision on the X measurement. Measured in meters.

           @return xDoP Dilution of precision on the X measurement. Measured in meters.
        */
        getXDoP(): number;
        /**
           Sets Dilution of precision on the X measurement. Measured in meters.

           @param xDoP Dilution of precision on the X measurement. Measured in meters.
        */
        setXDoP(xDoP: number): void;
        /**
           Gets Dilution of precision on the Y measurement. Measured in meters.

           @return yDoP Dilution of precision on the Y measurement. Measured in meters.
        */
        getYDoP(): number;
        /**
           Sets Dilution of precision on the Y measurement. Measured in meters.

           @param yDoP Dilution of precision on the Y measurement. Measured in meters.
        */
        setYDoP(yDoP: number): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): Geolocation;
    }
    /**
       Represents a basic bean to store keyName pair values

       @author Ferran Vila Conesa
       @since ARP1.0
       @version 1.0
    */
    class KeyPair extends APIBean {
        /**
           Key of the element
        */
        keyName: string;
        /**
           Value of the element
        */
        keyValue: string;
        /**
           Constructor using fields

           @param keyName  Key of the element
           @param keyValue Value of the element
           @since ARP1.0
        */
        constructor(keyName: string, keyValue: string);
        /**
           Returns the keyName of the element

           @return Key of the element
           @since ARP1.0
        */
        getKeyName(): string;
        /**
           Sets the keyName of the element

           @param keyName Key of the element
           @since ARP1.0
        */
        setKeyName(keyName: string): void;
        /**
           Returns the keyValue of the element

           @return Value of the element
           @since ARP1.0
        */
        getKeyValue(): string;
        /**
           Sets the keyValue of the element

           @param keyValue Value of the element
           @since ARP1.0
        */
        setKeyValue(keyValue: string): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): KeyPair;
    }
    /**
       Represents a specific application life-cycle stage.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    class Lifecycle extends APIBean {
        /**
           Represent the state of the app
<p/>
Possible lifecycle States:
<p/>
1. Starting    - Before starting.
2. Started     - Start concluded.
3. Running     - Accepts user interaction - running in foreground.
4. Pausing     - Before going to background.
4.1 PausedIdle - In background, no scheduled background activity (passive).
4.2 PausedRun  - In background, scheduled background activity (periodic network access, gps access, etc.)
5. Resuming    - Before going to foreground, followed by Running state.
6. Stopping    - Before stopping.
        */
        state: LifecycleState;
        /**
           Constructor used by the implementation

           @param state of the app
           @since ARP1.0
        */
        constructor(state: LifecycleState);
        /**
           Returns the state of the application

           @return state of the app
           @since ARP1.0
        */
        getState(): LifecycleState;
        /**
           Set the State of the application

           @param state of the app
           @since ARP1.0
        */
        setState(state: LifecycleState): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): Lifecycle;
    }
    /**
       Represents a specific user or system locate.

       @author Aryslan
       @since ARP1.0
       @version 1.0
    */
    class Locale extends APIBean {
        /**
           A valid ISO Country Code.
        */
        country: string;
        /**
           A valid ISO Language Code.
        */
        language: string;
        /**
           Constructor used by the implementation

           @param country  Country of the Locale
           @param language Language of the Locale
           @since ARP1.0
        */
        constructor(language: string, country: string);
        /**
           Returns the country code

           @return country code
           @since ARP1.0
        */
        getCountry(): string;
        /**
           Set the country code

           @param country code
           @since ARP1.0
        */
        setCountry(country: string): void;
        /**
           Returns the language code

           @return language code
           @since ARP1.0
        */
        getLanguage(): string;
        /**
           Set the language code

           @param language code
           @since ARP1.0
        */
        setLanguage(language: string): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): Locale;
    }
    /**
       Represents the basic information about the operating system.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    class OSInfo extends APIBean {
        /**
           The name of the operating system.
        */
        name: IOSType;
        /**
           The vendor of the operating system.
        */
        vendor: string;
        /**
           The version/identifier of the operating system.
        */
        version: string;
        /**
           Constructor used by implementation to set the OS information.

           @param name    of the OS.
           @param version of the OS.
           @param vendor  of the OS.
           @since ARP1.0
        */
        constructor(name: IOSType, version: string, vendor: string);
        /**
           Returns the name of the operating system.

           @return OS name.
           @since ARP1.0
        */
        getName(): IOSType;
        /**
           Sets The name of the operating system.

           @param name The name of the operating system.
        */
        setName(name: IOSType): void;
        /**
           Returns the vendor of the operating system.

           @return OS vendor.
           @since ARP1.0
        */
        getVendor(): string;
        /**
           Sets The vendor of the operating system.

           @param vendor The vendor of the operating system.
        */
        setVendor(vendor: string): void;
        /**
           Returns the version of the operating system.

           @return OS version.
           @since ARP1.0
        */
        getVersion(): string;
        /**
           Sets The version/identifier of the operating system.

           @param version The version/identifier of the operating system.
        */
        setVersion(version: string): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): OSInfo;
    }
    /**
       Represents a single secureKey-value pair.

       @author Aryslan
       @since ARP1.0
       @version 1.0
    */
    class SecureKeyPair extends APIBean {
        /**
           Value of the secured element
        */
        secureData: string;
        /**
           Key of the secured element
        */
        secureKey: string;
        /**
           Constructor with parameters

           @param secureKey  name of the keypair
           @param secureData value of the keypair
           @since ARP1.0
        */
        constructor(secureKey: string, secureData: string);
        /**
           Returns the object value

           @return Value.
           @since ARP 1.0
        */
        getSecureData(): string;
        /**
           Sets the value for this object

           @param secureData value to set.
           @since ARP 1.0
        */
        setSecureData(secureData: string): void;
        /**
           Returns the object secureKey name.

           @return Key name.
           @since ARP 1.0
        */
        getSecureKey(): string;
        /**
           Sets the secureKey name for this object.

           @param secureKey Key name.
           @since ARP 1.0
        */
        setSecureKey(secureKey: string): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): SecureKeyPair;
    }
    /**
       Represents an instance of a service.

       @author Aryslan
       @since ARP1.0
       @version 1.0
    */
    class Service extends APIBean {
        /**
           The method used
        */
        method: IServiceMethod;
        /**
           The type of the service
        */
        type: IServiceType;
        /**
           The service name
        */
        name: string;
        /**
           Endpoint of the service
        */
        serviceEndpoint: ServiceEndpoint;
        /**
           Constructor used by the implementation

           @param serviceEndpoint Endpoint of the service
           @param name            Name of the service
           @param method          Method of the service
           @param type            Type of the service
           @since ARP1.0
        */
        constructor(serviceEndpoint: ServiceEndpoint, name: string, method: IServiceMethod, type: IServiceType);
        /**
           Returns the method

           @return method
           @since ARP1.0
        */
        getMethod(): IServiceMethod;
        /**
           Set the method

           @param method Method of the service
           @since ARP1.0
        */
        setMethod(method: IServiceMethod): void;
        /**
           Returns the type

           @return type
           @since ARP1.0
        */
        getType(): IServiceType;
        /**
           Set the type

           @param type Type of the service
           @since ARP1.0
        */
        setType(type: IServiceType): void;
        /**
           Returns the name

           @return name
           @since ARP1.0
        */
        getName(): string;
        /**
           Set the name

           @param name Name of the service
           @since ARP1.0
        */
        setName(name: string): void;
        /**
           Returns the serviceEndpoint

           @return serviceEndpoint
           @since ARP1.0
        */
        getServiceEndpoint(): ServiceEndpoint;
        /**
           Set the serviceEndpoint

           @param serviceEndpoint Endpoint of the service
           @since ARP1.0
        */
        setServiceEndpoint(serviceEndpoint: ServiceEndpoint): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): Service;
    }
    /**
       Structure representing the cookieValue of a http cookie.

       @author Aryslan
       @since ARP1.0
       @version 1.0
    */
    class ServiceCookie extends APIBean {
        /**
           Name ot the cookie
        */
        cookieName: string;
        /**
           Value of the ServiceCookie
        */
        cookieValue: string;
        /**
           ServiceCookie creation timestamp in milliseconds.
        */
        creation: number;
        /**
           Domain for which the cookie is valid.
        */
        domain: string;
        /**
           ServiceCookie expiry in milliseconds or -1 for session only.
        */
        expiry: number;
        /**
           URI path for which the cookie is valid.
        */
        path: string;
        /**
           Scheme of the domain - http/https - for which the cookie is valid.
        */
        scheme: string;
        /**
           ServiceCookie is secure (https only)
        */
        secure: boolean;
        /**
           Contructor with fields

           @param cookieName  Name of the cookie
           @param cookieValue Value of the cookie
           @param domain      Domain of the cookie
           @param path        Path of the cookie
           @param scheme      Scheme of the cookie
           @param secure      Privacy of the cookie
           @param expiry      Expiration date of the cookie
           @param creation    Creation date of the cookie
           @since ARP1.0
        */
        constructor(cookieName: string, cookieValue: string, domain: string, path: string, scheme: string, secure: boolean, expiry: number, creation: number);
        /**
           Returns the cookie cookieName

           @return cookieName Name of the cookie
           @since ARP1.0
        */
        getCookieName(): string;
        /**
           Set the cookie cookieName

           @param cookieName Name of the cookie
           @since ARP1.0
        */
        setCookieName(cookieName: string): void;
        /**
           Returns the cookie cookieValue

           @return Value of the cookie
           @since ARP1.0
        */
        getCookieValue(): string;
        /**
           Set the cookie cookieValue

           @param cookieValue Value of the cookie
           @since ARP1.0
        */
        setCookieValue(cookieValue: string): void;
        /**
           Returns the creation date

           @return Creation date of the cookie
           @since ARP1.0
        */
        getCreation(): number;
        /**
           Sets the creation date

           @param creation Creation date of the cookie
           @since ARP1.0
        */
        setCreation(creation: number): void;
        /**
           Returns the domain

           @return domain
           @since ARP1.0
        */
        getDomain(): string;
        /**
           Set the domain

           @param domain Domain of the cookie
           @since ARP1.0
        */
        setDomain(domain: string): void;
        /**
           Returns the expiration date in milis

           @return expiry
           @since ARP1.0
        */
        getExpiry(): number;
        /**
           Set the expiration date in milis

           @param expiry Expiration date of the cookie
           @since ARP1.0
        */
        setExpiry(expiry: number): void;
        /**
           Returns the path

           @return path
           @since ARP1.0
        */
        getPath(): string;
        /**
           Set the path

           @param path Path of the cookie
           @since ARP1.0
        */
        setPath(path: string): void;
        /**
           Returns the scheme

           @return scheme
           @since ARP1.0
        */
        getScheme(): string;
        /**
           Set the scheme

           @param scheme Scheme of the cookie
           @since ARP1.0
        */
        setScheme(scheme: string): void;
        /**
           Returns whether the cookie is secure or not

           @return true if the cookie is secure; false otherwise
           @since ARP1.0
        */
        getSecure(): boolean;
        /**
           Set whether the cookie is secure or not

           @param secure Privacy of the cookie
           @since ARP1.0
        */
        setSecure(secure: boolean): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): ServiceCookie;
    }
    /**
       Structure representing a remote or local service access end-point.

       @author Aryslan
       @since ARP1.0
       @version 1.0
    */
    class ServiceEndpoint extends APIBean {
        /**
           The remote service host (alias or IP).
        */
        host: string;
        /**
           The remote service path (to be added to the host and port url).
        */
        path: string;
        /**
           The remote service accessible port.
        */
        port: number;
        /**
           The proxy url - if needed - to access the remote service. If IP and port are used, use the following syntax: "http://<IP>:<Port>".
        */
        proxy: string;
        /**
           The remote service scheme.
        */
        scheme: string;
        /**
           Constructor with parameters

           @param host   Remote service host
           @param path   Remote service Path
           @param port   Remote service Port
           @param proxy  Proxy url "http://IP_ADDRESS:PORT_NUMBER"
           @param scheme Remote service scheme
           @since ARP1.0
        */
        constructor(host: string, path: string, port: number, proxy: string, scheme: string);
        /**
           Returns the Remote service host

           @return Remote service host
           @since ARP1.0
        */
        getHost(): string;
        /**
           Set the Remote service host

           @param host Remote service host
           @since ARP1.0
        */
        setHost(host: string): void;
        /**
           Returns the Remote service Path

           @return Remote service Path
           @since ARP1.0
        */
        getPath(): string;
        /**
           Set the Remote service Path

           @param path Remote service Path
           @since ARP1.0
        */
        setPath(path: string): void;
        /**
           Returns the Remote service Port

           @return Remote service Port
           @since ARP1.0
        */
        getPort(): number;
        /**
           Set the Remote service Port

           @param port Remote service Port
           @since ARP1.0
        */
        setPort(port: number): void;
        /**
           Return the Proxy url

           @return Proxy url
           @since ARP1.0
        */
        getProxy(): string;
        /**
           Set the Proxy url

           @param proxy Proxy url
           @since ARP1.0
        */
        setProxy(proxy: string): void;
        /**
           Returns the Remote service scheme

           @return Remote service scheme
           @since ARP1.0
        */
        getScheme(): string;
        /**
           Set the Remote service scheme

           @param scheme Remote service scheme
           @since ARP1.0
        */
        setScheme(scheme: string): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): ServiceEndpoint;
    }
    /**
       Structure representing the data of a http request or response header.

       @author Aryslan
       @since ARP1.0
       @version 1.0
    */
    class ServiceHeader extends APIBean {
        /**
           Value of the header
        */
        data: string;
        /**
           Name ot the header
        */
        name: string;
        /**
           Constructor with fields

           @param name Name of the header
           @param data Value of the header
           @since ARP1.0
        */
        constructor(name: string, data: string);
        /**
           Returns the header value

           @return ServiceHeader value
           @since ARP1.0
        */
        getData(): string;
        /**
           Set the header value

           @param data ServiceHeader value
           @since ARP1.0
        */
        setData(data: string): void;
        /**
           Returns the header name

           @return ServiceHeader name
           @since ARP1.0
        */
        getName(): string;
        /**
           Set the header name

           @param name Name of the header
           @since ARP1.0
        */
        setName(name: string): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): ServiceHeader;
    }
    /**
       Represents a local or remote service request.

       @author Aryslan
       @since ARP1.0
       @version 1.0
    */
    class ServiceRequest extends APIBean {
        /**
           The HTTP procotol version to be used for this request.
        */
        protocolVersion: IServiceProtocolVersion;
        /**
           Request/Response data content (plain text).
        */
        content: string;
        /**
           The byte[] representing the Content field.
        */
        contentBinary: number[];
        /**
           The length in bytes for the binary Content.
        */
        contentBinaryLength: number;
        /**
           Encoding of the binary payload - by default assumed to be UTF8.
        */
        contentEncoding: string;
        /**
           The length in bytes for the Content field.
        */
        contentLength: number;
        /**
           The request/response content type (MIME TYPE).
        */
        contentType: string;
        /**
           The request method
        */
        method: string;
        /**
           The serviceHeaders array (name,value pairs) to be included on the I/O service request.
        */
        serviceHeaders: ServiceHeader[];
        /**
           Information about the session
        */
        serviceSession: ServiceSession;
        /**
           Contructor used by the implementation

           @param content             Request/Response data content (plain text)
           @param contentType         The request/response content type (MIME TYPE).
           @param contentEncoding     Encoding of the binary payload - by default assumed to be UTF8.
           @param contentLength       The length in bytes for the Content field.
           @param contentBinary       The byte[] representing the Content field.
           @param contentBinaryLength The length in bytes for the binary Content.
           @param serviceHeaders      The serviceHeaders array (name,value pairs) to be included on the I/O service request.
           @param method              The request method
           @param protocolVersion     The HTTP procotol version to be used for this request.
           @param serviceSession      The element service session
           @since ARP1.0
        */
        constructor(content: string, contentType: string, contentEncoding: string, contentLength: number, contentBinary: number[], contentBinaryLength: number, serviceHeaders: ServiceHeader[], method: string, protocolVersion: IServiceProtocolVersion, serviceSession: ServiceSession);
        /**
           Returns the protocol version

           @return protocolVersion enum
           @since ARP1.0
        */
        getProtocolVersion(): IServiceProtocolVersion;
        /**
           Set the protocol version

           @param protocolVersion The HTTP procotol version to be used for this request.
           @since ARP1.0
        */
        setProtocolVersion(protocolVersion: IServiceProtocolVersion): void;
        /**
           Returns the content

           @return content
           @since ARP1.0
        */
        getContent(): string;
        /**
           Set the content

           @param content Request/Response data content (plain text)
           @since ARP1.0
        */
        setContent(content: string): void;
        /**
           Returns the byte[] of the content

           @return contentBinary
           @since ARP1.0
        */
        getContentBinary(): number[];
        /**
           Set the byte[] of the content

           @param contentBinary The byte[] representing the Content field.
           @since ARP1.0
        */
        setContentBinary(contentBinary: number[]): void;
        /**
           Retrusn the binary content length

           @return contentBinaryLength
           @since ARP1.0
        */
        getContentBinaryLength(): number;
        /**
           Set the binary content length

           @param contentBinaryLength The length in bytes for the binary Content.
           @since ARP1.0
        */
        setContentBinaryLength(contentBinaryLength: number): void;
        /**
           Returns the content encoding

           @return contentEncoding
           @since ARP1.0
        */
        getContentEncoding(): string;
        /**
           Set the content encoding

           @param contentEncoding Encoding of the binary payload - by default assumed to be UTF8.
           @since ARP1.0
        */
        setContentEncoding(contentEncoding: string): void;
        /**
           Returns the content length

           @return contentLength
           @since ARP1.0
        */
        getContentLength(): number;
        /**
           Set the content length

           @param contentLength The length in bytes for the Content field.
           @since ARP1.0
        */
        setContentLength(contentLength: number): void;
        /**
           Returns the content type

           @return contentType
           @since ARP1.0
        */
        getContentType(): string;
        /**
           Set the content type

           @param contentType The request/response content type (MIME TYPE).
           @since ARP1.0
        */
        setContentType(contentType: string): void;
        /**
           Returns the method

           @return method
           @since ARP1.0
        */
        getMethod(): string;
        /**
           Set the method

           @param method The request method
           @since ARP1.0
        */
        setMethod(method: string): void;
        /**
           Returns the array of ServiceHeader

           @return serviceHeaders
           @since ARP1.0
        */
        getServiceHeaders(): ServiceHeader[];
        /**
           Set the array of ServiceHeader

           @param serviceHeaders The serviceHeaders array (name,value pairs) to be included on the I/O service request.
           @since ARP1.0
        */
        setServiceHeaders(serviceHeaders: ServiceHeader[]): void;
        /**
           Getter for service session

           @return The element service session
           @since ARP1.0
        */
        getServiceSession(): ServiceSession;
        /**
           Setter for service session

           @param serviceSession The element service session
           @since ARP1.0
        */
        setServiceSession(serviceSession: ServiceSession): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): ServiceRequest;
    }
    /**
       Represents a local or remote service response.

       @author Aryslan
       @since ARP1.0
       @version 1.0
    */
    class ServiceResponse extends APIBean {
        /**
           Request/Response data content (plain text).
        */
        content: string;
        /**
           The byte[] representing the binary Content.
        */
        contentBinary: number[];
        /**
           The length in bytes for the binary Content.
        */
        contentBinaryLength: number;
        /**
           Encoding of the binary payload - by default assumed to be UTF8.
        */
        contentEncoding: string;
        /**
           The length in bytes for the Content field.
        */
        contentLength: number;
        /**
           The request/response content type (MIME TYPE).
        */
        contentType: string;
        /**
           The serviceHeaders array (name,value pairs) to be included on the I/O service request.
        */
        serviceHeaders: ServiceHeader[];
        /**
           Information about the session
        */
        serviceSession: ServiceSession;
        /**
           Constructor with fields

           @param content             Request/Response data content (plain text).
           @param contentType         The request/response content type (MIME TYPE).
           @param contentEncoding     Encoding of the binary payload - by default assumed to be UTF8.
           @param contentLength       The length in bytes for the Content field.
           @param contentBinary       The byte[] representing the binary Content.
           @param contentBinaryLength The length in bytes for the binary Content.
           @param serviceHeaders      The serviceHeaders array (name,value pairs) to be included on the I/O service request.
           @param serviceSession      Information about the session
           @since ARP1.0
        */
        constructor(content: string, contentType: string, contentEncoding: string, contentLength: number, contentBinary: number[], contentBinaryLength: number, serviceHeaders: ServiceHeader[], serviceSession: ServiceSession);
        /**
           Returns the content

           @return content
           @since ARP1.0
        */
        getContent(): string;
        /**
           Set the content

           @param content Request/Response data content (plain text).
           @since ARP1.0
        */
        setContent(content: string): void;
        /**
           Returns the binary content

           @return contentBinary
           @since ARP1.0
        */
        getContentBinary(): number[];
        /**
           Set the binary content

           @param contentBinary The byte[] representing the binary Content.
           @since ARP1.0
        */
        setContentBinary(contentBinary: number[]): void;
        /**
           Returns the binary content length

           @return contentBinaryLength
           @since ARP1.0
        */
        getContentBinaryLength(): number;
        /**
           Set the binary content length

           @param contentBinaryLength The length in bytes for the binary Content.
           @since ARP1.0
        */
        setContentBinaryLength(contentBinaryLength: number): void;
        /**
           Returns the content encoding

           @return contentEncoding
           @since ARP1.0
        */
        getContentEncoding(): string;
        /**
           Set the content encoding

           @param contentEncoding Encoding of the binary payload - by default assumed to be UTF8.
           @since ARP1.0
        */
        setContentEncoding(contentEncoding: string): void;
        /**
           Returns the content length

           @return contentLength
           @since ARP1.0
        */
        getContentLength(): number;
        /**
           Set the content length

           @param contentLength The length in bytes for the Content field.
           @since ARP1.0
        */
        setContentLength(contentLength: number): void;
        /**
           Returns the content type

           @return contentType
           @since ARP1.0
        */
        getContentType(): string;
        /**
           Set the content type

           @param contentType The request/response content type (MIME TYPE).
           @since ARP1.0
        */
        setContentType(contentType: string): void;
        /**
           Returns the array of ServiceHeader

           @return serviceHeaders
           @since ARP1.0
        */
        getServiceHeaders(): ServiceHeader[];
        /**
           Set the array of ServiceHeader

           @param serviceHeaders The serviceHeaders array (name,value pairs) to be included on the I/O service request.
           @since ARP1.0
        */
        setServiceHeaders(serviceHeaders: ServiceHeader[]): void;
        /**
           Getter for service session

           @return The element service session
           @since ARP1.0
        */
        getServiceSession(): ServiceSession;
        /**
           Setter for service session

           @param serviceSession The element service session
           @since ARP1.0
        */
        setServiceSession(serviceSession: ServiceSession): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): ServiceResponse;
    }
    /**
       Represents a session object for HTTP request and responses

       @author Ferran Vila Conesa
       @since ARP1.0
       @version 1.0
    */
    class ServiceSession extends APIBean {
        /**
           The attributes of the response
        */
        attributes: string[];
        /**
           The cookies of the response
        */
        cookies: ServiceCookie[];
        /**
           Constructor with fields

           @param cookies    The cookies of the response
           @param attributes Attributes of the response
           @since ARP1.0
        */
        constructor(cookies: ServiceCookie[], attributes: string[]);
        /**
           Gets the attributes of the response

           @return Attributes of the response
           @since ARP1.0
        */
        getAttributes(): string[];
        /**
           Sets the attributes for the response

           @param attributes Attributes of the response
           @since ARP1.0
        */
        setAttributes(attributes: string[]): void;
        /**
           Returns the cookies of the response

           @return The cookies of the response
           @since ARP1.0
        */
        getCookies(): ServiceCookie[];
        /**
           Sets the cookies of the response

           @param cookies The cookies of the response
           @since ARP1.0
        */
        setCookies(cookies: ServiceCookie[]): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): ServiceSession;
    }
    /**
       Structure representing the data elements of a contact.

       @author Francisco Javier Martin Bueno
       @since ARP1.0
       @version 1.0
    */
    class Contact extends ContactUid {
        /**
           The adresses from the contact
        */
        contactAddresses: ContactAddress[];
        /**
           The emails from the contact
        */
        contactEmails: ContactEmail[];
        /**
           The phones from the contact
        */
        contactPhones: ContactPhone[];
        /**
           The social network info from the contact
        */
        contactSocials: ContactSocial[];
        /**
           The aditional tags from the contact
        */
        contactTags: ContactTag[];
        /**
           The websites from the contact
        */
        contactWebsites: ContactWebsite[];
        /**
           The personal info from the contact
        */
        personalInfo: ContactPersonalInfo;
        /**
           The professional info from the contact
        */
        professionalInfo: ContactProfessionalInfo;
        /**
           Constructor with all the fields

           @param contactId        Identifier of the contact
           @param personalInfo     Personal Information
           @param professionalInfo Professional Information
           @param contactAddresses Addresses of the contact
           @param contactPhones    Phones of the contact
           @param contactEmails    Emails of the contact
           @param contactWebsites  Websites of the contact
           @param contactSocials   Social Networks of the contact
           @param contactTags      Tags of the contact
           @since ARP1.0
        */
        constructor(contactId: string, personalInfo: ContactPersonalInfo, professionalInfo: ContactProfessionalInfo, contactAddresses: ContactAddress[], contactPhones: ContactPhone[], contactEmails: ContactEmail[], contactWebsites: ContactWebsite[], contactSocials: ContactSocial[], contactTags: ContactTag[]);
        /**
           Returns all the addresses of the Contact

           @return ContactAddress[]
           @since ARP1.0
        */
        getContactAddresses(): ContactAddress[];
        /**
           Set the addresses of the Contact

           @param contactAddresses Addresses of the contact
           @since ARP1.0
        */
        setContactAddresses(contactAddresses: ContactAddress[]): void;
        /**
           Returns all the emails of the Contact

           @return ContactEmail[]
           @since ARP1.0
        */
        getContactEmails(): ContactEmail[];
        /**
           Set the emails of the Contact

           @param contactEmails Emails of the contact
           @since ARP1.0
        */
        setContactEmails(contactEmails: ContactEmail[]): void;
        /**
           Returns all the phones of the Contact

           @return ContactPhone[]
           @since ARP1.0
        */
        getContactPhones(): ContactPhone[];
        /**
           Set the phones of the Contact

           @param contactPhones Phones of the contact
           @since ARP1.0
        */
        setContactPhones(contactPhones: ContactPhone[]): void;
        /**
           Returns all the social network info of the Contact

           @return ContactSocial[]
           @since ARP1.0
        */
        getContactSocials(): ContactSocial[];
        /**
           Set the social network info of the Contact

           @param contactSocials Social Networks of the contact
           @since ARP1.0
        */
        setContactSocials(contactSocials: ContactSocial[]): void;
        /**
           Returns the additional tags of the Contact

           @return ContactTag[]
           @since ARP1.0
        */
        getContactTags(): ContactTag[];
        /**
           Set the additional tags of the Contact

           @param contactTags Tags of the contact
           @since ARP1.0
        */
        setContactTags(contactTags: ContactTag[]): void;
        /**
           Returns all the websites of the Contact

           @return ContactWebsite[]
           @since ARP1.0
        */
        getContactWebsites(): ContactWebsite[];
        /**
           Set the websites of the Contact

           @param contactWebsites Websites of the contact
           @since ARP1.0
        */
        setContactWebsites(contactWebsites: ContactWebsite[]): void;
        /**
           Returns the personal info of the Contact

           @return ContactPersonalInfo of the Contact
           @since ARP1.0
        */
        getPersonalInfo(): ContactPersonalInfo;
        /**
           Set the personal info of the Contact

           @param personalInfo Personal Information
           @since ARP1.0
        */
        setPersonalInfo(personalInfo: ContactPersonalInfo): void;
        /**
           Returns the professional info of the Contact

           @return Array of personal info
           @since ARP1.0
        */
        getProfessionalInfo(): ContactProfessionalInfo;
        /**
           Set the professional info of the Contact

           @param professionalInfo Professional Information
           @since ARP1.0
        */
        setProfessionalInfo(professionalInfo: ContactProfessionalInfo): void;
        /**
           Convert JSON parsed object to typed equivalent.
        */
        static toObject(object: any): Contact;
    }
    class BaseListener implements IBaseListener {
        /**
           Unique id of listener.
        */
        id: number;
        /**
           Group of API.
        */
        apiGroup: IAdaptiveRPGroup;
        /**
           Constructor with listener id.

           @param id  The id of the listener.
        */
        constructor(id: number);
        /**
           Get the listener id.
           @return long with the identifier of the listener.
        */
        getId(): number;
        /**
           Return the API group for the given interface.
        */
        getAPIGroup(): IAdaptiveRPGroup;
        /**
           Return the API version for the given interface.

           @return {String} The version of the API.
        */
        getAPIVersion(): string;
    }
    /**
       AccelerationListener control dictionary.
    */
    var registeredAccelerationListener: Dictionary<IAccelerationListener>;
    /**
       AccelerationListener global listener handlers.
    */
    function handleAccelerationListenerError(id: number, error: IAccelerationListenerError): void;
    function handleAccelerationListenerResult(id: number, acceleration: Acceleration): void;
    function handleAccelerationListenerWarning(id: number, acceleration: Acceleration, warning: IAccelerationListenerWarning): void;
    class AccelerationListener extends BaseListener implements IAccelerationListener {
        onErrorFunction: (error: IAccelerationListenerError) => void;
        onResultFunction: (acceleration: Acceleration) => void;
        onWarningFunction: (acceleration: Acceleration, warning: IAccelerationListenerWarning) => void;
        /**
           Constructor with anonymous handler functions for listener.

           @param onErrorFunction Function receiving parameters of type: IAccelerationListenerError
           @param onResultFunction Function receiving parameters of type: Acceleration
           @param onWarningFunction Function receiving parameters of type: Acceleration, IAccelerationListenerWarning
        */
        constructor(onErrorFunction: (error: IAccelerationListenerError) => void, onResultFunction: (acceleration: Acceleration) => void, onWarningFunction: (acceleration: Acceleration, warning: IAccelerationListenerWarning) => void);
        /**
           No data received - error condition, not authorized or hardware not available. This will be reported once for the
listener and subsequently, the listener will be deactivated and removed from the internal list of listeners.

           @param error Error fired
           @since ARP1.0
        */
        onError(error: IAccelerationListenerError): void;
        /**
           Correct data received.

           @param acceleration Acceleration received
           @since ARP1.0
        */
        onResult(acceleration: Acceleration): void;
        /**
           Data received with warning - ie. Needs calibration.

           @param acceleration Acceleration received
           @param warning      Warning fired
           @since ARP1.0
        */
        onWarning(acceleration: Acceleration, warning: IAccelerationListenerWarning): void;
    }
    /**
       ButtonListener control dictionary.
    */
    var registeredButtonListener: Dictionary<IButtonListener>;
    /**
       ButtonListener global listener handlers.
    */
    function handleButtonListenerError(id: number, error: IButtonListenerError): void;
    function handleButtonListenerResult(id: number, button: Button): void;
    function handleButtonListenerWarning(id: number, button: Button, warning: IButtonListenerWarning): void;
    class ButtonListener extends BaseListener implements IButtonListener {
        onErrorFunction: (error: IButtonListenerError) => void;
        onResultFunction: (button: Button) => void;
        onWarningFunction: (button: Button, warning: IButtonListenerWarning) => void;
        /**
           Constructor with anonymous handler functions for listener.

           @param onErrorFunction Function receiving parameters of type: IButtonListenerError
           @param onResultFunction Function receiving parameters of type: Button
           @param onWarningFunction Function receiving parameters of type: Button, IButtonListenerWarning
        */
        constructor(onErrorFunction: (error: IButtonListenerError) => void, onResultFunction: (button: Button) => void, onWarningFunction: (button: Button, warning: IButtonListenerWarning) => void);
        /**
           No data received

           @param error occurred
           @since ARP1.0
        */
        onError(error: IButtonListenerError): void;
        /**
           Called on button pressed

           @param button pressed
           @since ARP1.0
        */
        onResult(button: Button): void;
        /**
           Data received with warning

           @param button  pressed
           @param warning happened
           @since ARP1.0
        */
        onWarning(button: Button, warning: IButtonListenerWarning): void;
    }
    /**
       GeolocationListener control dictionary.
    */
    var registeredGeolocationListener: Dictionary<IGeolocationListener>;
    /**
       GeolocationListener global listener handlers.
    */
    function handleGeolocationListenerError(id: number, error: IGeolocationListenerError): void;
    function handleGeolocationListenerResult(id: number, geolocation: Geolocation): void;
    function handleGeolocationListenerWarning(id: number, geolocation: Geolocation, warning: IGeolocationListenerWarning): void;
    class GeolocationListener extends BaseListener implements IGeolocationListener {
        onErrorFunction: (error: IGeolocationListenerError) => void;
        onResultFunction: (geolocation: Geolocation) => void;
        onWarningFunction: (geolocation: Geolocation, warning: IGeolocationListenerWarning) => void;
        /**
           Constructor with anonymous handler functions for listener.

           @param onErrorFunction Function receiving parameters of type: IGeolocationListenerError
           @param onResultFunction Function receiving parameters of type: Geolocation
           @param onWarningFunction Function receiving parameters of type: Geolocation, IGeolocationListenerWarning
        */
        constructor(onErrorFunction: (error: IGeolocationListenerError) => void, onResultFunction: (geolocation: Geolocation) => void, onWarningFunction: (geolocation: Geolocation, warning: IGeolocationListenerWarning) => void);
        /**
           No data received - error condition, not authorized or hardware not available.

           @param error Type of error encountered during reading.
           @since ARP1.0
        */
        onError(error: IGeolocationListenerError): void;
        /**
           Correct data received.

           @param geolocation Geolocation Bean
           @since ARP1.0
        */
        onResult(geolocation: Geolocation): void;
        /**
           Data received with warning - ie. HighDoP

           @param geolocation Geolocation Bean
           @param warning     Type of warning encountered during reading.
           @since ARP1.0
        */
        onWarning(geolocation: Geolocation, warning: IGeolocationListenerWarning): void;
    }
    /**
       LifecycleListener control dictionary.
    */
    var registeredLifecycleListener: Dictionary<ILifecycleListener>;
    /**
       LifecycleListener global listener handlers.
    */
    function handleLifecycleListenerError(id: number, error: ILifecycleListenerError): void;
    function handleLifecycleListenerResult(id: number, lifecycle: Lifecycle): void;
    function handleLifecycleListenerWarning(id: number, lifecycle: Lifecycle, warning: ILifecycleListenerWarning): void;
    class LifecycleListener extends BaseListener implements ILifecycleListener {
        onErrorFunction: (error: ILifecycleListenerError) => void;
        onResultFunction: (lifecycle: Lifecycle) => void;
        onWarningFunction: (lifecycle: Lifecycle, warning: ILifecycleListenerWarning) => void;
        /**
           Constructor with anonymous handler functions for listener.

           @param onErrorFunction Function receiving parameters of type: ILifecycleListenerError
           @param onResultFunction Function receiving parameters of type: Lifecycle
           @param onWarningFunction Function receiving parameters of type: Lifecycle, ILifecycleListenerWarning
        */
        constructor(onErrorFunction: (error: ILifecycleListenerError) => void, onResultFunction: (lifecycle: Lifecycle) => void, onWarningFunction: (lifecycle: Lifecycle, warning: ILifecycleListenerWarning) => void);
        /**
           No data received - error condition, not authorized or hardware not available.

           @param error Type of error encountered during reading.
           @since ARP1.0
        */
        onError(error: ILifecycleListenerError): void;
        /**
           Called when lifecycle changes somehow.

           @param lifecycle Lifecycle element
           @since ARP1.0
        */
        onResult(lifecycle: Lifecycle): void;
        /**
           Data received with warning

           @param lifecycle Lifecycle element
           @param warning   Type of warning encountered during reading.
           @since ARP1.0
        */
        onWarning(lifecycle: Lifecycle, warning: ILifecycleListenerWarning): void;
    }
    /**
       NetworkStatusListener control dictionary.
    */
    var registeredNetworkStatusListener: Dictionary<INetworkStatusListener>;
    /**
       NetworkStatusListener global listener handlers.
    */
    function handleNetworkStatusListenerError(id: number, error: INetworkStatusListenerError): void;
    function handleNetworkStatusListenerResult(id: number, network: ICapabilitiesNet): void;
    function handleNetworkStatusListenerWarning(id: number, network: ICapabilitiesNet, warning: INetworkStatusListenerWarning): void;
    class NetworkStatusListener extends BaseListener implements INetworkStatusListener {
        onErrorFunction: (error: INetworkStatusListenerError) => void;
        onResultFunction: (network: ICapabilitiesNet) => void;
        onWarningFunction: (network: ICapabilitiesNet, warning: INetworkStatusListenerWarning) => void;
        /**
           Constructor with anonymous handler functions for listener.

           @param onErrorFunction Function receiving parameters of type: INetworkStatusListenerError
           @param onResultFunction Function receiving parameters of type: ICapabilitiesNet
           @param onWarningFunction Function receiving parameters of type: ICapabilitiesNet, INetworkStatusListenerWarning
        */
        constructor(onErrorFunction: (error: INetworkStatusListenerError) => void, onResultFunction: (network: ICapabilitiesNet) => void, onWarningFunction: (network: ICapabilitiesNet, warning: INetworkStatusListenerWarning) => void);
        /**
           No data received - error condition, not authorized or hardware not available.

           @param error Type of error encountered during reading.
           @since ARP1.0
        */
        onError(error: INetworkStatusListenerError): void;
        /**
           Called when network connection changes somehow.

           @param network Change to this network.
           @since ARP1.0
        */
        onResult(network: ICapabilitiesNet): void;
        /**
           Status received with warning

           @param network Change to this network.
           @param warning Type of warning encountered during reading.
           @since ARP1.0
        */
        onWarning(network: ICapabilitiesNet, warning: INetworkStatusListenerWarning): void;
    }
    class BaseCallback implements IBaseCallback {
        /**
           Unique id of callback.
        */
        id: number;
        /**
           Group of API.
        */
        apiGroup: IAdaptiveRPGroup;
        /**
           Constructor with callback id.

           @param id  The id of the callback.
        */
        constructor(id: number);
        /**
           Get the listener id.
           @return long with the identifier of the callback.
        */
        getId(): number;
        /**
           Return the API group for the given interface.
        */
        getAPIGroup(): IAdaptiveRPGroup;
        /**
           Return the API version for the given interface.

           @return {String} The version of the API.
        */
        getAPIVersion(): string;
    }
    /**
       ContactPhotoResultCallback control dictionary.
    */
    var registeredContactPhotoResultCallback: Dictionary<IContactPhotoResultCallback>;
    /**
       ContactPhotoResultCallback global callback handlers.
    */
    function handleContactPhotoResultCallbackError(id: number, error: IContactPhotoResultCallbackError): void;
    function handleContactPhotoResultCallbackResult(id: number, contactPhoto: number[]): void;
    function handleContactPhotoResultCallbackWarning(id: number, contactPhoto: number[], warning: IContactPhotoResultCallbackWarning): void;
    class ContactPhotoResultCallback extends BaseCallback implements IContactPhotoResultCallback {
        onErrorFunction: (error: IContactPhotoResultCallbackError) => void;
        onResultFunction: (contactPhoto: number[]) => void;
        onWarningFunction: (contactPhoto: number[], warning: IContactPhotoResultCallbackWarning) => void;
        /**
           Constructor with anonymous handler functions for callback.

           @param onErrorFunction Function receiving parameters of type: IContactPhotoResultCallbackError
           @param onResultFunction Function receiving parameters of type: Array<number>
           @param onWarningFunction Function receiving parameters of type: Array<number>, IContactPhotoResultCallbackWarning
        */
        constructor(onErrorFunction: (error: IContactPhotoResultCallbackError) => void, onResultFunction: (contactPhoto: number[]) => void, onWarningFunction: (contactPhoto: number[], warning: IContactPhotoResultCallbackWarning) => void);
        /**
           This method is called on Error

           @param error returned by the platform
           @since ARP1.0
        */
        onError(error: IContactPhotoResultCallbackError): void;
        /**
           This method is called on Result

           @param contactPhoto returned by the platform
           @since ARP1.0
        */
        onResult(contactPhoto: number[]): void;
        /**
           This method is called on Warning

           @param contactPhoto returned by the platform
           @param warning      returned by the platform
           @since ARP1.0
        */
        onWarning(contactPhoto: number[], warning: IContactPhotoResultCallbackWarning): void;
    }
    /**
       ContactResultCallback control dictionary.
    */
    var registeredContactResultCallback: Dictionary<IContactResultCallback>;
    /**
       ContactResultCallback global callback handlers.
    */
    function handleContactResultCallbackError(id: number, error: IContactResultCallbackError): void;
    function handleContactResultCallbackResult(id: number, contacts: Contact[]): void;
    function handleContactResultCallbackWarning(id: number, contacts: Contact[], warning: IContactResultCallbackWarning): void;
    class ContactResultCallback extends BaseCallback implements IContactResultCallback {
        onErrorFunction: (error: IContactResultCallbackError) => void;
        onResultFunction: (contacts: Contact[]) => void;
        onWarningFunction: (contacts: Contact[], warning: IContactResultCallbackWarning) => void;
        /**
           Constructor with anonymous handler functions for callback.

           @param onErrorFunction Function receiving parameters of type: IContactResultCallbackError
           @param onResultFunction Function receiving parameters of type: Array<Contact>
           @param onWarningFunction Function receiving parameters of type: Array<Contact>, IContactResultCallbackWarning
        */
        constructor(onErrorFunction: (error: IContactResultCallbackError) => void, onResultFunction: (contacts: Contact[]) => void, onWarningFunction: (contacts: Contact[], warning: IContactResultCallbackWarning) => void);
        /**
           This method is called on Error

           @param error returned by the platform
           @since ARP1.0
        */
        onError(error: IContactResultCallbackError): void;
        /**
           This method is called on Result

           @param contacts returned by the platform
           @since ARP1.0
        */
        onResult(contacts: Contact[]): void;
        /**
           This method is called on Warning

           @param contacts returned by the platform
           @param warning  returned by the platform
           @since ARP1.0
        */
        onWarning(contacts: Contact[], warning: IContactResultCallbackWarning): void;
    }
    /**
       DatabaseResultCallback control dictionary.
    */
    var registeredDatabaseResultCallback: Dictionary<IDatabaseResultCallback>;
    /**
       DatabaseResultCallback global callback handlers.
    */
    function handleDatabaseResultCallbackError(id: number, error: IDatabaseResultCallbackError): void;
    function handleDatabaseResultCallbackResult(id: number, database: Database): void;
    function handleDatabaseResultCallbackWarning(id: number, database: Database, warning: IDatabaseResultCallbackWarning): void;
    class DatabaseResultCallback extends BaseCallback implements IDatabaseResultCallback {
        onErrorFunction: (error: IDatabaseResultCallbackError) => void;
        onResultFunction: (database: Database) => void;
        onWarningFunction: (database: Database, warning: IDatabaseResultCallbackWarning) => void;
        /**
           Constructor with anonymous handler functions for callback.

           @param onErrorFunction Function receiving parameters of type: IDatabaseResultCallbackError
           @param onResultFunction Function receiving parameters of type: Database
           @param onWarningFunction Function receiving parameters of type: Database, IDatabaseResultCallbackWarning
        */
        constructor(onErrorFunction: (error: IDatabaseResultCallbackError) => void, onResultFunction: (database: Database) => void, onWarningFunction: (database: Database, warning: IDatabaseResultCallbackWarning) => void);
        /**
           Result callback for error responses

           @param error Returned error
           @since ARP1.0
        */
        onError(error: IDatabaseResultCallbackError): void;
        /**
           Result callback for correct responses

           @param database Returns the database
           @since ARP1.0
        */
        onResult(database: Database): void;
        /**
           Result callback for warning responses

           @param database Returns the database
           @param warning  Returned Warning
           @since ARP1.0
        */
        onWarning(database: Database, warning: IDatabaseResultCallbackWarning): void;
    }
    /**
       DatabaseTableResultCallback control dictionary.
    */
    var registeredDatabaseTableResultCallback: Dictionary<IDatabaseTableResultCallback>;
    /**
       DatabaseTableResultCallback global callback handlers.
    */
    function handleDatabaseTableResultCallbackError(id: number, error: IDatabaseTableResultCallbackError): void;
    function handleDatabaseTableResultCallbackResult(id: number, databaseTable: DatabaseTable): void;
    function handleDatabaseTableResultCallbackWarning(id: number, databaseTable: DatabaseTable, warning: IDatabaseTableResultCallbackWarning): void;
    class DatabaseTableResultCallback extends BaseCallback implements IDatabaseTableResultCallback {
        onErrorFunction: (error: IDatabaseTableResultCallbackError) => void;
        onResultFunction: (databaseTable: DatabaseTable) => void;
        onWarningFunction: (databaseTable: DatabaseTable, warning: IDatabaseTableResultCallbackWarning) => void;
        /**
           Constructor with anonymous handler functions for callback.

           @param onErrorFunction Function receiving parameters of type: IDatabaseTableResultCallbackError
           @param onResultFunction Function receiving parameters of type: DatabaseTable
           @param onWarningFunction Function receiving parameters of type: DatabaseTable, IDatabaseTableResultCallbackWarning
        */
        constructor(onErrorFunction: (error: IDatabaseTableResultCallbackError) => void, onResultFunction: (databaseTable: DatabaseTable) => void, onWarningFunction: (databaseTable: DatabaseTable, warning: IDatabaseTableResultCallbackWarning) => void);
        /**
           Result callback for error responses

           @param error Returned error
           @since ARP1.0
        */
        onError(error: IDatabaseTableResultCallbackError): void;
        /**
           Result callback for correct responses

           @param databaseTable Returns the databaseTable
           @since ARP1.0
        */
        onResult(databaseTable: DatabaseTable): void;
        /**
           Result callback for warning responses

           @param databaseTable Returns the databaseTable
           @param warning       Returned Warning
           @since ARP1.0
        */
        onWarning(databaseTable: DatabaseTable, warning: IDatabaseTableResultCallbackWarning): void;
    }
    /**
       FileDataLoadResultCallback control dictionary.
    */
    var registeredFileDataLoadResultCallback: Dictionary<IFileDataLoadResultCallback>;
    /**
       FileDataLoadResultCallback global callback handlers.
    */
    function handleFileDataLoadResultCallbackError(id: number, error: IFileDataLoadResultCallbackError): void;
    function handleFileDataLoadResultCallbackResult(id: number, data: number[]): void;
    function handleFileDataLoadResultCallbackWarning(id: number, data: number[], warning: IFileDataLoadResultCallbackWarning): void;
    class FileDataLoadResultCallback extends BaseCallback implements IFileDataLoadResultCallback {
        onErrorFunction: (error: IFileDataLoadResultCallbackError) => void;
        onResultFunction: (data: number[]) => void;
        onWarningFunction: (data: number[], warning: IFileDataLoadResultCallbackWarning) => void;
        /**
           Constructor with anonymous handler functions for callback.

           @param onErrorFunction Function receiving parameters of type: IFileDataLoadResultCallbackError
           @param onResultFunction Function receiving parameters of type: Array<number>
           @param onWarningFunction Function receiving parameters of type: Array<number>, IFileDataLoadResultCallbackWarning
        */
        constructor(onErrorFunction: (error: IFileDataLoadResultCallbackError) => void, onResultFunction: (data: number[]) => void, onWarningFunction: (data: number[], warning: IFileDataLoadResultCallbackWarning) => void);
        /**
           Error processing data retrieval/storage operation.

           @param error Error condition encountered.
           @since ARP1.0
        */
        onError(error: IFileDataLoadResultCallbackError): void;
        /**
           Result of data retrieval operation.

           @param data Data loaded.
           @since ARP1.0
        */
        onResult(data: number[]): void;
        /**
           Result with warning of data retrieval/storage operation.

           @param data    File being loaded.
           @param warning Warning condition encountered.
           @since ARP1.0
        */
        onWarning(data: number[], warning: IFileDataLoadResultCallbackWarning): void;
    }
    /**
       FileDataStoreResultCallback control dictionary.
    */
    var registeredFileDataStoreResultCallback: Dictionary<IFileDataStoreResultCallback>;
    /**
       FileDataStoreResultCallback global callback handlers.
    */
    function handleFileDataStoreResultCallbackError(id: number, error: IFileDataStoreResultCallbackError): void;
    function handleFileDataStoreResultCallbackResult(id: number, file: FileDescriptor): void;
    function handleFileDataStoreResultCallbackWarning(id: number, file: FileDescriptor, warning: IFileDataStoreResultCallbackWarning): void;
    class FileDataStoreResultCallback extends BaseCallback implements IFileDataStoreResultCallback {
        onErrorFunction: (error: IFileDataStoreResultCallbackError) => void;
        onResultFunction: (file: FileDescriptor) => void;
        onWarningFunction: (file: FileDescriptor, warning: IFileDataStoreResultCallbackWarning) => void;
        /**
           Constructor with anonymous handler functions for callback.

           @param onErrorFunction Function receiving parameters of type: IFileDataStoreResultCallbackError
           @param onResultFunction Function receiving parameters of type: FileDescriptor
           @param onWarningFunction Function receiving parameters of type: FileDescriptor, IFileDataStoreResultCallbackWarning
        */
        constructor(onErrorFunction: (error: IFileDataStoreResultCallbackError) => void, onResultFunction: (file: FileDescriptor) => void, onWarningFunction: (file: FileDescriptor, warning: IFileDataStoreResultCallbackWarning) => void);
        /**
           Error processing data retrieval/storage operation.

           @param error Error condition encountered.
           @since ARP1.0
        */
        onError(error: IFileDataStoreResultCallbackError): void;
        /**
           Result of data storage operation.

           @param file File reference to stored data.
           @since ARP1.0
        */
        onResult(file: FileDescriptor): void;
        /**
           Result with warning of data retrieval/storage operation.

           @param file    File being loaded/stored.
           @param warning Warning condition encountered.
           @since ARP1.0
        */
        onWarning(file: FileDescriptor, warning: IFileDataStoreResultCallbackWarning): void;
    }
    /**
       FileListResultCallback control dictionary.
    */
    var registeredFileListResultCallback: Dictionary<IFileListResultCallback>;
    /**
       FileListResultCallback global callback handlers.
    */
    function handleFileListResultCallbackError(id: number, error: IFileListResultCallbackError): void;
    function handleFileListResultCallbackResult(id: number, files: FileDescriptor[]): void;
    function handleFileListResultCallbackWarning(id: number, files: FileDescriptor[], warning: IFileListResultCallbackWarning): void;
    class FileListResultCallback extends BaseCallback implements IFileListResultCallback {
        onErrorFunction: (error: IFileListResultCallbackError) => void;
        onResultFunction: (files: FileDescriptor[]) => void;
        onWarningFunction: (files: FileDescriptor[], warning: IFileListResultCallbackWarning) => void;
        /**
           Constructor with anonymous handler functions for callback.

           @param onErrorFunction Function receiving parameters of type: IFileListResultCallbackError
           @param onResultFunction Function receiving parameters of type: Array<FileDescriptor>
           @param onWarningFunction Function receiving parameters of type: Array<FileDescriptor>, IFileListResultCallbackWarning
        */
        constructor(onErrorFunction: (error: IFileListResultCallbackError) => void, onResultFunction: (files: FileDescriptor[]) => void, onWarningFunction: (files: FileDescriptor[], warning: IFileListResultCallbackWarning) => void);
        /**
           On error result of a file operation.

           @param error Error processing the request.
           @since ARP1.0
        */
        onError(error: IFileListResultCallbackError): void;
        /**
           On correct result of a file operation.

           @param files Array of resulting files/folders.
           @since ARP1.0
        */
        onResult(files: FileDescriptor[]): void;
        /**
           On partial result of a file operation, containing a warning.

           @param files   Array of resulting files/folders.
           @param warning Warning condition encountered.
           @since ARP1.0
        */
        onWarning(files: FileDescriptor[], warning: IFileListResultCallbackWarning): void;
    }
    /**
       FileResultCallback control dictionary.
    */
    var registeredFileResultCallback: Dictionary<IFileResultCallback>;
    /**
       FileResultCallback global callback handlers.
    */
    function handleFileResultCallbackError(id: number, error: IFileResultCallbackError): void;
    function handleFileResultCallbackResult(id: number, storageFile: FileDescriptor): void;
    function handleFileResultCallbackWarning(id: number, file: FileDescriptor, warning: IFileResultCallbackWarning): void;
    class FileResultCallback extends BaseCallback implements IFileResultCallback {
        onErrorFunction: (error: IFileResultCallbackError) => void;
        onResultFunction: (storageFile: FileDescriptor) => void;
        onWarningFunction: (file: FileDescriptor, warning: IFileResultCallbackWarning) => void;
        /**
           Constructor with anonymous handler functions for callback.

           @param onErrorFunction Function receiving parameters of type: IFileResultCallbackError
           @param onResultFunction Function receiving parameters of type: FileDescriptor
           @param onWarningFunction Function receiving parameters of type: FileDescriptor, IFileResultCallbackWarning
        */
        constructor(onErrorFunction: (error: IFileResultCallbackError) => void, onResultFunction: (storageFile: FileDescriptor) => void, onWarningFunction: (file: FileDescriptor, warning: IFileResultCallbackWarning) => void);
        /**
           On error result of a file operation.

           @param error Error processing the request.
           @since ARP1.0
        */
        onError(error: IFileResultCallbackError): void;
        /**
           On correct result of a file operation.

           @param storageFile Reference to the resulting file.
           @since ARP1.0
        */
        onResult(storageFile: FileDescriptor): void;
        /**
           On partial result of a file operation, containing a warning.

           @param file    Reference to the offending file.
           @param warning Warning processing the request.
           @since ARP1.0
        */
        onWarning(file: FileDescriptor, warning: IFileResultCallbackWarning): void;
    }
    /**
       MessagingCallback control dictionary.
    */
    var registeredMessagingCallback: Dictionary<IMessagingCallback>;
    /**
       MessagingCallback global callback handlers.
    */
    function handleMessagingCallbackError(id: number, error: IMessagingCallbackError): void;
    function handleMessagingCallbackResult(id: number, success: boolean): void;
    function handleMessagingCallbackWarning(id: number, success: boolean, warning: IMessagingCallbackWarning): void;
    class MessagingCallback extends BaseCallback implements IMessagingCallback {
        onErrorFunction: (error: IMessagingCallbackError) => void;
        onResultFunction: (success: boolean) => void;
        onWarningFunction: (success: boolean, warning: IMessagingCallbackWarning) => void;
        /**
           Constructor with anonymous handler functions for callback.

           @param onErrorFunction Function receiving parameters of type: IMessagingCallbackError
           @param onResultFunction Function receiving parameters of type: boolean
           @param onWarningFunction Function receiving parameters of type: boolean, IMessagingCallbackWarning
        */
        constructor(onErrorFunction: (error: IMessagingCallbackError) => void, onResultFunction: (success: boolean) => void, onWarningFunction: (success: boolean, warning: IMessagingCallbackWarning) => void);
        /**
           This method is called on Error

           @param error returned by the platform
           @since ARP1.0
        */
        onError(error: IMessagingCallbackError): void;
        /**
           This method is called on Result

           @param success true if sent;false otherwise
           @since ARP1.0
        */
        onResult(success: boolean): void;
        /**
           This method is called on Warning

           @param success true if sent;false otherwise
           @param warning returned by the platform
           @since ARP1.0
        */
        onWarning(success: boolean, warning: IMessagingCallbackWarning): void;
    }
    /**
       NetworkReachabilityCallback control dictionary.
    */
    var registeredNetworkReachabilityCallback: Dictionary<INetworkReachabilityCallback>;
    /**
       NetworkReachabilityCallback global callback handlers.
    */
    function handleNetworkReachabilityCallbackError(id: number, error: INetworkReachabilityCallbackError): void;
    function handleNetworkReachabilityCallbackResult(id: number, reachable: boolean): void;
    function handleNetworkReachabilityCallbackWarning(id: number, reachable: boolean, warning: INetworkReachabilityCallbackWarning): void;
    class NetworkReachabilityCallback extends BaseCallback implements INetworkReachabilityCallback {
        onErrorFunction: (error: INetworkReachabilityCallbackError) => void;
        onResultFunction: (reachable: boolean) => void;
        onWarningFunction: (reachable: boolean, warning: INetworkReachabilityCallbackWarning) => void;
        /**
           Constructor with anonymous handler functions for callback.

           @param onErrorFunction Function receiving parameters of type: INetworkReachabilityCallbackError
           @param onResultFunction Function receiving parameters of type: boolean
           @param onWarningFunction Function receiving parameters of type: boolean, INetworkReachabilityCallbackWarning
        */
        constructor(onErrorFunction: (error: INetworkReachabilityCallbackError) => void, onResultFunction: (reachable: boolean) => void, onWarningFunction: (reachable: boolean, warning: INetworkReachabilityCallbackWarning) => void);
        /**
           No data received - error condition, not authorized .

           @param error Error value
           @since ARP1.0
        */
        onError(error: INetworkReachabilityCallbackError): void;
        /**
           Correct data received.

           @param reachable Indicates if the host is reachable
           @since ARP1.0
        */
        onResult(reachable: boolean): void;
        /**
           Data received with warning - ie Found entries with existing key and values have been overriden

           @param reachable Indicates if the host is reachable
           @param warning   Warning value
           @since ARP1.0
        */
        onWarning(reachable: boolean, warning: INetworkReachabilityCallbackWarning): void;
    }
    /**
       SecurityResultCallback control dictionary.
    */
    var registeredSecurityResultCallback: Dictionary<ISecurityResultCallback>;
    /**
       SecurityResultCallback global callback handlers.
    */
    function handleSecurityResultCallbackError(id: number, error: ISecurityResultCallbackError): void;
    function handleSecurityResultCallbackResult(id: number, keyValues: SecureKeyPair[]): void;
    function handleSecurityResultCallbackWarning(id: number, keyValues: SecureKeyPair[], warning: ISecurityResultCallbackWarning): void;
    class SecurityResultCallback extends BaseCallback implements ISecurityResultCallback {
        onErrorFunction: (error: ISecurityResultCallbackError) => void;
        onResultFunction: (keyValues: SecureKeyPair[]) => void;
        onWarningFunction: (keyValues: SecureKeyPair[], warning: ISecurityResultCallbackWarning) => void;
        /**
           Constructor with anonymous handler functions for callback.

           @param onErrorFunction Function receiving parameters of type: ISecurityResultCallbackError
           @param onResultFunction Function receiving parameters of type: Array<SecureKeyPair>
           @param onWarningFunction Function receiving parameters of type: Array<SecureKeyPair>, ISecurityResultCallbackWarning
        */
        constructor(onErrorFunction: (error: ISecurityResultCallbackError) => void, onResultFunction: (keyValues: SecureKeyPair[]) => void, onWarningFunction: (keyValues: SecureKeyPair[], warning: ISecurityResultCallbackWarning) => void);
        /**
           No data received - error condition, not authorized .

           @param error Error values
           @since ARP1.0
        */
        onError(error: ISecurityResultCallbackError): void;
        /**
           Correct data received.

           @param keyValues key and values
           @since ARP1.0
        */
        onResult(keyValues: SecureKeyPair[]): void;
        /**
           Data received with warning - ie Found entries with existing key and values have been overriden

           @param keyValues key and values
           @param warning   Warning values
           @since ARP1.0
        */
        onWarning(keyValues: SecureKeyPair[], warning: ISecurityResultCallbackWarning): void;
    }
    /**
       ServiceResultCallback control dictionary.
    */
    var registeredServiceResultCallback: Dictionary<IServiceResultCallback>;
    /**
       ServiceResultCallback global callback handlers.
    */
    function handleServiceResultCallbackError(id: number, error: IServiceResultCallbackError): void;
    function handleServiceResultCallbackResult(id: number, response: ServiceResponse): void;
    function handleServiceResultCallbackWarning(id: number, response: ServiceResponse, warning: IServiceResultCallbackWarning): void;
    class ServiceResultCallback extends BaseCallback implements IServiceResultCallback {
        onErrorFunction: (error: IServiceResultCallbackError) => void;
        onResultFunction: (response: ServiceResponse) => void;
        onWarningFunction: (response: ServiceResponse, warning: IServiceResultCallbackWarning) => void;
        /**
           Constructor with anonymous handler functions for callback.

           @param onErrorFunction Function receiving parameters of type: IServiceResultCallbackError
           @param onResultFunction Function receiving parameters of type: ServiceResponse
           @param onWarningFunction Function receiving parameters of type: ServiceResponse, IServiceResultCallbackWarning
        */
        constructor(onErrorFunction: (error: IServiceResultCallbackError) => void, onResultFunction: (response: ServiceResponse) => void, onWarningFunction: (response: ServiceResponse, warning: IServiceResultCallbackWarning) => void);
        /**
           This method is called on Error

           @param error returned by the platform
           @since ARP1.0
        */
        onError(error: IServiceResultCallbackError): void;
        /**
           This method is called on Result

           @param response data
           @since ARP1.0
        */
        onResult(response: ServiceResponse): void;
        /**
           This method is called on Warning

           @param response data
           @param warning  returned by the platform
           @since ARP1.0
        */
        onWarning(response: ServiceResponse, warning: IServiceResultCallbackWarning): void;
    }
    /**
       Base application for Application purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    class BaseApplicationBridge implements IBaseApplication {
        /**
           Group of API.
        */
        apiGroup: IAdaptiveRPGroup;
        /**
           Default constructor.
        */
        constructor();
        /**
           Return the API group for the given interface.
        */
        getAPIGroup(): IAdaptiveRPGroup;
        /**
           Return the API version for the given interface.

           @return {String} The version of the API.
        */
        getAPIVersion(): string;
    }
    /**
       Base application for Commerce purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    class BaseCommerceBridge implements IBaseCommerce {
        /**
           Group of API.
        */
        apiGroup: IAdaptiveRPGroup;
        /**
           Default constructor.
        */
        constructor();
        /**
           Return the API group for the given interface.
        */
        getAPIGroup(): IAdaptiveRPGroup;
        /**
           Return the API version for the given interface.

           @return {String} The version of the API.
        */
        getAPIVersion(): string;
    }
    /**
       Base application for Communication purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    class BaseCommunicationBridge implements IBaseCommunication {
        /**
           Group of API.
        */
        apiGroup: IAdaptiveRPGroup;
        /**
           Default constructor.
        */
        constructor();
        /**
           Return the API group for the given interface.
        */
        getAPIGroup(): IAdaptiveRPGroup;
        /**
           Return the API version for the given interface.

           @return {String} The version of the API.
        */
        getAPIVersion(): string;
    }
    /**
       Base application for Data purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    class BaseDataBridge implements IBaseData {
        /**
           Group of API.
        */
        apiGroup: IAdaptiveRPGroup;
        /**
           Default constructor.
        */
        constructor();
        /**
           Return the API group for the given interface.
        */
        getAPIGroup(): IAdaptiveRPGroup;
        /**
           Return the API version for the given interface.

           @return {String} The version of the API.
        */
        getAPIVersion(): string;
    }
    /**
       Base application for Media purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    class BaseMediaBridge implements IBaseMedia {
        /**
           Group of API.
        */
        apiGroup: IAdaptiveRPGroup;
        /**
           Default constructor.
        */
        constructor();
        /**
           Return the API group for the given interface.
        */
        getAPIGroup(): IAdaptiveRPGroup;
        /**
           Return the API version for the given interface.

           @return {String} The version of the API.
        */
        getAPIVersion(): string;
    }
    /**
       Base application for Notification purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    class BaseNotificationBridge implements IBaseNotification {
        /**
           Group of API.
        */
        apiGroup: IAdaptiveRPGroup;
        /**
           Default constructor.
        */
        constructor();
        /**
           Return the API group for the given interface.
        */
        getAPIGroup(): IAdaptiveRPGroup;
        /**
           Return the API version for the given interface.

           @return {String} The version of the API.
        */
        getAPIVersion(): string;
    }
    /**
       Base application for PIM purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    class BasePIMBridge implements IBasePIM {
        /**
           Group of API.
        */
        apiGroup: IAdaptiveRPGroup;
        /**
           Default constructor.
        */
        constructor();
        /**
           Return the API group for the given interface.
        */
        getAPIGroup(): IAdaptiveRPGroup;
        /**
           Return the API version for the given interface.

           @return {String} The version of the API.
        */
        getAPIVersion(): string;
    }
    /**
       Base application for Reader purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    class BaseReaderBridge implements IBaseReader {
        /**
           Group of API.
        */
        apiGroup: IAdaptiveRPGroup;
        /**
           Default constructor.
        */
        constructor();
        /**
           Return the API group for the given interface.
        */
        getAPIGroup(): IAdaptiveRPGroup;
        /**
           Return the API version for the given interface.

           @return {String} The version of the API.
        */
        getAPIVersion(): string;
    }
    /**
       Base application for Security purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    class BaseSecurityBridge implements IBaseSecurity {
        /**
           Group of API.
        */
        apiGroup: IAdaptiveRPGroup;
        /**
           Default constructor.
        */
        constructor();
        /**
           Return the API group for the given interface.
        */
        getAPIGroup(): IAdaptiveRPGroup;
        /**
           Return the API version for the given interface.

           @return {String} The version of the API.
        */
        getAPIVersion(): string;
    }
    /**
       Base application for Sensor purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    class BaseSensorBridge implements IBaseSensor {
        /**
           Group of API.
        */
        apiGroup: IAdaptiveRPGroup;
        /**
           Default constructor.
        */
        constructor();
        /**
           Return the API group for the given interface.
        */
        getAPIGroup(): IAdaptiveRPGroup;
        /**
           Return the API version for the given interface.

           @return {String} The version of the API.
        */
        getAPIVersion(): string;
    }
    /**
       Base application for Social purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    class BaseSocialBridge implements IBaseSocial {
        /**
           Group of API.
        */
        apiGroup: IAdaptiveRPGroup;
        /**
           Default constructor.
        */
        constructor();
        /**
           Return the API group for the given interface.
        */
        getAPIGroup(): IAdaptiveRPGroup;
        /**
           Return the API version for the given interface.

           @return {String} The version of the API.
        */
        getAPIVersion(): string;
    }
    /**
       Base application for System purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    class BaseSystemBridge implements IBaseSystem {
        /**
           Group of API.
        */
        apiGroup: IAdaptiveRPGroup;
        /**
           Default constructor.
        */
        constructor();
        /**
           Return the API group for the given interface.
        */
        getAPIGroup(): IAdaptiveRPGroup;
        /**
           Return the API version for the given interface.

           @return {String} The version of the API.
        */
        getAPIVersion(): string;
    }
    /**
       Base application for UI purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    class BaseUIBridge implements IBaseUI {
        /**
           Group of API.
        */
        apiGroup: IAdaptiveRPGroup;
        /**
           Default constructor.
        */
        constructor();
        /**
           Return the API group for the given interface.
        */
        getAPIGroup(): IAdaptiveRPGroup;
        /**
           Return the API version for the given interface.

           @return {String} The version of the API.
        */
        getAPIVersion(): string;
    }
    /**
       Base application for Utility purposes

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    class BaseUtilBridge implements IBaseUtil {
        /**
           Group of API.
        */
        apiGroup: IAdaptiveRPGroup;
        /**
           Default constructor.
        */
        constructor();
        /**
           Return the API group for the given interface.
        */
        getAPIGroup(): IAdaptiveRPGroup;
        /**
           Return the API version for the given interface.

           @return {String} The version of the API.
        */
        getAPIVersion(): string;
    }
    /**
       Interface to retrieve auto-registered service implementation references.

       @author Carlos Lozano Diez
       @since ARP1.0
    */
    class AppRegistryBridge implements IAppRegistry {
        /**
           Singleton instance of AppRegistry.
        */
        private static instance;
        static getInstance(): IAppRegistry;
        /**
           Singleton instances of Bridges.
        */
        private static instanceAcceleration;
        private static instanceAds;
        private static instanceAlarm;
        private static instanceAmbientLight;
        private static instanceAnalytics;
        private static instanceAudio;
        private static instanceBarcode;
        private static instanceBarometer;
        private static instanceBluetooth;
        private static instanceBrowser;
        private static instanceCalendar;
        private static instanceCamera;
        private static instanceCapabilities;
        private static instanceCloud;
        private static instanceCompression;
        private static instanceConcurrent;
        private static instanceContact;
        private static instanceCrypto;
        private static instanceDataStream;
        private static instanceDatabase;
        private static instanceDesktop;
        private static instanceDevice;
        private static instanceDisplay;
        private static instanceFacebook;
        private static instanceFile;
        private static instanceFileSystem;
        private static instanceGeolocation;
        private static instanceGlobalization;
        private static instanceGooglePlus;
        private static instanceGyroscope;
        private static instanceImaging;
        private static instanceInternalStorage;
        private static instanceLifecycle;
        private static instanceLinkedIn;
        private static instanceLogging;
        private static instanceMagnetometer;
        private static instanceMail;
        private static instanceManagement;
        private static instanceMap;
        private static instanceMessaging;
        private static instanceNFC;
        private static instanceNetworkInfo;
        private static instanceNetworkNaming;
        private static instanceNetworkReachability;
        private static instanceNetworkStatus;
        private static instanceNotification;
        private static instanceNotificationLocal;
        private static instanceOAuth;
        private static instanceOCR;
        private static instanceOS;
        private static instanceOpenId;
        private static instancePrinting;
        private static instanceProximity;
        private static instanceQRCode;
        private static instanceRSS;
        private static instanceRuntime;
        private static instanceSecurity;
        private static instanceService;
        private static instanceSettings;
        private static instanceSocket;
        private static instanceStore;
        private static instanceTelephony;
        private static instanceTimer;
        private static instanceTwitter;
        private static instanceUI;
        private static instanceUpdate;
        private static instanceVibration;
        private static instanceVideo;
        private static instanceWallet;
        private static instanceXML;
        /**
           Obtain a reference to the IAcceleration bridge.

           @return IAcceleration bridge instance.
        */
        getAccelerationBridge(): IAcceleration;
        /**
           Obtain a reference to the IAds bridge.

           @return IAds bridge instance.
        */
        getAdsBridge(): IAds;
        /**
           Obtain a reference to the IAlarm bridge.

           @return IAlarm bridge instance.
        */
        getAlarmBridge(): IAlarm;
        /**
           Obtain a reference to the IAmbientLight bridge.

           @return IAmbientLight bridge instance.
        */
        getAmbientLightBridge(): IAmbientLight;
        /**
           Obtain a reference to the IAnalytics bridge.

           @return IAnalytics bridge instance.
        */
        getAnalyticsBridge(): IAnalytics;
        /**
           Obtain a reference to the IAudio bridge.

           @return IAudio bridge instance.
        */
        getAudioBridge(): IAudio;
        /**
           Obtain a reference to the IBarcode bridge.

           @return IBarcode bridge instance.
        */
        getBarcodeBridge(): IBarcode;
        /**
           Obtain a reference to the IBarometer bridge.

           @return IBarometer bridge instance.
        */
        getBarometerBridge(): IBarometer;
        /**
           Obtain a reference to the IBluetooth bridge.

           @return IBluetooth bridge instance.
        */
        getBluetoothBridge(): IBluetooth;
        /**
           Obtain a reference to the IBrowser bridge.

           @return IBrowser bridge instance.
        */
        getBrowserBridge(): IBrowser;
        /**
           Obtain a reference to the ICalendar bridge.

           @return ICalendar bridge instance.
        */
        getCalendarBridge(): ICalendar;
        /**
           Obtain a reference to the ICamera bridge.

           @return ICamera bridge instance.
        */
        getCameraBridge(): ICamera;
        /**
           Obtain a reference to the ICapabilities bridge.

           @return ICapabilities bridge instance.
        */
        getCapabilitiesBridge(): ICapabilities;
        /**
           Obtain a reference to the ICloud bridge.

           @return ICloud bridge instance.
        */
        getCloudBridge(): ICloud;
        /**
           Obtain a reference to the ICompression bridge.

           @return ICompression bridge instance.
        */
        getCompressionBridge(): ICompression;
        /**
           Obtain a reference to the IConcurrent bridge.

           @return IConcurrent bridge instance.
        */
        getConcurrentBridge(): IConcurrent;
        /**
           Obtain a reference to the IContact bridge.

           @return IContact bridge instance.
        */
        getContactBridge(): IContact;
        /**
           Obtain a reference to the ICrypto bridge.

           @return ICrypto bridge instance.
        */
        getCryptoBridge(): ICrypto;
        /**
           Obtain a reference to the IDataStream bridge.

           @return IDataStream bridge instance.
        */
        getDataStreamBridge(): IDataStream;
        /**
           Obtain a reference to the IDatabase bridge.

           @return IDatabase bridge instance.
        */
        getDatabaseBridge(): IDatabase;
        /**
           Obtain a reference to the IDesktop bridge.

           @return IDesktop bridge instance.
        */
        getDesktopBridge(): IDesktop;
        /**
           Obtain a reference to the IDevice bridge.

           @return IDevice bridge instance.
        */
        getDeviceBridge(): IDevice;
        /**
           Obtain a reference to the IDisplay bridge.

           @return IDisplay bridge instance.
        */
        getDisplayBridge(): IDisplay;
        /**
           Obtain a reference to the IFacebook bridge.

           @return IFacebook bridge instance.
        */
        getFacebookBridge(): IFacebook;
        /**
           Obtain a reference to the IFile bridge.

           @return IFile bridge instance.
        */
        getFileBridge(): IFile;
        /**
           Obtain a reference to the IFileSystem bridge.

           @return IFileSystem bridge instance.
        */
        getFileSystemBridge(): IFileSystem;
        /**
           Obtain a reference to the IGeolocation bridge.

           @return IGeolocation bridge instance.
        */
        getGeolocationBridge(): IGeolocation;
        /**
           Obtain a reference to the IGlobalization bridge.

           @return IGlobalization bridge instance.
        */
        getGlobalizationBridge(): IGlobalization;
        /**
           Obtain a reference to the IGooglePlus bridge.

           @return IGooglePlus bridge instance.
        */
        getGooglePlusBridge(): IGooglePlus;
        /**
           Obtain a reference to the IGyroscope bridge.

           @return IGyroscope bridge instance.
        */
        getGyroscopeBridge(): IGyroscope;
        /**
           Obtain a reference to the IImaging bridge.

           @return IImaging bridge instance.
        */
        getImagingBridge(): IImaging;
        /**
           Obtain a reference to the IInternalStorage bridge.

           @return IInternalStorage bridge instance.
        */
        getInternalStorageBridge(): IInternalStorage;
        /**
           Obtain a reference to the ILifecycle bridge.

           @return ILifecycle bridge instance.
        */
        getLifecycleBridge(): ILifecycle;
        /**
           Obtain a reference to the ILinkedIn bridge.

           @return ILinkedIn bridge instance.
        */
        getLinkedInBridge(): ILinkedIn;
        /**
           Obtain a reference to the ILogging bridge.

           @return ILogging bridge instance.
        */
        getLoggingBridge(): ILogging;
        /**
           Obtain a reference to the IMagnetometer bridge.

           @return IMagnetometer bridge instance.
        */
        getMagnetometerBridge(): IMagnetometer;
        /**
           Obtain a reference to the IMail bridge.

           @return IMail bridge instance.
        */
        getMailBridge(): IMail;
        /**
           Obtain a reference to the IManagement bridge.

           @return IManagement bridge instance.
        */
        getManagementBridge(): IManagement;
        /**
           Obtain a reference to the IMap bridge.

           @return IMap bridge instance.
        */
        getMapBridge(): IMap;
        /**
           Obtain a reference to the IMessaging bridge.

           @return IMessaging bridge instance.
        */
        getMessagingBridge(): IMessaging;
        /**
           Obtain a reference to the INFC bridge.

           @return INFC bridge instance.
        */
        getNFCBridge(): INFC;
        /**
           Obtain a reference to the INetworkInfo bridge.

           @return INetworkInfo bridge instance.
        */
        getNetworkInfoBridge(): INetworkInfo;
        /**
           Obtain a reference to the INetworkNaming bridge.

           @return INetworkNaming bridge instance.
        */
        getNetworkNamingBridge(): INetworkNaming;
        /**
           Obtain a reference to the INetworkReachability bridge.

           @return INetworkReachability bridge instance.
        */
        getNetworkReachabilityBridge(): INetworkReachability;
        /**
           Obtain a reference to the INetworkStatus bridge.

           @return INetworkStatus bridge instance.
        */
        getNetworkStatusBridge(): INetworkStatus;
        /**
           Obtain a reference to the INotification bridge.

           @return INotification bridge instance.
        */
        getNotificationBridge(): INotification;
        /**
           Obtain a reference to the INotificationLocal bridge.

           @return INotificationLocal bridge instance.
        */
        getNotificationLocalBridge(): INotificationLocal;
        /**
           Obtain a reference to the IOAuth bridge.

           @return IOAuth bridge instance.
        */
        getOAuthBridge(): IOAuth;
        /**
           Obtain a reference to the IOCR bridge.

           @return IOCR bridge instance.
        */
        getOCRBridge(): IOCR;
        /**
           Obtain a reference to the IOS bridge.

           @return IOS bridge instance.
        */
        getOSBridge(): IOS;
        /**
           Obtain a reference to the IOpenId bridge.

           @return IOpenId bridge instance.
        */
        getOpenIdBridge(): IOpenId;
        /**
           Obtain a reference to the IPrinting bridge.

           @return IPrinting bridge instance.
        */
        getPrintingBridge(): IPrinting;
        /**
           Obtain a reference to the IProximity bridge.

           @return IProximity bridge instance.
        */
        getProximityBridge(): IProximity;
        /**
           Obtain a reference to the IQRCode bridge.

           @return IQRCode bridge instance.
        */
        getQRCodeBridge(): IQRCode;
        /**
           Obtain a reference to the IRSS bridge.

           @return IRSS bridge instance.
        */
        getRSSBridge(): IRSS;
        /**
           Obtain a reference to the IRuntime bridge.

           @return IRuntime bridge instance.
        */
        getRuntimeBridge(): IRuntime;
        /**
           Obtain a reference to the ISecurity bridge.

           @return ISecurity bridge instance.
        */
        getSecurityBridge(): ISecurity;
        /**
           Obtain a reference to the IService bridge.

           @return IService bridge instance.
        */
        getServiceBridge(): IService;
        /**
           Obtain a reference to the ISettings bridge.

           @return ISettings bridge instance.
        */
        getSettingsBridge(): ISettings;
        /**
           Obtain a reference to the ISocket bridge.

           @return ISocket bridge instance.
        */
        getSocketBridge(): ISocket;
        /**
           Obtain a reference to the IStore bridge.

           @return IStore bridge instance.
        */
        getStoreBridge(): IStore;
        /**
           Obtain a reference to the ITelephony bridge.

           @return ITelephony bridge instance.
        */
        getTelephonyBridge(): ITelephony;
        /**
           Obtain a reference to the ITimer bridge.

           @return ITimer bridge instance.
        */
        getTimerBridge(): ITimer;
        /**
           Obtain a reference to the ITwitter bridge.

           @return ITwitter bridge instance.
        */
        getTwitterBridge(): ITwitter;
        /**
           Obtain a reference to the IUI bridge.

           @return IUI bridge instance.
        */
        getUIBridge(): IUI;
        /**
           Obtain a reference to the IUpdate bridge.

           @return IUpdate bridge instance.
        */
        getUpdateBridge(): IUpdate;
        /**
           Obtain a reference to the IVibration bridge.

           @return IVibration bridge instance.
        */
        getVibrationBridge(): IVibration;
        /**
           Obtain a reference to the IVideo bridge.

           @return IVideo bridge instance.
        */
        getVideoBridge(): IVideo;
        /**
           Obtain a reference to the IWallet bridge.

           @return IWallet bridge instance.
        */
        getWalletBridge(): IWallet;
        /**
           Obtain a reference to the IXML bridge.

           @return IXML bridge instance.
        */
        getXMLBridge(): IXML;
        /**
           Return the API version for the given interface.

           @return {String} The version of the API.
        */
        getAPIVersion(): string;
    }
    /**
       Enumeration ContactAddressType
    */
    class ContactAddressType {
        value: string;
        constructor(value: string);
        toString(): string;
        static Home: ContactAddressType;
        static Work: ContactAddressType;
        static Other: ContactAddressType;
        static Unknown: ContactAddressType;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): ContactAddressType;
    }
    /**
       Enumeration ContactEmailType
    */
    class ContactEmailType {
        value: string;
        constructor(value: string);
        toString(): string;
        static Personal: ContactEmailType;
        static Work: ContactEmailType;
        static Other: ContactEmailType;
        static Unknown: ContactEmailType;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): ContactEmailType;
    }
    /**
       Enumeration ContactPersonalInfoTitle
    */
    class ContactPersonalInfoTitle {
        value: string;
        constructor(value: string);
        toString(): string;
        static Mr: ContactPersonalInfoTitle;
        static Mrs: ContactPersonalInfoTitle;
        static Ms: ContactPersonalInfoTitle;
        static Dr: ContactPersonalInfoTitle;
        static Unknown: ContactPersonalInfoTitle;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): ContactPersonalInfoTitle;
    }
    /**
       Enumeration ContactPhoneType
    */
    class ContactPhoneType {
        value: string;
        constructor(value: string);
        toString(): string;
        static Mobile: ContactPhoneType;
        static Work: ContactPhoneType;
        static Home: ContactPhoneType;
        static Main: ContactPhoneType;
        static HomeFax: ContactPhoneType;
        static WorkFax: ContactPhoneType;
        static Other: ContactPhoneType;
        static Unknown: ContactPhoneType;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): ContactPhoneType;
    }
    /**
       Enumeration ContactSocialNetwork
    */
    class ContactSocialNetwork {
        value: string;
        constructor(value: string);
        toString(): string;
        static Twitter: ContactSocialNetwork;
        static Facebook: ContactSocialNetwork;
        static GooglePlus: ContactSocialNetwork;
        static LinkedIn: ContactSocialNetwork;
        static Flickr: ContactSocialNetwork;
        static Unknown: ContactSocialNetwork;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): ContactSocialNetwork;
    }
    /**
       Enumeration IAccelerationListenerError
    */
    class IAccelerationListenerError {
        value: string;
        constructor(value: string);
        toString(): string;
        static Unauthorized: IAccelerationListenerError;
        static Unavailable: IAccelerationListenerError;
        static Unknown: IAccelerationListenerError;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IAccelerationListenerError;
    }
    /**
       Enumeration IAccelerationListenerWarning
    */
    class IAccelerationListenerWarning {
        value: string;
        constructor(value: string);
        toString(): string;
        static NeedsCalibration: IAccelerationListenerWarning;
        static Stale: IAccelerationListenerWarning;
        static Unknown: IAccelerationListenerWarning;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IAccelerationListenerWarning;
    }
    /**
       Enumeration IAdaptiveRPGroup
    */
    class IAdaptiveRPGroup {
        value: string;
        constructor(value: string);
        toString(): string;
        static Application: IAdaptiveRPGroup;
        static Commerce: IAdaptiveRPGroup;
        static Communication: IAdaptiveRPGroup;
        static Data: IAdaptiveRPGroup;
        static Media: IAdaptiveRPGroup;
        static Notification: IAdaptiveRPGroup;
        static PIM: IAdaptiveRPGroup;
        static Reader: IAdaptiveRPGroup;
        static Security: IAdaptiveRPGroup;
        static Sensor: IAdaptiveRPGroup;
        static Social: IAdaptiveRPGroup;
        static System: IAdaptiveRPGroup;
        static UI: IAdaptiveRPGroup;
        static Util: IAdaptiveRPGroup;
        static Kernel: IAdaptiveRPGroup;
        static Unknown: IAdaptiveRPGroup;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IAdaptiveRPGroup;
    }
    /**
       Enumeration IButtonListenerError
    */
    class IButtonListenerError {
        value: string;
        constructor(value: string);
        toString(): string;
        static Not_Present: IButtonListenerError;
        static Unknown: IButtonListenerError;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IButtonListenerError;
    }
    /**
       Enumeration IButtonListenerWarning
    */
    class IButtonListenerWarning {
        value: string;
        constructor(value: string);
        toString(): string;
        static Not_Implemented: IButtonListenerWarning;
        static Unknown: IButtonListenerWarning;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IButtonListenerWarning;
    }
    /**
       Enumeration ICapabilitiesButton
    */
    class ICapabilitiesButton {
        value: string;
        constructor(value: string);
        toString(): string;
        static HomeButton: ICapabilitiesButton;
        static BackButton: ICapabilitiesButton;
        static OptionButton: ICapabilitiesButton;
        static Unknown: ICapabilitiesButton;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): ICapabilitiesButton;
    }
    /**
       Enumeration ICapabilitiesCommunication
    */
    class ICapabilitiesCommunication {
        value: string;
        constructor(value: string);
        toString(): string;
        static Calendar: ICapabilitiesCommunication;
        static Contact: ICapabilitiesCommunication;
        static Mail: ICapabilitiesCommunication;
        static Messaging: ICapabilitiesCommunication;
        static Telephony: ICapabilitiesCommunication;
        static Unknown: ICapabilitiesCommunication;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): ICapabilitiesCommunication;
    }
    /**
       Enumeration ICapabilitiesData
    */
    class ICapabilitiesData {
        value: string;
        constructor(value: string);
        toString(): string;
        static Database: ICapabilitiesData;
        static File: ICapabilitiesData;
        static Cloud: ICapabilitiesData;
        static Unknown: ICapabilitiesData;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): ICapabilitiesData;
    }
    /**
       Enumeration ICapabilitiesMedia
    */
    class ICapabilitiesMedia {
        value: string;
        constructor(value: string);
        toString(): string;
        static Audio_Playback: ICapabilitiesMedia;
        static Audio_Recording: ICapabilitiesMedia;
        static Camera: ICapabilitiesMedia;
        static Video_Playback: ICapabilitiesMedia;
        static Video_Recording: ICapabilitiesMedia;
        static Unknown: ICapabilitiesMedia;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): ICapabilitiesMedia;
    }
    /**
       Enumeration ICapabilitiesNet
    */
    class ICapabilitiesNet {
        value: string;
        constructor(value: string);
        toString(): string;
        static GSM: ICapabilitiesNet;
        static GPRS: ICapabilitiesNet;
        static HSDPA: ICapabilitiesNet;
        static LTE: ICapabilitiesNet;
        static WIFI: ICapabilitiesNet;
        static Ethernet: ICapabilitiesNet;
        static Unavailable: ICapabilitiesNet;
        static Unknown: ICapabilitiesNet;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): ICapabilitiesNet;
    }
    /**
       Enumeration ICapabilitiesNotification
    */
    class ICapabilitiesNotification {
        value: string;
        constructor(value: string);
        toString(): string;
        static Alarm: ICapabilitiesNotification;
        static LocalNotification: ICapabilitiesNotification;
        static RemoteNotification: ICapabilitiesNotification;
        static Vibration: ICapabilitiesNotification;
        static Unknown: ICapabilitiesNotification;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): ICapabilitiesNotification;
    }
    /**
       Enumeration ICapabilitiesSensor
    */
    class ICapabilitiesSensor {
        value: string;
        constructor(value: string);
        toString(): string;
        static Accelerometer: ICapabilitiesSensor;
        static AmbientLight: ICapabilitiesSensor;
        static Barometer: ICapabilitiesSensor;
        static Geolocation: ICapabilitiesSensor;
        static Gyroscope: ICapabilitiesSensor;
        static Magnetometer: ICapabilitiesSensor;
        static Proximity: ICapabilitiesSensor;
        static Unknown: ICapabilitiesSensor;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): ICapabilitiesSensor;
    }
    /**
       Enumeration IContactFieldGroup
    */
    class IContactFieldGroup {
        value: string;
        constructor(value: string);
        toString(): string;
        static PERSONAL_INFO: IContactFieldGroup;
        static PROFESSIONAL_INFO: IContactFieldGroup;
        static ADDRESSES: IContactFieldGroup;
        static PHONES: IContactFieldGroup;
        static EMAILS: IContactFieldGroup;
        static WEBSITES: IContactFieldGroup;
        static SOCIALS: IContactFieldGroup;
        static TAGS: IContactFieldGroup;
        static Unknown: IContactFieldGroup;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IContactFieldGroup;
    }
    /**
       Enumeration IContactFilter
    */
    class IContactFilter {
        value: string;
        constructor(value: string);
        toString(): string;
        static HAS_PHONE: IContactFilter;
        static HAS_EMAIL: IContactFilter;
        static HAS_ADDRESS: IContactFilter;
        static Unknown: IContactFilter;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IContactFilter;
    }
    /**
       Enumeration IContactPhotoResultCallbackError
    */
    class IContactPhotoResultCallbackError {
        value: string;
        constructor(value: string);
        toString(): string;
        static NoPermission: IContactPhotoResultCallbackError;
        static Wrong_Params: IContactPhotoResultCallbackError;
        static No_Photo: IContactPhotoResultCallbackError;
        static Unknown: IContactPhotoResultCallbackError;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IContactPhotoResultCallbackError;
    }
    /**
       Enumeration IContactPhotoResultCallbackWarning
    */
    class IContactPhotoResultCallbackWarning {
        value: string;
        constructor(value: string);
        toString(): string;
        static LimitExceeded: IContactPhotoResultCallbackWarning;
        static No_Matches: IContactPhotoResultCallbackWarning;
        static Unknown: IContactPhotoResultCallbackWarning;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IContactPhotoResultCallbackWarning;
    }
    /**
       Enumeration IContactResultCallbackError
    */
    class IContactResultCallbackError {
        value: string;
        constructor(value: string);
        toString(): string;
        static NoPermission: IContactResultCallbackError;
        static Wrong_Params: IContactResultCallbackError;
        static Unknown: IContactResultCallbackError;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IContactResultCallbackError;
    }
    /**
       Enumeration IContactResultCallbackWarning
    */
    class IContactResultCallbackWarning {
        value: string;
        constructor(value: string);
        toString(): string;
        static LimitExceeded: IContactResultCallbackWarning;
        static No_Matches: IContactResultCallbackWarning;
        static Unknown: IContactResultCallbackWarning;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IContactResultCallbackWarning;
    }
    /**
       Enumeration IDatabaseResultCallbackError
    */
    class IDatabaseResultCallbackError {
        value: string;
        constructor(value: string);
        toString(): string;
        static NoSpace: IDatabaseResultCallbackError;
        static SqlException: IDatabaseResultCallbackError;
        static NotDeleted: IDatabaseResultCallbackError;
        static Unknown: IDatabaseResultCallbackError;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IDatabaseResultCallbackError;
    }
    /**
       Enumeration IDatabaseResultCallbackWarning
    */
    class IDatabaseResultCallbackWarning {
        value: string;
        constructor(value: string);
        toString(): string;
        static DatabaseExists: IDatabaseResultCallbackWarning;
        static IsOpen: IDatabaseResultCallbackWarning;
        static Unknown: IDatabaseResultCallbackWarning;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IDatabaseResultCallbackWarning;
    }
    /**
       Enumeration IDatabaseTableResultCallbackError
    */
    class IDatabaseTableResultCallbackError {
        value: string;
        constructor(value: string);
        toString(): string;
        static NoSpace: IDatabaseTableResultCallbackError;
        static ReadOnlyTable: IDatabaseTableResultCallbackError;
        static SqlException: IDatabaseTableResultCallbackError;
        static DatabaseNotFound: IDatabaseTableResultCallbackError;
        static NoTableFound: IDatabaseTableResultCallbackError;
        static Unknown: IDatabaseTableResultCallbackError;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IDatabaseTableResultCallbackError;
    }
    /**
       Enumeration IDatabaseTableResultCallbackWarning
    */
    class IDatabaseTableResultCallbackWarning {
        value: string;
        constructor(value: string);
        toString(): string;
        static TableExists: IDatabaseTableResultCallbackWarning;
        static TableLocked: IDatabaseTableResultCallbackWarning;
        static NoResults: IDatabaseTableResultCallbackWarning;
        static Unknown: IDatabaseTableResultCallbackWarning;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IDatabaseTableResultCallbackWarning;
    }
    /**
       Enumeration IFileDataLoadResultCallbackError
    */
    class IFileDataLoadResultCallbackError {
        value: string;
        constructor(value: string);
        toString(): string;
        static InexistentFile: IFileDataLoadResultCallbackError;
        static InsufficientSpace: IFileDataLoadResultCallbackError;
        static Unauthorized: IFileDataLoadResultCallbackError;
        static Unknown: IFileDataLoadResultCallbackError;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IFileDataLoadResultCallbackError;
    }
    /**
       Enumeration IFileDataLoadResultCallbackWarning
    */
    class IFileDataLoadResultCallbackWarning {
        value: string;
        constructor(value: string);
        toString(): string;
        static ExceedMaximumSize: IFileDataLoadResultCallbackWarning;
        static Unknown: IFileDataLoadResultCallbackWarning;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IFileDataLoadResultCallbackWarning;
    }
    /**
       Enumeration IFileDataStoreResultCallbackError
    */
    class IFileDataStoreResultCallbackError {
        value: string;
        constructor(value: string);
        toString(): string;
        static InexistentFile: IFileDataStoreResultCallbackError;
        static InsufficientSpace: IFileDataStoreResultCallbackError;
        static Unauthorized: IFileDataStoreResultCallbackError;
        static Unknown: IFileDataStoreResultCallbackError;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IFileDataStoreResultCallbackError;
    }
    /**
       Enumeration IFileDataStoreResultCallbackWarning
    */
    class IFileDataStoreResultCallbackWarning {
        value: string;
        constructor(value: string);
        toString(): string;
        static ExceedMaximumSize: IFileDataStoreResultCallbackWarning;
        static Unknown: IFileDataStoreResultCallbackWarning;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IFileDataStoreResultCallbackWarning;
    }
    /**
       Enumeration IFileListResultCallbackError
    */
    class IFileListResultCallbackError {
        value: string;
        constructor(value: string);
        toString(): string;
        static InexistentFile: IFileListResultCallbackError;
        static Unauthorized: IFileListResultCallbackError;
        static Unknown: IFileListResultCallbackError;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IFileListResultCallbackError;
    }
    /**
       Enumeration IFileListResultCallbackWarning
    */
    class IFileListResultCallbackWarning {
        value: string;
        constructor(value: string);
        toString(): string;
        static PartialResult: IFileListResultCallbackWarning;
        static Unknown: IFileListResultCallbackWarning;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IFileListResultCallbackWarning;
    }
    /**
       Enumeration IFileResultCallbackError
    */
    class IFileResultCallbackError {
        value: string;
        constructor(value: string);
        toString(): string;
        static FileExists: IFileResultCallbackError;
        static SourceInexistent: IFileResultCallbackError;
        static DestionationExists: IFileResultCallbackError;
        static InsufficientSpace: IFileResultCallbackError;
        static Unauthorized: IFileResultCallbackError;
        static Unknown: IFileResultCallbackError;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IFileResultCallbackError;
    }
    /**
       Enumeration IFileResultCallbackWarning
    */
    class IFileResultCallbackWarning {
        value: string;
        constructor(value: string);
        toString(): string;
        static SourceNotDeleted: IFileResultCallbackWarning;
        static RootDirectory: IFileResultCallbackWarning;
        static Unknown: IFileResultCallbackWarning;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IFileResultCallbackWarning;
    }
    /**
       Enumeration IFileSystemSecurity
    */
    class IFileSystemSecurity {
        value: string;
        constructor(value: string);
        toString(): string;
        static Default: IFileSystemSecurity;
        static Protected: IFileSystemSecurity;
        static Encrypted: IFileSystemSecurity;
        static Unknown: IFileSystemSecurity;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IFileSystemSecurity;
    }
    /**
       Enumeration IFileSystemStorageType
    */
    class IFileSystemStorageType {
        value: string;
        constructor(value: string);
        toString(): string;
        static Application: IFileSystemStorageType;
        static Document: IFileSystemStorageType;
        static Cloud: IFileSystemStorageType;
        static Protected: IFileSystemStorageType;
        static Cache: IFileSystemStorageType;
        static External: IFileSystemStorageType;
        static Unknown: IFileSystemStorageType;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IFileSystemStorageType;
    }
    /**
       Enumeration IFileSystemType
    */
    class IFileSystemType {
        value: string;
        constructor(value: string);
        toString(): string;
        static Directory: IFileSystemType;
        static File: IFileSystemType;
        static Unknown: IFileSystemType;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IFileSystemType;
    }
    /**
       Enumeration IGeolocationListenerError
    */
    class IGeolocationListenerError {
        value: string;
        constructor(value: string);
        toString(): string;
        static Disabled: IGeolocationListenerError;
        static RestrictedAccess: IGeolocationListenerError;
        static DeniedAccess: IGeolocationListenerError;
        static StatusNotDetermined: IGeolocationListenerError;
        static Unknown: IGeolocationListenerError;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IGeolocationListenerError;
    }
    /**
       Enumeration IGeolocationListenerWarning
    */
    class IGeolocationListenerWarning {
        value: string;
        constructor(value: string);
        toString(): string;
        static HighDoP: IGeolocationListenerWarning;
        static StaleData: IGeolocationListenerWarning;
        static Unknown: IGeolocationListenerWarning;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IGeolocationListenerWarning;
    }
    /**
       Enumeration ILifecycleListenerError
    */
    class ILifecycleListenerError {
        value: string;
        constructor(value: string);
        toString(): string;
        static Runtime: ILifecycleListenerError;
        static Implementation: ILifecycleListenerError;
        static Killed: ILifecycleListenerError;
        static Unknown: ILifecycleListenerError;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): ILifecycleListenerError;
    }
    /**
       Enumeration ILifecycleListenerWarning
    */
    class ILifecycleListenerWarning {
        value: string;
        constructor(value: string);
        toString(): string;
        static MemoryLow: ILifecycleListenerWarning;
        static BatteryLow: ILifecycleListenerWarning;
        static Unknown: ILifecycleListenerWarning;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): ILifecycleListenerWarning;
    }
    /**
       Enumeration ILoggingLogLevel
    */
    class ILoggingLogLevel {
        value: string;
        constructor(value: string);
        toString(): string;
        static DEBUG: ILoggingLogLevel;
        static WARN: ILoggingLogLevel;
        static ERROR: ILoggingLogLevel;
        static INFO: ILoggingLogLevel;
        static Unknown: ILoggingLogLevel;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): ILoggingLogLevel;
    }
    /**
       Enumeration IMessagingCallbackError
    */
    class IMessagingCallbackError {
        value: string;
        constructor(value: string);
        toString(): string;
        static SIMNotPresent: IMessagingCallbackError;
        static EmailAccountNotFound: IMessagingCallbackError;
        static NotSent: IMessagingCallbackError;
        static WrongParams: IMessagingCallbackError;
        static NotSupported: IMessagingCallbackError;
        static Unknown: IMessagingCallbackError;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IMessagingCallbackError;
    }
    /**
       Enumeration IMessagingCallbackWarning
    */
    class IMessagingCallbackWarning {
        value: string;
        constructor(value: string);
        toString(): string;
        static UnableToSentAll: IMessagingCallbackWarning;
        static UnableToFetchAttachment: IMessagingCallbackWarning;
        static Unknown: IMessagingCallbackWarning;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IMessagingCallbackWarning;
    }
    /**
       Enumeration INetworkReachabilityCallbackError
    */
    class INetworkReachabilityCallbackError {
        value: string;
        constructor(value: string);
        toString(): string;
        static Forbidden: INetworkReachabilityCallbackError;
        static NotFound: INetworkReachabilityCallbackError;
        static MethodNotAllowed: INetworkReachabilityCallbackError;
        static NotAllowed: INetworkReachabilityCallbackError;
        static NotAuthenticated: INetworkReachabilityCallbackError;
        static TimeOut: INetworkReachabilityCallbackError;
        static NoResponse: INetworkReachabilityCallbackError;
        static Unreachable: INetworkReachabilityCallbackError;
        static Wrong_Params: INetworkReachabilityCallbackError;
        static MalformedUrl: INetworkReachabilityCallbackError;
        static DomainUnresolvable: INetworkReachabilityCallbackError;
        static Unknown: INetworkReachabilityCallbackError;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): INetworkReachabilityCallbackError;
    }
    /**
       Enumeration INetworkReachabilityCallbackWarning
    */
    class INetworkReachabilityCallbackWarning {
        value: string;
        constructor(value: string);
        toString(): string;
        static IncorrectScheme: INetworkReachabilityCallbackWarning;
        static NotSecure: INetworkReachabilityCallbackWarning;
        static NotTrusted: INetworkReachabilityCallbackWarning;
        static Redirected: INetworkReachabilityCallbackWarning;
        static NotRegisteredService: INetworkReachabilityCallbackWarning;
        static Unknown: INetworkReachabilityCallbackWarning;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): INetworkReachabilityCallbackWarning;
    }
    /**
       Enumeration INetworkStatusListenerError
    */
    class INetworkStatusListenerError {
        value: string;
        constructor(value: string);
        toString(): string;
        static NoPermission: INetworkStatusListenerError;
        static Unreachable: INetworkStatusListenerError;
        static Unknown: INetworkStatusListenerError;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): INetworkStatusListenerError;
    }
    /**
       Enumeration INetworkStatusListenerWarning
    */
    class INetworkStatusListenerWarning {
        value: string;
        constructor(value: string);
        toString(): string;
        static IpAddressNotAssigned: INetworkStatusListenerWarning;
        static IpAddressChanged: INetworkStatusListenerWarning;
        static Unknown: INetworkStatusListenerWarning;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): INetworkStatusListenerWarning;
    }
    /**
       Enumeration IOSType
    */
    class IOSType {
        value: string;
        constructor(value: string);
        toString(): string;
        static iOS: IOSType;
        static OSX: IOSType;
        static Windows: IOSType;
        static WindowsPhone: IOSType;
        static Android: IOSType;
        static Linux: IOSType;
        static Blackberry: IOSType;
        static Tizen: IOSType;
        static FirefoxOS: IOSType;
        static Chromium: IOSType;
        static Unspecified: IOSType;
        static Unknown: IOSType;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IOSType;
    }
    /**
       Enumeration ISecurityResultCallbackError
    */
    class ISecurityResultCallbackError {
        value: string;
        constructor(value: string);
        toString(): string;
        static NoPermission: ISecurityResultCallbackError;
        static NoMatchesFound: ISecurityResultCallbackError;
        static Unknown: ISecurityResultCallbackError;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): ISecurityResultCallbackError;
    }
    /**
       Enumeration ISecurityResultCallbackWarning
    */
    class ISecurityResultCallbackWarning {
        value: string;
        constructor(value: string);
        toString(): string;
        static EntryOverride: ISecurityResultCallbackWarning;
        static Unknown: ISecurityResultCallbackWarning;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): ISecurityResultCallbackWarning;
    }
    /**
       Enumeration IServiceProtocolVersion
    */
    class IServiceProtocolVersion {
        value: string;
        constructor(value: string);
        toString(): string;
        static HttpProtocolVersion10: IServiceProtocolVersion;
        static HttpProtocolVersion11: IServiceProtocolVersion;
        static Unknown: IServiceProtocolVersion;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IServiceProtocolVersion;
    }
    /**
       Enumeration IServiceMethod
    */
    class IServiceMethod {
        value: string;
        constructor(value: string);
        toString(): string;
        static Post: IServiceMethod;
        static Get: IServiceMethod;
        static Unknown: IServiceMethod;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IServiceMethod;
    }
    /**
       Enumeration IServiceType
    */
    class IServiceType {
        value: string;
        constructor(value: string);
        toString(): string;
        static ServiceTypeAmfSerialization: IServiceType;
        static ServiceTypeGwtRpc: IServiceType;
        static ServiceTypeOctetBinary: IServiceType;
        static ServiceTypeRemotingSerialization: IServiceType;
        static ServiceTypeRestJson: IServiceType;
        static ServiceTypeRestXml: IServiceType;
        static ServiceTypeSoapJson: IServiceType;
        static ServiceTypeSoapXml: IServiceType;
        static ServiceTypeXmlRpcJson: IServiceType;
        static ServiceTypeXmlRpcXml: IServiceType;
        static Unknown: IServiceType;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IServiceType;
    }
    /**
       Enumeration IServiceResultCallbackError
    */
    class IServiceResultCallbackError {
        value: string;
        constructor(value: string);
        toString(): string;
        static Forbidden: IServiceResultCallbackError;
        static NotFound: IServiceResultCallbackError;
        static MethodNotAllowed: IServiceResultCallbackError;
        static NotAllowed: IServiceResultCallbackError;
        static NotAuthenticated: IServiceResultCallbackError;
        static TimeOut: IServiceResultCallbackError;
        static NoResponse: IServiceResultCallbackError;
        static ServerError: IServiceResultCallbackError;
        static Unreachable: IServiceResultCallbackError;
        static MalformedUrl: IServiceResultCallbackError;
        static NotRegisteredService: IServiceResultCallbackError;
        static Unknown: IServiceResultCallbackError;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IServiceResultCallbackError;
    }
    /**
       Enumeration IServiceResultCallbackWarning
    */
    class IServiceResultCallbackWarning {
        value: string;
        constructor(value: string);
        toString(): string;
        static NotSecure: IServiceResultCallbackWarning;
        static NotTrusted: IServiceResultCallbackWarning;
        static Redirected: IServiceResultCallbackWarning;
        static Wrong_Params: IServiceResultCallbackWarning;
        static Unknown: IServiceResultCallbackWarning;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): IServiceResultCallbackWarning;
    }
    /**
       Enumeration ITelephonyStatus
    */
    class ITelephonyStatus {
        value: string;
        constructor(value: string);
        toString(): string;
        static Dialing: ITelephonyStatus;
        static Failed: ITelephonyStatus;
        static Unknown: ITelephonyStatus;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): ITelephonyStatus;
    }
    /**
       Enumeration LifecycleState
    */
    class LifecycleState {
        value: string;
        constructor(value: string);
        toString(): string;
        static Starting: LifecycleState;
        static Started: LifecycleState;
        static Running: LifecycleState;
        static Pausing: LifecycleState;
        static PausedIdle: LifecycleState;
        static PausedRun: LifecycleState;
        static Resuming: LifecycleState;
        static Stopping: LifecycleState;
        static Unknown: LifecycleState;
        /**
           Convert JSON parsed object to enumeration.
        */
        static toObject(object: any): LifecycleState;
    }
}
