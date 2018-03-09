import Foundation
import azureSwiftRuntime
public protocol RedisRegenerateKey  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  RedisRegenerateKeyParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (RedisAccessKeysProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Redis {
// RegenerateKey regenerate Redis cache's access keys. This operation requires write permission to the cache resource.
    internal class RegenerateKeyCommand : BaseCommand, RedisRegenerateKey {
        public var resourceGroupName : String
        public var name : String
        public var subscriptionId : String
        public var apiVersion = "2017-10-01"
    public var parameters :  RedisRegenerateKeyParametersProtocol?

        public init(resourceGroupName: String, name: String, subscriptionId: String, parameters: RedisRegenerateKeyParametersProtocol) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/Redis/{name}/regenerateKey"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? RedisRegenerateKeyParametersData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(RedisAccessKeysData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (RedisAccessKeysProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: RedisAccessKeysData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
