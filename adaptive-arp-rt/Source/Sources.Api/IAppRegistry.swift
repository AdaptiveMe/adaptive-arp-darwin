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

import Foundation

/**
   Interface to retrieve auto-registered service implementation references.

   @author Carlos Lozano Diez
   @since ARP1.0
   @version 1.0
*/
public protocol IAppRegistry : NSObjectProtocol {
    /**
       Returns a reference to the registered AccelerationBridge.

       @return AccelerationBridge reference or null if a bridge of this type is not registered.
    */
    func getAccelerationBridge() -> AccelerationBridge

    /**
       Returns a reference to the registered AdsBridge.

       @return AdsBridge reference or null if a bridge of this type is not registered.
    */
    func getAdsBridge() -> AdsBridge

    /**
       Returns a reference to the registered AlarmBridge.

       @return AlarmBridge reference or null if a bridge of this type is not registered.
    */
    func getAlarmBridge() -> AlarmBridge

    /**
       Returns a reference to the registered AmbientLightBridge.

       @return AmbientLightBridge reference or null if a bridge of this type is not registered.
    */
    func getAmbientLightBridge() -> AmbientLightBridge

    /**
       Returns a reference to the registered AnalyticsBridge.

       @return AnalyticsBridge reference or null if a bridge of this type is not registered.
    */
    func getAnalyticsBridge() -> AnalyticsBridge

    /**
       Returns a reference to the registered AudioBridge.

       @return AudioBridge reference or null if a bridge of this type is not registered.
    */
    func getAudioBridge() -> AudioBridge

    /**
       Returns a reference to the registered BarcodeBridge.

       @return BarcodeBridge reference or null if a bridge of this type is not registered.
    */
    func getBarcodeBridge() -> BarcodeBridge

    /**
       Returns a reference to the registered BarometerBridge.

       @return BarometerBridge reference or null if a bridge of this type is not registered.
    */
    func getBarometerBridge() -> BarometerBridge

    /**
       Returns a reference to the registered BluetoothBridge.

       @return BluetoothBridge reference or null if a bridge of this type is not registered.
    */
    func getBluetoothBridge() -> BluetoothBridge

    /**
       Returns a reference to the registered BrowserBridge.

       @return BrowserBridge reference or null if a bridge of this type is not registered.
    */
    func getBrowserBridge() -> BrowserBridge

    /**
       Returns a reference to the registered CalendarBridge.

       @return CalendarBridge reference or null if a bridge of this type is not registered.
    */
    func getCalendarBridge() -> CalendarBridge

    /**
       Returns a reference to the registered CameraBridge.

       @return CameraBridge reference or null if a bridge of this type is not registered.
    */
    func getCameraBridge() -> CameraBridge

    /**
       Returns a reference to the registered CapabilitiesBridge.

       @return CapabilitiesBridge reference or null if a bridge of this type is not registered.
    */
    func getCapabilitiesBridge() -> CapabilitiesBridge

    /**
       Returns a reference to the registered CloudBridge.

       @return CloudBridge reference or null if a bridge of this type is not registered.
    */
    func getCloudBridge() -> CloudBridge

    /**
       Returns a reference to the registered CompressionBridge.

       @return CompressionBridge reference or null if a bridge of this type is not registered.
    */
    func getCompressionBridge() -> CompressionBridge

    /**
       Returns a reference to the registered ConcurrentBridge.

       @return ConcurrentBridge reference or null if a bridge of this type is not registered.
    */
    func getConcurrentBridge() -> ConcurrentBridge

    /**
       Returns a reference to the registered ContactBridge.

       @return ContactBridge reference or null if a bridge of this type is not registered.
    */
    func getContactBridge() -> ContactBridge

    /**
       Returns a reference to the registered CryptoBridge.

       @return CryptoBridge reference or null if a bridge of this type is not registered.
    */
    func getCryptoBridge() -> CryptoBridge

    /**
       Returns a reference to the registered DataStreamBridge.

       @return DataStreamBridge reference or null if a bridge of this type is not registered.
    */
    func getDataStreamBridge() -> DataStreamBridge

    /**
       Returns a reference to the registered DatabaseBridge.

       @return DatabaseBridge reference or null if a bridge of this type is not registered.
    */
    func getDatabaseBridge() -> DatabaseBridge

    /**
       Returns a reference to the registered DesktopBridge.

       @return DesktopBridge reference or null if a bridge of this type is not registered.
    */
    func getDesktopBridge() -> DesktopBridge

    /**
       Returns a reference to the registered DeviceBridge.

       @return DeviceBridge reference or null if a bridge of this type is not registered.
    */
    func getDeviceBridge() -> DeviceBridge

    /**
       Returns a reference to the registered DisplayBridge.

       @return DisplayBridge reference or null if a bridge of this type is not registered.
    */
    func getDisplayBridge() -> DisplayBridge

