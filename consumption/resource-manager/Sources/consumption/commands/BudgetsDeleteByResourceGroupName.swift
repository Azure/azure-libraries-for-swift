import Foundation
import azureSwiftRuntime
public protocol BudgetsDeleteByResourceGroupName  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var budgetName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Budgets {
// DeleteByResourceGroupName the operation to delete a budget.
    internal class DeleteByResourceGroupNameCommand : BaseCommand, BudgetsDeleteByResourceGroupName {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var budgetName : String
        public var apiVersion = "2018-01-31"

        public init(subscriptionId: String, resourceGroupName: String, budgetName: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.budgetName = budgetName
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Consumption/budgets/{budgetName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{budgetName}"] = String(describing: self.budgetName)
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
