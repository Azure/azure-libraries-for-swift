import XCTest
import Foundation
import azureSwiftRuntime
import storage

public class BlobCommandTests : StorageTestsBase {
    
    func test_BlobsPut() {
        let e = expectation(description: "Wait for HTTP request to complete")
        
        var command = storage.Commands.Blobs.Put(
            azureStorageKey: self.azureStorageKey,
            accountName: "storageswifttest1",
            container: "container1",
            blob: "helloworld1")
        
        command.blobType = "BlockBlob"
        command.optionalbody = Data("This is my text file! Hello world!".utf8);
        
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
