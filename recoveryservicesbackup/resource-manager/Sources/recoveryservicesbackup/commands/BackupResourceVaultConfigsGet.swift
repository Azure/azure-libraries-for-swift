import Foundation
import azureSwiftRuntime
public protocol BackupResourceVaultConfigsGet  {
    var headerParameters: [String: String] { get set }
    var vaultName : String { get set }
    var resourceGroupName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (BackupResourceVaultConfigResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.BackupResourceVaultConfigs {
// Get fetches resource vault config.
internal class GetCommand : BaseCommand, BackupResourceVaultConfigsGet {
    public var vaultName : String
    public var resourceGroupName : String
    public var subscriptionId : String
    public var apiVersion = "2016-12-01"

    public init(vaultName: String, resourceGroupName: String, subscriptionId: String) {
        self.vaultName = vaultName
        self.resourceGroupName = resourceGroupName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupconfig/vaultconfig"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{vaultName}"] = String(describing: self.vaultName)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(BackupResourceVaultConfigResourceData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (BackupResourceVaultConfigResourceProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: BackupResourceVaultConfigResourceData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
