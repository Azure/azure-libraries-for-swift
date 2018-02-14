import Foundation
import azureSwiftRuntime
public protocol JobScheduleUpdate  {
    var headerParameters: [String: String] { get set }
    var jobScheduleId : String { get set }
    var timeout : Int32? { get set }
    var apiVersion : String { get set }
    var clientRequestId : String? { get set }
    var returnClientRequestId : Bool? { get set }
    var ocpDate : Date? { get set }
    var ifMatch : String? { get set }
    var ifNoneMatch : String? { get set }
    var ifModifiedSince : Date? { get set }
    var ifUnmodifiedSince : Date? { get set }
    var jobScheduleUpdateParameter :  JobScheduleUpdateParameterProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.JobSchedule {
// Update this fully replaces all the updateable properties of the job schedule. For example, if the schedule property
// is not specified with this request, then the Batch service will remove the existing schedule. Changes to a job
// schedule only impact jobs created by the schedule after the update has taken place; currently running jobs are
// unaffected.
internal class UpdateCommand : BaseCommand, JobScheduleUpdate {
    public var jobScheduleId : String
    public var timeout : Int32?
    public var apiVersion = "2017-09-01.6.0"
    public var clientRequestId : String?
    public var returnClientRequestId : Bool?
    public var ocpDate : Date?
    public var ifMatch : String?
    public var ifNoneMatch : String?
    public var ifModifiedSince : Date?
    public var ifUnmodifiedSince : Date?
    public var jobScheduleUpdateParameter :  JobScheduleUpdateParameterProtocol?

    public init(jobScheduleId: String, jobScheduleUpdateParameter: JobScheduleUpdateParameterProtocol) {
        self.jobScheduleId = jobScheduleId
        self.jobScheduleUpdateParameter = jobScheduleUpdateParameter
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/jobschedules/{jobScheduleId}"
        self.headerParameters = ["Content-Type":"application/json; odata=minimalmetadata; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{jobScheduleId}"] = String(describing: self.jobScheduleId)
        if self.timeout != nil { queryParameters["timeout"] = String(describing: self.timeout!) }
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
        if self.clientRequestId != nil { headerParameters["client-request-id"] = String(describing: self.clientRequestId!) }
        if self.returnClientRequestId != nil { headerParameters["return-client-request-id"] = String(describing: self.returnClientRequestId!) }
        if self.ocpDate != nil { headerParameters["ocp-date"] = String(describing: self.ocpDate!) }
        if self.ifMatch != nil { headerParameters["If-Match"] = String(describing: self.ifMatch!) }
        if self.ifNoneMatch != nil { headerParameters["If-None-Match"] = String(describing: self.ifNoneMatch!) }
        if self.ifModifiedSince != nil { headerParameters["If-Modified-Since"] = String(describing: self.ifModifiedSince!) }
        if self.ifUnmodifiedSince != nil { headerParameters["If-Unmodified-Since"] = String(describing: self.ifUnmodifiedSince!) }
    self.body = jobScheduleUpdateParameter
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(jobScheduleUpdateParameter)
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
