//
//  StorageTestsBase.swift
//  storage
//
//  Created by Vladimir Shcherbakov on 1/18/18.
//

import XCTest
import Foundation
import azureSwiftRuntime
@testable import storage

public class StorageTestsBase : XCTestCase {
    let envVarName = "AZURE_STORAGE_KEY"
    var azureStorageKey = String()
    let timeout: TimeInterval = 102.0
    
    var applicationTokenCredentials: ApplicationTokenCredentials!
    var azureClient: AzureClient!
    
    override public func setUp() {
        continueAfterFailure = false
        super.setUp()
        
        guard let azureStorageKey = self.getEnvironmentVar(name: envVarName.uppercased()) else {
            XCTFail("Azure storage key is not set in env var \(envVarName))")
            return
        }
        
        self.azureStorageKey = azureStorageKey
        
        self.azureClient = AzureClient()
            .withRequestInterceptor(LogRequestInterceptor(showOptions: .all))
            .withResponseInterceptor(LogResponseInterceptor(showOptions: .all))
    }
    
    func getEnvironmentVar(name: String) -> String? {
        guard let rawValue = getenv(name) else { return nil }
        return String(utf8String: rawValue)
    }
}
