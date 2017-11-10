import XCTest
import Foundation
import azureSwiftRuntime
@testable import storage
class StorageAccountTypeTest : XCTestCase {
    func testModel() {
        do {
            let filepath = "/Users/vlashch/__sp/sp1.azureauth"
            let atc = try ApplicationTokenCredentials.fromFile(path: filepath)
            guard let defaultSubscription = atc.defaultSubscriptionId else {
                XCTFail("defaultSubscriptionId is nil")
                return
            }
            
            let azureClient = AzureClient(atc: atc)
            let storageAccountsListCommand = StorageAccountsListCommand()
            storageAccountsListCommand.subscriptionId = defaultSubscription
            guard let res = try azureClient.execute(command: storageAccountsListCommand) else {
                XCTFail("command result is nil")
                return
            }
            print(res)
            
            let storageAccountsCreateCommand = StorageAccountsCreateCommand()
            storageAccountsCreateCommand.resourceGroupName = "shch-rg"
            storageAccountsCreateCommand.accountName = "shchswift7"
            storageAccountsCreateCommand.subscriptionId = defaultSubscription
            
            var storageAccountCreateParameters = StorageAccountCreateParametersType()
            
            var sku = SkuType()
            sku.name = SkuNameEnum.StandardGRS
            
            storageAccountCreateParameters.sku = sku
            storageAccountCreateParameters.kind = KindEnum.BlobStorage
            storageAccountCreateParameters.location = "West US"
            
            var properties = StorageAccountPropertiesCreateParametersType()
            properties.accessTier = AccessTierEnum.Cool
            storageAccountCreateParameters.properties = properties
            
            storageAccountsCreateCommand.parameters = storageAccountCreateParameters
            
            if let sa = try azureClient.execute(command: storageAccountsCreateCommand) {
                print("=== Storage account: ", sa)
            }
            
        } catch RuntimeClientError.executionError(let message) {
            print("RuntimeClientError:", message)
            XCTFail(message)
        } catch {
            print("Error:", error)
            XCTFail()
        }
    }
}
