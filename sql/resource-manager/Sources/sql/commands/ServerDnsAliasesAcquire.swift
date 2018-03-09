import Foundation
import azureSwiftRuntime
public protocol ServerDnsAliasesAcquire  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var dnsAliasName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  ServerDnsAliasAcquisitionProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.ServerDnsAliases {
// Acquire acquires server DNS alias from another server. This method may poll for completion. Polling can be canceled
// by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
    internal class AcquireCommand : BaseCommand, ServerDnsAliasesAcquire {
        public var resourceGroupName : String
        public var serverName : String
        public var dnsAliasName : String
        public var subscriptionId : String
        public var apiVersion = "2017-03-01-preview"
    public var parameters :  ServerDnsAliasAcquisitionProtocol?

        public init(resourceGroupName: String, serverName: String, dnsAliasName: String, subscriptionId: String, parameters: ServerDnsAliasAcquisitionProtocol) {
            self.resourceGroupName = resourceGroupName
            self.serverName = serverName
            self.dnsAliasName = dnsAliasName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/dnsAliases/{dnsAliasName}/acquire"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{serverName}"] = String(describing: self.serverName)
            self.pathParameters["{dnsAliasName}"] = String(describing: self.dnsAliasName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? ServerDnsAliasAcquisitionData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public func execute(client: RuntimeClient,
            completionHandler: @escaping (Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (error) in
                completionHandler(error)
            }
        }
    }
}
