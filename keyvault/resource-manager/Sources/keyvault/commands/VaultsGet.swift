import Foundation
import azureSwiftRuntime
public protocol VaultsGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var vaultName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (VaultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Vaults {
// Get gets the specified Azure key vault.
    internal class GetCommand : BaseCommand, VaultsGet {
        public var resourceGroupName : String
        public var vaultName : String
        public var subscriptionId : String
        public var apiVersion = "2016-10-01"

        public init(resourceGroupName: String, vaultName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.vaultName = vaultName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.KeyVault/vaults/{vaultName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{vaultName}"] = String(describing: self.vaultName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

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
