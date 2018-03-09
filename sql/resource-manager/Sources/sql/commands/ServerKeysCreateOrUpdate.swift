import Foundation
import azureSwiftRuntime
public protocol ServerKeysCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var keyName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  ServerKeyProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ServerKeyProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ServerKeys {
// CreateOrUpdate creates or updates a server key. This method may poll for completion. Polling can be canceled by
// passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
    internal class CreateOrUpdateCommand : BaseCommand, ServerKeysCreateOrUpdate {
        public var resourceGroupName : String
        public var serverName : String
        public var keyName : String
        public var subscriptionId : String
        public var apiVersion = "2015-05-01-preview"
    public var parameters :  ServerKeyProtocol?

        public init(resourceGroupName: String, serverName: String, keyName: String, subscriptionId: String, parameters: ServerKeyProtocol) {
            self.resourceGroupName = resourceGroupName
            self.serverName = serverName
            self.keyName = keyName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/keys/{keyName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{serverName}"] = String(describing: self.serverName)
            self.pathParameters["{keyName}"] = String(describing: self.keyName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? ServerKeyData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ServerKeyData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ServerKeyProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: ServerKeyData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
