//
//  StorageAuth.swift
//  storage
//
//  Created by Vladimir Shcherbakov on 1/5/18.
//

import Foundation
import azureSwiftRuntime
import CryptoSwift

enum RequestSignError: Error {
    case base64DecodeFailed
}

public class StorageAuth {
    
    public static func signRequest(
        storageKey: String,
        storageAccountName: String,
        method: String,
        headers: inout [String:String],
        uriPath: String? = nil,
        contentLength: Int? = nil,
        queryParamsMap: [String:String]? = nil) throws {
        
        let msVersion: String = "2016-05-31"
        headers["x-ms-version"] = msVersion
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss O"
        dateFormatter.timeZone = TimeZone(identifier: "GMT")
        let dateString =  dateFormatter.string(from: date)
        headers["x-ms-date"] = dateString
        
        var canonicalizedHeaders = ""
        let headersKeysSorted = Array(headers.keys).filter{$0.starts(with: "x-ms")}.sorted{$0<$1}
        for key in headersKeysSorted {
            canonicalizedHeaders += key.lowercased() + ":" + headers[key]! + "\n"
        }
        
        //print("=== canonicalizedHeaders", canonicalizedHeaders)
        
        var queryParamString = ""
        if let _ = queryParamsMap {
            let queryParamsKeysSorted = Array(queryParamsMap!.keys).sorted{$0<$1}
            for key in queryParamsKeysSorted {
                queryParamString += "\n" + key.lowercased() + ":" + queryParamsMap![key]!.lowercased()
            }
        }
        
        let canonicalizedResources = "/" + storageAccountName + (uriPath ?? "") + queryParamString
        
        //print("=== canonicalizedResources", canonicalizedResources)
        
        let contentLengthStr = contentLength == nil ? "" : String(describing: contentLength!)
        let contentType = headers["Content-Type"] ?? ""
        
        let stringToSign = method.uppercased()
            + "\n\n\n\(contentLengthStr)\n\n\(contentType)\n\n\n\n\n\n\n"
            + canonicalizedHeaders
            + canonicalizedResources
        
        //print("=== stringToSign", stringToSign)
        
        guard
            let base64DecodedData = Data(base64Encoded: storageKey) else {
            throw RequestSignError.base64DecodeFailed
        }
        
        let stringToSignBytes: [UInt8] = stringToSign.data(using: .utf8)!.bytes
        let base64DecodedBytes: [UInt8] = base64DecodedData.bytes
        
        let signatureBytes = try HMAC(key: base64DecodedBytes, variant: .sha256).authenticate(stringToSignBytes)
        let signatureString = Data(bytes: signatureBytes).base64EncodedString()
        headers["Authorization"] = "SharedKey " + storageAccountName + ":" + signatureString
    }
}
