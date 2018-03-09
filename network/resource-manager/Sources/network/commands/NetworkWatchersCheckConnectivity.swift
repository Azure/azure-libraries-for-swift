import Foundation
import azureSwiftRuntime
public protocol NetworkWatchersCheckConnectivity  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var networkWatcherName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  ConnectivityParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ConnectivityInformationProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.NetworkWatchers {
// CheckConnectivity verifies the possibility of establishing a direct TCP connection from a virtual machine to a given
// endpoint including another VM or an arbitrary remote server. This method may poll for completion. Polling can be
// canceled by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
    internal class CheckConnectivityCommand : BaseCommand, NetworkWatchersCheckConnectivity {
        public var resourceGroupName : String
        public var networkWatcherName : String
        public var subscriptionId : String
        public var apiVersion = "2018-01-01"
    public var parameters :  ConnectivityParametersProtocol?

        public init(resourceGroupName: String, networkWatcherName: String, subscriptionId: String, parameters: ConnectivityParametersProtocol) {
            self.resourceGroupName = resourceGroupName
            self.networkWatcherName = networkWatcherName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/connectivityCheck"
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
                let encodedValue = try encoder.encode(parameters as? ConnectivityParametersData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ConnectivityInformationData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ConnectivityInformationProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: ConnectivityInformationData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
