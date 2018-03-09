import Foundation
import azureSwiftRuntime
public protocol ViewsDelete  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var hubName : String { get set }
    var viewName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var userId : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Views {
// Delete deletes a view in the specified hub.
    internal class DeleteCommand : BaseCommand, ViewsDelete {
        public var resourceGroupName : String
        public var hubName : String
        public var viewName : String
        public var subscriptionId : String
        public var apiVersion = "2017-04-26"
        public var userId : String

        public init(resourceGroupName: String, hubName: String, viewName: String, subscriptionId: String, userId: String) {
            self.resourceGroupName = resourceGroupName
            self.hubName = hubName
            self.viewName = viewName
            self.subscriptionId = subscriptionId
            self.userId = userId
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/views/{viewName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{hubName}"] = String(describing: self.hubName)
            self.pathParameters["{viewName}"] = String(describing: self.viewName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.queryParameters["userId"] = String(describing: self.userId)

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
