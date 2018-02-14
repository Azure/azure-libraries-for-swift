import Foundation
import azureSwiftRuntime
public protocol SyncAgentsGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var syncAgentName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (SyncAgentProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.SyncAgents {
// Get gets a sync agent.
internal class GetCommand : BaseCommand, SyncAgentsGet {
    public var resourceGroupName : String
    public var serverName : String
    public var syncAgentName : String
    public var subscriptionId : String
    public var apiVersion = "2015-05-01-preview"

    public init(resourceGroupName: String, serverName: String, syncAgentName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.serverName = serverName
        self.syncAgentName = syncAgentName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/syncAgents/{syncAgentName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{serverName}"] = String(describing: self.serverName)
        self.pathParameters["{syncAgentName}"] = String(describing: self.syncAgentName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
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
        client.executeAsync(command: self) {
            (result: SyncAgentData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
