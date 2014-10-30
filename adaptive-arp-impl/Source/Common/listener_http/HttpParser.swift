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

class HttpParser {
    
    class func err(reason:String) -> NSError {
        //return NSError.errorWithDomain("HTTP_PARSER", code: 0, userInfo:[NSLocalizedFailureReasonErrorKey : reason])
        return NSError(domain: "HTTP_PARSER", code: 0, userInfo:[NSLocalizedFailureReasonErrorKey : reason])
    }

    func nextHttpRequest(socket: CInt, error:NSErrorPointer = nil) -> HttpRequest? { //(String, String, Dictionary<String, String>)? {
        if let statusLine = nextLine(socket, error: error) {
            let statusTokens = split(statusLine, { $0 == " " })
            println(statusTokens)
            if ( statusTokens.count < 3 ) {
                if error != nil { error.memory = HttpParser.err("Invalid status line: \(statusLine)") }
                return nil
            }
            let method = statusTokens[0]
            let path = statusTokens[1]
            if let headers = nextHeaders(socket, error: error) {
                var responseString = ""
                while let line = nextLine(socket, error: error)
                {
                    if line.isEmpty {
                        break
                    }
                    responseString += line
                }
                println(responseString)
                let responseData = responseString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
                return HttpRequest(url: path, method: method, headers: headers, responseData: responseData)
            }
        }
        return nil
    }
    
    func nextHeaders(socket: CInt, error:NSErrorPointer) -> Dictionary<String, String>? {
        var headers = Dictionary<String, String>()
        while let headerLine = nextLine(socket, error: error) {
            if ( headerLine.isEmpty ) {
                return headers
            }
            let headerTokens = split(headerLine, { $0 == ":" })
            if ( headerTokens.count >= 2 ) {
                // RFC 2616 - "Hypertext Transfer Protocol -- HTTP/1.1", paragraph 4.2, "Message Headers":
                // "Each header field consists of a name followed by a colon (":") and the field value. Field names are case-insensitive."
                // We can keep lower case version.
                let headerName = headerTokens[0].lowercaseString
                let headerValue = headerTokens[1]
                if ( !headerName.isEmpty && !headerValue.isEmpty ) {
                    headers.updateValue(headerValue, forKey: headerName)
                }
            }
        }
        return nil
    }

    var recvBuffer = [UInt8](count: 1024, repeatedValue: 0)
    var recvBufferSize: Int = 0
    var recvBufferOffset: Int = 0
    
    func nextUInt8(socket: CInt) -> Int {
        if ( recvBufferSize == 0 || recvBufferOffset == recvBuffer.count ) {
            recvBufferOffset = 0
            recvBufferSize = recv(socket, &recvBuffer, UInt(recvBuffer.count), MSG_DONTWAIT)
            if ( recvBufferSize <= 0 ) { return recvBufferSize }
            if recvBufferSize < recvBuffer.count
            {
                recvBuffer[recvBufferSize] = 0
            }
        }
        let returnValue = recvBuffer[recvBufferOffset]
        recvBufferOffset++
        return Int(returnValue)
    }
    
    func nextLine(socket: CInt, error:NSErrorPointer) -> String? {
        var characters: String = ""
        var n = 0
        do {
            n = nextUInt8(socket)
            if ( n > 13 /* CR */ ) { characters.append(Character(UnicodeScalar(n))) }
        } while ( n > 0 && n != 10 /* NL */)
        if ( n == -1 && characters.isEmpty ) {
            if error != nil { error.memory = Socket.socketLastError("recv(...) failed.") }
            return nil
        }
        return characters
    }
    
    func supportsKeepAlive(headers: Dictionary<String, String>) -> Bool {
        if let value = headers["connection"] {
            return "keep-alive" == value.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).lowercaseString
        }
        return false
    }
}
