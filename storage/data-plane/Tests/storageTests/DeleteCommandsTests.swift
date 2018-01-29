//
//  DeleteCommandsTests.swift
//  storage
//
//  Created by Vladimir Shcherbakov on 1/29/18.
//

import XCTest
import Foundation
import azureSwiftRuntime
import storage

public class o9DeleteCommandsTests : StorageTestsBase {
    
    func BlobsDelete() {
        let e = expectation(description: "Wait for HTTP request to complete")
        
        var command =
            storage.Commands.Blobs.Delete (
                azureStorageKey: self.azureStorageKey,
                accountName: self.accountName,
                containerName: self.containerName,
                blobName: self.blobName)
        
        command.execute(client: self.azureClient) {
            error in
            defer { e.fulfill() }
            self.checkError(error: error)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func test3_ContainerDelete() {
        let e = expectation(description: "Wait for HTTP request to complete")
        
        var command =
            storage.Commands.Container.Delete (
                azureStorageKey: self.azureStorageKey,
                accountName: self.accountName,
                containerName: self.containerName)
        
        command.execute(client: self.azureClient) {
            error in
            defer { e.fulfill() }
            self.checkError(error: error)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
}
