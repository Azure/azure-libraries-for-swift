import Foundation
import azureSwiftRuntime
// CheckNameAvailability checks that the storage account name is valid and is not already in use.
public class StorageAccountsCheckNameAvailabilityCommand : BaseCommand {
    public var subscriptionId : String?
    public var apiVersion : String? = "2017-06-01"
    public var accountName :  StorageAccountCheckNameAvailabilityParametersTypeProtocol?

    public init(test:String) {
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Storage/checkNameAvailability"
    }
    public override init() {
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Storage/checkNameAvailability"
    }

    public override func preCall()  {
        if self.subscriptionId != nil { pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId!) }
        if self.apiVersion != nil { queryParameters["api-version"] = String(describing: self.apiVersion!) }
        self.body = accountName
    }

    public override func encodeBody() throws -> Data? {
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(accountName as! StorageAccountCheckNameAvailabilityParametersType?)
        return jsonData
    }

    public override func returnFunc(decoder: ResponseDecoder, jsonString: String) throws -> Decodable? {
        return try decoder.decode(CheckNameAvailabilityResultType?.self, from: jsonString)
    }
    public func execute(client: RuntimeClient) throws -> CheckNameAvailabilityResultTypeProtocol? {
        return try client.execute(command: self) as! CheckNameAvailabilityResultTypeProtocol?
    }
    }
