var Adaptive = {
    
    version: "1.0",
    
    basePath: "http://adaptive/",
    
    callbacksCount : 1,
    callbacks : {},
    
    /**
     * Use this in javascript to request native syncronous methods
     * @version 1.0
     * @param {String} service The service name
     * @param {String} args The JSON string request with the params needed for method invocation
     * @return {Object} Service invocation returned object (javacript object).
     */
    callSync : function call(service, args) {
        
        var path = Adaptive.basePath + service;
        
        var xhr = new XMLHttpRequest();
        
        // Prepare the request
        xhr.open("POST", path, false);
        xhr.setRequestHeader("Content-type", "application/json");
        
        // Prepare the Arguments
        var reqData = null;
        if (!(typeof args === 'undefined')) {
            reqData = encodeURIComponent(JSON.stringify(args))
        }
        
        // Send the request
        try {
            xhr.send(reqData);
        } catch (e) {
            return null;
        }
        
        // Read the response
        var responseText = xhr.responseText;
        
        if (responseText != '') {
            try {
                // TODO: change by JSON parse
                //return JSON.parse(responseText);
                return responseText
            } catch (e) {
                return null;
            }
        } else {
            return null;
        }
    },
    
    // Automatically called by native layer when a result is available
    resultForCallback : function resultForCallback(callbackId, resultArray) {
        try {
            var callback = NativeBridge.callbacks[callbackId];
            if (!callback) return;
            
            callback.apply(null,resultArray);
        } catch(e) {alert(e)}
    },
    
    // Use this in javascript to request native objective-c code
    // functionName : string (I think the name is explicit :p)
    // args : array of arguments
    // callback : function with n-arguments that is going to be called when the native code returned
    /*call : function call(functionName, args, callback) {
        
        var hasCallback = callback && typeof callback == "function";
        var callbackId = hasCallback ? NativeBridge.callbacksCount++ : 0;
        
        if (hasCallback)
            NativeBridge.callbacks[callbackId] = callback;
        
        var iframe = document.createElement("IFRAME");
        
        var message = "hybrid:" + functionName + ":" + callbackId+ ":" + encodeURIComponent(JSON.stringify(args))
        
        iframe.setAttribute("src", message);
        // For some reason we need to set a non-empty size for the iOS6 simulator...
        iframe.setAttribute("height", "1px");
        iframe.setAttribute("width", "1px");
        document.documentElement.appendChild(iframe);
        iframe.parentNode.removeChild(iframe);
        iframe = null;
        
        if (!(typeof webkit === 'undefined')) {
            // Call for wkWebKit
            webkit.messageHandlers.callbackHandler.postMessage(message);
        }
    }*/
    
};