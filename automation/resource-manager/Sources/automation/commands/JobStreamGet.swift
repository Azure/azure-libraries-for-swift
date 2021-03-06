import Foundation
import azureSwiftRuntime
public protocol JobStreamGet  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var automationAccountName : String { get set }
    var jobName : String { get set }
    var jobStreamId : String { get set }
    var apiVersion : String { get set }
    var clientRequestId : String? { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (JobStreamProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.JobStream {
// Get retrieve the job stream identified by job stream id.
    internal class GetCommand : BaseCommand, JobStreamGet {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var automationAccountName : String
        public var jobName : String
        public var jobStreamId : String
        public var apiVersion = "2017-05-15-preview"
        public var clientRequestId : String?

        public init(subscriptionId: String, resourceGroupName: String, automationAccountName: String, jobName: String, jobStreamId: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.automationAccountName = automationAccountName
            self.jobName = jobName
            self.jobStreamId = jobStreamId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/jobs/{jobName}/streams/{jobStreamId}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{automationAccountName}"] = String(describing: self.automationAccountName)
            self.pathParameters["{jobName}"] = String(describing: self.jobName)
            self.pathParameters["{jobStreamId}"] = String(describing: self.jobStreamId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            if self.clientRequestId != nil { headerParameters["clientRequestId"] = String(describing: self.clientRequestId!) }

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(JobStreamData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (JobStreamProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: JobStreamData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
