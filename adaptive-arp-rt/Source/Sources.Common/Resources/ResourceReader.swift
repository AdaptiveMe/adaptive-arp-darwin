//
//  ResourceReader.swift
//  AdaptivePacker
//
//  Created by Carlos Lozano on 16/02/15.
//  Copyright (c) 2015 Carlos Lozano Diez. All rights reserved.
//

import Foundation
import CryptoSwift

private let _ResourceReader = ResourceReader()


public class ResourceReader  {
    
    public class var sharedInstance : ResourceReader {
        return _ResourceReader
    }
    
    private var path : String?
    
    public init() {
        
    }
    
    public func setPath(path : String) {
        self.path = path
    }
    
    public func getResource(resourceId : String) -> ResourceData? {
        var response : ResourceData?
        
        var iStream = NSInputStream(fileAtPath: self.path!)
        iStream?.open()
        var iReader = BTBinaryStreamReader(stream: iStream, andSourceByteOrder: CFByteOrderGetCurrent())
        var count = Int(readInt(iReader))
        for (var i = 0;i < count; i++) {
            
            var id = readString(iReader)
            var cooked = readBool(iReader)
            var cooked_type = readString(iReader)
            
            if (cooked) {
                if (cooked_type == "MSCZ" || cooked_type == "MSC") {
                    if (id == resourceId.sha256()!) {
                        response = ResourceData()
                        response?.id_data = id
                        response?.cooked = cooked
                        response?.cooked_type = cooked_type
                        
                        // fnva (23/04/2015) - Swift 1.2
                        // var keyData = (resourceId as String).md5()!.dataUsingEncoding(NSUTF8StringEncoding)!
                        // var ivData = (resourceId as String).sha256()!.dataUsingEncoding(NSUTF8StringEncoding)!
                        var keyData:[UInt8] = [UInt8]()
                        keyData += resourceId.md5()!.utf8
                        var ivData:[UInt8] = [UInt8]()
                        ivData += resourceId.sha256()!.utf8
                        let setup = (key: keyData, iv: ivData)
                        
                        response = ResourceData()
                        response?.id_data = id
                        response?.cooked = cooked
                        response?.cooked_type = cooked_type
                        // Skip length of payload
                        iReader.readInt32()
                        response?.raw_type = NSString(data: NSData(base64EncodedString: readString(iReader), options: NSDataBase64DecodingOptions.allZeros)!.decrypt(Cipher.ChaCha20(setup))!, encoding: NSUTF8StringEncoding)!
                        response?.raw_length = readInt(iReader)
                        response?.cooked_length = readInt(iReader)
                        response?.data = readData(iReader).decrypt(Cipher.ChaCha20(setup))!
                        
                        if (cooked_type == "MSCZ") {
                            response?.data = response!.data.gzipInflate()
                        }
                        break
                    } else {
                        skipData(iReader, stream:iStream!)
                    }
                } else if (cooked_type == "Z") {
                    if (id == resourceId) {
                        response = ResourceData()
                        response?.id_data = id
                        response?.cooked = cooked
                        response?.cooked_type = cooked_type
                        // Skip length of payload
                        iReader.readInt32()
                        response?.raw_type = readString(iReader)
                        response?.raw_length = readInt(iReader)
                        response?.cooked_length = readInt(iReader)
                        response?.data = readData(iReader).gzipInflate()
                        break
                    } else {
                        skipData(iReader, stream: iStream!)
                    }
                }
            } else {
                if (id == resourceId) {
                    response = ResourceData()
                    response?.id_data = id
                    response?.cooked = cooked
                    response?.cooked_type = cooked_type
                    // Skip length of payload
                    iReader.readInt32()
                    response?.raw_type = readString(iReader)
                    response?.raw_length = readInt(iReader)
                    response?.cooked_length = readInt(iReader)
                    response?.data = readData(iReader)
                    break
                } else {
                    skipData(iReader, stream: iStream!)
                }
            }
            
            
            
        }
        /*
        if let response = response {
            println("           Id: \(response.id_data)");
            println("     Raw-Type: \(response.raw_type)");
            println("   Raw-Length: \(response.raw_length)");
            println("       Cooked: \(response.cooked)");
            println("  Cooked-Type: \(response.cooked_type)");
            println("Cooked-Length: \(response.cooked_length)");
            println("  Data-Length: \(response.data.length)")
        }
        */
        iStream?.close()
        
        return response
    }
    
    private func readString(reader : BTBinaryStreamReader) -> String {
        var length = UInt(reader.readInt32())
        if (length > 0) {
            return reader.readStringWithEncoding(NSUTF8StringEncoding, andLength: length)
        } else {
            return ""
        }
    }
    
    private func readBool(reader : BTBinaryStreamReader) -> Bool {
        var val = reader.readInt8()
        if (val == 0) {
            return false
        } else {
            return true
        }
    }
    
    private func readInt(reader : BTBinaryStreamReader) -> Int64 {
        return reader.readInt64()
    }
    
    private func readData(reader : BTBinaryStreamReader) -> NSData {
        var length = UInt(reader.readInt32())
        return reader.readDataOfLength(length)
    }
    
    private func skipData(reader: BTBinaryStreamReader, stream : NSInputStream) {
        var length = Int(reader.readInt32())
        var offset = stream.propertyForKey(NSStreamFileCurrentOffsetKey) as! Int
        var newoffset : Int = offset + length
        stream.setProperty(newoffset, forKey: NSStreamFileCurrentOffsetKey)
    }
}