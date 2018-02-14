import Foundation
import azureSwiftRuntime
public protocol WorkflowsRegenerateAccessKey  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var workflowName : String { get set }
    var apiVersion : String { get set }
    var keyType :  RegenerateActionParameterProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Workflows {
// RegenerateAccessKey regenerates the callback URL access key for request triggers.
internal class RegenerateAccessKeyCommand : BaseCommand, WorkflowsRegenerateAccessKey {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var workflowName : String
    public var apiVersion = "2016-06-01"
    public var keyType :  RegenerateActionParameterProtocol?

    public init(subscriptionId: String, resourceGroupName: String, workflowName: String, keyType: RegenerateActionParameterProtocol) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.workflowName = workflowName
        self.keyType = keyType
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/workflows/{workflowName}/regenerateAccessKey"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{workflowName}"] = String(describing: self.workflowName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = keyType
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(keyType)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (error) in
            completionHandler(error)
        }
    }
}
}
