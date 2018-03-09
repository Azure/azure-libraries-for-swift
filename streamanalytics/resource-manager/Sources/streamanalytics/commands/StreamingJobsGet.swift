import Foundation
import azureSwiftRuntime
public protocol StreamingJobsGet  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var jobName : String { get set }
    var expand : String? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (StreamingJobProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.StreamingJobs {
// Get gets details about the specified streaming job.
    internal class GetCommand : BaseCommand, StreamingJobsGet {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var jobName : String
        public var expand : String?
        public var apiVersion = "2016-03-01"

        public init(subscriptionId: String, resourceGroupName: String, jobName: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.jobName = jobName
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.StreamAnalytics/streamingjobs/{jobName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{jobName}"] = String(describing: self.jobName)
            if self.expand != nil { queryParameters["$expand"] = String(describing: self.expand!) }
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

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
            client.executeAsync(command: self) {
                (result: StreamingJobData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
