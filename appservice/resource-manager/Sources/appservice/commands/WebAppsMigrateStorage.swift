import Foundation
import azureSwiftRuntime
public protocol WebAppsMigrateStorage  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var subscriptionId : String { get set }
    var subscriptionName : String { get set }
    var apiVersion : String { get set }
    var migrationOptions :  StorageMigrationOptionsProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (StorageMigrationResponseProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WebApps {
// MigrateStorage restores a web app. This method may poll for completion. Polling can be canceled by passing the
// cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
internal class MigrateStorageCommand : BaseCommand, WebAppsMigrateStorage {
    public var resourceGroupName : String
    public var name : String
    public var subscriptionId : String
    public var subscriptionName : String
    public var apiVersion = "2016-08-01"
    public var migrationOptions :  StorageMigrationOptionsProtocol?

    public init(resourceGroupName: String, name: String, subscriptionId: String, subscriptionName: String, migrationOptions: StorageMigrationOptionsProtocol) {
        self.resourceGroupName = resourceGroupName
        self.name = name
        self.subscriptionId = subscriptionId
        self.subscriptionName = subscriptionName
        self.migrationOptions = migrationOptions
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/migrate"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{name}"] = String(describing: self.name)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["subscriptionName"] = String(describing: self.subscriptionName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = migrationOptions
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(migrationOptions)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(StorageMigrationResponseData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (StorageMigrationResponseProtocol?, Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (result: StorageMigrationResponseData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
