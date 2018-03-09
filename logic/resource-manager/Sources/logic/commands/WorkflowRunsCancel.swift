import Foundation
import azureSwiftRuntime
public protocol WorkflowRunsCancel  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var workflowName : String { get set }
    var runName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.WorkflowRuns {
// Cancel cancels a workflow run.
    internal class CancelCommand : BaseCommand, WorkflowRunsCancel {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var workflowName : String
        public var runName : String
        public var apiVersion = "2016-06-01"

        public init(subscriptionId: String, resourceGroupName: String, workflowName: String, runName: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.workflowName = workflowName
            self.runName = runName
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/workflows/{workflowName}/runs/{runName}/cancel"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{workflowName}"] = String(describing: self.workflowName)
            self.pathParameters["{runName}"] = String(describing: self.runName)
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
