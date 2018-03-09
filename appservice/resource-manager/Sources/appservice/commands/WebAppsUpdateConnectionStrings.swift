import Foundation
import azureSwiftRuntime
public protocol WebAppsUpdateConnectionStrings  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var connectionStrings :  ConnectionStringDictionaryProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ConnectionStringDictionaryProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WebApps {
// UpdateConnectionStrings replaces the connection strings of an app.
    internal class UpdateConnectionStringsCommand : BaseCommand, WebAppsUpdateConnectionStrings {
        public var resourceGroupName : String
        public var name : String
        public var subscriptionId : String
        public var apiVersion = "2016-08-01"
    public var connectionStrings :  ConnectionStringDictionaryProtocol?

        public init(resourceGroupName: String, name: String, subscriptionId: String, connectionStrings: ConnectionStringDictionaryProtocol) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.subscriptionId = subscriptionId
            self.connectionStrings = connectionStrings
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/config/connectionstrings"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = connectionStrings

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(connectionStrings as? ConnectionStringDictionaryData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ConnectionStringDictionaryData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ConnectionStringDictionaryProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: ConnectionStringDictionaryData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
