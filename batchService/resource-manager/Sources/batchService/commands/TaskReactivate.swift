import Foundation
import azureSwiftRuntime
public protocol TaskReactivate  {
    var headerParameters: [String: String] { get set }
    var jobId : String { get set }
    var taskId : String { get set }
    var timeout : Int32? { get set }
    var apiVersion : String { get set }
    var clientRequestId : String? { get set }
    var returnClientRequestId : Bool? { get set }
    var ocpDate : Date? { get set }
    var ifMatch : String? { get set }
    var ifNoneMatch : String? { get set }
    var ifModifiedSince : Date? { get set }
    var ifUnmodifiedSince : Date? { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Task {
// Reactivate reactivation makes a task eligible to be retried again up to its maximum retry count. The task's state is
// changed to active. As the task is no longer in the completed state, any previous exit code or failure information is
// no longer available after reactivation. Each time a task is reactivated, its retry count is reset to 0. Reactivation
// will fail for tasks that are not completed or that previously completed successfully (with an exit code of 0).
// Additionally, it will fail if the job has completed (or is terminating or deleting).
internal class ReactivateCommand : BaseCommand, TaskReactivate {
    public var jobId : String
    public var taskId : String
    public var timeout : Int32?
    public var apiVersion = "2017-09-01.6.0"
    public var clientRequestId : String?
    public var returnClientRequestId : Bool?
    public var ocpDate : Date?
    public var ifMatch : String?
    public var ifNoneMatch : String?
    public var ifModifiedSince : Date?
    public var ifUnmodifiedSince : Date?

    public init(jobId: String, taskId: String) {
        self.jobId = jobId
        self.taskId = taskId
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/jobs/{jobId}/tasks/{taskId}/reactivate"
        self.headerParameters = ["Content-Type":"application/json; odata=minimalmetadata; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{jobId}"] = String(describing: self.jobId)
        self.pathParameters["{taskId}"] = String(describing: self.taskId)
        if self.timeout != nil { queryParameters["timeout"] = String(describing: self.timeout!) }
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
        if self.clientRequestId != nil { headerParameters["client-request-id"] = String(describing: self.clientRequestId!) }
        if self.returnClientRequestId != nil { headerParameters["return-client-request-id"] = String(describing: self.returnClientRequestId!) }
        if self.ocpDate != nil { headerParameters["ocp-date"] = String(describing: self.ocpDate!) }
        if self.ifMatch != nil { headerParameters["If-Match"] = String(describing: self.ifMatch!) }
        if self.ifNoneMatch != nil { headerParameters["If-None-Match"] = String(describing: self.ifNoneMatch!) }
        if self.ifModifiedSince != nil { headerParameters["If-Modified-Since"] = String(describing: self.ifModifiedSince!) }
        if self.ifUnmodifiedSince != nil { headerParameters["If-Unmodified-Since"] = String(describing: self.ifUnmodifiedSince!) }
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
