import Foundation
import azureSwiftRuntime
// ListAccountSAS list SAS credentials of a storage account.
class StorageAccountsListAccountSASCommand : BaseCommand {
    var resourceGroupName : String?
    var accountName : String?
    var subscriptionId : String?
    var apiVersion : String? = "2017-06-01"
    var parameters :  AccountSasParametersTypeProtocol?

    override init() {
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/ListAccountSas"
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
        let jsonData = try jsonEncoder.encode(parameters as! AccountSasParametersType?)
        return jsonData
    }

    override func returnFunc(decoder: ResponseDecoder, jsonString: String) throws -> Decodable? {
        return try decoder.decode(ListAccountSasResponseType?.self, from: jsonString)
    }
    public func execute(client: RuntimeClient) throws -> ListAccountSasResponseTypeProtocol? {
        return try client.execute(command: self) as! ListAccountSasResponseTypeProtocol?
    }
    }
