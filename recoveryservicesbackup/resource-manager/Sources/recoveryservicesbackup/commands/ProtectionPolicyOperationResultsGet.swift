import Foundation
import azureSwiftRuntime
public protocol ProtectionPolicyOperationResultsGet  {
    var headerParameters: [String: String] { get set }
    var vaultName : String { get set }
    var resourceGroupName : String { get set }
    var subscriptionId : String { get set }
    var policyName : String { get set }
    var operationId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ProtectionPolicyResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ProtectionPolicyOperationResults {
// Get provides the result of an operation.
internal class GetCommand : BaseCommand, ProtectionPolicyOperationResultsGet {
    public var vaultName : String
    public var resourceGroupName : String
    public var subscriptionId : String
    public var policyName : String
    public var operationId : String
    public var apiVersion = "2016-12-01"

    public init(vaultName: String, resourceGroupName: String, subscriptionId: String, policyName: String, operationId: String) {
        self.vaultName = vaultName
        self.resourceGroupName = resourceGroupName
        self.subscriptionId = subscriptionId
        self.policyName = policyName
        self.operationId = operationId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupPolicies/{policyName}/operationResults/{operationId}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{vaultName}"] = String(describing: self.vaultName)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{policyName}"] = String(describing: self.policyName)
        self.pathParameters["{operationId}"] = String(describing: self.operationId)
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
