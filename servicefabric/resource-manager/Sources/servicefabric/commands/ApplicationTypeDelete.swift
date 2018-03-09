import Foundation
import azureSwiftRuntime
public protocol ApplicationTypeDelete  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var clusterName : String { get set }
    var applicationTypeName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.ApplicationType {
// Delete deletes the application type name resource. This method may poll for completion. Polling can be canceled by
// passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
    internal class DeleteCommand : BaseCommand, ApplicationTypeDelete {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var clusterName : String
        public var applicationTypeName : String
        public var apiVersion = "2017-07-01-preview"

        public init(subscriptionId: String, resourceGroupName: String, clusterName: String, applicationTypeName: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.clusterName = clusterName
            self.applicationTypeName = applicationTypeName
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/clusters/{clusterName}/applicationTypes/{applicationTypeName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{clusterName}"] = String(describing: self.clusterName)
            self.pathParameters["{applicationTypeName}"] = String(describing: self.applicationTypeName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public func execute(client: RuntimeClient,
            completionHandler: @escaping (Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (error) in
                completionHandler(error)
            }
        }
    }
}
