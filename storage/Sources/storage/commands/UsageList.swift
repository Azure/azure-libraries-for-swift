import Foundation
import azureSwiftRuntime
// List gets the current usage count and the limit for the resources under the subscription.
public class UsageListCommand : BaseCommand {
    public var subscriptionId : String?
    public var apiVersion : String? = "2017-06-01"

    public init(test:String) {
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Storage/usages"
    }
    public override init() {
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Storage/usages"
    }

    public override func preCall()  {
        if self.subscriptionId != nil { pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId!) }
        if self.apiVersion != nil { queryParameters["api-version"] = String(describing: self.apiVersion!) }
    }


    public override func returnFunc(decoder: ResponseDecoder, jsonString: String) throws -> Decodable? {
        return try decoder.decode(UsageListResultType?.self, from: jsonString)
    }
    public func execute(client: RuntimeClient) throws -> UsageListResultTypeProtocol? {
        return try client.execute(command: self) as! UsageListResultTypeProtocol?
    }
    }
