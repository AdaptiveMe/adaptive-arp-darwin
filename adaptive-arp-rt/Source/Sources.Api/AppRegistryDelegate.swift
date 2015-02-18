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

    * @version v2.1.6

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Interface to retrieve auto-registered service implementation references.
   Auto-generated implementation of IAppRegistry specification.
*/
public class AppRegistryDelegate : NSObject, IAppRegistry {

    /**
       Default Constructor.
    */
    public override init() {
        super.init()
    }

    /**
       Bridge references.
    */
    private var __accelerationBridge : AccelerationBridge? = nil
    private var __adsBridge : AdsBridge? = nil
    private var __alarmBridge : AlarmBridge? = nil
    private var __ambientlightBridge : AmbientLightBridge? = nil
    private var __analyticsBridge : AnalyticsBridge? = nil
    private var __audioBridge : AudioBridge? = nil
    private var __barcodeBridge : BarcodeBridge? = nil
    private var __barometerBridge : BarometerBridge? = nil
    private var __bluetoothBridge : BluetoothBridge? = nil
    private var __browserBridge : BrowserBridge? = nil
    private var __calendarBridge : CalendarBridge? = nil
    private var __cameraBridge : CameraBridge? = nil
    private var __capabilitiesBridge : CapabilitiesBridge? = nil
    private var __cloudBridge : CloudBridge? = nil
    private var __compressionBridge : CompressionBridge? = nil
    private var __concurrentBridge : ConcurrentBridge? = nil
    private var __contactBridge : ContactBridge? = nil
    private var __cryptoBridge : CryptoBridge? = nil
    private var __datastreamBridge : DataStreamBridge? = nil
    private var __databaseBridge : DatabaseBridge? = nil
    private var __desktopBridge : DesktopBridge? = nil
    private var __deviceBridge : DeviceBridge? = nil
    private var __displayBridge : DisplayBridge? = nil
    private var __facebookBridge : FacebookBridge? = nil
    private var __fileBridge : FileBridge? = nil
    private var __filesystemBridge : FileSystemBridge? = nil
    private var __geolocationBridge : GeolocationBridge? = nil
    private var __globalizationBridge : GlobalizationBridge? = nil
    private var __googleplusBridge : GooglePlusBridge? = nil
    private var __gyroscopeBridge : GyroscopeBridge? = nil
    private var __imagingBridge : ImagingBridge? = nil
    private var __internalstorageBridge : InternalStorageBridge? = nil
    private var __lifecycleBridge : LifecycleBridge? = nil
    private var __linkedinBridge : LinkedInBridge? = nil
    private var __loggingBridge : LoggingBridge? = nil
    private var __magnetometerBridge : MagnetometerBridge? = nil
    private var __mailBridge : MailBridge? = nil
    private var __managementBridge : ManagementBridge? = nil
    private var __mapBridge : MapBridge? = nil
    private var __messagingBridge : MessagingBridge? = nil
    private var __nfcBridge : NFCBridge? = nil
    private var __networkinfoBridge : NetworkInfoBridge? = nil
    private var __networknamingBridge : NetworkNamingBridge? = nil
    private var __networkreachabilityBridge : NetworkReachabilityBridge? = nil
    private var __networkstatusBridge : NetworkStatusBridge? = nil
    private var __notificationBridge : NotificationBridge? = nil
    private var __notificationlocalBridge : NotificationLocalBridge? = nil
    private var __oauthBridge : OAuthBridge? = nil
    private var __ocrBridge : OCRBridge? = nil
    private var __osBridge : OSBridge? = nil
    private var __openidBridge : OpenIdBridge? = nil
    private var __printingBridge : PrintingBridge? = nil
    private var __proximityBridge : ProximityBridge? = nil
    private var __qrcodeBridge : QRCodeBridge? = nil
    private var __rssBridge : RSSBridge? = nil
    private var __runtimeBridge : RuntimeBridge? = nil
    private var __securityBridge : SecurityBridge? = nil
    private var __serviceBridge : ServiceBridge? = nil
    private var __settingsBridge : SettingsBridge? = nil
    private var __socketBridge : SocketBridge? = nil
    private var __storeBridge : StoreBridge? = nil
    private var __telephonyBridge : TelephonyBridge? = nil
    private var __timerBridge : TimerBridge? = nil
    private var __twitterBridge : TwitterBridge? = nil
    private var __uiBridge : UIBridge? = nil
    private var __updateBridge : UpdateBridge? = nil
    private var __vibrationBridge : VibrationBridge? = nil
    private var __videoBridge : VideoBridge? = nil
    private var __walletBridge : WalletBridge? = nil
    private var __xmlBridge : XMLBridge? = nil

