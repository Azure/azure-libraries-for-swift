import Foundation
import azureSwiftRuntime
public protocol SyncAgentsCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var syncAgentName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  SyncAgentProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (SyncAgentProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.SyncAgents {
// CreateOrUpdate creates or updates a sync agent. This method may poll for completion. Polling can be canceled by
// passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
    internal class CreateOrUpdateCommand : BaseCommand, SyncAgentsCreateOrUpdate {
        public var resourceGroupName : String
        public var serverName : String
        public var syncAgentName : String
        public var subscriptionId : String
        public var apiVersion = "2015-05-01-preview"
    public var parameters :  SyncAgentProtocol?

        public init(resourceGroupName: String, serverName: String, syncAgentName: String, subscriptionId: String, parameters: SyncAgentProtocol) {
            self.resourceGroupName = resourceGroupName
            self.serverName = serverName
            self.syncAgentName = syncAgentName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/syncAgents/{syncAgentName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{serverName}"] = String(describing: self.serverName)
            self.pathParameters["{syncAgentName}"] = String(describing: self.syncAgentName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? SyncAgentData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(SyncAgentData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (SyncAgentProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: SyncAgentData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
