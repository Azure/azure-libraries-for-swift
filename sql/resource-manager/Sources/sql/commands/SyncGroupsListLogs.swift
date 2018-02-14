import Foundation
import azureSwiftRuntime
public protocol SyncGroupsListLogs  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var databaseName : String { get set }
    var syncGroupName : String { get set }
    var subscriptionId : String { get set }
    var startTime : String { get set }
    var endTime : String { get set }
    var type : ListLogsTypeEnum { get set }
    var continuationToken : String? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (SyncGroupLogListResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.SyncGroups {
// ListLogs gets a collection of sync group logs.
internal class ListLogsCommand : BaseCommand, SyncGroupsListLogs {
    var nextLink: String?
    public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
    public var resourceGroupName : String
    public var serverName : String
    public var databaseName : String
    public var syncGroupName : String
    public var subscriptionId : String
    public var startTime : String
    public var endTime : String
    public var type : ListLogsTypeEnum
    public var continuationToken : String?
    public var apiVersion = "2015-05-01-preview"

    public init(resourceGroupName: String, serverName: String, databaseName: String, syncGroupName: String, subscriptionId: String, startTime: String, endTime: String, type: ListLogsTypeEnum) {
        self.resourceGroupName = resourceGroupName
        self.serverName = serverName
        self.databaseName = databaseName
        self.syncGroupName = syncGroupName
        self.subscriptionId = subscriptionId
        self.startTime = startTime
        self.endTime = endTime
        self.type = type
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/logs"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{serverName}"] = String(describing: self.serverName)
        self.pathParameters["{databaseName}"] = String(describing: self.databaseName)
        self.pathParameters["{syncGroupName}"] = String(describing: self.syncGroupName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["startTime"] = String(describing: self.startTime)
        self.queryParameters["endTime"] = String(describing: self.endTime)
        self.queryParameters["type"] = String(describing: self.type)
        if self.continuationToken != nil { queryParameters["continuationToken"] = String(describing: self.continuationToken!) }
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            if var pageDecoder = decoder as? PageDecoder {
                pageDecoder.isPagedData = true
                pageDecoder.nextLinkName = "NextLink"
            }
            let result = try decoder.decode(SyncGroupLogListResultData?.self, from: data)
            if var pageDecoder = decoder as? PageDecoder {
                self.nextLink = pageDecoder.nextLink
            }
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (SyncGroupLogListResultProtocol?, Error?) -> Void) -> Void {
        if self.nextLink != nil {
            self.path = nextLink!
            self.nextLink = nil;
            self.pathType = .absolute
        }
        client.executeAsync(command: self) {
            (result: SyncGroupLogListResultData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
