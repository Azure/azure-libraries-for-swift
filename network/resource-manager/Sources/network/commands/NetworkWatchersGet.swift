import Foundation
import azureSwiftRuntime
public protocol NetworkWatchersGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var networkWatcherName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (NetworkWatcherProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.NetworkWatchers {
// Get gets the specified network watcher by resource group.
internal class GetCommand : BaseCommand, NetworkWatchersGet {
    public var resourceGroupName : String
    public var networkWatcherName : String
    public var subscriptionId : String
    public var apiVersion = "2018-01-01"

    public init(resourceGroupName: String, networkWatcherName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.networkWatcherName = networkWatcherName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{networkWatcherName}"] = String(describing: self.networkWatcherName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(NetworkWatcherData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (NetworkWatcherProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: NetworkWatcherData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
