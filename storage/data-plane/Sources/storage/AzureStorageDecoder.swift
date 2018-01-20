//
//  AzureErrorDecoder.swift
//  storage
//
//  Created by Vladimir Shcherbakov on 1/18/18.
//

import Foundation
import azureSwiftRuntime

public class AzureStorageDecoder {
    public static func decode(error: Error) -> ErrorProtocol? {
        if case RuntimeError.errorStatusCode(_, let data) = error {
            let azureError = AzureErrorDecoder<ErrorData>(mimeType: .xml).decode(data: data)
            return azureError
        }
        
        return nil
    }
}
