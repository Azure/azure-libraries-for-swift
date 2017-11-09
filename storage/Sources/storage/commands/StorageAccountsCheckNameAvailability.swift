import azureSwiftRuntime
// CheckNameAvailability checks that the storage account name is valid and is not already in use.
class StorageAccountsCheckNameAvailabilityCommand : BaseCommand {
    var subscriptionId : String?
    var apiVersion : String? = "2017-06-01"
    var accountName :  StorageAccountCheckNameAvailabilityParametersTypeProtocol?

    override init() {
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Storage/checkNameAvailability"
    }

    override func preCall()  {
        if self.subscriptionId != nil { pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId!) }
        if self.apiVersion != nil { queryParameters["api-version"] = String(describing: self.apiVersion!) }
        self.body = accountName
    }

    override func returnFunc(decoder: ResponseDecoder, jsonString: String) throws -> Decodable? {
        return try decoder.decode(StorageAccountListResultType?.self, from: jsonString)
    }
}
