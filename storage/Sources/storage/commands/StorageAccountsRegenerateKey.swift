import Foundation
import azureSwiftRuntime
// RegenerateKey regenerates one of the access keys for the specified storage account.
public class StorageAccountsRegenerateKeyCommand : BaseCommand {
    public var resourceGroupName : String?
    public var accountName : String?
    public var subscriptionId : String?
    public var apiVersion : String? = "2017-06-01"
    public var regenerateKey :  StorageAccountRegenerateKeyParametersTypeProtocol?

    public init(test:String) {
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/regenerateKey"
    }
    public override init() {
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/regenerateKey"
    }

    public override func preCall()  {
        if self.resourceGroupName != nil { pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName!) }
        if self.accountName != nil { pathParameters["{accountName}"] = String(describing: self.accountName!) }
        if self.subscriptionId != nil { pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId!) }
        if self.apiVersion != nil { queryParameters["api-version"] = String(describing: self.apiVersion!) }
        self.body = regenerateKey
    }

    public override func encodeBody() throws -> Data? {
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(regenerateKey as! StorageAccountRegenerateKeyParametersType?)
        return jsonData
    }

    public override func returnFunc(decoder: ResponseDecoder, jsonString: String) throws -> Decodable? {
        return try decoder.decode(StorageAccountListKeysResultType?.self, from: jsonString)
    }
    public func execute(client: RuntimeClient) throws -> StorageAccountListKeysResultTypeProtocol? {
        return try client.execute(command: self) as! StorageAccountListKeysResultTypeProtocol?
    }
    }
