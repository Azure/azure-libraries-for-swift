import Foundation
import azureSwiftRuntime
public protocol VirtualNetworkGatewayConnectionsSetSharedKey  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var virtualNetworkGatewayConnectionName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  ConnectionSharedKeyProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ConnectionSharedKeyProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.VirtualNetworkGatewayConnections {
// SetSharedKey the Put VirtualNetworkGatewayConnectionSharedKey operation sets the virtual network gateway connection
// shared key for passed virtual network gateway connection in the specified resource group through Network resource
// provider. This method may poll for completion. Polling can be canceled by passing the cancel channel argument. The
// channel will be used to cancel polling and any outstanding HTTP requests.
internal class SetSharedKeyCommand : BaseCommand, VirtualNetworkGatewayConnectionsSetSharedKey {
    public var resourceGroupName : String
    public var virtualNetworkGatewayConnectionName : String
    public var subscriptionId : String
    public var apiVersion = "2018-01-01"
    public var parameters :  ConnectionSharedKeyProtocol?

    public init(resourceGroupName: String, virtualNetworkGatewayConnectionName: String, subscriptionId: String, parameters: ConnectionSharedKeyProtocol) {
        self.resourceGroupName = resourceGroupName
        self.virtualNetworkGatewayConnectionName = virtualNetworkGatewayConnectionName
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/sharedkey"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{virtualNetworkGatewayConnectionName}"] = String(describing: self.virtualNetworkGatewayConnectionName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = parameters
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(parameters)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(ConnectionSharedKeyData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ConnectionSharedKeyProtocol?, Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (result: ConnectionSharedKeyData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
