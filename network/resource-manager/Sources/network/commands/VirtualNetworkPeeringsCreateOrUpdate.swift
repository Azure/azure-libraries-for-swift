import Foundation
import azureSwiftRuntime
public protocol VirtualNetworkPeeringsCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var virtualNetworkName : String { get set }
    var virtualNetworkPeeringName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var virtualNetworkPeeringParameters :  VirtualNetworkPeeringProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (VirtualNetworkPeeringProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.VirtualNetworkPeerings {
// CreateOrUpdate creates or updates a peering in the specified virtual network. This method may poll for completion.
// Polling can be canceled by passing the cancel channel argument. The channel will be used to cancel polling and any
// outstanding HTTP requests.
    internal class CreateOrUpdateCommand : BaseCommand, VirtualNetworkPeeringsCreateOrUpdate {
        public var resourceGroupName : String
        public var virtualNetworkName : String
        public var virtualNetworkPeeringName : String
        public var subscriptionId : String
        public var apiVersion = "2018-01-01"
    public var virtualNetworkPeeringParameters :  VirtualNetworkPeeringProtocol?

        public init(resourceGroupName: String, virtualNetworkName: String, virtualNetworkPeeringName: String, subscriptionId: String, virtualNetworkPeeringParameters: VirtualNetworkPeeringProtocol) {
            self.resourceGroupName = resourceGroupName
            self.virtualNetworkName = virtualNetworkName
            self.virtualNetworkPeeringName = virtualNetworkPeeringName
            self.subscriptionId = subscriptionId
            self.virtualNetworkPeeringParameters = virtualNetworkPeeringParameters
            super.init()
            self.method = "Put"
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
            self.body = virtualNetworkPeeringParameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(virtualNetworkPeeringParameters as? VirtualNetworkPeeringData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
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
            client.executeAsyncLRO(command: self) {
                (result: VirtualNetworkPeeringData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
