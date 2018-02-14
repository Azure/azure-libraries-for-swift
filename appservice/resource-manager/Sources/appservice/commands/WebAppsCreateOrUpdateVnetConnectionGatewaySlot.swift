import Foundation
import azureSwiftRuntime
public protocol WebAppsCreateOrUpdateVnetConnectionGatewaySlot  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var vnetName : String { get set }
    var gatewayName : String { get set }
    var slot : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var connectionEnvelope :  VnetGatewayProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (VnetGatewayProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WebApps {
// CreateOrUpdateVnetConnectionGatewaySlot adds a gateway to a connected Virtual Network (PUT) or updates it (PATCH).
internal class CreateOrUpdateVnetConnectionGatewaySlotCommand : BaseCommand, WebAppsCreateOrUpdateVnetConnectionGatewaySlot {
    public var resourceGroupName : String
    public var name : String
    public var vnetName : String
    public var gatewayName : String
    public var slot : String
    public var subscriptionId : String
    public var apiVersion = "2016-08-01"
    public var connectionEnvelope :  VnetGatewayProtocol?

    public init(resourceGroupName: String, name: String, vnetName: String, gatewayName: String, slot: String, subscriptionId: String, connectionEnvelope: VnetGatewayProtocol) {
        self.resourceGroupName = resourceGroupName
        self.name = name
        self.vnetName = vnetName
        self.gatewayName = gatewayName
        self.slot = slot
        self.subscriptionId = subscriptionId
        self.connectionEnvelope = connectionEnvelope
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/virtualNetworkConnections/{vnetName}/gateways/{gatewayName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{name}"] = String(describing: self.name)
        self.pathParameters["{vnetName}"] = String(describing: self.vnetName)
        self.pathParameters["{gatewayName}"] = String(describing: self.gatewayName)
        self.pathParameters["{slot}"] = String(describing: self.slot)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = connectionEnvelope
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(connectionEnvelope)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(VnetGatewayData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (VnetGatewayProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: VnetGatewayData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
