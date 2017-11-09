import XCTest
import Foundation
import azureSwiftRuntime
@testable import storage
class StorageAccountTypeTest : XCTestCase {
    func testModel() {
        do {
            let filepath = ""
            let atc = try ApplicationTokenCredentials.fromFile(path: filepath)
            guard let defaultSubscription = atc.defaultSubscriptionId else {
                XCTFail("defaultSubscriptionId is nil")
                return
            }
            
            let storageAccountsListCommand = StorageAccountsListCommand()
            storageAccountsListCommand.subscriptionId = defaultSubscription
            let azureClient = AzureClient(atc: atc)
            guard let res = try azureClient.execute(command: storageAccountsListCommand) else {
                XCTFail("command result is nil")
                return
            }
            print(res)
            
        } catch RuntimeClientError.executionError(let message) {
            print("RuntimeClientError:", message)
            XCTFail(message)
        } catch {
            print("Error:", error)
            XCTFail()
        }
    }
}
