import XCTest
import Foundation
import azureSwiftRuntime
@testable import storage
class StorageAccountTypeTest : XCTestCase {
    func testModel() {
        do {
            let envVarName = "AUTH_FILE_PATH"
            guard let filepath = self.getEnvironmentVar(name: envVarName.uppercased()) else {
                XCTFail("azure auth file path is not set in env var \(envVarName))")
                return
            }
            
            let atc = try ApplicationTokenCredentials.fromFile(path: filepath)
            guard let defaultSubscription = atc.defaultSubscriptionId else {
                XCTFail("defaultSubscriptionId is nil")
                return
            }
            
            // === create runtime client
            
            let azureClient = AzureClient(atc: atc)
            
            // === create storage account
            
            let storageAccountsCreateCommand = StorageAccountsCreateCommand()
            storageAccountsCreateCommand.resourceGroupName = "shch-rg"
            storageAccountsCreateCommand.accountName = self.randomName(prefix: "swift", length: 10)
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
            
            if storageAccountsCreateCommand.isLongRunningOperation {
                var count = 10
                var ret = try azureClient.execute(command: storageAccountsCreateCommand)
                while ret == nil && count > 0 {
                    Thread.sleep(forTimeInterval: 5)
                    ret = try azureClient.execute(command: storageAccountsCreateCommand)
                    count -= 1
                }
                
                if let sa = try azureClient.execute(command: storageAccountsCreateCommand) {
                    print("=== Storage account created: ", sa)
                } else {
                    XCTFail("command result is nil")
                }
            }
            
            // === list storage accounts
            
            let storageAccountsListCommand = StorageAccountsListCommand()
            storageAccountsListCommand.subscriptionId = defaultSubscription
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
    
    // === private helpers ===
    
    func randomName(prefix: String, length: Int) -> String {
        let allowedChars = "abcdefghijklmnopqrstuvwxyz123456789"
        let allowedCharsCount = UInt32(allowedChars.characters.count)
        var randomString = ""
        
        for _ in 0..<length {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
            let newCharacter = allowedChars[randomIndex]
            randomString += String(newCharacter)
        }
        
        return prefix + randomString
    }
    
    func getEnvironmentVar(name: String) -> String? {
        guard let rawValue = getenv(name) else { return nil }
        return String(utf8String: rawValue)
    }
}
