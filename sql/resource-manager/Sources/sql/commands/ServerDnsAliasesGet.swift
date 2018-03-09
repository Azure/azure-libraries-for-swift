import Foundation
import azureSwiftRuntime
public protocol ServerDnsAliasesGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var dnsAliasName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ServerDnsAliasProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ServerDnsAliases {
// Get gets a server DNS alias.
    internal class GetCommand : BaseCommand, ServerDnsAliasesGet {
        public var resourceGroupName : String
        public var serverName : String
        public var dnsAliasName : String
        public var subscriptionId : String
        public var apiVersion = "2017-03-01-preview"

        public init(resourceGroupName: String, serverName: String, dnsAliasName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.serverName = serverName
            self.dnsAliasName = dnsAliasName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/dnsAliases/{dnsAliasName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{serverName}"] = String(describing: self.serverName)
            self.pathParameters["{dnsAliasName}"] = String(describing: self.dnsAliasName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ServerDnsAliasData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ServerDnsAliasProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: ServerDnsAliasData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
