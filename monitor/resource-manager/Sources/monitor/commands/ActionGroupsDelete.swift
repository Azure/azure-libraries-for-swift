import Foundation
import azureSwiftRuntime
public protocol ActionGroupsDelete  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var actionGroupName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.ActionGroups {
// Delete delete an action group.
    internal class DeleteCommand : BaseCommand, ActionGroupsDelete {
        public var resourceGroupName : String
        public var actionGroupName : String
        public var subscriptionId : String
        public var apiVersion = "2017-04-01"

        public init(resourceGroupName: String, actionGroupName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.actionGroupName = actionGroupName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.insights/actionGroups/{actionGroupName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{actionGroupName}"] = String(describing: self.actionGroupName)
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
