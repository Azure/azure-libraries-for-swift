import Foundation
import azureSwiftRuntime
public protocol WorkflowVersionsGet  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var workflowName : String { get set }
    var versionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (WorkflowVersionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WorkflowVersions {
// Get gets a workflow version.
    internal class GetCommand : BaseCommand, WorkflowVersionsGet {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var workflowName : String
        public var versionId : String
        public var apiVersion = "2016-06-01"

        public init(subscriptionId: String, resourceGroupName: String, workflowName: String, versionId: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.workflowName = workflowName
            self.versionId = versionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/workflows/{workflowName}/versions/{versionId}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{workflowName}"] = String(describing: self.workflowName)
            self.pathParameters["{versionId}"] = String(describing: self.versionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(WorkflowVersionData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (WorkflowVersionProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: WorkflowVersionData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
