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

    * @version v2.0.8

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Interface for Managing the Network reachability operations
   Auto-generated implementation of INetworkReachability specification.
*/
public class NetworkReachabilityBridge : BaseCommunicationBridge, INetworkReachability, APIBridge {

    /**
       API Delegate.
    */
    private var delegate : INetworkReachability? = nil

    /**
       Constructor with delegate.

       @param delegate The delegate implementing platform specific functions.
    */
    public init(delegate : INetworkReachability?) {
        super.init()
        self.delegate = delegate
    }
    /**
       Get the delegate implementation.
       @return INetworkReachability delegate that manages platform specific functions..
    */
    public final func getDelegate() -> INetworkReachability? {
        return self.delegate
    }
    /**
       Set the delegate implementation.

       @param delegate The delegate implementing platform specific functions.
    */
    public final func setDelegate(delegate : INetworkReachability) {
        self.delegate = delegate;
    }

    /**
       Whether there is connectivity to a host, via domain name or ip address, or not.

       @param host     domain name or ip address of host.
       @param callback Callback called at the end.
       @since v2.0
    */
    public func isNetworkReachable(host : String , callback : INetworkReachabilityCallback ) {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "NetworkReachabilityBridge executing isNetworkReachable('\(host)','\(callback)').")
        }

        if (self.delegate != nil) {
            self.delegate!.isNetworkReachable(host, callback: callback)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "NetworkReachabilityBridge executed 'isNetworkReachable' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "NetworkReachabilityBridge no delegate for 'isNetworkReachable'.")
            }
        }
        
    }

    /**
       Whether there is connectivity to an url of a service or not.

       @param url      to look for
       @param callback Callback called at the end
       @since v2.0
    */
    public func isNetworkServiceReachable(url : String , callback : INetworkReachabilityCallback ) {
        // Start logging elapsed time.
        var tIn : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        var logger : ILogging? = AppRegistryBridge.sharedInstance.getLoggingBridge()

        if (logger != nil) {
            logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "NetworkReachabilityBridge executing isNetworkServiceReachable('\(url)','\(callback)').")
        }

        if (self.delegate != nil) {
            self.delegate!.isNetworkServiceReachable(url, callback: callback)
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.DEBUG, category: getAPIGroup()!.toString(), message: "NetworkReachabilityBridge executed 'isNetworkServiceReachable' in \(UInt(tIn.distanceTo(NSDate.timeIntervalSinceReferenceDate())*1000)) ms.")
             }
        } else {
            if (logger != nil) {
                logger!.log(ILoggingLogLevel.ERROR, category: getAPIGroup()!.toString(), message: "NetworkReachabilityBridge no delegate for 'isNetworkServiceReachable'.")
            }
        }
        
    }

    /**
       Invokes the given method specified in the API request object.

       @param request APIRequest object containing method name and parameters.
       @return APIResponse with status code, message and JSON response or a JSON null string for void functions. Status code 200 is OK, all others are HTTP standard error conditions.
    */
    public override func invoke(request : APIRequest) -> APIResponse? {
        var response : APIResponse = APIResponse()
        var responseCode : Int = 200
        var responseMessage : String = "OK"
        var responseJSON : String? = "null"
        switch request.getMethodName()! {
            case "isNetworkReachable":
                var host0 : String? = JSONUtil.unescapeString(request.getParameters()![0])
                var callback0 : INetworkReachabilityCallback? =  NetworkReachabilityCallbackImpl(id: request.getAsyncId()!)
                self.isNetworkReachable(host0!, callback: callback0!);
            case "isNetworkServiceReachable":
                var url1 : String? = JSONUtil.unescapeString(request.getParameters()![0])
                var callback1 : INetworkReachabilityCallback? =  NetworkReachabilityCallbackImpl(id: request.getAsyncId()!)
                self.isNetworkServiceReachable(url1!, callback: callback1!);
            default:
                // 404 - response null.
                responseCode = 404
                responseMessage = "NetworkReachabilityBridge does not provide the function '\(request.getMethodName()!)' Please check your client-side API version; should be API version >= v2.0.8."
        }
        response.setResponse(responseJSON!)
        response.setStatusCode(responseCode)
        response.setStatusMessage(responseMessage)
        return response
    }
}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
