import Foundation
import azureSwiftRuntime
public protocol VirtualNetworkPeeringsGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var virtualNetworkName : String { get set }
    var virtualNetworkPeeringName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (VirtualNetworkPeeringProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.VirtualNetworkPeerings {
// Get gets the specified virtual network peering.
    internal class GetCommand : BaseCommand, VirtualNetworkPeeringsGet {
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
            self.method = "Get"
            self.isLongRunningOperation = false
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

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(VirtualNetworkPeeringData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (VirtualNetworkPeeringProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: VirtualNetworkPeeringData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
