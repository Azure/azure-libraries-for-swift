import Foundation
import azureSwiftRuntime
public protocol ProtectionPoliciesCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var vaultName : String { get set }
    var resourceGroupName : String { get set }
    var subscriptionId : String { get set }
    var policyName : String { get set }
    var apiVersion : String { get set }
    var parameters :  ProtectionPolicyResourceProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ProtectionPolicyResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ProtectionPolicies {
// CreateOrUpdate creates or modifies a backup policy. This is an asynchronous operation. Status of the operation can
// be fetched using GetPolicyOperationResult API.
    internal class CreateOrUpdateCommand : BaseCommand, ProtectionPoliciesCreateOrUpdate {
        public var vaultName : String
        public var resourceGroupName : String
        public var subscriptionId : String
        public var policyName : String
        public var apiVersion = "2016-12-01"
    public var parameters :  ProtectionPolicyResourceProtocol?

        public init(vaultName: String, resourceGroupName: String, subscriptionId: String, policyName: String, parameters: ProtectionPolicyResourceProtocol) {
            self.vaultName = vaultName
            self.resourceGroupName = resourceGroupName
            self.subscriptionId = subscriptionId
            self.policyName = policyName
            self.parameters = parameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupPolicies/{policyName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{vaultName}"] = String(describing: self.vaultName)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{policyName}"] = String(describing: self.policyName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? ProtectionPolicyResourceData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ProtectionPolicyResourceData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ProtectionPolicyResourceProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: ProtectionPolicyResourceData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
