import Foundation
import azureSwiftRuntime
public protocol ConnectionMonitorsQuery  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var networkWatcherName : String { get set }
    var connectionMonitorName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ConnectionMonitorQueryResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ConnectionMonitors {
// Query query a snapshot of the most recent connection states. This method may poll for completion. Polling can be
// canceled by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
internal class QueryCommand : BaseCommand, ConnectionMonitorsQuery {
    public var resourceGroupName : String
    public var networkWatcherName : String
    public var connectionMonitorName : String
    public var subscriptionId : String
    public var apiVersion = "2018-01-01"

    public init(resourceGroupName: String, networkWatcherName: String, connectionMonitorName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.networkWatcherName = networkWatcherName
        self.connectionMonitorName = connectionMonitorName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors/{connectionMonitorName}/query"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{networkWatcherName}"] = String(describing: self.networkWatcherName)
        self.pathParameters["{connectionMonitorName}"] = String(describing: self.connectionMonitorName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(ConnectionMonitorQueryResultData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ConnectionMonitorQueryResultProtocol?, Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (result: ConnectionMonitorQueryResultData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
