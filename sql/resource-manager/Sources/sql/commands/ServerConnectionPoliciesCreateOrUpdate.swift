import Foundation
import azureSwiftRuntime
public protocol ServerConnectionPoliciesCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var connectionPolicyName : String { get set }
    var apiVersion : String { get set }
    var parameters :  ServerConnectionPolicyProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ServerConnectionPolicyProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ServerConnectionPolicies {
// CreateOrUpdate creates or updates the server's connection policy.
internal class CreateOrUpdateCommand : BaseCommand, ServerConnectionPoliciesCreateOrUpdate {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var serverName : String
    public var connectionPolicyName : String
    public var apiVersion = "2014-04-01"
    public var parameters :  ServerConnectionPolicyProtocol?

    public init(subscriptionId: String, resourceGroupName: String, serverName: String, connectionPolicyName: String, parameters: ServerConnectionPolicyProtocol) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.serverName = serverName
        self.connectionPolicyName = connectionPolicyName
        self.parameters = parameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/connectionPolicies/{connectionPolicyName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{serverName}"] = String(describing: self.serverName)
        self.pathParameters["{connectionPolicyName}"] = String(describing: self.connectionPolicyName)
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
            let result = try decoder.decode(ServerConnectionPolicyData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ServerConnectionPolicyProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: ServerConnectionPolicyData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
