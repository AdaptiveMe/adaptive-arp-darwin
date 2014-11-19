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

var Adaptive = {
    
    version: "1.0",
    
    basePath: "http://adaptiveapp/",
    
    callbacksCount : 0,
    callbacks : {},
    
    /**
     * Use this in javascript to request native syncronous methods
     *
     * @version 1.0
     * @param {String} service The service name
     * @param {String} method The method name
     * @param {String} args The JSON string request with the params needed for method invocation
     */
    callSync : function callSync(service, method, args) {
        
        var path = Adaptive.basePath + service + "/" + method;
        
        var request = Adaptive.prepareRequest(path, "POST", false, args)
        
        // Read the response
        var responseText = request.responseText;
        
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
    
    /**
     * Use this in javascript to request native asyncronous methods with a callback
     *
     * @version 1.0
     * @param {String} service The service name
     * @param {String} method The method name
     * @param {String} args The JSON string request with the params needed for method invocation
     * @param {function} callback Function with n-arguments that is going to be called when the native code returned
     */
    callAsyncCallback : function callAsyncCallback(service, method, args, callback) {
        
        var hasCallback = callback && typeof callback == "function";
        var callbackId = hasCallback ? Adaptive.callbacksCount++ : 0;
        
        if (hasCallback)
            Adaptive.callbacks[callbackId] = callback;
        
        var path = Adaptive.basePath + service + "/" + method + "/" + callbackId;
        
        var request = Adaptive.prepareRequest(path, "POST", true, args)
    },
    
    /**
     * This function is the responsible for preparing the request
     *
     * @version 1.0
     * @param {String} url The url for calling the service
     * @param {String} method The HTTP method for making the request POST or GET
     * @param {Boolean} asyncronous True if the call is asyncronous, syncronous otherwise
     * @param {Array} arguments Array of argument to pass to native
     */
    prepareRequest : function prepareRequest(url, method, asyncronous, arguments) {
        
        var xhr = new XMLHttpRequest();
        
        // Prepare the request
        xhr.open(method, url, asyncronous);
        xhr.setRequestHeader("Content-type", "application/javascript; charset=utf-8");
        
        // Prepare the Arguments
        var data = null;
        if (!(typeof arguments === 'undefined')) {
            data = encodeURIComponent(JSON.stringify(arguments))
        }
        
        // Send the request
        try {
            xhr.send(data);
        } catch (e) {
            return null;
        }
        
        return xhr
    },
    
    /**
     * Automatically called by native layer when a result is available
     *
     * @version 1.0
     * @param {Integer} callbackId The callback identifier
     * @param {Array} resultArray Array with the result
     */
    resultForCallback : function resultForCallback(callbackId, resultArray) {
        try {
            var callback = Adaptive.callbacks[callbackId];
            if (!callback) return;
            
            callback.apply(null,resultArray);
        } catch(e) {
            return null;
        }
    }
    
};