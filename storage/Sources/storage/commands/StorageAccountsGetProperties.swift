import Foundation
import azureSwiftRuntime
// GetProperties returns the properties for the specified storage account including but not limited to name, SKU name,
// location, and account status. The ListKeys operation should be used to retrieve storage keys.
class StorageAccountsGetPropertiesCommand : BaseCommand {
    var resourceGroupName : String?
    var accountName : String?
    var subscriptionId : String?
    var apiVersion : String? = "2017-06-01"

    override init() {
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}"
    }

    override func preCall()  {
        if self.resourceGroupName != nil { pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName!) }
        if self.accountName != nil { pathParameters["{accountName}"] = String(describing: self.accountName!) }
        if self.subscriptionId != nil { pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId!) }
        if self.apiVersion != nil { queryParameters["api-version"] = String(describing: self.apiVersion!) }
    }


    override func returnFunc(decoder: ResponseDecoder, jsonString: String) throws -> Decodable? {
        return try decoder.decode(StorageAccountType?.self, from: jsonString)
    }
    public func execute(client: RuntimeClient) throws -> StorageAccountTypeProtocol? {
        return try client.execute(command: self) as! StorageAccountTypeProtocol?
    }
    }
