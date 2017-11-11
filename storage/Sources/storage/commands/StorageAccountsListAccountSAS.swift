import Foundation
import azureSwiftRuntime
// ListAccountSAS list SAS credentials of a storage account.
public class StorageAccountsListAccountSASCommand : BaseCommand {
    public var resourceGroupName : String?
    public var accountName : String?
    public var subscriptionId : String?
    public var apiVersion : String? = "2017-06-01"
    public var parameters :  AccountSasParametersTypeProtocol?

    public init(test:String) {
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/ListAccountSas"
    }
    public override init() {
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/ListAccountSas"
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
        let jsonData = try jsonEncoder.encode(parameters as! AccountSasParametersType?)
        return jsonData
    }

    public override func returnFunc(decoder: ResponseDecoder, jsonString: String) throws -> Decodable? {
        return try decoder.decode(ListAccountSasResponseType?.self, from: jsonString)
    }
    public func execute(client: RuntimeClient) throws -> ListAccountSasResponseTypeProtocol? {
        return try client.execute(command: self) as! ListAccountSasResponseTypeProtocol?
    }
    }
