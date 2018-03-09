import Foundation
import azureSwiftRuntime
public protocol ContainerServicesDelete  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var containerServiceName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.ContainerServices {
// Delete deletes the specified container service in the specified subscription and resource group. The operation does
// not delete other resources created as part of creating a container service, including storage accounts, VMs, and
// availability sets. All the other resources created with the container service are part of the same resource group
// and can be deleted individually. This method may poll for completion. Polling can be canceled by passing the cancel
// channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
    internal class DeleteCommand : BaseCommand, ContainerServicesDelete {
        public var resourceGroupName : String
        public var containerServiceName : String
        public var subscriptionId : String
        public var apiVersion = "2017-01-31"

        public init(resourceGroupName: String, containerServiceName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.containerServiceName = containerServiceName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerService/containerServices/{containerServiceName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{containerServiceName}"] = String(describing: self.containerServiceName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
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
