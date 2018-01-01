import XCTest
import Foundation
import azureSwiftRuntime
 import storage

public class BlobGetCommandTest : XCTestCase {
    let envVarName = "AUTH_FILE_PATH"
    var filepath = String()
    let timeout: TimeInterval = 102.0

    var applicationTokenCredentials: ApplicationTokenCredentials!
    var azureClient: AzureClient!

    override public func setUp() {
        continueAfterFailure = false
        
        let env = AuzureEnvironment(endpoints:[
            .resourceManager : ""
            ])
        
        let atc = AzureTokenCredentials(environment: env, tenantId: "", subscriptionId: "")
        
        self.azureClient = AzureClient(atc: atc)
            .withRequestInterceptor(LogRequestInterceptor(showOptions: .all))
            .withResponseInterceptor(LogResponseInterceptor(showOptions: .all))
        super.setUp()
    }
    
    func testCommand() {
        var command = storage.Commands.Blobs    .Put(accountName: "autoswifttest1", container: "container1", blob: "TestName")
        command.optionalbody = Data("Test".utf8);
        var base64String = ""
        command.headerParameters["Authorization"] = "SharedKey autoswifttest1:\(base64String)"
        let e = expectation(description: "Wait for HTTP request to complete")

        command.execute(client: self.azureClient) {
            (error) in
                defer { e.fulfill() }
                XCTAssertNil(error)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
        
}
