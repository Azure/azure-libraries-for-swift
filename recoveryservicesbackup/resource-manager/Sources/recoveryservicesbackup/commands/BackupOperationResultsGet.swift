import Foundation
import azureSwiftRuntime
public protocol BackupOperationResultsGet  {
    var headerParameters: [String: String] { get set }
    var vaultName : String { get set }
    var resourceGroupName : String { get set }
    var subscriptionId : String { get set }
    var operationId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.BackupOperationResults {
// Get provides the status of the delete operations such as deleting backed up item. Once the operation has started,
// the status code in the response would be Accepted. It will continue to be in this state till it reaches completion.
// On successful completion, the status code will be OK. This method expects OperationID as an argument. OperationID is
// part of the Location header of the operation response.
    internal class GetCommand : BaseCommand, BackupOperationResultsGet {
        public var vaultName : String
        public var resourceGroupName : String
        public var subscriptionId : String
        public var operationId : String
        public var apiVersion = "2016-12-01"

        public init(vaultName: String, resourceGroupName: String, subscriptionId: String, operationId: String) {
            self.vaultName = vaultName
            self.resourceGroupName = resourceGroupName
            self.subscriptionId = subscriptionId
            self.operationId = operationId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupOperationResults/{operationId}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{vaultName}"] = String(describing: self.vaultName)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{operationId}"] = String(describing: self.operationId)
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
