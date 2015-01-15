/// <reference path="Adaptive.d.ts" />
/// <reference path="jquery.d.ts" />
/// <reference path="jquerymobile.d.ts" />

$(document).ready(function () {

    // Adaptive Bridges
    var os:Adaptive.IOS = Adaptive.AppRegistryBridge.getInstance().getOSBridge();
    var globalization:Adaptive.IGlobalization = Adaptive.AppRegistryBridge.getInstance().getGlobalizationBridge();
    var browser:Adaptive.IBrowser = Adaptive.AppRegistryBridge.getInstance().getBrowserBridge();
    var capabilities:Adaptive.ICapabilities = Adaptive.AppRegistryBridge.getInstance().getCapabilitiesBridge();
    var device:Adaptive.IDevice = Adaptive.AppRegistryBridge.getInstance().getDeviceBridge();

    // Adaptive version
    var version:string = Adaptive.AppRegistryBridge.getInstance().getAPIVersion();
    $('#adaptive-version').html(version);

    // Synchronous Method (getOSInfo)
    var osInfo:Adaptive.OSInfo = os.getOSInfo();
    $('#os-info').html("<b>Operating System</b>: " + osInfo.getVendor() + " " + osInfo.getName() + " " + osInfo.getVersion());

    // Synchronous Method with Parameters (getResourceLiteral)
    var locale:Adaptive.Locale = globalization.getDefaultLocale();
    var i18nResource:string = globalization.getResourceLiteral("hello-world", locale);
    $('#i18n-resource').html("<b>String from Adaptive Core</b>: " + i18nResource);

    // Open Browser
    $('#open-browser').click(function () {
        browser.openInternalBrowser("http://www.google.es", "Google Page", "Back")
    });

    // Capabilities
    $('#capabilities').html("<b>Has camera support?</b> " + capabilities.hasMediaSupport(Adaptive.ICapabilitiesMedia.Camera));

    // Device
    var deviceInfo:Adaptive.DeviceInfo = device.getDeviceInfo();
    $('#device').html("<b>Model</b>: " + deviceInfo.getModel() + "<br>" +
    "<b>Name</b>: " + deviceInfo.getName() + "<br>" +
    "<b>Uuid</b>: " + deviceInfo.getUuid() + "<br>" +
    "<b>Vendor</b>: " + deviceInfo.getVendor());


    // Asynchronous Method (callback) (getContacts)
    /**
     var contactsBridge:Adaptive.IContact = Adaptive.AppRegistryBridge.getInstance().getContactBridge();

     var callback:Adaptive.IContactResultCallback = new Adaptive.ContactResultCallback(
     function onError(error:Adaptive.IContactResultCallbackError) {
            console.error("ERROR: " + error.toString)
        },
     function onResult(contacts:Adaptive.Contact[]) {
            console.log(contacts);
        },
     function onWarning(contacts:Adaptive.Contact[], warning:Adaptive.IContactResultCallbackWarning) {
            console.warn("WARNING: " + warning.toString());
            console.log(contacts);
        }
     );
     contactsBridge.getContactsForFields(callback, [Adaptive.IContactFieldGroup.PERSONAL_INFO]);
     **/


    // Asynchronous Method (listener) (Lifecycle)
    /**
     var lifecycleBridge:Adaptive.ILifecycle = Adaptive.AppRegistryBridge.getInstance().getLifecycleBridge();

     var listener:Adaptive.ILifecycleListener = new Adaptive.LifecycleListener(
     function onError(error:Adaptive.ILifecycleListenerError) {
            console.error("ERROR: " + error.toString)
        },
     function onResult(lifecycle:Adaptive.Lifecycle) {
            console.log(lifecycle);
        },
     function onWarning(lifecycle:Adaptive.Lifecycle, warning:Adaptive.ILifecycleListenerWarning) {
            console.warn("WARNING: " + warning.toString());
            console.log(lifecycle);
        }
     );

     lifecycleBridge.addLifecycleListener(listener);
     **/

    /**
     * Utility native log function
     * @param level Level of Logging
     * @param message Message to be logged
     */
    function log(level:Adaptive.ILoggingLogLevel, message:string):void {
        Adaptive.AppRegistryBridge.getInstance().getLoggingBridge().log_level_category_message(level, "APPLICATION", message);
    }

});