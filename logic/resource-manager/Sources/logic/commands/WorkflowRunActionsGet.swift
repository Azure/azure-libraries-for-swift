import Foundation
import azureSwiftRuntime
public protocol WorkflowRunActionsGet  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var workflowName : String { get set }
    var runName : String { get set }
    var actionName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (WorkflowRunActionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WorkflowRunActions {
// Get gets a workflow run action.
internal class GetCommand : BaseCommand, WorkflowRunActionsGet {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var workflowName : String
    public var runName : String
    public var actionName : String
    public var apiVersion = "2016-06-01"

    public init(subscriptionId: String, resourceGroupName: String, workflowName: String, runName: String, actionName: String) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.workflowName = workflowName
        self.runName = runName
        self.actionName = actionName
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/workflows/{workflowName}/runs/{runName}/actions/{actionName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{workflowName}"] = String(describing: self.workflowName)
        self.pathParameters["{runName}"] = String(describing: self.runName)
        self.pathParameters["{actionName}"] = String(describing: self.actionName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(WorkflowRunActionData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (WorkflowRunActionProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: WorkflowRunActionData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
