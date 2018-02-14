import Foundation
import azureSwiftRuntime
public protocol SecurityRulesDelete  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var networkSecurityGroupName : String { get set }
    var securityRuleName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.SecurityRules {
// Delete deletes the specified network security rule. This method may poll for completion. Polling can be canceled by
// passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
internal class DeleteCommand : BaseCommand, SecurityRulesDelete {
    public var resourceGroupName : String
    public var networkSecurityGroupName : String
    public var securityRuleName : String
    public var subscriptionId : String
    public var apiVersion = "2018-01-01"

    public init(resourceGroupName: String, networkSecurityGroupName: String, securityRuleName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.networkSecurityGroupName = networkSecurityGroupName
        self.securityRuleName = securityRuleName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}/securityRules/{securityRuleName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{networkSecurityGroupName}"] = String(describing: self.networkSecurityGroupName)
        self.pathParameters["{securityRuleName}"] = String(describing: self.securityRuleName)
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
