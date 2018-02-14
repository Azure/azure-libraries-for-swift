import Foundation
import azureSwiftRuntime
public protocol DatabaseAccountsCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var accountName : String { get set }
    var apiVersion : String { get set }
    var createUpdateParameters :  DatabaseAccountCreateUpdateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (DatabaseAccountProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.DatabaseAccounts {
// CreateOrUpdate creates or updates an Azure Cosmos DB database account. This method may poll for completion. Polling
// can be canceled by passing the cancel channel argument. The channel will be used to cancel polling and any
// outstanding HTTP requests.
internal class CreateOrUpdateCommand : BaseCommand, DatabaseAccountsCreateOrUpdate {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var accountName : String
    public var apiVersion = "2015-04-08"
    public var createUpdateParameters :  DatabaseAccountCreateUpdateParametersProtocol?

    public init(subscriptionId: String, resourceGroupName: String, accountName: String, createUpdateParameters: DatabaseAccountCreateUpdateParametersProtocol) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.accountName = accountName
        self.createUpdateParameters = createUpdateParameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DocumentDB/databaseAccounts/{accountName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{accountName}"] = String(describing: self.accountName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = createUpdateParameters
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(createUpdateParameters)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(DatabaseAccountData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (DatabaseAccountProtocol?, Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (result: DatabaseAccountData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
