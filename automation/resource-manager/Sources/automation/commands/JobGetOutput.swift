import Foundation
import azureSwiftRuntime
public protocol JobGetOutput  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var automationAccountName : String { get set }
    var jobId : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Data?, Error?) -> Void) -> Void ;
}

extension Commands.Job {
// GetOutput retrieve the job output identified by job id.
internal class GetOutputCommand : BaseCommand, JobGetOutput {
    public var resourceGroupName : String
    public var automationAccountName : String
    public var jobId : String
    public var subscriptionId : String
    public var apiVersion = "2015-10-31"

    public init(resourceGroupName: String, automationAccountName: String, jobId: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.automationAccountName = automationAccountName
        self.jobId = jobId
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/jobs/{jobId}/output"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{automationAccountName}"] = String(describing: self.automationAccountName)
        self.pathParameters["{jobId}"] = String(describing: self.jobId)
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
