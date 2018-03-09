import Foundation
import azureSwiftRuntime
public protocol BackupLongTermRetentionVaultsCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var backupLongTermRetentionVaultName : String { get set }
    var apiVersion : String { get set }
    var parameters :  BackupLongTermRetentionVaultProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (BackupLongTermRetentionVaultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.BackupLongTermRetentionVaults {
// CreateOrUpdate updates a server backup long term retention vault This method may poll for completion. Polling can be
// canceled by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
    internal class CreateOrUpdateCommand : BaseCommand, BackupLongTermRetentionVaultsCreateOrUpdate {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var serverName : String
        public var backupLongTermRetentionVaultName : String
        public var apiVersion = "2014-04-01"
    public var parameters :  BackupLongTermRetentionVaultProtocol?

        public init(subscriptionId: String, resourceGroupName: String, serverName: String, backupLongTermRetentionVaultName: String, parameters: BackupLongTermRetentionVaultProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.serverName = serverName
            self.backupLongTermRetentionVaultName = backupLongTermRetentionVaultName
            self.parameters = parameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/backupLongTermRetentionVaults/{backupLongTermRetentionVaultName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{serverName}"] = String(describing: self.serverName)
            self.pathParameters["{backupLongTermRetentionVaultName}"] = String(describing: self.backupLongTermRetentionVaultName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? BackupLongTermRetentionVaultData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(BackupLongTermRetentionVaultData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (BackupLongTermRetentionVaultProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: BackupLongTermRetentionVaultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
