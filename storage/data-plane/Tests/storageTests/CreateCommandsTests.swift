//
//  CreateCommandsTests.swift
//  storage
//
//  Created by Vladimir Shcherbakov on 1/29/18.
//

import XCTest
import Foundation
import azureSwiftRuntime
import storage

public class o1CreateCommandsTests : StorageTestsBase {
    
    func test1_ContainerCreate() {
        let e = expectation(description: "Wait for HTTP request to complete")
        
        var command = Commands.Container.Create (
            azureStorageKey: self.azureStorageKey,
            accountName: self.accountName,
            containerName: self.containerName)
        
        command.execute(client: self.azureClient) {
            error in
            defer { e.fulfill() }
            self.checkError(error: error)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
        pause()
    }
    
    func test2_BlobsPut() {
        let e = expectation(description: "Wait for HTTP request to complete")
        
        var command = storage.Commands.Blobs.Put(
            azureStorageKey: self.azureStorageKey,
            accountName: self.accountName,
            containerName: self.containerName,
            blobName: self.blobName,
            blobType: BlobType.BlockBlob)
        
        command.optionalbody = Data("This is my text file! Hello world!".utf8)
        
        command.execute(client: self.azureClient) {
            (error) in
            defer { e.fulfill() }
            self.checkError(error: error)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
        pause()
    }
}

