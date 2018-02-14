import Foundation
import azureSwiftRuntime
public protocol WebAppsCreateOrUpdateVnetConnection  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var vnetName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var connectionEnvelope :  VnetInfoProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (VnetInfoProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WebApps {
// CreateOrUpdateVnetConnection adds a Virtual Network connection to an app or slot (PUT) or updates the connection
// properties (PATCH).
internal class CreateOrUpdateVnetConnectionCommand : BaseCommand, WebAppsCreateOrUpdateVnetConnection {
    public var resourceGroupName : String
    public var name : String
    public var vnetName : String
    public var subscriptionId : String
    public var apiVersion = "2016-08-01"
    public var connectionEnvelope :  VnetInfoProtocol?

    public init(resourceGroupName: String, name: String, vnetName: String, subscriptionId: String, connectionEnvelope: VnetInfoProtocol) {
        self.resourceGroupName = resourceGroupName
        self.name = name
        self.vnetName = vnetName
        self.subscriptionId = subscriptionId
        self.connectionEnvelope = connectionEnvelope
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/virtualNetworkConnections/{vnetName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{name}"] = String(describing: self.name)
        self.pathParameters["{vnetName}"] = String(describing: self.vnetName)
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
            let result = try decoder.decode(VnetInfoData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (VnetInfoProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: VnetInfoData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
