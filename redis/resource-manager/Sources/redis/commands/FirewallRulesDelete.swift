import Foundation
import azureSwiftRuntime
public protocol FirewallRulesDelete  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var cacheName : String { get set }
    var ruleName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.FirewallRules {
// Delete deletes a single firewall rule in a specified redis cache.
internal class DeleteCommand : BaseCommand, FirewallRulesDelete {
    public var resourceGroupName : String
    public var cacheName : String
    public var ruleName : String
    public var subscriptionId : String
    public var apiVersion = "2017-10-01"

    public init(resourceGroupName: String, cacheName: String, ruleName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.cacheName = cacheName
        self.ruleName = ruleName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/Redis/{cacheName}/firewallRules/{ruleName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{cacheName}"] = String(describing: self.cacheName)
        self.pathParameters["{ruleName}"] = String(describing: self.ruleName)
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
