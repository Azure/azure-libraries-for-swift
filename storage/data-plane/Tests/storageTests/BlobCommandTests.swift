import XCTest
import Foundation
import azureSwiftRuntime
@testable import storage

public class BlobCommandTests : StorageTestsBase {
    
    func test_BlobsPut() {
        let e = expectation(description: "Wait for HTTP request to complete")
        
        var command = storage.Commands.Blobs.Put(
            azureStorageKey: self.azureStorageKey,
            accountName: "storageswifttest1",
            container: "container1",
            blob: "TestName4")
        
        command.blobType = "BlockBlob"
        command.optionalbody = Data("Test".utf8);
        
        command.execute(client: self.azureClient) {
            (error) in
            defer { e.fulfill() }
            if let e = error,
                let azureError = AzureStorageDecoder.decode(error: e) {
                print("=== AzureError:", azureError.message)
            }
            
            XCTAssertNil(error)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
}
