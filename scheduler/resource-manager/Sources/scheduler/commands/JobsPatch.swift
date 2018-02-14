import Foundation
import azureSwiftRuntime
public protocol JobsPatch  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var jobCollectionName : String { get set }
    var jobName : String { get set }
    var apiVersion : String { get set }
    var job :  JobDefinitionProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (JobDefinitionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Jobs {
// Patch patches an existing job.
internal class PatchCommand : BaseCommand, JobsPatch {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var jobCollectionName : String
    public var jobName : String
    public var apiVersion = "2016-03-01"
    public var job :  JobDefinitionProtocol?

    public init(subscriptionId: String, resourceGroupName: String, jobCollectionName: String, jobName: String, job: JobDefinitionProtocol) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.jobCollectionName = jobCollectionName
        self.jobName = jobName
        self.job = job
        super.init()
        self.method = "Patch"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Scheduler/jobCollections/{jobCollectionName}/jobs/{jobName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{jobCollectionName}"] = String(describing: self.jobCollectionName)
        self.pathParameters["{jobName}"] = String(describing: self.jobName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
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

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(JobDefinitionData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (JobDefinitionProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: JobDefinitionData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
