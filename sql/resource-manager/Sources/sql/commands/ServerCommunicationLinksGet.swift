import Foundation
import azureSwiftRuntime
public protocol ServerCommunicationLinksGet  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var communicationLinkName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ServerCommunicationLinkProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ServerCommunicationLinks {
// Get returns a server communication link.
internal class GetCommand : BaseCommand, ServerCommunicationLinksGet {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var serverName : String
    public var communicationLinkName : String
    public var apiVersion = "2014-04-01"

    public init(subscriptionId: String, resourceGroupName: String, serverName: String, communicationLinkName: String) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.serverName = serverName
        self.communicationLinkName = communicationLinkName
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/communicationLinks/{communicationLinkName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{serverName}"] = String(describing: self.serverName)
        self.pathParameters["{communicationLinkName}"] = String(describing: self.communicationLinkName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(ServerCommunicationLinkData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ServerCommunicationLinkProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: ServerCommunicationLinkData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
