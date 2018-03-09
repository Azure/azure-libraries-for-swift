import Foundation
import azureSwiftRuntime
public protocol RunbookDelete  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var automationAccountName : String { get set }
    var runbookName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Runbook {
// Delete delete the runbook by name.
    internal class DeleteCommand : BaseCommand, RunbookDelete {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var automationAccountName : String
        public var runbookName : String
        public var apiVersion = "2015-10-31"

        public init(subscriptionId: String, resourceGroupName: String, automationAccountName: String, runbookName: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.automationAccountName = automationAccountName
            self.runbookName = runbookName
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/runbooks/{runbookName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{automationAccountName}"] = String(describing: self.automationAccountName)
            self.pathParameters["{runbookName}"] = String(describing: self.runbookName)
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
