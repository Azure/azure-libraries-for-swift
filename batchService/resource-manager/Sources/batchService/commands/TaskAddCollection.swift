import Foundation
import azureSwiftRuntime
public protocol TaskAddCollection  {
    var headerParameters: [String: String] { get set }
    var jobId : String { get set }
    var timeout : Int32? { get set }
    var apiVersion : String { get set }
    var clientRequestId : String? { get set }
    var returnClientRequestId : Bool? { get set }
    var ocpDate : Date? { get set }
    var taskCollection :  TaskAddCollectionParameterProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (TaskAddCollectionResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Task {
// AddCollection note that each task must have a unique ID. The Batch service may not return the results for each task
// in the same order the tasks were submitted in this request. If the server times out or the connection is closed
// during the request, the request may have been partially or fully processed, or not at all. In such cases, the user
// should re-issue the request. Note that it is up to the user to correctly handle failures when re-issuing a request.
// For example, you should use the same task IDs during a retry so that if the prior operation succeeded, the retry
// will not create extra tasks unexpectedly. If the response contains any tasks which failed to add, a client can retry
// the request. In a retry, it is most efficient to resubmit only tasks that failed to add, and to omit tasks that were
// successfully added on the first attempt. The maximum lifetime of a task from addition to completion is 7 days. If a
// task has not completed within 7 days of being added it will be terminated by the Batch service and left in whatever
// state it was in at that time.
internal class AddCollectionCommand : BaseCommand, TaskAddCollection {
    public var jobId : String
    public var timeout : Int32?
    public var apiVersion = "2017-09-01.6.0"
    public var clientRequestId : String?
    public var returnClientRequestId : Bool?
    public var ocpDate : Date?
    public var taskCollection :  TaskAddCollectionParameterProtocol?

    public init(jobId: String, taskCollection: TaskAddCollectionParameterProtocol) {
        self.jobId = jobId
        self.taskCollection = taskCollection
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/jobs/{jobId}/addtaskcollection"
        self.headerParameters = ["Content-Type":"application/json; odata=minimalmetadata; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{jobId}"] = String(describing: self.jobId)
        if self.timeout != nil { queryParameters["timeout"] = String(describing: self.timeout!) }
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
        if self.clientRequestId != nil { headerParameters["client-request-id"] = String(describing: self.clientRequestId!) }
        if self.returnClientRequestId != nil { headerParameters["return-client-request-id"] = String(describing: self.returnClientRequestId!) }
        if self.ocpDate != nil { headerParameters["ocp-date"] = String(describing: self.ocpDate!) }
    self.body = taskCollection
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(taskCollection)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(TaskAddCollectionResultData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (TaskAddCollectionResultProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: TaskAddCollectionResultData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
