import Foundation
import azureSwiftRuntime
public protocol WorkflowTriggersListCallbackUrl  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var workflowName : String { get set }
    var triggerName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (WorkflowTriggerCallbackUrlProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WorkflowTriggers {
// ListCallbackUrl gets the callback URL for a workflow trigger.
internal class ListCallbackUrlCommand : BaseCommand, WorkflowTriggersListCallbackUrl {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var workflowName : String
    public var triggerName : String
    public var apiVersion = "2016-06-01"

    public init(subscriptionId: String, resourceGroupName: String, workflowName: String, triggerName: String) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.workflowName = workflowName
        self.triggerName = triggerName
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/workflows/{workflowName}/triggers/{triggerName}/listCallbackUrl"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{workflowName}"] = String(describing: self.workflowName)
        self.pathParameters["{triggerName}"] = String(describing: self.triggerName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
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
