import Foundation
import azureSwiftRuntime
// Update the update operation can be used to update the SKU, encryption, access tier, or tags for a storage account.
// It can also be used to map the account to a custom domain. Only one custom domain is supported per storage account;
// the replacement/change of custom domain is not supported. In order to replace an old custom domain, the old value
// must be cleared/unregistered before a new value can be set. The update of multiple properties is supported. This
// call does not change the storage keys for the account. If you want to change the storage account keys, use the
// regenerate keys operation. The location and name of the storage account cannot be changed after creation.
public class StorageAccountsUpdateCommand : BaseCommand {
    public var resourceGroupName : String?
    public var accountName : String?
    public var subscriptionId : String?
    public var apiVersion : String? = "2017-06-01"
    public var parameters :  StorageAccountUpdateParametersTypeProtocol?

    public init(test:String) {
        super.init()
        self.method = "Patch"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}"
    }
    public override init() {
        super.init()
        self.method = "Patch"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}"
    }

    public override func preCall()  {
        if self.resourceGroupName != nil { pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName!) }
        if self.accountName != nil { pathParameters["{accountName}"] = String(describing: self.accountName!) }
        if self.subscriptionId != nil { pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId!) }
        if self.apiVersion != nil { queryParameters["api-version"] = String(describing: self.apiVersion!) }
        self.body = parameters
    }

    public override func encodeBody() throws -> Data? {
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(parameters as! StorageAccountUpdateParametersType?)
        return jsonData
    }

    public override func returnFunc(decoder: ResponseDecoder, jsonString: String) throws -> Decodable? {
        return try decoder.decode(StorageAccountType?.self, from: jsonString)
    }
    public func execute(client: RuntimeClient) throws -> StorageAccountTypeProtocol? {
        return try client.execute(command: self) as! StorageAccountTypeProtocol?
    }
    }
