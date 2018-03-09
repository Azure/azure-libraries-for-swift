import Foundation
import azureSwiftRuntime
public protocol WebAppsDeleteFunction  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var functionName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.WebApps {
// DeleteFunction delete a function for web site, or a deployment slot.
    internal class DeleteFunctionCommand : BaseCommand, WebAppsDeleteFunction {
        public var resourceGroupName : String
        public var name : String
        public var functionName : String
        public var subscriptionId : String
        public var apiVersion = "2016-08-01"

        public init(resourceGroupName: String, name: String, functionName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.functionName = functionName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/functions/{functionName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{functionName}"] = String(describing: self.functionName)
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
