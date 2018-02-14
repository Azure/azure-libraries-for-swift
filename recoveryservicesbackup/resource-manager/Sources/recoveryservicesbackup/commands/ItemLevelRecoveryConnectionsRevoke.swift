import Foundation
import azureSwiftRuntime
public protocol ItemLevelRecoveryConnectionsRevoke  {
    var headerParameters: [String: String] { get set }
    var vaultName : String { get set }
    var resourceGroupName : String { get set }
    var subscriptionId : String { get set }
    var fabricName : String { get set }
    var containerName : String { get set }
    var protectedItemName : String { get set }
    var recoveryPointId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.ItemLevelRecoveryConnections {
// Revoke revokes an iSCSI connection which can be used to download a script. Executing this script opens a file
// explorer displaying all recoverable files and folders. This is an asynchronous operation.
internal class RevokeCommand : BaseCommand, ItemLevelRecoveryConnectionsRevoke {
    public var vaultName : String
    public var resourceGroupName : String
    public var subscriptionId : String
    public var fabricName : String
    public var containerName : String
    public var protectedItemName : String
    public var recoveryPointId : String
    public var apiVersion = "2016-12-01"

    public init(vaultName: String, resourceGroupName: String, subscriptionId: String, fabricName: String, containerName: String, protectedItemName: String, recoveryPointId: String) {
        self.vaultName = vaultName
        self.resourceGroupName = resourceGroupName
        self.subscriptionId = subscriptionId
        self.fabricName = fabricName
        self.containerName = containerName
        self.protectedItemName = protectedItemName
        self.recoveryPointId = recoveryPointId
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/recoveryPoints/{recoveryPointId}/revokeInstantItemRecovery"
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
