import Foundation
import azureSwiftRuntime
public protocol WorkflowsCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var workflowName : String { get set }
    var apiVersion : String { get set }
    var workflow :  WorkflowProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (WorkflowProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Workflows {
// CreateOrUpdate creates or updates a workflow.
    internal class CreateOrUpdateCommand : BaseCommand, WorkflowsCreateOrUpdate {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var workflowName : String
        public var apiVersion = "2016-06-01"
    public var workflow :  WorkflowProtocol?

        public init(subscriptionId: String, resourceGroupName: String, workflowName: String, workflow: WorkflowProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.workflowName = workflowName
            self.workflow = workflow
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/workflows/{workflowName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{workflowName}"] = String(describing: self.workflowName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = workflow

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(workflow as? WorkflowData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(WorkflowData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (WorkflowProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: WorkflowData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
