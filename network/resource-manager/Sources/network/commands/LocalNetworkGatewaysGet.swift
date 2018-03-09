import Foundation
import azureSwiftRuntime
public protocol LocalNetworkGatewaysGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var localNetworkGatewayName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (LocalNetworkGatewayProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.LocalNetworkGateways {
// Get gets the specified local network gateway in a resource group.
    internal class GetCommand : BaseCommand, LocalNetworkGatewaysGet {
        public var resourceGroupName : String
        public var localNetworkGatewayName : String
        public var subscriptionId : String
        public var apiVersion = "2018-01-01"

        public init(resourceGroupName: String, localNetworkGatewayName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.localNetworkGatewayName = localNetworkGatewayName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/localNetworkGateways/{localNetworkGatewayName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{localNetworkGatewayName}"] = String(describing: self.localNetworkGatewayName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(LocalNetworkGatewayData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (LocalNetworkGatewayProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: LocalNetworkGatewayData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
