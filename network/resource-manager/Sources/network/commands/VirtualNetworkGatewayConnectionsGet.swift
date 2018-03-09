import Foundation
import azureSwiftRuntime
public protocol VirtualNetworkGatewayConnectionsGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var virtualNetworkGatewayConnectionName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (VirtualNetworkGatewayConnectionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.VirtualNetworkGatewayConnections {
// Get gets the specified virtual network gateway connection by resource group.
    internal class GetCommand : BaseCommand, VirtualNetworkGatewayConnectionsGet {
        public var resourceGroupName : String
        public var virtualNetworkGatewayConnectionName : String
        public var subscriptionId : String
        public var apiVersion = "2018-01-01"

        public init(resourceGroupName: String, virtualNetworkGatewayConnectionName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.virtualNetworkGatewayConnectionName = virtualNetworkGatewayConnectionName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/connections/{virtualNetworkGatewayConnectionName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{virtualNetworkGatewayConnectionName}"] = String(describing: self.virtualNetworkGatewayConnectionName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(VirtualNetworkGatewayConnectionData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (VirtualNetworkGatewayConnectionProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: VirtualNetworkGatewayConnectionData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
