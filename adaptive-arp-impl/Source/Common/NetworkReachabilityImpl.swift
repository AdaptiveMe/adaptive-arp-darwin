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
import AdaptiveArpApi
import Alamofire
import SystemConfiguration

public class NetworkReachabilityImpl : NSObject, INetworkReachability {
    
    /// Logging variable
    let logger : ILogging = LoggingImpl()
    let loggerTag : String = "NetworkReachabilityImpl"
    
    /// Class constructor
    public override init() {
        
    }
    
    /// Whether there is connectivity to an url of a service or not.
    /// :param: url to look for
    /// :param: callback Callback called at the end
    public func isNetworkServiceReachable(url : String, callback : INetworkReachabilityCallback) {
        
        // TODO: handle http status WARNING codes for: NotRegisteredService, NotTrusted, IncorrectScheme
        
        // Check the url for malforming
        if(Utils.validateUrl(url)){
            callback.onError(INetworkReachabilityCallbackError.MalformedUrl)
            self.logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "Url malformed: \(url)")
            return
        }
        
        Alamofire.request(.GET, url)
            
            .response { (request, response, JSON, error) in
                
                // Error
                if (error != nil) {
                    
                    self.logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "\(error?.description)")
                    callback.onError(INetworkReachabilityCallbackError.Unknown)
                    return
                }
                
                // Check for Not secured url
                if startsWith(url, "https://") {
                    self.logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "Secured URL (https): \(url)")
                } else {
                    self.logger.log(ILoggingLogLevel.WARN, category: loggerTag, message: "NOT Secured URL (https): \(url)")
                    
                    callback.onWarning("", warning: INetworkReachabilityCallbackWarning.NotSecure)
                }
                
                self.logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "status code: \(response!.statusCode)")
                
                switch (response!.statusCode) {
                case 200..<299:
                    callback.onResult("")
                case 300..<399:
                    callback.onWarning("", warning: INetworkReachabilityCallbackWarning.Redirected)
                case 400:
                    callback.onError(INetworkReachabilityCallbackError.Wrong_Params)
                case 401:
                    callback.onError(INetworkReachabilityCallbackError.NotAuthenticated)
                case 403:
                    callback.onError(INetworkReachabilityCallbackError.Forbidden)
                case 404:
                    callback.onError(INetworkReachabilityCallbackError.NotFound)
                case 405:
                    callback.onError(INetworkReachabilityCallbackError.MethodNotAllowed)
                case 406:
                    callback.onError(INetworkReachabilityCallbackError.NotAllowed)
                case 408:
                    callback.onError(INetworkReachabilityCallbackError.TimeOut)
                case 444:
                    callback.onError(INetworkReachabilityCallbackError.NoResponse)
                case 400..<499:
                    callback.onError(INetworkReachabilityCallbackError.Unreachable)
                case 500..<599:
                    callback.onError(INetworkReachabilityCallbackError.Unreachable)
                default:
                    callback.onError(INetworkReachabilityCallbackError.Unknown)
                }
        }
    }
    
    /// Whether there is connectivity to a host, via domain name or ip address, or not.
    /// :param: host domain name or ip address of host.
    /// :param: callback Callback called at the end
    public func isNetworkReachable(host : String, callback : INetworkReachabilityCallback) {
        
        var reachability:Reachability = Reachability(hostname: host)
        
        var isReachableViaWiFi = reachability.isReachableViaWiFi()
        logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "isReachableViaWiFi: \(isReachableViaWiFi)")
        
        var isReachableViaWWAN = reachability.isReachableViaWWAN()
        logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "isReachableViaWWAN: \(isReachableViaWWAN)")
        
        if isReachableViaWiFi || isReachableViaWWAN {
            logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "isReachable!")
            callback.onResult("")
        } else {
            logger.log(ILoggingLogLevel.DEBUG, category: loggerTag, message: "isUnreachable!")
            callback.onError(INetworkReachabilityCallbackError.Unreachable)
        }
        
    }
    
    
    
    /// Checks to see if a host is reachable
    class func isHostnameReachable(hostname: NSString) -> Bool {
        
        var reachabilityRef = SCNetworkReachabilityCreateWithName(nil,hostname.UTF8String)
        
        var reachability = reachabilityRef.takeUnretainedValue()
        var flags: SCNetworkReachabilityFlags = 65536
        SCNetworkReachabilityGetFlags(reachabilityRef.takeUnretainedValue(), &flags)
        
        return (flags & UInt32(kSCNetworkReachabilityFlagsReachable) != 0)
        
    }
    
    /// Checks if the device is connected to any network
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0)).takeRetainedValue()
        }
        
        var flags: SCNetworkReachabilityFlags = 0
        if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == 0 {
            return false
        }
        
        let isReachable = (flags & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        return (isReachable && !needsConnection) ? true : false
    }
}

