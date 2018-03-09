import Foundation
import azureSwiftRuntime
public protocol SubscriptionsDelete  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var namespaceName : String { get set }
    var topicName : String { get set }
    var subscriptionName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Subscriptions {
// Delete deletes a subscription from the specified topic.
    internal class DeleteCommand : BaseCommand, SubscriptionsDelete {
        public var resourceGroupName : String
        public var namespaceName : String
        public var topicName : String
        public var subscriptionName : String
        public var subscriptionId : String
        public var apiVersion = "2017-04-01"

        public init(resourceGroupName: String, namespaceName: String, topicName: String, subscriptionName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.namespaceName = namespaceName
            self.topicName = topicName
            self.subscriptionName = subscriptionName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}/subscriptions/{subscriptionName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{namespaceName}"] = String(describing: self.namespaceName)
            self.pathParameters["{topicName}"] = String(describing: self.topicName)
            self.pathParameters["{subscriptionName}"] = String(describing: self.subscriptionName)
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
