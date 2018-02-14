import Foundation
import azureSwiftRuntime
public protocol ConnectionMonitorsCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var networkWatcherName : String { get set }
    var connectionMonitorName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  ConnectionMonitorProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ConnectionMonitorResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ConnectionMonitors {
// CreateOrUpdate create or update a connection monitor. This method may poll for completion. Polling can be canceled
// by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
internal class CreateOrUpdateCommand : BaseCommand, ConnectionMonitorsCreateOrUpdate {
    public var resourceGroupName : String
    public var networkWatcherName : String
    public var connectionMonitorName : String
    public var subscriptionId : String
    public var apiVersion = "2018-01-01"
    public var parameters :  ConnectionMonitorProtocol?

    public init(resourceGroupName: String, networkWatcherName: String, connectionMonitorName: String, subscriptionId: String, parameters: ConnectionMonitorProtocol) {
        self.resourceGroupName = resourceGroupName
        self.networkWatcherName = networkWatcherName
        self.connectionMonitorName = connectionMonitorName
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors/{connectionMonitorName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{networkWatcherName}"] = String(describing: self.networkWatcherName)
        self.pathParameters["{connectionMonitorName}"] = String(describing: self.connectionMonitorName)
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
            let result = try decoder.decode(ConnectionMonitorResultData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ConnectionMonitorResultProtocol?, Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (result: ConnectionMonitorResultData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
