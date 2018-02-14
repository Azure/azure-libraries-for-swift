import Foundation
import azureSwiftRuntime
public protocol WebAppsDeleteInstanceProcess  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var processId : String { get set }
    var instanceId : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.WebApps {
// DeleteInstanceProcess terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out
// instance in a web site.
internal class DeleteInstanceProcessCommand : BaseCommand, WebAppsDeleteInstanceProcess {
    public var resourceGroupName : String
    public var name : String
    public var processId : String
    public var instanceId : String
    public var subscriptionId : String
    public var apiVersion = "2016-08-01"

    public init(resourceGroupName: String, name: String, processId: String, instanceId: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.name = name
        self.processId = processId
        self.instanceId = instanceId
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/instances/{instanceId}/processes/{processId}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{name}"] = String(describing: self.name)
        self.pathParameters["{processId}"] = String(describing: self.processId)
        self.pathParameters["{instanceId}"] = String(describing: self.instanceId)
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
