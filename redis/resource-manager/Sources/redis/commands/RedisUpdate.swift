import Foundation
import azureSwiftRuntime
public protocol RedisUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  RedisUpdateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (RedisResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Redis {
// Update update an existing Redis cache.
internal class UpdateCommand : BaseCommand, RedisUpdate {
    public var resourceGroupName : String
    public var name : String
    public var subscriptionId : String
    public var apiVersion = "2017-10-01"
    public var parameters :  RedisUpdateParametersProtocol?

    public init(resourceGroupName: String, name: String, subscriptionId: String, parameters: RedisUpdateParametersProtocol) {
        self.resourceGroupName = resourceGroupName
        self.name = name
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Patch"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/Redis/{name}"
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
            let encodedValue = try encoder.encode(parameters)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(RedisResourceData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (RedisResourceProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: RedisResourceData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
