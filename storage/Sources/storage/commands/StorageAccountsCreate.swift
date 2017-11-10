import Foundation
import azureSwiftRuntime
// Create asynchronously creates a new storage account with the specified parameters. If an account is already created
// and a subsequent create request is issued with different properties, the account properties will be updated. If an
// account is already created and a subsequent create or update request is issued with the exact same set of
// properties, the request will succeed. This method may poll for completion. Polling can be canceled by passing the
// cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
class StorageAccountsCreateCommand : BaseCommand {
    var resourceGroupName : String?
    var accountName : String?
    var subscriptionId : String?
    var apiVersion : String? = "2017-06-01"
    var parameters :  StorageAccountCreateParametersTypeProtocol?

    override init() {
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}"
    }

    override func preCall()  {
        if self.resourceGroupName != nil { pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName!) }
        if self.accountName != nil { pathParameters["{accountName}"] = String(describing: self.accountName!) }
        if self.subscriptionId != nil { pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId!) }
        if self.apiVersion != nil { queryParameters["api-version"] = String(describing: self.apiVersion!) }
        self.body = parameters
    }

    override func encodeBody() throws -> Data? {
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(parameters as! StorageAccountCreateParametersType?)
        return jsonData
    }

    override func returnFunc(decoder: ResponseDecoder, jsonString: String) throws -> Decodable? {
        return try decoder.decode(StorageAccountType?.self, from: jsonString)
    }
    public func execute(client: RuntimeClient) throws -> StorageAccountTypeProtocol? {
        return try client.execute(command: self) as! StorageAccountTypeProtocol?
    }
    }
