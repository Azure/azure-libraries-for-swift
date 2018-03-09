import Foundation
import azureSwiftRuntime
public protocol WebhooksDelete  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var registryName : String { get set }
    var webhookName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Webhooks {
// Delete deletes a webhook from a container registry. This method may poll for completion. Polling can be canceled by
// passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
    internal class DeleteCommand : BaseCommand, WebhooksDelete {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var registryName : String
        public var webhookName : String
        public var apiVersion = "2017-10-01"

        public init(subscriptionId: String, resourceGroupName: String, registryName: String, webhookName: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.registryName = registryName
            self.webhookName = webhookName
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerRegistry/registries/{registryName}/webhooks/{webhookName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{registryName}"] = String(describing: self.registryName)
            self.pathParameters["{webhookName}"] = String(describing: self.webhookName)
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
