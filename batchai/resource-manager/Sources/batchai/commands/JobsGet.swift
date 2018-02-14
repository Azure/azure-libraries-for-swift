import Foundation
import azureSwiftRuntime
public protocol JobsGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var jobName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (JobProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Jobs {
// Get gets information about the specified Batch AI job.
internal class GetCommand : BaseCommand, JobsGet {
    public var resourceGroupName : String
    public var jobName : String
    public var subscriptionId : String
    public var apiVersion = "2017-09-01-preview"

    public init(resourceGroupName: String, jobName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.jobName = jobName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BatchAI/jobs/{jobName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{jobName}"] = String(describing: self.jobName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(JobData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (JobProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: JobData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
