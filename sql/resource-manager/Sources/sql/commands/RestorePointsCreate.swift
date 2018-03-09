import Foundation
import azureSwiftRuntime
public protocol RestorePointsCreate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var databaseName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  CreateDatabaseRestorePointDefinitionProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (RestorePointProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.RestorePoints {
// Create creates a restore point for a data warehouse. This method may poll for completion. Polling can be canceled by
// passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
    internal class CreateCommand : BaseCommand, RestorePointsCreate {
        public var resourceGroupName : String
        public var serverName : String
        public var databaseName : String
        public var subscriptionId : String
        public var apiVersion = "2017-03-01-preview"
    public var parameters :  CreateDatabaseRestorePointDefinitionProtocol?

        public init(resourceGroupName: String, serverName: String, databaseName: String, subscriptionId: String, parameters: CreateDatabaseRestorePointDefinitionProtocol) {
            self.resourceGroupName = resourceGroupName
            self.serverName = serverName
            self.databaseName = databaseName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/restorePoints"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{serverName}"] = String(describing: self.serverName)
            self.pathParameters["{databaseName}"] = String(describing: self.databaseName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? CreateDatabaseRestorePointDefinitionData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(RestorePointData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (RestorePointProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: RestorePointData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
