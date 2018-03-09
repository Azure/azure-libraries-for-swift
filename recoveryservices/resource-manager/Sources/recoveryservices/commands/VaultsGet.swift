import Foundation
import azureSwiftRuntime
public protocol VaultsGet  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var vaultName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (VaultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Vaults {
// Get get the Vault details.
    internal class GetCommand : BaseCommand, VaultsGet {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var vaultName : String
        public var apiVersion = "2016-06-01"

        public init(subscriptionId: String, resourceGroupName: String, vaultName: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.vaultName = vaultName
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{vaultName}"] = String(describing: self.vaultName)
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
