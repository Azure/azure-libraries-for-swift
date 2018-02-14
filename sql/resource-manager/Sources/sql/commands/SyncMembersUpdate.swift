import Foundation
import azureSwiftRuntime
public protocol SyncMembersUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var databaseName : String { get set }
    var syncGroupName : String { get set }
    var syncMemberName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  SyncMemberProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (SyncMemberProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.SyncMembers {
// Update updates an existing sync member. This method may poll for completion. Polling can be canceled by passing the
// cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
internal class UpdateCommand : BaseCommand, SyncMembersUpdate {
    public var resourceGroupName : String
    public var serverName : String
    public var databaseName : String
    public var syncGroupName : String
    public var syncMemberName : String
    public var subscriptionId : String
    public var apiVersion = "2015-05-01-preview"
    public var parameters :  SyncMemberProtocol?

    public init(resourceGroupName: String, serverName: String, databaseName: String, syncGroupName: String, syncMemberName: String, subscriptionId: String, parameters: SyncMemberProtocol) {
        self.resourceGroupName = resourceGroupName
        self.serverName = serverName
        self.databaseName = databaseName
        self.syncGroupName = syncGroupName
        self.syncMemberName = syncMemberName
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Patch"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers/{syncMemberName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{serverName}"] = String(describing: self.serverName)
        self.pathParameters["{databaseName}"] = String(describing: self.databaseName)
        self.pathParameters["{syncGroupName}"] = String(describing: self.syncGroupName)
        self.pathParameters["{syncMemberName}"] = String(describing: self.syncMemberName)
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
            let result = try decoder.decode(SyncMemberData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (SyncMemberProtocol?, Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (result: SyncMemberData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
