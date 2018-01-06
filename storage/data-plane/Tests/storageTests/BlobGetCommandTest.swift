import XCTest
import Foundation
import azureSwiftRuntime
import storage
import CryptoSwift

public class BlobGetCommandTest : XCTestCase {
    let envVarName = "AZURE_STORAGE_KEY"
    var azureStorageKey = String()
    let timeout: TimeInterval = 102.0

    var applicationTokenCredentials: ApplicationTokenCredentials!
    var azureClient: AzureClient!

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
    
    func testCommand() {
        let e = expectation(description: "Wait for HTTP request to complete")
        
        var command = storage.Commands.Blobs.Put(
            azureStorageKey: self.azureStorageKey,
            accountName: "autoswifttest1",
            container: "container1",
            blob: "TestName")
        
        command.blobType = "BlockBlob"
        command.optionalbody = Data("Test".utf8);
        
        command.execute(client: self.azureClient) {
            (error) in
                defer { e.fulfill() }
                XCTAssertNil(error)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
}
