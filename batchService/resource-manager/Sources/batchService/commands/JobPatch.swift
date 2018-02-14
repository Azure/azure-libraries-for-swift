import Foundation
import azureSwiftRuntime
public protocol JobPatch  {
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
    var jobPatchParameter :  JobPatchParameterProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Job {
// Patch this replaces only the job properties specified in the request. For example, if the job has constraints, and a
// request does not specify the constraints element, then the job keeps the existing constraints.
internal class PatchCommand : BaseCommand, JobPatch {
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
    public var jobPatchParameter :  JobPatchParameterProtocol?

    public init(jobId: String, jobPatchParameter: JobPatchParameterProtocol) {
        self.jobId = jobId
        self.jobPatchParameter = jobPatchParameter
        super.init()
        self.method = "Patch"
        self.isLongRunningOperation = false
        self.path = "/jobs/{jobId}"
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
    self.body = jobPatchParameter
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(jobPatchParameter)
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
