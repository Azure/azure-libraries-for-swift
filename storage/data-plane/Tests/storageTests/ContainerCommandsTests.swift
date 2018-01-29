//
//  ContainersCommandTests.swift
//  storage
//
//  Created by Vladimir Shcherbakov on 1/18/18.
//

import XCTest
import Foundation
import azureSwiftRuntime
import storage

public class ContainerCommandsTests : StorageTestsBase {
    
    func test1_ContainerCreate() {
        let e = expectation(description: "Wait for HTTP request to complete")
        
        var command = Commands.Container.Create (
            azureStorageKey: self.azureStorageKey,
            accountName: "storageswifttest1",
            container: "container2")
        
        command.execute(client: self.azureClient) {
            error in
            defer { e.fulfill() }
            self.checkError(error: error)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func test2_ContainerGetProperties() {
        let e = expectation(description: "Wait for HTTP request to complete")
        
        var command = Commands.Container.GetProperties (
            azureStorageKey: self.azureStorageKey,
            accountName: "storageswifttest1",
            container: "container2")
        
        command.execute(client: self.azureClient) {
            error in
            defer { e.fulfill() }
            self.checkError(error: error)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func test3_ContainerSetAcl() {
        let e = expectation(description: "Wait for HTTP request to complete")

        var command = Commands.Container.SetAcl (
            azureStorageKey: self.azureStorageKey,
            accountName: "storageswifttest1",
            container: "container2")
        let ap = AccessPolicyData()
        let sid = SignedIdentifierData(id: "sid1", accessPolicy: ap)
        
        //command.containerAcl = [sid]

        command.execute(client: self.azureClient) {
            error in
            defer { e.fulfill() }
            self.checkError(error: error)
        }

        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func test4_ContainerGetAcl() {
        let e = expectation(description: "Wait for HTTP request to complete")
        
        var command = Commands.Container.GetAcl (
            azureStorageKey: self.azureStorageKey,
            accountName: "storageswifttest1",
            container: "container2")
        
        command.execute(client: self.azureClient) {
            res, error in
            defer { e.fulfill() }
            self.checkError(error: error)
            if let signedIdentifiers = res {
                for si in signedIdentifiers {
                    print("Signed identifier id:", si?.id ?? "-")
                    print("\tAccessPolicy:")
                    print("\t\tstart:", si?.accessPolicy.start ?? "-")
                    print("\t\texpiry:", si?.accessPolicy.expiry ?? "-")
                    print("\t\tpermission:", si?.accessPolicy.permission ?? "-")
                    
                }
            } else {
                print("No signed identifiers found.")
            }
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func test5_ContainerListBlobs() {
        let e = expectation(description: "Wait for HTTP request to complete")
        
        var command = Commands.Container.ListBlobs(
            azureStorageKey: self.azureStorageKey,
            accountName: "storageswifttest1",
            container: "container1",
            restype: "container")
        
        command.execute(client: self.azureClient) {
            (res, error) in
            defer { e.fulfill() }
            self.checkError(error: error)
            
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
                        print("\t", "name: \(name), blobType: \(blobType), contentLength: \(contentLength), xMsBlobSequenceNumber: \(properties.xMsBlobSequenceNumber ?? "-")")
                    }
                }
                
            } else {
                print("=== No blobs found in the container \(res!.containerName ?? "name not found")")
            }
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
}
