import Foundation
import azureSwiftRuntime
public protocol SchemasCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var integrationAccountName : String { get set }
    var schemaName : String { get set }
    var apiVersion : String { get set }
    var schema :  IntegrationAccountSchemaProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (IntegrationAccountSchemaProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Schemas {
// CreateOrUpdate creates or updates an integration account schema.
    internal class CreateOrUpdateCommand : BaseCommand, SchemasCreateOrUpdate {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var integrationAccountName : String
        public var schemaName : String
        public var apiVersion = "2016-06-01"
    public var schema :  IntegrationAccountSchemaProtocol?

        public init(subscriptionId: String, resourceGroupName: String, integrationAccountName: String, schemaName: String, schema: IntegrationAccountSchemaProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.integrationAccountName = integrationAccountName
            self.schemaName = schemaName
            self.schema = schema
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/integrationAccounts/{integrationAccountName}/schemas/{schemaName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{integrationAccountName}"] = String(describing: self.integrationAccountName)
            self.pathParameters["{schemaName}"] = String(describing: self.schemaName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = schema

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(schema as? IntegrationAccountSchemaData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(IntegrationAccountSchemaData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (IntegrationAccountSchemaProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: IntegrationAccountSchemaData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
