import Foundation
import azureSwiftRuntime
public protocol FileGetPropertiesFromTask  {
    var headerParameters: [String: String] { get set }
    var jobId : String { get set }
    var taskId : String { get set }
    var filePath : String { get set }
    var timeout : Int32? { get set }
    var apiVersion : String { get set }
    var clientRequestId : String? { get set }
    var returnClientRequestId : Bool? { get set }
    var ocpDate : Date? { get set }
    var ifModifiedSince : Date? { get set }
    var ifUnmodifiedSince : Date? { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.File {
// GetPropertiesFromTask gets the properties of the specified task file.
internal class GetPropertiesFromTaskCommand : BaseCommand, FileGetPropertiesFromTask {
    public var jobId : String
    public var taskId : String
    public var filePath : String
    public var timeout : Int32?
    public var apiVersion = "2017-09-01.6.0"
    public var clientRequestId : String?
    public var returnClientRequestId : Bool?
    public var ocpDate : Date?
    public var ifModifiedSince : Date?
    public var ifUnmodifiedSince : Date?

    public init(jobId: String, taskId: String, filePath: String) {
        self.jobId = jobId
        self.taskId = taskId
        self.filePath = filePath
        super.init()
        self.method = "Head"
        self.isLongRunningOperation = false
        self.path = "/jobs/{jobId}/tasks/{taskId}/files/{filePath}"
        self.headerParameters = ["Content-Type":"application/json; odata=minimalmetadata; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{jobId}"] = String(describing: self.jobId)
        self.pathParameters["{taskId}"] = String(describing: self.taskId)
        self.pathParameters["{filePath}"] = String(describing: self.filePath)
        if self.timeout != nil { queryParameters["timeout"] = String(describing: self.timeout!) }
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
        if self.clientRequestId != nil { headerParameters["client-request-id"] = String(describing: self.clientRequestId!) }
        if self.returnClientRequestId != nil { headerParameters["return-client-request-id"] = String(describing: self.returnClientRequestId!) }
        if self.ocpDate != nil { headerParameters["ocp-date"] = String(describing: self.ocpDate!) }
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
