import azureSwiftRuntime
// List gets the current usage count and the limit for the resources under the subscription.
class UsageListCommand : BaseCommand {
    var subscriptionId : String?
    var apiVersion : String? = "2017-06-01"

    override init() {
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Storage/usages"
    }

    override func preCall()  {
        if self.subscriptionId != nil { pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId!) }
        if self.apiVersion != nil { queryParameters["api-version"] = String(describing: self.apiVersion!) }
    }

    override func returnFunc(decoder: ResponseDecoder, jsonString: String) throws -> Decodable? {
        return try decoder.decode(StorageAccountListResultType?.self, from: jsonString)
    }
}
