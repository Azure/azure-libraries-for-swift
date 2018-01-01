import Foundation
import azureSwiftRuntime
public protocol StorageAccountsCreate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var accountName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  StorageAccountCreateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (StorageAccountProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.StorageAccounts {
// Create asynchronously creates a new storage account with the specified parameters. If an account is already created
// and a subsequent create request is issued with different properties, the account properties will be updated. If an
// account is already created and a subsequent create or update request is issued with the exact same set of
// properties, the request will succeed. This method may poll for completion. Polling can be canceled by passing the
// cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
internal class CreateCommand : BaseCommand, StorageAccountsCreate {
    public var resourceGroupName : String
    public var accountName : String
    public var subscriptionId : String
    public var apiVersion : String = "2017-06-01"
    public var parameters :  StorageAccountCreateParametersProtocol?

    public init(resourceGroupName: String, accountName: String, subscriptionId: String, apiVersion: String, parameters: StorageAccountCreateParametersProtocol) {
        self.resourceGroupName = resourceGroupName
        self.accountName = accountName
        self.subscriptionId = subscriptionId
        self.apiVersion = apiVersion
        self.parameters = parameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{accountName}"] = String(describing: self.accountName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["{api-version}"] = String(describing: self.apiVersion)
    self.body = parameters
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(parameters)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            return try decoder.decode(StorageAccountData?.self, from: data)
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (StorageAccountProtocol?, Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (result: StorageAccountData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
