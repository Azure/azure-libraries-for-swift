import Foundation
import azureSwiftRuntime
public protocol VaultsGetDeleted  {
    var headerParameters: [String: String] { get set }
    var vaultName : String { get set }
    var location : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (DeletedVaultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Vaults {
// GetDeleted gets the deleted Azure key vault.
    internal class GetDeletedCommand : BaseCommand, VaultsGetDeleted {
        public var vaultName : String
        public var location : String
        public var subscriptionId : String
        public var apiVersion = "2016-10-01"

        public init(vaultName: String, location: String, subscriptionId: String) {
            self.vaultName = vaultName
            self.location = location
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.KeyVault/locations/{location}/deletedVaults/{vaultName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{vaultName}"] = String(describing: self.vaultName)
            self.pathParameters["{location}"] = String(describing: self.location)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(DeletedVaultData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (DeletedVaultProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: DeletedVaultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
