import Foundation
import azureSwiftRuntime
public protocol BackupEnginesGet  {
    var headerParameters: [String: String] { get set }
    var vaultName : String { get set }
    var resourceGroupName : String { get set }
    var subscriptionId : String { get set }
    var backupEngineName : String { get set }
    var apiVersion : String { get set }
    var filter : String? { get set }
    var skipToken : String? { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (BackupEngineBaseResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.BackupEngines {
// Get returns backup management server registered to Recovery Services Vault.
    internal class GetCommand : BaseCommand, BackupEnginesGet {
        public var vaultName : String
        public var resourceGroupName : String
        public var subscriptionId : String
        public var backupEngineName : String
        public var apiVersion = "2016-12-01"
        public var filter : String?
        public var skipToken : String?

        public init(vaultName: String, resourceGroupName: String, subscriptionId: String, backupEngineName: String) {
            self.vaultName = vaultName
            self.resourceGroupName = resourceGroupName
            self.subscriptionId = subscriptionId
            self.backupEngineName = backupEngineName
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupEngines/{backupEngineName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{vaultName}"] = String(describing: self.vaultName)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{backupEngineName}"] = String(describing: self.backupEngineName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            if self.filter != nil { queryParameters["$filter"] = String(describing: self.filter!) }
            if self.skipToken != nil { queryParameters["$skipToken"] = String(describing: self.skipToken!) }

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(BackupEngineBaseResourceData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (BackupEngineBaseResourceProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: BackupEngineBaseResourceData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
