import Foundation
import azureSwiftRuntime
public protocol LinkedServerCreate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var linkedServerName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  RedisLinkedServerCreateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (RedisLinkedServerWithPropertiesProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.LinkedServer {
// Create adds a linked server to the Redis cache (requires Premium SKU). This method may poll for completion. Polling
// can be canceled by passing the cancel channel argument. The channel will be used to cancel polling and any
// outstanding HTTP requests.
internal class CreateCommand : BaseCommand, LinkedServerCreate {
    public var resourceGroupName : String
    public var name : String
    public var linkedServerName : String
    public var subscriptionId : String
    public var apiVersion = "2017-10-01"
    public var parameters :  RedisLinkedServerCreateParametersProtocol?

    public init(resourceGroupName: String, name: String, linkedServerName: String, subscriptionId: String, parameters: RedisLinkedServerCreateParametersProtocol) {
        self.resourceGroupName = resourceGroupName
        self.name = name
        self.linkedServerName = linkedServerName
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/Redis/{name}/linkedServers/{linkedServerName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{name}"] = String(describing: self.name)
        self.pathParameters["{linkedServerName}"] = String(describing: self.linkedServerName)
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
            let result = try decoder.decode(RedisLinkedServerWithPropertiesData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (RedisLinkedServerWithPropertiesProtocol?, Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (result: RedisLinkedServerWithPropertiesData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