    /**
       Returns a reference to the registered FacebookBridge.

       @return FacebookBridge reference or null if a bridge of this type is not registered.
    */
    func getFacebookBridge() -> FacebookBridge

    /**
       Returns a reference to the registered FileBridge.

       @return FileBridge reference or null if a bridge of this type is not registered.
    */
    func getFileBridge() -> FileBridge

    /**
       Returns a reference to the registered FileSystemBridge.

       @return FileSystemBridge reference or null if a bridge of this type is not registered.
    */
    func getFileSystemBridge() -> FileSystemBridge

    /**
       Returns a reference to the registered GeolocationBridge.

       @return GeolocationBridge reference or null if a bridge of this type is not registered.
    */
    func getGeolocationBridge() -> GeolocationBridge

    /**
       Returns a reference to the registered GlobalizationBridge.

       @return GlobalizationBridge reference or null if a bridge of this type is not registered.
    */
    func getGlobalizationBridge() -> GlobalizationBridge

    /**
       Returns a reference to the registered GooglePlusBridge.

       @return GooglePlusBridge reference or null if a bridge of this type is not registered.
    */
    func getGooglePlusBridge() -> GooglePlusBridge

    /**
       Returns a reference to the registered GyroscopeBridge.

       @return GyroscopeBridge reference or null if a bridge of this type is not registered.
    */
    func getGyroscopeBridge() -> GyroscopeBridge

    /**
       Returns a reference to the registered ImagingBridge.

       @return ImagingBridge reference or null if a bridge of this type is not registered.
    */
    func getImagingBridge() -> ImagingBridge

    /**
       Returns a reference to the registered InternalStorageBridge.

       @return InternalStorageBridge reference or null if a bridge of this type is not registered.
    */
    func getInternalStorageBridge() -> InternalStorageBridge

    /**
       Returns a reference to the registered LifecycleBridge.

       @return LifecycleBridge reference or null if a bridge of this type is not registered.
    */
    func getLifecycleBridge() -> LifecycleBridge

    /**
       Returns a reference to the registered LinkedInBridge.

       @return LinkedInBridge reference or null if a bridge of this type is not registered.
    */
    func getLinkedInBridge() -> LinkedInBridge

    /**
       Returns a reference to the registered LoggingBridge.

       @return LoggingBridge reference or null if a bridge of this type is not registered.
    */
    func getLoggingBridge() -> LoggingBridge

    /**
       Returns a reference to the registered MagnetometerBridge.

       @return MagnetometerBridge reference or null if a bridge of this type is not registered.
    */
    func getMagnetometerBridge() -> MagnetometerBridge

    /**
       Returns a reference to the registered MailBridge.

       @return MailBridge reference or null if a bridge of this type is not registered.
    */
    func getMailBridge() -> MailBridge

    /**
       Returns a reference to the registered ManagementBridge.

       @return ManagementBridge reference or null if a bridge of this type is not registered.
    */
    func getManagementBridge() -> ManagementBridge

    /**
       Returns a reference to the registered MapBridge.

       @return MapBridge reference or null if a bridge of this type is not registered.
    */
    func getMapBridge() -> MapBridge

    /**
       Returns a reference to the registered MessagingBridge.

       @return MessagingBridge reference or null if a bridge of this type is not registered.
    */
    func getMessagingBridge() -> MessagingBridge

    /**
       Returns a reference to the registered NFCBridge.

       @return NFCBridge reference or null if a bridge of this type is not registered.
    */
    func getNFCBridge() -> NFCBridge

    /**
       Returns a reference to the registered NetworkInfoBridge.

       @return NetworkInfoBridge reference or null if a bridge of this type is not registered.
    */
    func getNetworkInfoBridge() -> NetworkInfoBridge

    /**
       Returns a reference to the registered NetworkNamingBridge.

       @return NetworkNamingBridge reference or null if a bridge of this type is not registered.
    */
    func getNetworkNamingBridge() -> NetworkNamingBridge

    /**
       Returns a reference to the registered NetworkReachabilityBridge.

       @return NetworkReachabilityBridge reference or null if a bridge of this type is not registered.
    */
    func getNetworkReachabilityBridge() -> NetworkReachabilityBridge

    /**
       Returns a reference to the registered NetworkStatusBridge.

       @return NetworkStatusBridge reference or null if a bridge of this type is not registered.
    */
    func getNetworkStatusBridge() -> NetworkStatusBridge

    /**
       Returns a reference to the registered NotificationBridge.

       @return NotificationBridge reference or null if a bridge of this type is not registered.
    */
    func getNotificationBridge() -> NotificationBridge

    /**
       Returns a reference to the registered NotificationLocalBridge.

       @return NotificationLocalBridge reference or null if a bridge of this type is not registered.
    */
    func getNotificationLocalBridge() -> NotificationLocalBridge

    /**
       Returns a reference to the registered OAuthBridge.

       @return OAuthBridge reference or null if a bridge of this type is not registered.
    */
    func getOAuthBridge() -> OAuthBridge

