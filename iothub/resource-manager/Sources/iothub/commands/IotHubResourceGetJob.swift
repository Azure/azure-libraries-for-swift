import Foundation
import azureSwiftRuntime
public protocol IotHubResourceGetJob  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var resourceName : String { get set }
    var jobId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (JobResponseProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.IotHubResource {
// GetJob get the details of a job from an IoT hub. For more information, see:
// https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry.
    internal class GetJobCommand : BaseCommand, IotHubResourceGetJob {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var resourceName : String
        public var jobId : String
        public var apiVersion = "2017-07-01"

        public init(subscriptionId: String, resourceGroupName: String, resourceName: String, jobId: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.resourceName = resourceName
            self.jobId = jobId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/jobs/{jobId}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{resourceName}"] = String(describing: self.resourceName)
            self.pathParameters["{jobId}"] = String(describing: self.jobId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(JobResponseData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (JobResponseProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: JobResponseData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
