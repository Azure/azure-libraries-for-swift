import Foundation
import azureSwiftRuntime
public protocol WebAppsDeleteBackup  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var backupId : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.WebApps {
// DeleteBackup deletes a backup of an app by its ID.
internal class DeleteBackupCommand : BaseCommand, WebAppsDeleteBackup {
    public var resourceGroupName : String
    public var name : String
    public var backupId : String
    public var subscriptionId : String
    public var apiVersion = "2016-08-01"

    public init(resourceGroupName: String, name: String, backupId: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.name = name
        self.backupId = backupId
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/backups/{backupId}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{name}"] = String(describing: self.name)
        self.pathParameters["{backupId}"] = String(describing: self.backupId)
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
