import XCTest
import Foundation
import azureSwiftRuntime
@testable import storage
class StorageAccountTests : XCTestCase {
    func testModel() {
        do {
            let filepath = "/Users/alvab/myauth.azureAuth.json"
            let accountName = "testswift3";
            let resourceGroupName = "testSwiftRG"
            let resourceLocation = "westus"

            //Create azure client runtime
            let atc = try ApplicationTokenCredentials.fromFile(path: filepath)
            guard let defaultSubscription = atc.defaultSubscriptionId else {
                XCTFail("defaultSubscriptionId is nil")
                return
            }
            
            let azureClient = AzureClient(atc: atc)
            try listStorageAccounts(azureClient, subscription: defaultSubscription)
            
            //Create storage account
            var storageAccountCreateParametersType = StorageAccountCreateParametersType()
            storageAccountCreateParametersType.location = resourceLocation
            storageAccountCreateParametersType.sku = SkuType()
            storageAccountCreateParametersType.sku?.name = SkuNameEnum.StandardGRS
            
            let storageAccountsCreateCommand = StorageAccountsCreateCommand()
            storageAccountsCreateCommand.accountName = accountName
            storageAccountsCreateCommand.subscriptionId = defaultSubscription
            storageAccountsCreateCommand.resourceGroupName = resourceGroupName
            storageAccountsCreateCommand.parameters = storageAccountCreateParametersType
            try storageAccountsCreateCommand.execute(client: azureClient)
            print("=================Storage account created with name: \(accountName)=================")
            //Get created storage account
            var done = true;
            repeat {
                done = true
                let storageAccountsGetPropertiesCommand = StorageAccountsGetPropertiesCommand()
                storageAccountsGetPropertiesCommand.accountName = accountName
                storageAccountsGetPropertiesCommand.subscriptionId = defaultSubscription
                storageAccountsGetPropertiesCommand.resourceGroupName = resourceGroupName
                let resGet = try storageAccountsGetPropertiesCommand.execute(client: azureClient)
                if resGet == nil && resGet?.properties?.provisioningState == .Succeeded {
                    done = false;
                }else {
                    print("=================Storage account found with name: \(resGet?.name ?? "")=================")
                }
            }while(!done)

            let storageAccountDeleteCommand = StorageAccountsDeleteCommand()
            storageAccountDeleteCommand.accountName = accountName
            storageAccountDeleteCommand.subscriptionId = defaultSubscription
            storageAccountDeleteCommand.resourceGroupName = resourceGroupName
            try storageAccountDeleteCommand.execute(client: azureClient)
            print("=================Storage account deleted with name: \(accountName)=================")
            try listStorageAccounts(azureClient, subscription: defaultSubscription)
        } catch RuntimeClientError.executionError(let message) {
            print("RuntimeClientError:", message)
            XCTFail(message)
        } catch {
            print("Error:", error)
            XCTFail()
        }    
    }
    
    //List all storage accounts
    func listStorageAccounts(_ azureClient: AzureClient, subscription: String) throws {
        //List all storage accounts
        let storageAccountsListCommand = StorageAccountsListCommand()
        storageAccountsListCommand.subscriptionId = subscription
        guard let res = try storageAccountsListCommand.execute(client: azureClient) else {
            XCTFail("command result is nil")
            return
        }
        
        for var storageAccount in res.value! {
            print("Storage account name: \(storageAccount?.name ?? "")")
        }
    }
}
