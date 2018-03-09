import Foundation
import azureSwiftRuntime
public protocol ReplicationJobsResume  {
    var headerParameters: [String: String] { get set }
    var resourceName : String { get set }
    var resourceGroupName : String { get set }
    var subscriptionId : String { get set }
    var jobName : String { get set }
    var apiVersion : String { get set }
    var resumeJobParams :  ResumeJobParamsProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (JobProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ReplicationJobs {
// Resume the operation to resume an Azure Site Recovery job This method may poll for completion. Polling can be
// canceled by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
    internal class ResumeCommand : BaseCommand, ReplicationJobsResume {
        public var resourceName : String
        public var resourceGroupName : String
        public var subscriptionId : String
        public var jobName : String
        public var apiVersion = "2018-01-10"
    public var resumeJobParams :  ResumeJobParamsProtocol?

        public init(resourceName: String, resourceGroupName: String, subscriptionId: String, jobName: String, resumeJobParams: ResumeJobParamsProtocol) {
            self.resourceName = resourceName
            self.resourceGroupName = resourceGroupName
            self.subscriptionId = subscriptionId
            self.jobName = jobName
            self.resumeJobParams = resumeJobParams
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = true
            self.path = "/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{resourceName}/replicationJobs/{jobName}/resume"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceName}"] = String(describing: self.resourceName)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{jobName}"] = String(describing: self.jobName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = resumeJobParams

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(resumeJobParams as? ResumeJobParamsData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
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
            client.executeAsyncLRO(command: self) {
                (result: JobData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
