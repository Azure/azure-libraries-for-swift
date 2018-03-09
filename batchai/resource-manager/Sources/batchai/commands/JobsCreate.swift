import Foundation
import azureSwiftRuntime
public protocol JobsCreate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var jobName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  JobCreateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (JobProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Jobs {
// Create adds a Job that gets executed on a cluster. This method may poll for completion. Polling can be canceled by
// passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
    internal class CreateCommand : BaseCommand, JobsCreate {
        public var resourceGroupName : String
        public var jobName : String
        public var subscriptionId : String
        public var apiVersion = "2017-09-01-preview"
    public var parameters :  JobCreateParametersProtocol?

        public init(resourceGroupName: String, jobName: String, subscriptionId: String, parameters: JobCreateParametersProtocol) {
            self.resourceGroupName = resourceGroupName
            self.jobName = jobName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BatchAI/jobs/{jobName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{jobName}"] = String(describing: self.jobName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? JobCreateParametersData)
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
