import Foundation
import azureSwiftRuntime
public protocol ItemLevelRecoveryConnectionsProvision  {
    var headerParameters: [String: String] { get set }
    var vaultName : String { get set }
    var resourceGroupName : String { get set }
    var subscriptionId : String { get set }
    var fabricName : String { get set }
    var containerName : String { get set }
    var protectedItemName : String { get set }
    var recoveryPointId : String { get set }
    var apiVersion : String { get set }
    var parameters :  ILRRequestResourceProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.ItemLevelRecoveryConnections {
// Provision provisions a script which invokes an iSCSI connection to the backup data. Executing this script opens a
// file explorer displaying all the recoverable files and folders. This is an asynchronous operation. To know the
// status of provisioning, call GetProtectedItemOperationResult API.
internal class ProvisionCommand : BaseCommand, ItemLevelRecoveryConnectionsProvision {
    public var vaultName : String
    public var resourceGroupName : String
    public var subscriptionId : String
    public var fabricName : String
    public var containerName : String
    public var protectedItemName : String
    public var recoveryPointId : String
    public var apiVersion = "2016-12-01"
    public var parameters :  ILRRequestResourceProtocol?

    public init(vaultName: String, resourceGroupName: String, subscriptionId: String, fabricName: String, containerName: String, protectedItemName: String, recoveryPointId: String, parameters: ILRRequestResourceProtocol) {
        self.vaultName = vaultName
        self.resourceGroupName = resourceGroupName
        self.subscriptionId = subscriptionId
        self.fabricName = fabricName
        self.containerName = containerName
        self.protectedItemName = protectedItemName
        self.recoveryPointId = recoveryPointId
        self.parameters = parameters
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/recoveryPoints/{recoveryPointId}/provisionInstantItemRecovery"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{vaultName}"] = String(describing: self.vaultName)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{fabricName}"] = String(describing: self.fabricName)
        self.pathParameters["{containerName}"] = String(describing: self.containerName)
        self.pathParameters["{protectedItemName}"] = String(describing: self.protectedItemName)
        self.pathParameters["{recoveryPointId}"] = String(describing: self.recoveryPointId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = parameters
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(parameters)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (error) in
            completionHandler(error)
        }
    }
}
}
