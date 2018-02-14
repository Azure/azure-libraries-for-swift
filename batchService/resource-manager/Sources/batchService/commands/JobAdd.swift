import Foundation
import azureSwiftRuntime
public protocol JobAdd  {
    var headerParameters: [String: String] { get set }
    var timeout : Int32? { get set }
    var apiVersion : String { get set }
    var clientRequestId : String? { get set }
    var returnClientRequestId : Bool? { get set }
    var ocpDate : Date? { get set }
    var job :  JobAddParameterProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Job {
// Add the Batch service supports two ways to control the work done as part of a job. In the first approach, the user
// specifies a Job Manager task. The Batch service launches this task when it is ready to start the job. The Job
// Manager task controls all other tasks that run under this job, by using the Task APIs. In the second approach, the
// user directly controls the execution of tasks under an active job, by using the Task APIs. Also note: when naming
// jobs, avoid including sensitive information such as user names or secret project names. This information may appear
// in telemetry logs accessible to Microsoft Support engineers.
internal class AddCommand : BaseCommand, JobAdd {
    public var timeout : Int32?
    public var apiVersion = "2017-09-01.6.0"
    public var clientRequestId : String?
    public var returnClientRequestId : Bool?
    public var ocpDate : Date?
    public var job :  JobAddParameterProtocol?

    public init(job: JobAddParameterProtocol) {
        self.job = job
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/jobs"
        self.headerParameters = ["Content-Type":"application/json; odata=minimalmetadata; charset=utf-8"]
    }

    public override func preCall()  {
        if self.timeout != nil { queryParameters["timeout"] = String(describing: self.timeout!) }
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
        if self.clientRequestId != nil { headerParameters["client-request-id"] = String(describing: self.clientRequestId!) }
        if self.returnClientRequestId != nil { headerParameters["return-client-request-id"] = String(describing: self.returnClientRequestId!) }
        if self.ocpDate != nil { headerParameters["ocp-date"] = String(describing: self.ocpDate!) }
    self.body = job
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(job)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
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
