import Foundation
import azureSwiftRuntime
public protocol ProtectionPoliciesGet  {
    var headerParameters: [String: String] { get set }
    var vaultName : String { get set }
    var resourceGroupName : String { get set }
    var subscriptionId : String { get set }
    var policyName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ProtectionPolicyResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ProtectionPolicies {
// Get provides the details of the backup policies associated to Recovery Services Vault. This is an asynchronous
// operation. Status of the operation can be fetched using GetPolicyOperationResult API.
internal class GetCommand : BaseCommand, ProtectionPoliciesGet {
    public var vaultName : String
    public var resourceGroupName : String
    public var subscriptionId : String
    public var policyName : String
    public var apiVersion = "2016-12-01"

    public init(vaultName: String, resourceGroupName: String, subscriptionId: String, policyName: String) {
        self.vaultName = vaultName
        self.resourceGroupName = resourceGroupName
        self.subscriptionId = subscriptionId
        self.policyName = policyName
        super.init()
        self.method = "Get"
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
