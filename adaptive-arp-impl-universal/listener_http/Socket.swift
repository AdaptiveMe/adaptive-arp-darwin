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
*     *
*
* =====================================================================================================================
*/

import Foundation

/* Low level routines for POSIX sockets */

struct Socket {
        
    static func socketLastError(reason:String) -> NSError {
        let errorCode = errno
        if let errorText = String.fromCString(UnsafePointer(strerror(errorCode))) {
            return NSError.errorWithDomain("SOCKET", code: Int(errorCode), userInfo: [NSLocalizedFailureReasonErrorKey : reason, NSLocalizedDescriptionKey : errorText])
        }
        return NSError.errorWithDomain("SOCKET", code: Int(errorCode), userInfo: nil)
    }
    
    static func tcpForListen(port: in_port_t = 8080, error:NSErrorPointer = nil) -> CInt? {
        let s = socket(AF_INET, SOCK_STREAM, 0)
        if ( s == -1 ) {
            if error != nil { error.memory = socketLastError("socket(...) failed.") }
            return nil
        }
        var value: Int32 = 1;
        if ( setsockopt(s, SOL_SOCKET, SO_REUSEADDR, &value, socklen_t(sizeof(Int32))) == -1 ) {
            release(s)
            if error != nil { error.memory = socketLastError("setsockopt(...) failed.") }
            return nil
        }
        nosigpipe(s)
        var addr = sockaddr_in(sin_len: __uint8_t(sizeof(sockaddr_in)), sin_family: sa_family_t(AF_INET),
            sin_port: port_htons(port), sin_addr: in_addr(s_addr: inet_addr("0.0.0.0")), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        
        var sock_addr = sockaddr(sa_len: 0, sa_family: 0, sa_data: (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0))
        memcpy(&sock_addr, &addr, UInt(sizeof(sockaddr_in)))
        if ( bind(s, &sock_addr, socklen_t(sizeof(sockaddr_in))) == -1 ) {
            release(s)
            if error != nil { error.memory = socketLastError("bind(...) failed.") }
            return nil
        }
        if ( listen(s, 20 /* max pending connection */ ) == -1 ) {
            release(s)
            if error != nil { error.memory = socketLastError("listen(...) failed.") }
            return nil
        }
        return s
    }
    
    static func writeStringUTF8(socket: CInt, string: String, error:NSErrorPointer = nil) -> Bool {
        var sent = 0;
        if let nsdata = string.dataUsingEncoding(NSUTF8StringEncoding)
		{
			let unsafePointer = UnsafePointer<UInt8>(nsdata.bytes)
			while ( sent < nsdata.length ) {
				let s = write(socket, unsafePointer + sent, UInt(nsdata.length - sent))
				if ( s <= 0 ) {
					if error != nil { error.memory = socketLastError("write(\(string)) failed.") }
					return false
				}
				sent += s
			}
		}
        return true
    }
    
    static func acceptClientSocket(socket: CInt, error:NSErrorPointer = nil) -> CInt? {
        var addr = sockaddr(sa_len: 0, sa_family: 0, sa_data: (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)), len: socklen_t = 0
        let clientSocket = accept(socket, &addr, &len)
        if ( clientSocket != -1 ) {
            Socket.nosigpipe(clientSocket)
            return clientSocket
        }
        if error != nil { error.memory = socketLastError("accept(...) failed.") }
        return nil
    }
    
    static func nosigpipe(socket: CInt) {
        // prevents crashes when blocking calls are pending and the app is paused ( via Home button )
        var no_sig_pipe: Int32 = 1;
        setsockopt(socket, SOL_SOCKET, SO_NOSIGPIPE, &no_sig_pipe, socklen_t(sizeof(Int32)));
    }
    
    static func port_htons(port: in_port_t) -> in_port_t {
        let isLittleEndian = Int(OSHostByteOrder()) == OSLittleEndian
        return isLittleEndian ? _OSSwapInt16(port) : port
    }
    
    static func release(socket: CInt) {
        shutdown(socket, SHUT_RDWR)
        close(socket)
    }
}
