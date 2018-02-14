import Foundation
import azureSwiftRuntime
public protocol StreamingJobsCreateOrReplace  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var jobName : String { get set }
    var apiVersion : String { get set }
    var ifMatch : String? { get set }
    var ifNoneMatch : String? { get set }
    var streamingJob :  StreamingJobProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (StreamingJobProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.StreamingJobs {
// CreateOrReplace creates a streaming job or replaces an already existing streaming job. This method may poll for
// completion. Polling can be canceled by passing the cancel channel argument. The channel will be used to cancel
// polling and any outstanding HTTP requests.
internal class CreateOrReplaceCommand : BaseCommand, StreamingJobsCreateOrReplace {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var jobName : String
    public var apiVersion = "2016-03-01"
    public var ifMatch : String?
    public var ifNoneMatch : String?
    public var streamingJob :  StreamingJobProtocol?

    public init(subscriptionId: String, resourceGroupName: String, jobName: String, streamingJob: StreamingJobProtocol) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.jobName = jobName
        self.streamingJob = streamingJob
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.StreamAnalytics/streamingjobs/{jobName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{jobName}"] = String(describing: self.jobName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
        if self.ifMatch != nil { headerParameters["If-Match"] = String(describing: self.ifMatch!) }
        if self.ifNoneMatch != nil { headerParameters["If-None-Match"] = String(describing: self.ifNoneMatch!) }
    self.body = streamingJob
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(streamingJob)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(StreamingJobData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (StreamingJobProtocol?, Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (result: StreamingJobData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
