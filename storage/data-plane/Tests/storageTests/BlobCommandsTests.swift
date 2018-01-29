import XCTest
import Foundation
import azureSwiftRuntime
import storage

public class o2BlobCommandsTests : StorageTestsBase {
    
    func test1_BlobsGetProperties() {
        
        let e = self.expectation(description: "Wait for HTTP request to complete")
        
        let cmd = Commands.Blobs.GetProperties(
            azureStorageKey: self.azureStorageKey,
            accountName: self.accountName,
            containerName: self.containerName,
            blobName: self.blobName)
        
        cmd.execute(client: self.azureClient) {
            (res, error) in
            defer { e.fulfill() }
            self.checkError(error: error)
            
            guard let blobProperties = res else {
                XCTFail("nil result")
                return
            }
            
            print("Blob \(self.blobName) properties:")
            print("\tcontentLength:", blobProperties.contentLength)
            print("\tcontentType:", blobProperties.contentType)
            print("\tdate:", blobProperties.date)
            print("\tlastModified:", blobProperties.lastModified)
            print("\teTag:", blobProperties.eTag)
            print("\txMsServerEncrypted:", blobProperties.xMsServerEncrypted)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func test2_BlobsGet() {
        let e = expectation(description: "Wait for HTTP request to complete")
        
        var command =
            storage.Commands.Blobs.Get (
                azureStorageKey: self.azureStorageKey,
                accountName: self.accountName,
                containerName: self.containerName,
                blobName: self.blobName)
        
        command.execute(client: self.azureClient) {
            (result, error) in
            defer { e.fulfill() }
            self.checkError(error: error)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
}
