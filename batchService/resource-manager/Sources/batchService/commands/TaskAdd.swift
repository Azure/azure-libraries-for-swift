import Foundation
import azureSwiftRuntime
public protocol TaskAdd  {
    var headerParameters: [String: String] { get set }
    var jobId : String { get set }
    var timeout : Int32? { get set }
    var apiVersion : String { get set }
    var clientRequestId : String? { get set }
    var returnClientRequestId : Bool? { get set }
    var ocpDate : Date? { get set }
    var task :  TaskAddParameterProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Task {
// Add the maximum lifetime of a task from addition to completion is 7 days. If a task has not completed within 7 days
// of being added it will be terminated by the Batch service and left in whatever state it was in at that time.
    internal class AddCommand : BaseCommand, TaskAdd {
        public var jobId : String
        public var timeout : Int32?
        public var apiVersion = "2017-09-01.6.0"
        public var clientRequestId : String?
        public var returnClientRequestId : Bool?
        public var ocpDate : Date?
    public var task :  TaskAddParameterProtocol?

        public init(jobId: String, task: TaskAddParameterProtocol) {
            self.jobId = jobId
            self.task = task
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/jobs/{jobId}/tasks"
            self.headerParameters = ["Content-Type":"application/json; odata=minimalmetadata; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{jobId}"] = String(describing: self.jobId)
            if self.timeout != nil { queryParameters["timeout"] = String(describing: self.timeout!) }
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            if self.clientRequestId != nil { headerParameters["client-request-id"] = String(describing: self.clientRequestId!) }
            if self.returnClientRequestId != nil { headerParameters["return-client-request-id"] = String(describing: self.returnClientRequestId!) }
            if self.ocpDate != nil { headerParameters["ocp-date"] = String(describing: self.ocpDate!) }
            self.body = task

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(task as? TaskAddParameterData)
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
