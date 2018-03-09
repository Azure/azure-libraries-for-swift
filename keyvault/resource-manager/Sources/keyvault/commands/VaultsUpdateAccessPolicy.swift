import Foundation
import azureSwiftRuntime
public protocol VaultsUpdateAccessPolicy  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var vaultName : String { get set }
    var operationKind : AccessPolicyUpdateKindEnum { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  VaultAccessPolicyParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (VaultAccessPolicyParametersProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Vaults {
// UpdateAccessPolicy update access policies in a key vault in the specified subscription.
    internal class UpdateAccessPolicyCommand : BaseCommand, VaultsUpdateAccessPolicy {
        public var resourceGroupName : String
        public var vaultName : String
        public var operationKind : AccessPolicyUpdateKindEnum
        public var subscriptionId : String
        public var apiVersion = "2016-10-01"
    public var parameters :  VaultAccessPolicyParametersProtocol?

        public init(resourceGroupName: String, vaultName: String, operationKind: AccessPolicyUpdateKindEnum, subscriptionId: String, parameters: VaultAccessPolicyParametersProtocol) {
            self.resourceGroupName = resourceGroupName
            self.vaultName = vaultName
            self.operationKind = operationKind
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.KeyVault/vaults/{vaultName}/accessPolicies/{operationKind}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{vaultName}"] = String(describing: self.vaultName)
            self.pathParameters["{operationKind}"] = String(describing: self.operationKind)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? VaultAccessPolicyParametersData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(VaultAccessPolicyParametersData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (VaultAccessPolicyParametersProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: VaultAccessPolicyParametersData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
