//
//  StorageTestsBase.swift
//  storage
//
//  Created by Vladimir Shcherbakov on 1/18/18.
//

import XCTest
import Foundation
import azureSwiftRuntime
import storage

public class StorageTestsBase : XCTestCase {
    let envVarName = "AZURE_STORAGE_KEY"
    var azureStorageKey = String()
    let timeout: TimeInterval = 102.0
    
    var applicationTokenCredentials: ApplicationTokenCredentials!
    var azureClient: AzureClient!
    
    let accountName = "swiftazurestoragesdktest"
    static let uuid = UUID().uuidString
    static let rnd = String(uuid[uuid.startIndex...uuid.index(uuid.startIndex, offsetBy: 7)]).lowercased()
    let containerName = "testcontainer" + rnd
    let blobName = "testblob" + rnd
    
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
    
    func checkError(error: Error?) {
        if let e = error {
            if let azureError = AzureStorageDecoder.decode(error: e) {
                print("=== AzureError:", azureError.message)
                XCTFail(azureError.message)
            } else {
                print ("=== Error:", e)
                XCTFail(e.localizedDescription)
            }
        }
    }
    
    func pause() {
        let e = expectation(description: "Wait for HTTP request to complete")
        let queue = DispatchQueue(label: "com.azure.storage.sleep", qos: .userInitiated)
        queue.async {
            print("sleep...")
            defer { e.fulfill() }
            Thread.sleep(forTimeInterval: 2.0)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
        print("wakeUp!")
    }
}
