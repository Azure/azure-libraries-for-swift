import Foundation
import azureSwiftRuntime
public protocol SyncGroupsRefreshHubSchema  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var databaseName : String { get set }
    var syncGroupName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.SyncGroups {
// RefreshHubSchema refreshes a hub database schema. This method may poll for completion. Polling can be canceled by
// passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
    internal class RefreshHubSchemaCommand : BaseCommand, SyncGroupsRefreshHubSchema {
        public var resourceGroupName : String
        public var serverName : String
        public var databaseName : String
        public var syncGroupName : String
        public var subscriptionId : String
        public var apiVersion = "2015-05-01-preview"

        public init(resourceGroupName: String, serverName: String, databaseName: String, syncGroupName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.serverName = serverName
            self.databaseName = databaseName
            self.syncGroupName = syncGroupName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/refreshHubSchema"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{serverName}"] = String(describing: self.serverName)
            self.pathParameters["{databaseName}"] = String(describing: self.databaseName)
            self.pathParameters["{syncGroupName}"] = String(describing: self.syncGroupName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public func execute(client: RuntimeClient,
            completionHandler: @escaping (Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (error) in
                completionHandler(error)
            }
        }
    }
}
