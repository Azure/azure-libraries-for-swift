import Foundation
import azureSwiftRuntime
public protocol JobCollectionsGet  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var jobCollectionName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (JobCollectionDefinitionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.JobCollections {
// Get gets a job collection.
    internal class GetCommand : BaseCommand, JobCollectionsGet {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var jobCollectionName : String
        public var apiVersion = "2016-03-01"

        public init(subscriptionId: String, resourceGroupName: String, jobCollectionName: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.jobCollectionName = jobCollectionName
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Scheduler/jobCollections/{jobCollectionName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{jobCollectionName}"] = String(describing: self.jobCollectionName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(JobCollectionDefinitionData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (JobCollectionDefinitionProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: JobCollectionDefinitionData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
