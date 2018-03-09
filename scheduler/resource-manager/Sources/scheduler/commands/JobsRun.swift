import Foundation
import azureSwiftRuntime
public protocol JobsRun  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var jobCollectionName : String { get set }
    var jobName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Jobs {
// Run runs a job.
    internal class RunCommand : BaseCommand, JobsRun {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var jobCollectionName : String
        public var jobName : String
        public var apiVersion = "2016-03-01"

        public init(subscriptionId: String, resourceGroupName: String, jobCollectionName: String, jobName: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.jobCollectionName = jobCollectionName
            self.jobName = jobName
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Scheduler/jobCollections/{jobCollectionName}/jobs/{jobName}/run"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{jobCollectionName}"] = String(describing: self.jobCollectionName)
            self.pathParameters["{jobName}"] = String(describing: self.jobName)
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
