import Foundation
import azureSwiftRuntime
public protocol JobGetTaskCounts  {
    var headerParameters: [String: String] { get set }
    var jobId : String { get set }
    var timeout : Int32? { get set }
    var apiVersion : String { get set }
    var clientRequestId : String? { get set }
    var returnClientRequestId : Bool? { get set }
    var ocpDate : Date? { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (TaskCountsProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Job {
// GetTaskCounts task counts provide a count of the tasks by active, running or completed task state, and a count of
// tasks which succeeded or failed. Tasks in the preparing state are counted as running. If the validationStatus is
// unvalidated, then the Batch service has not been able to check state counts against the task states as reported in
// the List Tasks API. The validationStatus may be unvalidated if the job contains more than 200,000 tasks.
    internal class GetTaskCountsCommand : BaseCommand, JobGetTaskCounts {
        public var jobId : String
        public var timeout : Int32?
        public var apiVersion = "2017-09-01.6.0"
        public var clientRequestId : String?
        public var returnClientRequestId : Bool?
        public var ocpDate : Date?

        public init(jobId: String) {
            self.jobId = jobId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/jobs/{jobId}/taskcounts"
            self.headerParameters = ["Content-Type":"application/json; odata=minimalmetadata; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{jobId}"] = String(describing: self.jobId)
            if self.timeout != nil { queryParameters["timeout"] = String(describing: self.timeout!) }
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            if self.clientRequestId != nil { headerParameters["client-request-id"] = String(describing: self.clientRequestId!) }
            if self.returnClientRequestId != nil { headerParameters["return-client-request-id"] = String(describing: self.returnClientRequestId!) }
            if self.ocpDate != nil { headerParameters["ocp-date"] = String(describing: self.ocpDate!) }

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(TaskCountsData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (TaskCountsProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: TaskCountsData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
