import Foundation
import azureSwiftRuntime
public protocol GatewayCreate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var gatewayName : String { get set }
    var apiVersion : String { get set }
    var gatewayParameters :  GatewayParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (GatewayResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Gateway {
// Create creates or updates a ManagementService gateway. This method may poll for completion. Polling can be canceled
// by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
internal class CreateCommand : BaseCommand, GatewayCreate {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var gatewayName : String
    public var apiVersion = "2016-07-01-preview"
    public var gatewayParameters :  GatewayParametersProtocol?

    public init(subscriptionId: String, resourceGroupName: String, gatewayName: String, gatewayParameters: GatewayParametersProtocol) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.gatewayName = gatewayName
        self.gatewayParameters = gatewayParameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServerManagement/gateways/{gatewayName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{gatewayName}"] = String(describing: self.gatewayName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = gatewayParameters
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(gatewayParameters)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(GatewayResourceData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (GatewayResourceProtocol?, Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (result: GatewayResourceData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
