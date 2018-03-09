import Foundation
import azureSwiftRuntime
public protocol BatchAccountDelete  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var accountName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.BatchAccount {
// Delete deletes the specified Batch account. This method may poll for completion. Polling can be canceled by passing
// the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
    internal class DeleteCommand : BaseCommand, BatchAccountDelete {
        public var resourceGroupName : String
        public var accountName : String
        public var subscriptionId : String
        public var apiVersion = "2017-09-01"

        public init(resourceGroupName: String, accountName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.accountName = accountName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{accountName}"] = String(describing: self.accountName)
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
