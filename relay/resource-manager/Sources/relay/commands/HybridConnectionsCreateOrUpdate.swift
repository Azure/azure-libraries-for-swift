import Foundation
import azureSwiftRuntime
public protocol HybridConnectionsCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var namespaceName : String { get set }
    var hybridConnectionName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  HybridConnectionProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (HybridConnectionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.HybridConnections {
// CreateOrUpdate creates or updates a service hybrid connection. This operation is idempotent.
internal class CreateOrUpdateCommand : BaseCommand, HybridConnectionsCreateOrUpdate {
    public var resourceGroupName : String
    public var namespaceName : String
    public var hybridConnectionName : String
    public var subscriptionId : String
    public var apiVersion = "2017-04-01"
    public var parameters :  HybridConnectionProtocol?

    public init(resourceGroupName: String, namespaceName: String, hybridConnectionName: String, subscriptionId: String, parameters: HybridConnectionProtocol) {
        self.resourceGroupName = resourceGroupName
        self.namespaceName = namespaceName
        self.hybridConnectionName = hybridConnectionName
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/hybridConnections/{hybridConnectionName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{namespaceName}"] = String(describing: self.namespaceName)
        self.pathParameters["{hybridConnectionName}"] = String(describing: self.hybridConnectionName)
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
            let result = try decoder.decode(HybridConnectionData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (HybridConnectionProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: HybridConnectionData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
