import Foundation
import azureSwiftRuntime
public protocol BudgetsDelete  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var budgetName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Budgets {
// Delete the operation to delete a budget.
    internal class DeleteCommand : BaseCommand, BudgetsDelete {
        public var subscriptionId : String
        public var budgetName : String
        public var apiVersion = "2018-01-31"

        public init(subscriptionId: String, budgetName: String) {
            self.subscriptionId = subscriptionId
            self.budgetName = budgetName
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Consumption/budgets/{budgetName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
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