let ReachabilityChangedNotification = "ReachabilityChangedNotification"

public class Reachability {
    
    typealias NetworkReachable = (Reachability) -> ()
    typealias NetworkUneachable = (Reachability) -> ()
    typealias StartNotifier = (Reachability) -> (Bool)
    
    enum NetworkStatus {
        // Apple NetworkStatus Compatible Names.
        case NotReachable, ReachableViaWiFi, ReachableViaWWAN
    }
    
    var reachabilityRef: SCNetworkReachability?
    var reachabilitySerialQueue: dispatch_queue_t?
    var reachabilityObject: AnyObject?
    var reachableBlock: NetworkReachable?
    var unreachableBlock: NetworkUneachable?
    var startNotifierBlock: StartNotifier?
    var reachableOnWWAN: Bool
    
    init(reachabilityRef: SCNetworkReachability) {
        reachableOnWWAN = true;
        self.reachabilityRef = reachabilityRef;
    }
    
    convenience init(hostname: String) {
        let ref = SCNetworkReachabilityCreateWithName(nil, (hostname as NSString).UTF8String).takeRetainedValue()
        self.init(reachabilityRef: ref)
    }
    
    class func reachabilityForInternetConnection() -> Reachability {
        
        var zeroAddress = sockaddr_in(sin_len: __uint8_t(0), sin_family: sa_family_t(0), sin_port: in_port_t(0), sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let ref = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, UnsafePointer($0)).takeRetainedValue()
        }
        return Reachability(reachabilityRef: ref)
    }
    
    class func reachabilityForLocalWiFi() -> Reachability {
        
        var localWifiAddress: sockaddr_in = sockaddr_in(sin_len: __uint8_t(0), sin_family: sa_family_t(0), sin_port: in_port_t(0), sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        localWifiAddress.sin_len = UInt8(sizeofValue(localWifiAddress))
        localWifiAddress.sin_family = sa_family_t(AF_INET)
        
        // IN_LINKLOCALNETNUM is defined in <netinet/in.h> as 169.254.0.0
        localWifiAddress.sin_addr.s_addr = in_addr_t(Int64(0xA9FE0000).bigEndian)
        
        let ref = withUnsafePointer(&localWifiAddress) {
            SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, UnsafePointer($0)).takeRetainedValue()
        }
        return Reachability(reachabilityRef: ref)
    }
    
    func startNotifier() -> Bool {
        
        reachabilityObject = self
        // First, we need to create a serial queue.
        // We allocate this once for the lifetime of the notifier.
        reachabilitySerialQueue = dispatch_queue_create("com.joylordsystems.reachability", nil)
        if reachabilitySerialQueue == nil {
            return false
        }
        
        let callback:(SCNetworkReachability!, SCNetworkReachabilityFlags, UnsafeMutablePointer<Void>) -> () = { (target: SCNetworkReachability!, flags: SCNetworkReachabilityFlags, info: UnsafeMutablePointer<Void>) in
            self.reachabilityChanged(flags)
        }
        
        let p = UnsafeMutablePointer<(SCNetworkReachability!, SCNetworkReachabilityFlags, UnsafeMutablePointer<Void>) -> Void>.alloc(1)
        p.initialize(callback)
        
        let cp = COpaquePointer(p) // convert UnsafeMutablePointer to COpaquePointer
        let fp = CFunctionPointer<(SCNetworkReachability!, SCNetworkReachabilityFlags, UnsafeMutablePointer<Void>) -> Void>(cp) // convert COpaquePointer to CFunctionPointer
        
        if SCNetworkReachabilitySetCallback(self.reachabilityRef, fp, nil) != 0 {
            
            println("SCNetworkReachabilitySetCallback() failed: \(SCErrorString(SCError()))")
            
            // Clear out the dispatch queue
            reachabilitySerialQueue = nil;
            reachabilityObject = nil;
            
            return false;
        }
        
        // Set it as our reachability queue, which will retain the queue
        if SCNetworkReachabilitySetDispatchQueue(reachabilityRef, reachabilitySerialQueue) == 0
        {
            println("SCNetworkReachabilitySetDispatchQueue() failed: \(SCErrorString(SCError()))")
            
            // First stop, any callbacks!
            SCNetworkReachabilitySetCallback(reachabilityRef, nil, nil)
            
            // Then clear out the dispatch queue.
            reachabilitySerialQueue = nil
            reachabilityObject = nil
            
            return false
        }
        
        return true;
    }
    
    func stopNotifier() {
        
        // First stop, any callbacks!
        SCNetworkReachabilitySetCallback(reachabilityRef, nil, nil)
        
        // Unregister target from the GCD serial dispatch queue.
        SCNetworkReachabilitySetDispatchQueue(nil, nil);
        
        reachabilitySerialQueue = nil;
        reachabilityObject = nil;
    }
    
    func reachabilityChanged(flags: SCNetworkReachabilityFlags) {
        if isReachableWithFlags(flags) {
            if let block = reachableBlock {
                block(self)
            }
        } else {
            if let block = unreachableBlock {
                block(self)
            }
        }
        
        // this makes sure the change notification happens on the MAIN THREAD
        dispatch_async(dispatch_get_main_queue()) {
            NSNotificationCenter.defaultCenter().postNotificationName(ReachabilityChangedNotification, object:self)
        }
    }
    
    func isReachableWithFlags(flags: SCNetworkReachabilityFlags) -> Bool {
        
        let reachable = isReachable(flags)
        
        if reachable {
            return false
        }
        
        if isConnectionRequiredOrTransient(flags) {
            return false
        }
        
        #if TARGET_OS_IPHONE
            if isOnWWAN(flags) && !reachableOnWWAN {
            // We don't want to connect when on 3G.
            return false
            }
        #endif
        
        return true
    }
    
    func isReachableWithTest(test: (SCNetworkReachabilityFlags) -> (Bool)) -> Bool {
        var flags: SCNetworkReachabilityFlags = 0
        let gotFlags = SCNetworkReachabilityGetFlags(reachabilityRef, &flags) != 0
        if gotFlags {
            return test(flags)
        }
        
        return false
    }
    
    func isReachable() -> Bool {
        return isReachableWithTest({ (flags: SCNetworkReachabilityFlags) -> (Bool) in
            return self.isReachableWithFlags(flags)
        })
    }
    
    func isReachableViaWWAN() -> Bool {
        #if TARGET_OS_IPHONE
            return isReachableWithTest({ (flags: SCNetworkReachabilityFlags) -> (Bool) in
            // Check we're REACHABLE
            if self.isReachable(flags) {
            
            // Now, check we're on WWAN
            if self.isOnWWAN(flags) {
            return true
            }
            }
            return false
            })
        #endif
        return false
    }
    
    func isReachableViaWiFi() -> Bool {
        
        return isReachableWithTest({ (flags: SCNetworkReachabilityFlags) -> (Bool) in
            
            // Check we're reachable
            if self.isReachable(flags) {
                #if TARGET_OS_IPHONE
                    
                    // Check we're NOT on WWAN
                    if self.isOnWWAN(flags) {
                    return false
                    }
                #endif
                return true
            }
            
            return false
        })
    }
    
    // WWAN may be available, but not active until a connection has been established.
    // WiFi may require a connection for VPN on Demand.
    func isConnectionRequired() -> Bool {
        return connectionRequired()
    }
    
    func connectionRequired() -> Bool {
        return isReachableWithTest({ (flags: SCNetworkReachabilityFlags) -> (Bool) in
            return self.isConnectionRequired(flags)
        })
    }
    
    // Dynamic, on demand connection?
    func isConnectionOnDemand() -> Bool {
        return isReachableWithTest({ (flags: SCNetworkReachabilityFlags) -> (Bool) in
            return self.isConnectionRequired(flags) && self.isConnectionOnTrafficOrDemand(flags)
        })
    }
    
    // Is user intervention required?
    func isInterventionRequired() -> Bool {
        return isReachableWithTest({ (flags: SCNetworkReachabilityFlags) -> (Bool) in
            return self.isConnectionRequired(flags) && self.isInterventionRequired(flags)
        })
    }
    
    func isOnWWAN(flags: SCNetworkReachabilityFlags) -> Bool {
        return flags & SCNetworkReachabilityFlags(kSCNetworkReachabilityFlagsIsWWAN) != 0
    }
    func isReachable(flags: SCNetworkReachabilityFlags) -> Bool {
        return flags & SCNetworkReachabilityFlags(kSCNetworkReachabilityFlagsReachable) != 0
    }
    func isConnectionRequired(flags: SCNetworkReachabilityFlags) -> Bool {
        return flags & SCNetworkReachabilityFlags(kSCNetworkReachabilityFlagsConnectionRequired) != 0
    }
    func isInterventionRequired(flags: SCNetworkReachabilityFlags) -> Bool {
        return flags & SCNetworkReachabilityFlags(kSCNetworkReachabilityFlagsInterventionRequired) != 0
    }
    func isConnectionOnTraffic(flags: SCNetworkReachabilityFlags) -> Bool {
        return flags & SCNetworkReachabilityFlags(kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0
    }
    func isConnectionOnDemand(flags: SCNetworkReachabilityFlags) -> Bool {
        return flags & SCNetworkReachabilityFlags(kSCNetworkReachabilityFlagsConnectionOnDemand) != 0
    }
    func isConnectionOnTrafficOrDemand(flags: SCNetworkReachabilityFlags) -> Bool {
        return flags & SCNetworkReachabilityFlags(kSCNetworkReachabilityFlagsConnectionOnTraffic | kSCNetworkReachabilityFlagsConnectionOnDemand) != 0
    }
    func isTransientConnection(flags: SCNetworkReachabilityFlags) -> Bool {
        return flags & SCNetworkReachabilityFlags(kSCNetworkReachabilityFlagsTransientConnection) != 0
    }
    func isLocalAddress(flags: SCNetworkReachabilityFlags) -> Bool {
        return flags & SCNetworkReachabilityFlags(kSCNetworkReachabilityFlagsIsLocalAddress) != 0
    }
    func isDirect(flags: SCNetworkReachabilityFlags) -> Bool {
        return flags & SCNetworkReachabilityFlags(kSCNetworkReachabilityFlagsIsDirect) != 0
    }
    func isConnectionRequiredOrTransient(flags: SCNetworkReachabilityFlags) -> Bool {
        let testcase = SCNetworkReachabilityFlags(kSCNetworkReachabilityFlagsConnectionRequired | kSCNetworkReachabilityFlagsTransientConnection)
        return flags & testcase == testcase
    }
    
    // MARK: - *** xx methods ***
    
    var currentReachabilityStatus: NetworkStatus {
        if isReachable() {
            if isReachableViaWiFi() {
                return .ReachableViaWiFi
            }
            #if	TARGET_OS_IPHONE
                return .ReachableViaWWAN;a
            #endif
        }
        
        return .NotReachable
    }
    
    var reachabilityFlags: SCNetworkReachabilityFlags {
        var flags: SCNetworkReachabilityFlags = 0
        let gotFlags = SCNetworkReachabilityGetFlags(reachabilityRef, &flags) != 0
        if gotFlags {
            return flags
        }
        
        return 0
    }
    
    var currentReachabilityString: String {
        
        switch currentReachabilityStatus {
        case .ReachableViaWWAN:
            return NSLocalizedString("Cellular", comment: "")
        case .ReachableViaWiFi:
            return NSLocalizedString("WiFi", comment: "")
        case .NotReachable:
            return NSLocalizedString("No Connection", comment: "");
        }
    }
    
    var currentReachabilityFlags: String {
        #if	TARGET_OS_IPHONE
            let W = isOnWWAN(reachabilityFlags) ? "W" : "-"
            #else
            let W = "X"
        #endif
        let R = isReachable(reachabilityFlags) ? "R" : "-"
        let c = isConnectionRequired(reachabilityFlags) ? "c" : "-"
        let t = isTransientConnection(reachabilityFlags) ? "t" : "-"
        let i = isInterventionRequired(reachabilityFlags) ? "i" : "-"
        let C = isConnectionOnTraffic(reachabilityFlags) ? "C" : "-"
        let D = isConnectionOnDemand(reachabilityFlags) ? "D" : "-"
        let l = isLocalAddress(reachabilityFlags) ? "l" : "-"
        let d = isDirect(reachabilityFlags) ? "d" : "-"
        
        return "\(W)\(R) \(c)\(t)\(i)\(C)\(D)\(l)\(d)"
    }
    
    deinit {
        stopNotifier()
        
        reachabilityRef = nil
        reachableBlock = nil
        unreachableBlock = nil
    }
    
}