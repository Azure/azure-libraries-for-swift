import Foundation
import azureSwiftRuntime
public protocol ConnectorMappingsCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var hubName : String { get set }
    var connectorName : String { get set }
    var mappingName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  ConnectorMappingResourceFormatProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ConnectorMappingResourceFormatProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ConnectorMappings {
// CreateOrUpdate creates a connector mapping or updates an existing connector mapping in the connector.
    internal class CreateOrUpdateCommand : BaseCommand, ConnectorMappingsCreateOrUpdate {
        public var resourceGroupName : String
        public var hubName : String
        public var connectorName : String
        public var mappingName : String
        public var subscriptionId : String
        public var apiVersion = "2017-04-26"
    public var parameters :  ConnectorMappingResourceFormatProtocol?

        public init(resourceGroupName: String, hubName: String, connectorName: String, mappingName: String, subscriptionId: String, parameters: ConnectorMappingResourceFormatProtocol) {
            self.resourceGroupName = resourceGroupName
            self.hubName = hubName
            self.connectorName = connectorName
            self.mappingName = mappingName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/connectors/{connectorName}/mappings/{mappingName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{hubName}"] = String(describing: self.hubName)
            self.pathParameters["{connectorName}"] = String(describing: self.connectorName)
            self.pathParameters["{mappingName}"] = String(describing: self.mappingName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? ConnectorMappingResourceFormatData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ConnectorMappingResourceFormatData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ConnectorMappingResourceFormatProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: ConnectorMappingResourceFormatData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
