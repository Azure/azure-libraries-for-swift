import Foundation
import azureSwiftRuntime
public protocol ServersDelete  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Servers {
// Delete deletes a server. This method may poll for completion. Polling can be canceled by passing the cancel channel
// argument. The channel will be used to cancel polling and any outstanding HTTP requests.
internal class DeleteCommand : BaseCommand, ServersDelete {
    public var resourceGroupName : String
    public var serverName : String
    public var subscriptionId : String
    public var apiVersion = "2015-05-01-preview"

    public init(resourceGroupName: String, serverName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.serverName = serverName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{serverName}"] = String(describing: self.serverName)
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
