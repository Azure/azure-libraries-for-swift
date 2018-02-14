import Foundation
import azureSwiftRuntime
public protocol ReplicationLinksGet  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var databaseName : String { get set }
    var linkId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ReplicationLinkProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ReplicationLinks {
// Get gets a database replication link.
internal class GetCommand : BaseCommand, ReplicationLinksGet {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var serverName : String
    public var databaseName : String
    public var linkId : String
    public var apiVersion = "2014-04-01"

    public init(subscriptionId: String, resourceGroupName: String, serverName: String, databaseName: String, linkId: String) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.serverName = serverName
        self.databaseName = databaseName
        self.linkId = linkId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/replicationLinks/{linkId}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{serverName}"] = String(describing: self.serverName)
        self.pathParameters["{databaseName}"] = String(describing: self.databaseName)
        self.pathParameters["{linkId}"] = String(describing: self.linkId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(ReplicationLinkData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ReplicationLinkProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: ReplicationLinkData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
