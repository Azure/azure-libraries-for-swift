import Foundation
import azureSwiftRuntime
public protocol NotificationHubsDeleteAuthorizationRule  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var namespaceName : String { get set }
    var notificationHubName : String { get set }
    var authorizationRuleName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.NotificationHubs {
// DeleteAuthorizationRule deletes a notificationHub authorization rule
internal class DeleteAuthorizationRuleCommand : BaseCommand, NotificationHubsDeleteAuthorizationRule {
    public var resourceGroupName : String
    public var namespaceName : String
    public var notificationHubName : String
    public var authorizationRuleName : String
    public var subscriptionId : String
    public var apiVersion = "2017-04-01"

    public init(resourceGroupName: String, namespaceName: String, notificationHubName: String, authorizationRuleName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.namespaceName = namespaceName
        self.notificationHubName = notificationHubName
        self.authorizationRuleName = authorizationRuleName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/notificationHubs/{notificationHubName}/AuthorizationRules/{authorizationRuleName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{namespaceName}"] = String(describing: self.namespaceName)
        self.pathParameters["{notificationHubName}"] = String(describing: self.notificationHubName)
        self.pathParameters["{authorizationRuleName}"] = String(describing: self.authorizationRuleName)
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
