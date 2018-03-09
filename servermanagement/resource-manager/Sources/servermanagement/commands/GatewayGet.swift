import Foundation
import azureSwiftRuntime
public protocol GatewayGet  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var gatewayName : String { get set }
    var apiVersion : String { get set }
    var expand : GatewayExpandOptionEnum? { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (GatewayResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Gateway {
// Get gets a gateway.
    internal class GetCommand : BaseCommand, GatewayGet {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var gatewayName : String
        public var apiVersion = "2016-07-01-preview"
        public var expand : GatewayExpandOptionEnum?

        public init(subscriptionId: String, resourceGroupName: String, gatewayName: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.gatewayName = gatewayName
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServerManagement/gateways/{gatewayName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{gatewayName}"] = String(describing: self.gatewayName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            if self.expand != nil { queryParameters["$expand"] = String(describing: self.expand!) }

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
            client.executeAsync(command: self) {
                (result: GatewayResourceData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
