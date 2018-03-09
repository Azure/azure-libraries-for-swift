import Foundation
import azureSwiftRuntime
public protocol VaultsCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var vaultName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  VaultCreateOrUpdateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (VaultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Vaults {
// CreateOrUpdate create or update a key vault in the specified subscription.
    internal class CreateOrUpdateCommand : BaseCommand, VaultsCreateOrUpdate {
        public var resourceGroupName : String
        public var vaultName : String
        public var subscriptionId : String
        public var apiVersion = "2016-10-01"
    public var parameters :  VaultCreateOrUpdateParametersProtocol?

        public init(resourceGroupName: String, vaultName: String, subscriptionId: String, parameters: VaultCreateOrUpdateParametersProtocol) {
            self.resourceGroupName = resourceGroupName
            self.vaultName = vaultName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.KeyVault/vaults/{vaultName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{vaultName}"] = String(describing: self.vaultName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? VaultCreateOrUpdateParametersData)
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
