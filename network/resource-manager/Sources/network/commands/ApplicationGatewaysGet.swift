import Foundation
import azureSwiftRuntime
public protocol ApplicationGatewaysGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var applicationGatewayName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ApplicationGatewayProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ApplicationGateways {
// Get gets the specified application gateway.
internal class GetCommand : BaseCommand, ApplicationGatewaysGet {
    public var resourceGroupName : String
    public var applicationGatewayName : String
    public var subscriptionId : String
    public var apiVersion = "2018-01-01"

    public init(resourceGroupName: String, applicationGatewayName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.applicationGatewayName = applicationGatewayName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/applicationGateways/{applicationGatewayName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{applicationGatewayName}"] = String(describing: self.applicationGatewayName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(ApplicationGatewayData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ApplicationGatewayProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: ApplicationGatewayData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
