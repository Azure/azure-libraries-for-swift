import Foundation
import azureSwiftRuntime
public protocol ConnectorsGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var hubName : String { get set }
    var connectorName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ConnectorResourceFormatProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Connectors {
// Get gets a connector in the hub.
    internal class GetCommand : BaseCommand, ConnectorsGet {
        public var resourceGroupName : String
        public var hubName : String
        public var connectorName : String
        public var subscriptionId : String
        public var apiVersion = "2017-04-26"

        public init(resourceGroupName: String, hubName: String, connectorName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.hubName = hubName
            self.connectorName = connectorName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/connectors/{connectorName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{hubName}"] = String(describing: self.hubName)
            self.pathParameters["{connectorName}"] = String(describing: self.connectorName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ConnectorResourceFormatData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ConnectorResourceFormatProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: ConnectorResourceFormatData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
