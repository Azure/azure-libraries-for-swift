import Foundation
import azureSwiftRuntime
public protocol ApplicationGatewaysBackendHealth  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var applicationGatewayName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var expand : String? { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ApplicationGatewayBackendHealthProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ApplicationGateways {
// BackendHealth gets the backend health of the specified application gateway in a resource group. This method may poll
// for completion. Polling can be canceled by passing the cancel channel argument. The channel will be used to cancel
// polling and any outstanding HTTP requests.
    internal class BackendHealthCommand : BaseCommand, ApplicationGatewaysBackendHealth {
        public var resourceGroupName : String
        public var applicationGatewayName : String
        public var subscriptionId : String
        public var apiVersion = "2018-01-01"
        public var expand : String?

        public init(resourceGroupName: String, applicationGatewayName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.applicationGatewayName = applicationGatewayName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/applicationGateways/{applicationGatewayName}/backendhealth"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{applicationGatewayName}"] = String(describing: self.applicationGatewayName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            if self.expand != nil { queryParameters["$expand"] = String(describing: self.expand!) }

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ApplicationGatewayBackendHealthData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ApplicationGatewayBackendHealthProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: ApplicationGatewayBackendHealthData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
