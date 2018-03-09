import Foundation
import azureSwiftRuntime
public protocol JobStop  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var automationAccountName : String { get set }
    var jobName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var clientRequestId : String? { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Job {
// Stop stop the job identified by jobName.
    internal class StopCommand : BaseCommand, JobStop {
        public var resourceGroupName : String
        public var automationAccountName : String
        public var jobName : String
        public var subscriptionId : String
        public var apiVersion = "2017-05-15-preview"
        public var clientRequestId : String?

        public init(resourceGroupName: String, automationAccountName: String, jobName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.automationAccountName = automationAccountName
            self.jobName = jobName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/jobs/{jobName}/stop"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{automationAccountName}"] = String(describing: self.automationAccountName)
            self.pathParameters["{jobName}"] = String(describing: self.jobName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            if self.clientRequestId != nil { headerParameters["clientRequestId"] = String(describing: self.clientRequestId!) }

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
