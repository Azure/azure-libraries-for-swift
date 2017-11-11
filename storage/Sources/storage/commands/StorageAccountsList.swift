import Foundation
import azureSwiftRuntime
// List lists all the storage accounts available under the subscription. Note that storage keys are not returned; use
// the ListKeys operation for this.
public class StorageAccountsListCommand : BaseCommand {
    public var subscriptionId : String?
    public var apiVersion : String? = "2017-06-01"

    public init(test:String) {
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Storage/storageAccounts"
    }
    public override init() {
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Storage/storageAccounts"
    }

    public override func preCall()  {
        if self.subscriptionId != nil { pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId!) }
        if self.apiVersion != nil { queryParameters["api-version"] = String(describing: self.apiVersion!) }
    }


    public override func returnFunc(decoder: ResponseDecoder, jsonString: String) throws -> Decodable? {
        return try decoder.decode(StorageAccountListResultType?.self, from: jsonString)
    }
    public func execute(client: RuntimeClient) throws -> StorageAccountListResultTypeProtocol? {
        return try client.execute(command: self) as! StorageAccountListResultTypeProtocol?
    }
    }
