//
//  AccountCommandTests.swift
//  storage
//
//  Created by Vladimir Shcherbakov on 1/19/18.
//

import XCTest
import Foundation
import azureSwiftRuntime
import storage

public class AccountCommandsTests : StorageTestsBase {
    
    func test_AccountListContainers() {
        let e = expectation(description: "Wait for HTTP request to complete")
        
        var command = Commands.Service.ListContainers (
            azureStorageKey: self.azureStorageKey,
            accountName: "storageswifttest1")
        
        command.execute(client: self.azureClient) {
            (res, error) in
            defer { e.fulfill() }
            self.checkError(error: error)
            
            XCTAssertNotNil(res)
            
            if let containers = res!.containers,
                containers.count > 0 {
                print("=== Container list:")
                for container_ in containers {
                    if let container = container_ ,
                        let name = container.name,
                        let properties = container.properties,
                        let leaseStatus = properties.leaseStatus {
                        print("\t", "name: \(name),", "leaseStatus:", leaseStatus)
                    }
                }
                
            } else {
                print("=== No containers found in \(res?.serviceEndpoint ?? "no name")")
            }
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
}
