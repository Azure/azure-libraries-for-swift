import Foundation
import azureSwiftRuntime
public protocol JobScheduleDelete  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var automationAccountName : String { get set }
    var jobScheduleId : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.JobSchedule {
// Delete delete the job schedule identified by job schedule name.
    internal class DeleteCommand : BaseCommand, JobScheduleDelete {
        public var resourceGroupName : String
        public var automationAccountName : String
        public var jobScheduleId : String
        public var subscriptionId : String
        public var apiVersion = "2015-10-31"

        public init(resourceGroupName: String, automationAccountName: String, jobScheduleId: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.automationAccountName = automationAccountName
            self.jobScheduleId = jobScheduleId
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/jobSchedules/{jobScheduleId}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{automationAccountName}"] = String(describing: self.automationAccountName)
            self.pathParameters["{jobScheduleId}"] = String(describing: self.jobScheduleId)
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
