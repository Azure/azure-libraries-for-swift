import Foundation
import azureSwiftRuntime
// List lists the available SKUs supported by Microsoft.Storage for given subscription.
public class SkusListCommand : BaseCommand {
    public var subscriptionId : String?
    public var apiVersion : String? = "2017-06-01"

    public init(test:String) {
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Storage/skus"
    }
    public override init() {
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Storage/skus"
    }

    public override func preCall()  {
        if self.subscriptionId != nil { pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId!) }
        if self.apiVersion != nil { queryParameters["api-version"] = String(describing: self.apiVersion!) }
    }


    public override func returnFunc(decoder: ResponseDecoder, jsonString: String) throws -> Decodable? {
        return try decoder.decode(StorageSkuListResultType?.self, from: jsonString)
    }
    public func execute(client: RuntimeClient) throws -> StorageSkuListResultTypeProtocol? {
        return try client.execute(command: self) as! StorageSkuListResultTypeProtocol?
    }
    }
