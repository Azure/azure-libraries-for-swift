import Foundation
import azureSwiftRuntime
public protocol FileGetFromTask  {
    var headerParameters: [String: String] { get set }
    var jobId : String { get set }
    var taskId : String { get set }
    var filePath : String { get set }
    var timeout : Int32? { get set }
    var apiVersion : String { get set }
    var clientRequestId : String? { get set }
    var returnClientRequestId : Bool? { get set }
    var ocpDate : Date? { get set }
    var ocpRange : String? { get set }
    var ifModifiedSince : Date? { get set }
    var ifUnmodifiedSince : Date? { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Data?, Error?) -> Void) -> Void ;
}

extension Commands.File {
// GetFromTask returns the content of the specified task file.
internal class GetFromTaskCommand : BaseCommand, FileGetFromTask {
    public var jobId : String
    public var taskId : String
    public var filePath : String
    public var timeout : Int32?
    public var apiVersion = "2017-09-01.6.0"
    public var clientRequestId : String?
    public var returnClientRequestId : Bool?
    public var ocpDate : Date?
    public var ocpRange : String?
    public var ifModifiedSince : Date?
    public var ifUnmodifiedSince : Date?

    public init(jobId: String, taskId: String, filePath: String) {
        self.jobId = jobId
        self.taskId = taskId
        self.filePath = filePath
        super.init()
        self.method = "Get"
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
        if self.ocpRange != nil { headerParameters["ocp-range"] = String(describing: self.ocpRange!) }
        if self.ifModifiedSince != nil { headerParameters["If-Modified-Since"] = String(describing: self.ifModifiedSince!) }
        if self.ifUnmodifiedSince != nil { headerParameters["If-Unmodified-Since"] = String(describing: self.ifUnmodifiedSince!) }
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        return DataWrapper(data: data);
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (Data?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: DataWrapper?, error: Error?) in
            let data = result?.data as Data?
            completionHandler(data!, error)
        }
    }
}
}
