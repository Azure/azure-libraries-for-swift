import Foundation
import azureSwiftRuntime
public protocol VaultsCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var vaultName : String { get set }
    var apiVersion : String { get set }
    var vault :  VaultProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (VaultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Vaults {
// CreateOrUpdate creates or updates a Recovery Services vault.
internal class CreateOrUpdateCommand : BaseCommand, VaultsCreateOrUpdate {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var vaultName : String
    public var apiVersion = "2016-06-01"
    public var vault :  VaultProtocol?

    public init(subscriptionId: String, resourceGroupName: String, vaultName: String, vault: VaultProtocol) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.vaultName = vaultName
        self.vault = vault
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{vaultName}"] = String(describing: self.vaultName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = vault
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(vault)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(VaultData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (VaultProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: VaultData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
