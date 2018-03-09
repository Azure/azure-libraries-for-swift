import Foundation
import azureSwiftRuntime
public protocol WorkflowVersionsListCallbackUrl  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var workflowName : String { get set }
    var versionId : String { get set }
    var triggerName : String { get set }
    var apiVersion : String { get set }
    var parameters :  GetCallbackUrlParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (WorkflowTriggerCallbackUrlProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WorkflowVersions {
// ListCallbackUrl lists the callback URL for a trigger of a workflow version.
    internal class ListCallbackUrlCommand : BaseCommand, WorkflowVersionsListCallbackUrl {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var workflowName : String
        public var versionId : String
        public var triggerName : String
        public var apiVersion = "2016-06-01"
    public var parameters :  GetCallbackUrlParametersProtocol?

        public init(subscriptionId: String, resourceGroupName: String, workflowName: String, versionId: String, triggerName: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.workflowName = workflowName
            self.versionId = versionId
            self.triggerName = triggerName
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/workflows/{workflowName}/versions/{versionId}/triggers/{triggerName}/listCallbackUrl"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{workflowName}"] = String(describing: self.workflowName)
            self.pathParameters["{versionId}"] = String(describing: self.versionId)
            self.pathParameters["{triggerName}"] = String(describing: self.triggerName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? GetCallbackUrlParametersData?)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(WorkflowTriggerCallbackUrlData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (WorkflowTriggerCallbackUrlProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: WorkflowTriggerCallbackUrlData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
