import Foundation
import azureSwiftRuntime
public protocol ReplicationsDelete  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var registryName : String { get set }
    var replicationName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Replications {
// Delete deletes a replication from a container registry. This method may poll for completion. Polling can be canceled
// by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
internal class DeleteCommand : BaseCommand, ReplicationsDelete {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var registryName : String
    public var replicationName : String
    public var apiVersion = "2017-10-01"

    public init(subscriptionId: String, resourceGroupName: String, registryName: String, replicationName: String) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.registryName = registryName
        self.replicationName = replicationName
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerRegistry/registries/{registryName}/replications/{replicationName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{registryName}"] = String(describing: self.registryName)
        self.pathParameters["{replicationName}"] = String(describing: self.replicationName)
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
