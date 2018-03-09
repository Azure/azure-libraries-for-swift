import Foundation
import azureSwiftRuntime
public protocol VaultsDelete  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var vaultName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Vaults {
// Delete deletes the specified Azure key vault.
    internal class DeleteCommand : BaseCommand, VaultsDelete {
        public var resourceGroupName : String
        public var vaultName : String
        public var subscriptionId : String
        public var apiVersion = "2016-10-01"

        public init(resourceGroupName: String, vaultName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.vaultName = vaultName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.KeyVault/vaults/{vaultName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{vaultName}"] = String(describing: self.vaultName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
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
