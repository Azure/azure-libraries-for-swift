import Foundation
import azureSwiftRuntime
public protocol WorkflowsGenerateUpgradedDefinition  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var workflowName : String { get set }
    var apiVersion : String { get set }
    var parameters :  GenerateUpgradedDefinitionParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping ([String: String?]?, Error?) -> Void) -> Void ;
}

extension Commands.Workflows {
// GenerateUpgradedDefinition generates the upgraded definition for a workflow.
    internal class GenerateUpgradedDefinitionCommand : BaseCommand, WorkflowsGenerateUpgradedDefinition {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var workflowName : String
        public var apiVersion = "2016-06-01"
    public var parameters :  GenerateUpgradedDefinitionParametersProtocol?

        public init(subscriptionId: String, resourceGroupName: String, workflowName: String, parameters: GenerateUpgradedDefinitionParametersProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.workflowName = workflowName
            self.parameters = parameters
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/workflows/{workflowName}/generateUpgradedDefinition"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{workflowName}"] = String(describing: self.workflowName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? GenerateUpgradedDefinitionParametersData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode([String: String?]?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping ([String: String?]?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: [String: String?]?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
