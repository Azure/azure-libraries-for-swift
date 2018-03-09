import Foundation
import azureSwiftRuntime
public protocol AppServicePlansGetVnetGateway  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var vnetName : String { get set }
    var gatewayName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (VnetGatewayProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.AppServicePlans {
// GetVnetGateway get a Virtual Network gateway.
    internal class GetVnetGatewayCommand : BaseCommand, AppServicePlansGetVnetGateway {
        public var resourceGroupName : String
        public var name : String
        public var vnetName : String
        public var gatewayName : String
        public var subscriptionId : String
        public var apiVersion = "2016-09-01"

        public init(resourceGroupName: String, name: String, vnetName: String, gatewayName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.vnetName = vnetName
            self.gatewayName = gatewayName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/serverfarms/{name}/virtualNetworkConnections/{vnetName}/gateways/{gatewayName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{vnetName}"] = String(describing: self.vnetName)
            self.pathParameters["{gatewayName}"] = String(describing: self.gatewayName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

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
