import Foundation
import azureSwiftRuntime
public protocol ReplicationNetworkMappingsDelete  {
    var headerParameters: [String: String] { get set }
    var resourceName : String { get set }
    var resourceGroupName : String { get set }
    var subscriptionId : String { get set }
    var fabricName : String { get set }
    var networkName : String { get set }
    var networkMappingName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.ReplicationNetworkMappings {
// Delete the operation to delete a network mapping. This method may poll for completion. Polling can be canceled by
// passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
internal class DeleteCommand : BaseCommand, ReplicationNetworkMappingsDelete {
    public var resourceName : String
    public var resourceGroupName : String
    public var subscriptionId : String
    public var fabricName : String
    public var networkName : String
    public var networkMappingName : String
    public var apiVersion = "2016-08-10"

    public init(resourceName: String, resourceGroupName: String, subscriptionId: String, fabricName: String, networkName: String, networkMappingName: String) {
        self.resourceName = resourceName
        self.resourceGroupName = resourceGroupName
        self.subscriptionId = subscriptionId
        self.fabricName = fabricName
        self.networkName = networkName
        self.networkMappingName = networkMappingName
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = true
        self.path = "/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{resourceName}/replicationFabrics/{fabricName}/replicationNetworks/{networkName}/replicationNetworkMappings/{networkMappingName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceName}"] = String(describing: self.resourceName)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{fabricName}"] = String(describing: self.fabricName)
        self.pathParameters["{networkName}"] = String(describing: self.networkName)
        self.pathParameters["{networkMappingName}"] = String(describing: self.networkMappingName)
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
