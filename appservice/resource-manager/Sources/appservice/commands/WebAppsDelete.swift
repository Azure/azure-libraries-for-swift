import Foundation
import azureSwiftRuntime
public protocol WebAppsDelete  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var subscriptionId : String { get set }
    var deleteMetrics : Bool? { get set }
    var deleteEmptyServerFarm : Bool? { get set }
    var skipDnsRegistration : Bool? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.WebApps {
// Delete deletes a web, mobile, or API app, or one of the deployment slots.
    internal class DeleteCommand : BaseCommand, WebAppsDelete {
        public var resourceGroupName : String
        public var name : String
        public var subscriptionId : String
        public var deleteMetrics : Bool?
        public var deleteEmptyServerFarm : Bool?
        public var skipDnsRegistration : Bool?
        public var apiVersion = "2016-08-01"

        public init(resourceGroupName: String, name: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            if self.deleteMetrics != nil { queryParameters["deleteMetrics"] = String(describing: self.deleteMetrics!) }
            if self.deleteEmptyServerFarm != nil { queryParameters["deleteEmptyServerFarm"] = String(describing: self.deleteEmptyServerFarm!) }
            if self.skipDnsRegistration != nil { queryParameters["skipDnsRegistration"] = String(describing: self.skipDnsRegistration!) }
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
