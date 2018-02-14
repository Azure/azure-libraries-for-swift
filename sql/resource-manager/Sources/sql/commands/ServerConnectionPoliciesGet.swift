import Foundation
import azureSwiftRuntime
public protocol ServerConnectionPoliciesGet  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var connectionPolicyName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ServerConnectionPolicyProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ServerConnectionPolicies {
// Get gets the server's secure connection policy.
internal class GetCommand : BaseCommand, ServerConnectionPoliciesGet {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var serverName : String
    public var connectionPolicyName : String
    public var apiVersion = "2014-04-01"

    public init(subscriptionId: String, resourceGroupName: String, serverName: String, connectionPolicyName: String) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.serverName = serverName
        self.connectionPolicyName = connectionPolicyName
        super.init()
        self.method = "Get"
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
