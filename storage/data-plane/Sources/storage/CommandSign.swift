//
//  CommandSign.swift
//  storagePackageDescription
//
//  Created by Vladimir Shcherbakov on 1/17/18.
//

import Foundation
import azureSwiftRuntime

extension BaseCommand {
    func signRequest(azureStorageKey: String, storageAccountName: String) {
        var uriPath: String? = nil
        if !self.path.isEmpty {
            uriPath = self.path
            for (key, value) in self.pathParameters {
                uriPath = uriPath!.replacingOccurrences(of: key, with: value)
            }
        }
        
        let cl = (self.body as? Data?)??.bytes.count
        
        do {
            try StorageAuth.signRequest(storageKey: azureStorageKey,
                storageAccountName: storageAccountName,
                method: self.method,
                headers: &self.headerParameters,
                uriPath: uriPath,
                contentLength: cl,
                queryParamsMap: self.queryParameters)
        } catch {
            print("=== Error:", error)
        }
    }
    
}