    /**
       Returns a reference to the registered OCRBridge.

       @return OCRBridge reference or null if a bridge of this type is not registered.
    */
    func getOCRBridge() -> OCRBridge

    /**
       Returns a reference to the registered OSBridge.

       @return OSBridge reference or null if a bridge of this type is not registered.
    */
    func getOSBridge() -> OSBridge

    /**
       Returns a reference to the registered OpenIdBridge.

       @return OpenIdBridge reference or null if a bridge of this type is not registered.
    */
    func getOpenIdBridge() -> OpenIdBridge

    /**
       Returns a reference to the registered PrintingBridge.

       @return PrintingBridge reference or null if a bridge of this type is not registered.
    */
    func getPrintingBridge() -> PrintingBridge

    /**
       Returns a reference to the registered ProximityBridge.

       @return ProximityBridge reference or null if a bridge of this type is not registered.
    */
    func getProximityBridge() -> ProximityBridge

    /**
       Returns a reference to the registered QRCodeBridge.

       @return QRCodeBridge reference or null if a bridge of this type is not registered.
    */
    func getQRCodeBridge() -> QRCodeBridge

    /**
       Returns a reference to the registered RSSBridge.

       @return RSSBridge reference or null if a bridge of this type is not registered.
    */
    func getRSSBridge() -> RSSBridge

    /**
       Returns a reference to the registered RuntimeBridge.

       @return RuntimeBridge reference or null if a bridge of this type is not registered.
    */
    func getRuntimeBridge() -> RuntimeBridge

    /**
       Returns a reference to the registered SecurityBridge.

       @return SecurityBridge reference or null if a bridge of this type is not registered.
    */
    func getSecurityBridge() -> SecurityBridge

    /**
       Returns a reference to the registered ServiceBridge.

       @return ServiceBridge reference or null if a bridge of this type is not registered.
    */
    func getServiceBridge() -> ServiceBridge

    /**
       Returns a reference to the registered SettingsBridge.

       @return SettingsBridge reference or null if a bridge of this type is not registered.
    */
    func getSettingsBridge() -> SettingsBridge

    /**
       Returns a reference to the registered SocketBridge.

       @return SocketBridge reference or null if a bridge of this type is not registered.
    */
    func getSocketBridge() -> SocketBridge

    /**
       Returns a reference to the registered StoreBridge.

       @return StoreBridge reference or null if a bridge of this type is not registered.
    */
    func getStoreBridge() -> StoreBridge

    /**
       Returns a reference to the registered TelephonyBridge.

       @return TelephonyBridge reference or null if a bridge of this type is not registered.
    */
    func getTelephonyBridge() -> TelephonyBridge

    /**
       Returns a reference to the registered TimerBridge.

       @return TimerBridge reference or null if a bridge of this type is not registered.
    */
    func getTimerBridge() -> TimerBridge

    /**
       Returns a reference to the registered TwitterBridge.

       @return TwitterBridge reference or null if a bridge of this type is not registered.
    */
    func getTwitterBridge() -> TwitterBridge

    /**
       Returns a reference to the registered UIBridge.

       @return UIBridge reference or null if a bridge of this type is not registered.
    */
    func getUIBridge() -> UIBridge

    /**
       Returns a reference to the registered UpdateBridge.

       @return UpdateBridge reference or null if a bridge of this type is not registered.
    */
    func getUpdateBridge() -> UpdateBridge

    /**
       Returns a reference to the registered VibrationBridge.

       @return VibrationBridge reference or null if a bridge of this type is not registered.
    */
    func getVibrationBridge() -> VibrationBridge

    /**
       Returns a reference to the registered VideoBridge.

       @return VideoBridge reference or null if a bridge of this type is not registered.
    */
    func getVideoBridge() -> VideoBridge

    /**
       Returns a reference to the registered WalletBridge.

       @return WalletBridge reference or null if a bridge of this type is not registered.
    */
    func getWalletBridge() -> WalletBridge

    /**
       Returns a reference to the registered XMLBridge.

       @return XMLBridge reference or null if a bridge of this type is not registered.
    */
    func getXMLBridge() -> XMLBridge

    /**
       Provides a bridge to handle API calls for the given interface name.

       @param bridgeType String with the interface name required.
       @return APIBridge That handles calls for the specified interface or null if the given bridge is not registered.
    */
    func getBridge(bridgeType : String) -> APIBridge?

    /**
       Method that returns the API version of the implementation.

       @return API Version string.
       @since ARP1.0
    */
    func getAPIVersion() -> String?

    /**
       Returns a reference to the Platform Context

       @return Reference to the platform context
       @since ARP1.0
    */
    func getPlatformContext() -> AppContextBridge 

    /**
       Returns a reference to the Webview platform context

       @return Reference to the Webview Context
       @since ARP1.0
    */
    func getPlatformContextWeb() -> AppContextWebviewBridge 

}

/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
