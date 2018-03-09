import Foundation
import azureSwiftRuntime
public protocol JobsExport  {
    var headerParameters: [String: String] { get set }
    var vaultName : String { get set }
    var resourceGroupName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var filter : String? { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Jobs {
// Export triggers export of jobs specified by filters and returns an OperationID to track.
    internal class ExportCommand : BaseCommand, JobsExport {
        public var vaultName : String
        public var resourceGroupName : String
        public var subscriptionId : String
        public var apiVersion = "2017-07-01"
        public var filter : String?

        public init(vaultName: String, resourceGroupName: String, subscriptionId: String) {
            self.vaultName = vaultName
            self.resourceGroupName = resourceGroupName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupJobsExport"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{vaultName}"] = String(describing: self.vaultName)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
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
