import Foundation
import azureSwiftRuntime
public protocol DatabaseOperationsCancel  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var databaseName : String { get set }
    var operationId : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.DatabaseOperations {
// Cancel cancels the asynchronous operation on the database.
internal class CancelCommand : BaseCommand, DatabaseOperationsCancel {
    public var resourceGroupName : String
    public var serverName : String
    public var databaseName : String
    public var operationId : String
    public var subscriptionId : String
    public var apiVersion = "2017-03-01-preview"

    public init(resourceGroupName: String, serverName: String, databaseName: String, operationId: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.serverName = serverName
        self.databaseName = databaseName
        self.operationId = operationId
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/operations/{operationId}/cancel"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{serverName}"] = String(describing: self.serverName)
        self.pathParameters["{databaseName}"] = String(describing: self.databaseName)
        self.pathParameters["{operationId}"] = String(describing: self.operationId)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (error) in
            completionHandler(error)
        }
    }
}
}