    /**
       Returns a reference to the registered AccelerationBridge.

       @return AccelerationBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getAccelerationBridge() -> AccelerationBridge {
         if(__accelerationBridge == nil) {
            __accelerationBridge = AccelerationBridge(delegate: nil);
        }
        return __accelerationBridge!
    }

    /**
       Returns a reference to the registered AdsBridge.

       @return AdsBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getAdsBridge() -> AdsBridge {
         if(__adsBridge == nil) {
            __adsBridge = AdsBridge(delegate: nil);
        }
        return __adsBridge!
    }

    /**
       Returns a reference to the registered AlarmBridge.

       @return AlarmBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getAlarmBridge() -> AlarmBridge {
         if(__alarmBridge == nil) {
            __alarmBridge = AlarmBridge(delegate: nil);
        }
        return __alarmBridge!
    }

    /**
       Returns a reference to the registered AmbientLightBridge.

       @return AmbientLightBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getAmbientLightBridge() -> AmbientLightBridge {
         if(__ambientlightBridge == nil) {
            __ambientlightBridge = AmbientLightBridge(delegate: nil);
        }
        return __ambientlightBridge!
    }

    /**
       Returns a reference to the registered AnalyticsBridge.

       @return AnalyticsBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getAnalyticsBridge() -> AnalyticsBridge {
         if(__analyticsBridge == nil) {
            __analyticsBridge = AnalyticsBridge(delegate: nil);
        }
        return __analyticsBridge!
    }

    /**
       Returns a reference to the registered AudioBridge.

       @return AudioBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getAudioBridge() -> AudioBridge {
         if(__audioBridge == nil) {
            __audioBridge = AudioBridge(delegate: nil);
        }
        return __audioBridge!
    }

    /**
       Returns a reference to the registered BarcodeBridge.

       @return BarcodeBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getBarcodeBridge() -> BarcodeBridge {
         if(__barcodeBridge == nil) {
            __barcodeBridge = BarcodeBridge(delegate: nil);
        }
        return __barcodeBridge!
    }

    /**
       Returns a reference to the registered BarometerBridge.

       @return BarometerBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getBarometerBridge() -> BarometerBridge {
         if(__barometerBridge == nil) {
            __barometerBridge = BarometerBridge(delegate: nil);
        }
        return __barometerBridge!
    }

    /**
       Returns a reference to the registered BluetoothBridge.

       @return BluetoothBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getBluetoothBridge() -> BluetoothBridge {
         if(__bluetoothBridge == nil) {
            __bluetoothBridge = BluetoothBridge(delegate: nil);
        }
        return __bluetoothBridge!
    }

    /**
       Returns a reference to the registered BrowserBridge.

       @return BrowserBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getBrowserBridge() -> BrowserBridge {
         if(__browserBridge == nil) {
            __browserBridge = BrowserBridge(delegate: nil);
        }
        return __browserBridge!
    }

    /**
       Returns a reference to the registered CalendarBridge.

       @return CalendarBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getCalendarBridge() -> CalendarBridge {
         if(__calendarBridge == nil) {
            __calendarBridge = CalendarBridge(delegate: nil);
        }
        return __calendarBridge!
    }

    /**
       Returns a reference to the registered CameraBridge.

       @return CameraBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getCameraBridge() -> CameraBridge {
         if(__cameraBridge == nil) {
            __cameraBridge = CameraBridge(delegate: nil);
        }
        return __cameraBridge!
    }

    /**
       Returns a reference to the registered CapabilitiesBridge.

       @return CapabilitiesBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getCapabilitiesBridge() -> CapabilitiesBridge {
         if(__capabilitiesBridge == nil) {
            __capabilitiesBridge = CapabilitiesBridge(delegate: nil);
        }
        return __capabilitiesBridge!
    }

    /**
       Returns a reference to the registered CloudBridge.

       @return CloudBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getCloudBridge() -> CloudBridge {
         if(__cloudBridge == nil) {
            __cloudBridge = CloudBridge(delegate: nil);
        }
        return __cloudBridge!
    }

    /**
       Returns a reference to the registered CompressionBridge.

       @return CompressionBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getCompressionBridge() -> CompressionBridge {
         if(__compressionBridge == nil) {
            __compressionBridge = CompressionBridge(delegate: nil);
        }
        return __compressionBridge!
    }

    /**
       Returns a reference to the registered ConcurrentBridge.

       @return ConcurrentBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getConcurrentBridge() -> ConcurrentBridge {
         if(__concurrentBridge == nil) {
            __concurrentBridge = ConcurrentBridge(delegate: nil);
        }
        return __concurrentBridge!
    }

    /**
       Returns a reference to the registered ContactBridge.

       @return ContactBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getContactBridge() -> ContactBridge {
         if(__contactBridge == nil) {
            __contactBridge = ContactBridge(delegate: nil);
        }
        return __contactBridge!
    }

    /**
       Returns a reference to the registered CryptoBridge.

       @return CryptoBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getCryptoBridge() -> CryptoBridge {
         if(__cryptoBridge == nil) {
            __cryptoBridge = CryptoBridge(delegate: nil);
        }
        return __cryptoBridge!
    }

    /**
       Returns a reference to the registered DataStreamBridge.

       @return DataStreamBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getDataStreamBridge() -> DataStreamBridge {
         if(__datastreamBridge == nil) {
            __datastreamBridge = DataStreamBridge(delegate: nil);
        }
        return __datastreamBridge!
    }

    /**
       Returns a reference to the registered DatabaseBridge.

       @return DatabaseBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getDatabaseBridge() -> DatabaseBridge {
         if(__databaseBridge == nil) {
            __databaseBridge = DatabaseBridge(delegate: nil);
        }
        return __databaseBridge!
    }

    /**
       Returns a reference to the registered DesktopBridge.

       @return DesktopBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getDesktopBridge() -> DesktopBridge {
         if(__desktopBridge == nil) {
            __desktopBridge = DesktopBridge(delegate: nil);
        }
        return __desktopBridge!
    }

    /**
       Returns a reference to the registered DeviceBridge.

       @return DeviceBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getDeviceBridge() -> DeviceBridge {
         if(__deviceBridge == nil) {
            __deviceBridge = DeviceBridge(delegate: nil);
        }
        return __deviceBridge!
    }

    /**
       Returns a reference to the registered DisplayBridge.

       @return DisplayBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getDisplayBridge() -> DisplayBridge {
         if(__displayBridge == nil) {
            __displayBridge = DisplayBridge(delegate: nil);
        }
        return __displayBridge!
    }

    /**
       Returns a reference to the registered FacebookBridge.

       @return FacebookBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getFacebookBridge() -> FacebookBridge {
         if(__facebookBridge == nil) {
            __facebookBridge = FacebookBridge(delegate: nil);
        }
        return __facebookBridge!
    }

    /**
       Returns a reference to the registered FileBridge.

       @return FileBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getFileBridge() -> FileBridge {
         if(__fileBridge == nil) {
            __fileBridge = FileBridge(delegate: nil);
        }
        return __fileBridge!
    }

    /**
       Returns a reference to the registered FileSystemBridge.

       @return FileSystemBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getFileSystemBridge() -> FileSystemBridge {
         if(__filesystemBridge == nil) {
            __filesystemBridge = FileSystemBridge(delegate: nil);
        }
        return __filesystemBridge!
    }

    /**
       Returns a reference to the registered GeolocationBridge.

       @return GeolocationBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getGeolocationBridge() -> GeolocationBridge {
         if(__geolocationBridge == nil) {
            __geolocationBridge = GeolocationBridge(delegate: nil);
        }
        return __geolocationBridge!
    }

    /**
       Returns a reference to the registered GlobalizationBridge.

       @return GlobalizationBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getGlobalizationBridge() -> GlobalizationBridge {
         if(__globalizationBridge == nil) {
            __globalizationBridge = GlobalizationBridge(delegate: nil);
        }
        return __globalizationBridge!
    }

    /**
       Returns a reference to the registered GooglePlusBridge.

       @return GooglePlusBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getGooglePlusBridge() -> GooglePlusBridge {
         if(__googleplusBridge == nil) {
            __googleplusBridge = GooglePlusBridge(delegate: nil);
        }
        return __googleplusBridge!
    }

    /**
       Returns a reference to the registered GyroscopeBridge.

       @return GyroscopeBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getGyroscopeBridge() -> GyroscopeBridge {
         if(__gyroscopeBridge == nil) {
            __gyroscopeBridge = GyroscopeBridge(delegate: nil);
        }
        return __gyroscopeBridge!
    }

    /**
       Returns a reference to the registered ImagingBridge.

       @return ImagingBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getImagingBridge() -> ImagingBridge {
         if(__imagingBridge == nil) {
            __imagingBridge = ImagingBridge(delegate: nil);
        }
        return __imagingBridge!
    }

    /**
       Returns a reference to the registered InternalStorageBridge.

       @return InternalStorageBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getInternalStorageBridge() -> InternalStorageBridge {
         if(__internalstorageBridge == nil) {
            __internalstorageBridge = InternalStorageBridge(delegate: nil);
        }
        return __internalstorageBridge!
    }

    /**
       Returns a reference to the registered LifecycleBridge.

       @return LifecycleBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getLifecycleBridge() -> LifecycleBridge {
         if(__lifecycleBridge == nil) {
            __lifecycleBridge = LifecycleBridge(delegate: nil);
        }
        return __lifecycleBridge!
    }

    /**
       Returns a reference to the registered LinkedInBridge.

       @return LinkedInBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getLinkedInBridge() -> LinkedInBridge {
         if(__linkedinBridge == nil) {
            __linkedinBridge = LinkedInBridge(delegate: nil);
        }
        return __linkedinBridge!
    }

    /**
       Returns a reference to the registered LoggingBridge.

       @return LoggingBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getLoggingBridge() -> LoggingBridge {
         if(__loggingBridge == nil) {
            __loggingBridge = LoggingBridge(delegate: nil);
        }
        return __loggingBridge!
    }

    /**
       Returns a reference to the registered MagnetometerBridge.

       @return MagnetometerBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getMagnetometerBridge() -> MagnetometerBridge {
         if(__magnetometerBridge == nil) {
            __magnetometerBridge = MagnetometerBridge(delegate: nil);
        }
        return __magnetometerBridge!
    }

    /**
       Returns a reference to the registered MailBridge.

       @return MailBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getMailBridge() -> MailBridge {
         if(__mailBridge == nil) {
            __mailBridge = MailBridge(delegate: nil);
        }
        return __mailBridge!
    }

    /**
       Returns a reference to the registered ManagementBridge.

       @return ManagementBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getManagementBridge() -> ManagementBridge {
         if(__managementBridge == nil) {
            __managementBridge = ManagementBridge(delegate: nil);
        }
        return __managementBridge!
    }

    /**
       Returns a reference to the registered MapBridge.

       @return MapBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getMapBridge() -> MapBridge {
         if(__mapBridge == nil) {
            __mapBridge = MapBridge(delegate: nil);
        }
        return __mapBridge!
    }

    /**
       Returns a reference to the registered MessagingBridge.

       @return MessagingBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getMessagingBridge() -> MessagingBridge {
         if(__messagingBridge == nil) {
            __messagingBridge = MessagingBridge(delegate: nil);
        }
        return __messagingBridge!
    }

    /**
       Returns a reference to the registered NFCBridge.

       @return NFCBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getNFCBridge() -> NFCBridge {
         if(__nfcBridge == nil) {
            __nfcBridge = NFCBridge(delegate: nil);
        }
        return __nfcBridge!
    }

    /**
       Returns a reference to the registered NetworkInfoBridge.

       @return NetworkInfoBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getNetworkInfoBridge() -> NetworkInfoBridge {
         if(__networkinfoBridge == nil) {
            __networkinfoBridge = NetworkInfoBridge(delegate: nil);
        }
        return __networkinfoBridge!
    }

    /**
       Returns a reference to the registered NetworkNamingBridge.

       @return NetworkNamingBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getNetworkNamingBridge() -> NetworkNamingBridge {
         if(__networknamingBridge == nil) {
            __networknamingBridge = NetworkNamingBridge(delegate: nil);
        }
        return __networknamingBridge!
    }

    /**
       Returns a reference to the registered NetworkReachabilityBridge.

       @return NetworkReachabilityBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getNetworkReachabilityBridge() -> NetworkReachabilityBridge {
         if(__networkreachabilityBridge == nil) {
            __networkreachabilityBridge = NetworkReachabilityBridge(delegate: nil);
        }
        return __networkreachabilityBridge!
    }

    /**
       Returns a reference to the registered NetworkStatusBridge.

       @return NetworkStatusBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getNetworkStatusBridge() -> NetworkStatusBridge {
         if(__networkstatusBridge == nil) {
            __networkstatusBridge = NetworkStatusBridge(delegate: nil);
        }
        return __networkstatusBridge!
    }

    /**
       Returns a reference to the registered NotificationBridge.

       @return NotificationBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getNotificationBridge() -> NotificationBridge {
         if(__notificationBridge == nil) {
            __notificationBridge = NotificationBridge(delegate: nil);
        }
        return __notificationBridge!
    }

    /**
       Returns a reference to the registered NotificationLocalBridge.

       @return NotificationLocalBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getNotificationLocalBridge() -> NotificationLocalBridge {
         if(__notificationlocalBridge == nil) {
            __notificationlocalBridge = NotificationLocalBridge(delegate: nil);
        }
        return __notificationlocalBridge!
    }

    /**
       Returns a reference to the registered OAuthBridge.

       @return OAuthBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getOAuthBridge() -> OAuthBridge {
         if(__oauthBridge == nil) {
            __oauthBridge = OAuthBridge(delegate: nil);
        }
        return __oauthBridge!
    }

    /**
       Returns a reference to the registered OCRBridge.

       @return OCRBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getOCRBridge() -> OCRBridge {
         if(__ocrBridge == nil) {
            __ocrBridge = OCRBridge(delegate: nil);
        }
        return __ocrBridge!
    }

    /**
       Returns a reference to the registered OSBridge.

       @return OSBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getOSBridge() -> OSBridge {
         if(__osBridge == nil) {
            __osBridge = OSBridge(delegate: nil);
        }
        return __osBridge!
    }

    /**
       Returns a reference to the registered OpenIdBridge.

       @return OpenIdBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getOpenIdBridge() -> OpenIdBridge {
         if(__openidBridge == nil) {
            __openidBridge = OpenIdBridge(delegate: nil);
        }
        return __openidBridge!
    }

    /**
       Returns a reference to the registered PrintingBridge.

       @return PrintingBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getPrintingBridge() -> PrintingBridge {
         if(__printingBridge == nil) {
            __printingBridge = PrintingBridge(delegate: nil);
        }
        return __printingBridge!
    }

    /**
       Returns a reference to the registered ProximityBridge.

       @return ProximityBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getProximityBridge() -> ProximityBridge {
         if(__proximityBridge == nil) {
            __proximityBridge = ProximityBridge(delegate: nil);
        }
        return __proximityBridge!
    }

    /**
       Returns a reference to the registered QRCodeBridge.

       @return QRCodeBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getQRCodeBridge() -> QRCodeBridge {
         if(__qrcodeBridge == nil) {
            __qrcodeBridge = QRCodeBridge(delegate: nil);
        }
        return __qrcodeBridge!
    }

    /**
       Returns a reference to the registered RSSBridge.

       @return RSSBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getRSSBridge() -> RSSBridge {
         if(__rssBridge == nil) {
            __rssBridge = RSSBridge(delegate: nil);
        }
        return __rssBridge!
    }

    /**
       Returns a reference to the registered RuntimeBridge.

       @return RuntimeBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getRuntimeBridge() -> RuntimeBridge {
         if(__runtimeBridge == nil) {
            __runtimeBridge = RuntimeBridge(delegate: nil);
        }
        return __runtimeBridge!
    }

    /**
       Returns a reference to the registered SecurityBridge.

       @return SecurityBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getSecurityBridge() -> SecurityBridge {
         if(__securityBridge == nil) {
            __securityBridge = SecurityBridge(delegate: nil);
        }
        return __securityBridge!
    }

    /**
       Returns a reference to the registered ServiceBridge.

       @return ServiceBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getServiceBridge() -> ServiceBridge {
         if(__serviceBridge == nil) {
            __serviceBridge = ServiceBridge(delegate: nil);
        }
        return __serviceBridge!
    }

    /**
       Returns a reference to the registered SettingsBridge.

       @return SettingsBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getSettingsBridge() -> SettingsBridge {
         if(__settingsBridge == nil) {
            __settingsBridge = SettingsBridge(delegate: nil);
        }
        return __settingsBridge!
    }

    /**
       Returns a reference to the registered SocketBridge.

       @return SocketBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getSocketBridge() -> SocketBridge {
         if(__socketBridge == nil) {
            __socketBridge = SocketBridge(delegate: nil);
        }
        return __socketBridge!
    }

    /**
       Returns a reference to the registered StoreBridge.

       @return StoreBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getStoreBridge() -> StoreBridge {
         if(__storeBridge == nil) {
            __storeBridge = StoreBridge(delegate: nil);
        }
        return __storeBridge!
    }

    /**
       Returns a reference to the registered TelephonyBridge.

       @return TelephonyBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getTelephonyBridge() -> TelephonyBridge {
         if(__telephonyBridge == nil) {
            __telephonyBridge = TelephonyBridge(delegate: nil);
        }
        return __telephonyBridge!
    }

    /**
       Returns a reference to the registered TimerBridge.

       @return TimerBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getTimerBridge() -> TimerBridge {
         if(__timerBridge == nil) {
            __timerBridge = TimerBridge(delegate: nil);
        }
        return __timerBridge!
    }

    /**
       Returns a reference to the registered TwitterBridge.

       @return TwitterBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getTwitterBridge() -> TwitterBridge {
         if(__twitterBridge == nil) {
            __twitterBridge = TwitterBridge(delegate: nil);
        }
        return __twitterBridge!
    }

    /**
       Returns a reference to the registered UIBridge.

       @return UIBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getUIBridge() -> UIBridge {
         if(__uiBridge == nil) {
            __uiBridge = UIBridge(delegate: nil);
        }
        return __uiBridge!
    }

    /**
       Returns a reference to the registered UpdateBridge.

       @return UpdateBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getUpdateBridge() -> UpdateBridge {
         if(__updateBridge == nil) {
            __updateBridge = UpdateBridge(delegate: nil);
        }
        return __updateBridge!
    }

    /**
       Returns a reference to the registered VibrationBridge.

       @return VibrationBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getVibrationBridge() -> VibrationBridge {
         if(__vibrationBridge == nil) {
            __vibrationBridge = VibrationBridge(delegate: nil);
        }
        return __vibrationBridge!
    }

    /**
       Returns a reference to the registered VideoBridge.

       @return VideoBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getVideoBridge() -> VideoBridge {
         if(__videoBridge == nil) {
            __videoBridge = VideoBridge(delegate: nil);
        }
        return __videoBridge!
    }

    /**
       Returns a reference to the registered WalletBridge.

       @return WalletBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getWalletBridge() -> WalletBridge {
         if(__walletBridge == nil) {
            __walletBridge = WalletBridge(delegate: nil);
        }
        return __walletBridge!
    }

    /**
       Returns a reference to the registered XMLBridge.

       @return XMLBridge reference or nil if a bridge of this type is not registered.
    */
    public final func getXMLBridge() -> XMLBridge {
         if(__xmlBridge == nil) {
            __xmlBridge = XMLBridge(delegate: nil);
        }
        return __xmlBridge!
    }

