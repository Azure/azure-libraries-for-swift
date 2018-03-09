import Foundation
import azureSwiftRuntime
public protocol NetworkWatchersGetNextHop  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var networkWatcherName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  NextHopParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (NextHopResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.NetworkWatchers {
// GetNextHop gets the next hop from the specified VM. This method may poll for completion. Polling can be canceled by
// passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
    internal class GetNextHopCommand : BaseCommand, NetworkWatchersGetNextHop {
        public var resourceGroupName : String
        public var networkWatcherName : String
        public var subscriptionId : String
        public var apiVersion = "2018-01-01"
    public var parameters :  NextHopParametersProtocol?

        public init(resourceGroupName: String, networkWatcherName: String, subscriptionId: String, parameters: NextHopParametersProtocol) {
            self.resourceGroupName = resourceGroupName
            self.networkWatcherName = networkWatcherName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/nextHop"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{networkWatcherName}"] = String(describing: self.networkWatcherName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? NextHopParametersData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(NextHopResultData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (NextHopResultProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: NextHopResultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
