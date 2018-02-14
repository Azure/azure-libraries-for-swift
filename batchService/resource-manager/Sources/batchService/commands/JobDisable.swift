import Foundation
import azureSwiftRuntime
public protocol JobDisable  {
    var headerParameters: [String: String] { get set }
    var jobId : String { get set }
    var timeout : Int32? { get set }
    var apiVersion : String { get set }
    var clientRequestId : String? { get set }
    var returnClientRequestId : Bool? { get set }
    var ocpDate : Date? { get set }
    var ifMatch : String? { get set }
    var ifNoneMatch : String? { get set }
    var ifModifiedSince : Date? { get set }
    var ifUnmodifiedSince : Date? { get set }
    var jobDisableParameter :  JobDisableParameterProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Job {
// Disable the Batch Service immediately moves the job to the disabling state. Batch then uses the disableTasks
// parameter to determine what to do with the currently running tasks of the job. The job remains in the disabling
// state until the disable operation is completed and all tasks have been dealt with according to the disableTasks
// option; the job then moves to the disabled state. No new tasks are started under the job until it moves back to
// active state. If you try to disable a job that is in any state other than active, disabling, or disabled, the
// request fails with status code 409.
internal class DisableCommand : BaseCommand, JobDisable {
    public var jobId : String
    public var timeout : Int32?
    public var apiVersion = "2017-09-01.6.0"
    public var clientRequestId : String?
    public var returnClientRequestId : Bool?
    public var ocpDate : Date?
    public var ifMatch : String?
    public var ifNoneMatch : String?
    public var ifModifiedSince : Date?
    public var ifUnmodifiedSince : Date?
    public var jobDisableParameter :  JobDisableParameterProtocol?

    public init(jobId: String, jobDisableParameter: JobDisableParameterProtocol) {
        self.jobId = jobId
        self.jobDisableParameter = jobDisableParameter
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/jobs/{jobId}/disable"
        self.headerParameters = ["Content-Type":"application/json; odata=minimalmetadata; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{jobId}"] = String(describing: self.jobId)
        if self.timeout != nil { queryParameters["timeout"] = String(describing: self.timeout!) }
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
        if self.clientRequestId != nil { headerParameters["client-request-id"] = String(describing: self.clientRequestId!) }
        if self.returnClientRequestId != nil { headerParameters["return-client-request-id"] = String(describing: self.returnClientRequestId!) }
        if self.ocpDate != nil { headerParameters["ocp-date"] = String(describing: self.ocpDate!) }
        if self.ifMatch != nil { headerParameters["If-Match"] = String(describing: self.ifMatch!) }
        if self.ifNoneMatch != nil { headerParameters["If-None-Match"] = String(describing: self.ifNoneMatch!) }
        if self.ifModifiedSince != nil { headerParameters["If-Modified-Since"] = String(describing: self.ifModifiedSince!) }
        if self.ifUnmodifiedSince != nil { headerParameters["If-Unmodified-Since"] = String(describing: self.ifUnmodifiedSince!) }
    self.body = jobDisableParameter
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(jobDisableParameter)
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
