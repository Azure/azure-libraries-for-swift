import Foundation
import azureSwiftRuntime
public protocol MapsCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var integrationAccountName : String { get set }
    var mapName : String { get set }
    var apiVersion : String { get set }
    var map :  IntegrationAccountMapProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (IntegrationAccountMapProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Maps {
// CreateOrUpdate creates or updates an integration account map.
    internal class CreateOrUpdateCommand : BaseCommand, MapsCreateOrUpdate {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var integrationAccountName : String
        public var mapName : String
        public var apiVersion = "2016-06-01"
    public var map :  IntegrationAccountMapProtocol?

        public init(subscriptionId: String, resourceGroupName: String, integrationAccountName: String, mapName: String, map: IntegrationAccountMapProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.integrationAccountName = integrationAccountName
            self.mapName = mapName
            self.map = map
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/integrationAccounts/{integrationAccountName}/maps/{mapName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{integrationAccountName}"] = String(describing: self.integrationAccountName)
            self.pathParameters["{mapName}"] = String(describing: self.mapName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = map

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(map as? IntegrationAccountMapData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(IntegrationAccountMapData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (IntegrationAccountMapProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: IntegrationAccountMapData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