    /**
       Provides a bridge to handle API calls for the given interface name.

       @param bridgeType String with the interface name required.
       @return APIBridge That handles calls for the specified interface or nil if the given bridge is not registered.
    */
    public final func getBridge(bridgeType : String) -> APIBridge? {
        switch(bridgeType) {

            case "IAcceleration":
                return getAccelerationBridge()

            case "IAds":
                return getAdsBridge()

            case "IAlarm":
                return getAlarmBridge()

            case "IAmbientLight":
                return getAmbientLightBridge()

            case "IAnalytics":
                return getAnalyticsBridge()

            case "IAudio":
                return getAudioBridge()

            case "IBarcode":
                return getBarcodeBridge()

            case "IBarometer":
                return getBarometerBridge()

            case "IBluetooth":
                return getBluetoothBridge()

            case "IBrowser":
                return getBrowserBridge()

            case "ICalendar":
                return getCalendarBridge()

            case "ICamera":
                return getCameraBridge()

            case "ICapabilities":
                return getCapabilitiesBridge()

            case "ICloud":
                return getCloudBridge()

            case "ICompression":
                return getCompressionBridge()

            case "IConcurrent":
                return getConcurrentBridge()

            case "IContact":
                return getContactBridge()

            case "ICrypto":
                return getCryptoBridge()

            case "IDataStream":
                return getDataStreamBridge()

            case "IDatabase":
                return getDatabaseBridge()

            case "IDesktop":
                return getDesktopBridge()

            case "IDevice":
                return getDeviceBridge()

            case "IDisplay":
                return getDisplayBridge()

            case "IFacebook":
                return getFacebookBridge()

            case "IFile":
                return getFileBridge()

            case "IFileSystem":
                return getFileSystemBridge()

            case "IGeolocation":
                return getGeolocationBridge()

            case "IGlobalization":
                return getGlobalizationBridge()

            case "IGooglePlus":
                return getGooglePlusBridge()

            case "IGyroscope":
                return getGyroscopeBridge()

            case "IImaging":
                return getImagingBridge()

            case "IInternalStorage":
                return getInternalStorageBridge()

            case "ILifecycle":
                return getLifecycleBridge()

            case "ILinkedIn":
                return getLinkedInBridge()

            case "ILogging":
                return getLoggingBridge()

            case "IMagnetometer":
                return getMagnetometerBridge()

            case "IMail":
                return getMailBridge()

            case "IManagement":
                return getManagementBridge()

            case "IMap":
                return getMapBridge()

            case "IMessaging":
                return getMessagingBridge()

            case "INFC":
                return getNFCBridge()

            case "INetworkInfo":
                return getNetworkInfoBridge()

            case "INetworkNaming":
                return getNetworkNamingBridge()

            case "INetworkReachability":
                return getNetworkReachabilityBridge()

            case "INetworkStatus":
                return getNetworkStatusBridge()

            case "INotification":
                return getNotificationBridge()

            case "INotificationLocal":
                return getNotificationLocalBridge()

            case "IOAuth":
                return getOAuthBridge()

            case "IOCR":
                return getOCRBridge()

            case "IOS":
                return getOSBridge()

            case "IOpenId":
                return getOpenIdBridge()

            case "IPrinting":
                return getPrintingBridge()

            case "IProximity":
                return getProximityBridge()

            case "IQRCode":
                return getQRCodeBridge()

            case "IRSS":
                return getRSSBridge()

            case "IRuntime":
                return getRuntimeBridge()

            case "ISecurity":
                return getSecurityBridge()

            case "IService":
                return getServiceBridge()

            case "ISettings":
                return getSettingsBridge()

            case "ISocket":
                return getSocketBridge()

            case "IStore":
                return getStoreBridge()

            case "ITelephony":
                return getTelephonyBridge()

            case "ITimer":
                return getTimerBridge()

            case "ITwitter":
                return getTwitterBridge()

            case "IUI":
                return getUIBridge()

            case "IUpdate":
                return getUpdateBridge()

            case "IVibration":
                return getVibrationBridge()

            case "IVideo":
                return getVideoBridge()

            case "IWallet":
                return getWalletBridge()

            case "IXML":
                return getXMLBridge()

            default:
                return nil
        }
    }

    /**
       Method that returns the API version of the implementation.
    */
    public func getAPIVersion() -> String? {
        return "v2.1.6"
    }

    /**
       Returns a reference to the Platform Context
    */
    private var __appcontextBridge : AppContextBridge? = nil

    /**
       Returns a reference to the Platform Context

       @return Reference to the platform context
       @since v2.0
    */
    public func getPlatformContext() -> AppContextBridge {
         if(__appcontextBridge == nil) {
            __appcontextBridge = AppContextBridge(delegate: nil)
        }
        return __appcontextBridge!
    }

    /**
       Returns a reference to the Webview platform context
    */
    private var __appcontextwebviewBridge : AppContextWebviewBridge? = nil

    /**
       Returns a reference to the Webview platform context

       @return Reference to the Webview Context
       @since v2.0
    */
    public func getPlatformContextWeb() -> AppContextWebviewBridge {
         if(__appcontextwebviewBridge == nil) {
            __appcontextwebviewBridge = AppContextWebviewBridge(delegate: nil)
        }
        return __appcontextwebviewBridge!
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
