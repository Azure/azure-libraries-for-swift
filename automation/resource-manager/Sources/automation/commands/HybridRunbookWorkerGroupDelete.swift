import Foundation
import azureSwiftRuntime
public protocol HybridRunbookWorkerGroupDelete  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var automationAccountName : String { get set }
    var hybridRunbookWorkerGroupName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.HybridRunbookWorkerGroup {
// Delete delete a hybrid runbook worker group.
internal class DeleteCommand : BaseCommand, HybridRunbookWorkerGroupDelete {
    public var resourceGroupName : String
    public var automationAccountName : String
    public var hybridRunbookWorkerGroupName : String
    public var subscriptionId : String
    public var apiVersion = "2015-10-31"

    public init(resourceGroupName: String, automationAccountName: String, hybridRunbookWorkerGroupName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.automationAccountName = automationAccountName
        self.hybridRunbookWorkerGroupName = hybridRunbookWorkerGroupName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/hybridRunbookWorkerGroups/{hybridRunbookWorkerGroupName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{automationAccountName}"] = String(describing: self.automationAccountName)
        self.pathParameters["{hybridRunbookWorkerGroupName}"] = String(describing: self.hybridRunbookWorkerGroupName)
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
