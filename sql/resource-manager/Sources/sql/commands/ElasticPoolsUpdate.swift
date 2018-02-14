import Foundation
import azureSwiftRuntime
public protocol ElasticPoolsUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var elasticPoolName : String { get set }
    var apiVersion : String { get set }
    var parameters :  ElasticPoolUpdateProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ElasticPoolProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ElasticPools {
// Update updates an existing elastic pool. This method may poll for completion. Polling can be canceled by passing the
// cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
internal class UpdateCommand : BaseCommand, ElasticPoolsUpdate {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var serverName : String
    public var elasticPoolName : String
    public var apiVersion = "2014-04-01"
    public var parameters :  ElasticPoolUpdateProtocol?

    public init(subscriptionId: String, resourceGroupName: String, serverName: String, elasticPoolName: String, parameters: ElasticPoolUpdateProtocol) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.serverName = serverName
        self.elasticPoolName = elasticPoolName
        self.parameters = parameters
        super.init()
        self.method = "Patch"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{serverName}"] = String(describing: self.serverName)
        self.pathParameters["{elasticPoolName}"] = String(describing: self.elasticPoolName)
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
            let result = try decoder.decode(ElasticPoolData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ElasticPoolProtocol?, Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (result: ElasticPoolData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
