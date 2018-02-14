import Foundation
import azureSwiftRuntime
public protocol FailoverGroupsGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var failoverGroupName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (FailoverGroupProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.FailoverGroups {
// Get gets a failover group.
internal class GetCommand : BaseCommand, FailoverGroupsGet {
    public var resourceGroupName : String
    public var serverName : String
    public var failoverGroupName : String
    public var subscriptionId : String
    public var apiVersion = "2015-05-01-preview"

    public init(resourceGroupName: String, serverName: String, failoverGroupName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.serverName = serverName
        self.failoverGroupName = failoverGroupName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/failoverGroups/{failoverGroupName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{serverName}"] = String(describing: self.serverName)
        self.pathParameters["{failoverGroupName}"] = String(describing: self.failoverGroupName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(FailoverGroupData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (FailoverGroupProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: FailoverGroupData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
