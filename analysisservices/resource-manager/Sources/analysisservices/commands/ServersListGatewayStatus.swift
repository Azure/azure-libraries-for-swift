import Foundation
import azureSwiftRuntime
public protocol ServersListGatewayStatus  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (GatewayListStatusLiveProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Servers {
// ListGatewayStatus return the gateway status of the specified Analysis Services server instance.
    internal class ListGatewayStatusCommand : BaseCommand, ServersListGatewayStatus {
        public var resourceGroupName : String
        public var serverName : String
        public var subscriptionId : String
        public var apiVersion = "2017-08-01"

        public init(resourceGroupName: String, serverName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.serverName = serverName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AnalysisServices/servers/{serverName}/listGatewayStatus"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{serverName}"] = String(describing: self.serverName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(GatewayListStatusLiveData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (GatewayListStatusLiveProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: GatewayListStatusLiveData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
