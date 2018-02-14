import Foundation
import azureSwiftRuntime
public protocol JobDetailsGet  {
    var headerParameters: [String: String] { get set }
    var vaultName : String { get set }
    var resourceGroupName : String { get set }
    var subscriptionId : String { get set }
    var jobName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (JobResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.JobDetails {
// Get gets exteded information associated with the job.
internal class GetCommand : BaseCommand, JobDetailsGet {
    public var vaultName : String
    public var resourceGroupName : String
    public var subscriptionId : String
    public var jobName : String
    public var apiVersion = "2017-07-01"

    public init(vaultName: String, resourceGroupName: String, subscriptionId: String, jobName: String) {
        self.vaultName = vaultName
        self.resourceGroupName = resourceGroupName
        self.subscriptionId = subscriptionId
        self.jobName = jobName
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupJobs/{jobName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{vaultName}"] = String(describing: self.vaultName)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{jobName}"] = String(describing: self.jobName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(JobResourceData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (JobResourceProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: JobResourceData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
