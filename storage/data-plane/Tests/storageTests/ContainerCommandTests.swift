//
//  ContainersCommandTests.swift
//  storage
//
//  Created by Vladimir Shcherbakov on 1/18/18.
//

import XCTest
import Foundation
import azureSwiftRuntime
@testable import storage

public class ContainerCommandTests : StorageTestsBase {
    
    func test_ContainerListBlobs() {
        let e = expectation(description: "Wait for HTTP request to complete")
        
        var command = Commands.Container.ListBlobs(
            azureStorageKey: self.azureStorageKey,
            accountName: "storageswifttest1",
            container: "container1",
            restype: "container",
            comp: "list")
        
        command.execute(client: self.azureClient) {
            (res, error) in
            defer { e.fulfill() }
            
            if let e = error,
                let azureError = AzureStorageDecoder.decode(error: e) {
                print("=== AzureError:", azureError.message)
            }
            
            XCTAssertNil(error)
            XCTAssertNotNil(res)
            
            if let blobs = res!.blobs,
                blobs.count > 0 {
                print("=== Blob list:")
                for blob_ in blobs {
                    if let blob = blob_,
                        let name = blob.name,
                        let properties = blob.properties,
                        let blobType = properties.blobType,
                        let contentLength = properties.contentLength {
                        print("\t", "name: \(name), blobType: \(blobType), contentLength: \(contentLength)")
                    }
                }
                
            } else {
                print("=== No blobs found in the container \(res!.containerName ?? "name not found")")
            }
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
}
