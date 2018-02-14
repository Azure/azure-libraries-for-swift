import Foundation
import azureSwiftRuntime
public protocol RegisteredIdentitiesDelete  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var vaultName : String { get set }
    var identityName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.RegisteredIdentities {
// Delete unregisters the given container from your Recovery Services vault.
internal class DeleteCommand : BaseCommand, RegisteredIdentitiesDelete {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var vaultName : String
    public var identityName : String
    public var apiVersion = "2016-06-01"

    public init(subscriptionId: String, resourceGroupName: String, vaultName: String, identityName: String) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.vaultName = vaultName
        self.identityName = identityName
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = false
        self.path = "/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/registeredIdentities/{identityName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{vaultName}"] = String(describing: self.vaultName)
        self.pathParameters["{identityName}"] = String(describing: self.identityName)
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
