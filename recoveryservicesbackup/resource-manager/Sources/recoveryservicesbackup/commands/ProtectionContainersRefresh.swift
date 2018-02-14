import Foundation
import azureSwiftRuntime
public protocol ProtectionContainersRefresh  {
    var headerParameters: [String: String] { get set }
    var vaultName : String { get set }
    var resourceGroupName : String { get set }
    var subscriptionId : String { get set }
    var fabricName : String { get set }
    var apiVersion : String { get set }
    var filter : String? { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.ProtectionContainers {
// Refresh discovers all the containers in the subscription that can be backed up to Recovery Services Vault. This is
// an asynchronous operation. To know the status of the operation, call GetRefreshOperationResult API.
internal class RefreshCommand : BaseCommand, ProtectionContainersRefresh {
    public var vaultName : String
    public var resourceGroupName : String
    public var subscriptionId : String
    public var fabricName : String
    public var apiVersion = "2016-12-01"
    public var filter : String?

    public init(vaultName: String, resourceGroupName: String, subscriptionId: String, fabricName: String) {
        self.vaultName = vaultName
        self.resourceGroupName = resourceGroupName
        self.subscriptionId = subscriptionId
        self.fabricName = fabricName
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/refreshContainers"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{vaultName}"] = String(describing: self.vaultName)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{fabricName}"] = String(describing: self.fabricName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
        if self.filter != nil { queryParameters["$filter"] = String(describing: self.filter!) }
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
