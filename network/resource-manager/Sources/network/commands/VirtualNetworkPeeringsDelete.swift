import Foundation
import azureSwiftRuntime
public protocol VirtualNetworkPeeringsDelete  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var virtualNetworkName : String { get set }
    var virtualNetworkPeeringName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.VirtualNetworkPeerings {
// Delete deletes the specified virtual network peering. This method may poll for completion. Polling can be canceled
// by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
    internal class DeleteCommand : BaseCommand, VirtualNetworkPeeringsDelete {
        public var resourceGroupName : String
        public var virtualNetworkName : String
        public var virtualNetworkPeeringName : String
        public var subscriptionId : String
        public var apiVersion = "2018-01-01"

        public init(resourceGroupName: String, virtualNetworkName: String, virtualNetworkPeeringName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.virtualNetworkName = virtualNetworkName
            self.virtualNetworkPeeringName = virtualNetworkPeeringName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/virtualNetworkPeerings/{virtualNetworkPeeringName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{virtualNetworkName}"] = String(describing: self.virtualNetworkName)
            self.pathParameters["{virtualNetworkPeeringName}"] = String(describing: self.virtualNetworkPeeringName)
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
