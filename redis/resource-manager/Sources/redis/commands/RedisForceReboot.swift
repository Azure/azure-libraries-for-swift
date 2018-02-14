import Foundation
import azureSwiftRuntime
public protocol RedisForceReboot  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  RedisRebootParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (RedisForceRebootResponseProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Redis {
// ForceReboot reboot specified Redis node(s). This operation requires write permission to the cache resource. There
// can be potential data loss.
internal class ForceRebootCommand : BaseCommand, RedisForceReboot {
    public var resourceGroupName : String
    public var name : String
    public var subscriptionId : String
    public var apiVersion = "2017-10-01"
    public var parameters :  RedisRebootParametersProtocol?

    public init(resourceGroupName: String, name: String, subscriptionId: String, parameters: RedisRebootParametersProtocol) {
        self.resourceGroupName = resourceGroupName
        self.name = name
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/Redis/{name}/forceReboot"
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
            let result = try decoder.decode(RedisForceRebootResponseData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (RedisForceRebootResponseProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: RedisForceRebootResponseData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
