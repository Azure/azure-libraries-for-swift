import Foundation
import azureSwiftRuntime
public protocol NamespacesDelete  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var namespaceName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Namespaces {
// Delete deletes an existing namespace. This operation also removes all associated resources under the namespace. This
// method may poll for completion. Polling can be canceled by passing the cancel channel argument. The channel will be
// used to cancel polling and any outstanding HTTP requests.
    internal class DeleteCommand : BaseCommand, NamespacesDelete {
        public var resourceGroupName : String
        public var namespaceName : String
        public var subscriptionId : String
        public var apiVersion = "2017-04-01"

        public init(resourceGroupName: String, namespaceName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.namespaceName = namespaceName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{namespaceName}"] = String(describing: self.namespaceName)
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
