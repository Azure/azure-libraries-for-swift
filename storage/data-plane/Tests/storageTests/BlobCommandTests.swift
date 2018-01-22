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
            blob: "helloworld")
        command.blobType = "BlockBlob"
        command.optionalbody = Data("This is my text file! Hello world!".utf8)
        
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
    
    struct DataSize {
        static let b = 1
        static let kb = b << 10
        static let mb = kb * kb
        static let gb = mb * mb
        static let tb = gb * gb
        static let blobMaxLimit = 256 * mb
    }
    
    func test_BlobsPutBytes() {
        let e = expectation(description: "Wait for HTTP request to complete")
        
        var command = storage.Commands.Blobs.Put(
            azureStorageKey: self.azureStorageKey,
            accountName: "storageswifttest1",
            container: "container1",
            blob: "bytes256mb")
        
        command.blobType = "BlockBlob"
        
        var bytes = [UInt8](repeating: 0x01, count: 256 * DataSize.mb)
        command.optionalbody = Data(bytes: bytes)
        
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
