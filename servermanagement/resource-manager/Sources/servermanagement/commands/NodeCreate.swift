import Foundation
import azureSwiftRuntime
public protocol NodeCreate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var nodeName : String { get set }
    var apiVersion : String { get set }
    var gatewayParameters :  NodeParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (NodeResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Node {
// Create creates or updates a management node. This method may poll for completion. Polling can be canceled by passing
// the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
    internal class CreateCommand : BaseCommand, NodeCreate {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var nodeName : String
        public var apiVersion = "2016-07-01-preview"
    public var gatewayParameters :  NodeParametersProtocol?

        public init(subscriptionId: String, resourceGroupName: String, nodeName: String, gatewayParameters: NodeParametersProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.nodeName = nodeName
            self.gatewayParameters = gatewayParameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServerManagement/nodes/{nodeName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{nodeName}"] = String(describing: self.nodeName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = gatewayParameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(gatewayParameters as? NodeParametersData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(NodeResourceData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (NodeResourceProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: NodeResourceData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
