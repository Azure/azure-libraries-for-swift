import Foundation
import azureSwiftRuntime
public protocol RunbookGetContent  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var automationAccountName : String { get set }
    var runbookName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Data?, Error?) -> Void) -> Void ;
}

extension Commands.Runbook {
// GetContent retrieve the content of runbook identified by runbook name.
internal class GetContentCommand : BaseCommand, RunbookGetContent {
    public var resourceGroupName : String
    public var automationAccountName : String
    public var runbookName : String
    public var subscriptionId : String
    public var apiVersion = "2015-10-31"

    public init(resourceGroupName: String, automationAccountName: String, runbookName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.automationAccountName = automationAccountName
        self.runbookName = runbookName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/runbooks/{runbookName}/content"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{automationAccountName}"] = String(describing: self.automationAccountName)
        self.pathParameters["{runbookName}"] = String(describing: self.runbookName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        return DataWrapper(data: data);
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (Data?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: DataWrapper?, error: Error?) in
            let data = result?.data as Data?
            completionHandler(data!, error)
        }
    }
}
}
