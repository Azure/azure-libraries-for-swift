import Foundation
import azureSwiftRuntime
public protocol SourceControlSyncJobCreate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var automationAccountName : String { get set }
    var sourceControlName : String { get set }
    var sourceControlSyncJobId : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (SourceControlSyncJobProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.SourceControlSyncJob {
// Create creates the sync job for a source control.
internal class CreateCommand : BaseCommand, SourceControlSyncJobCreate {
    public var resourceGroupName : String
    public var automationAccountName : String
    public var sourceControlName : String
    public var sourceControlSyncJobId : String
    public var subscriptionId : String
    public var apiVersion = "2017-05-15-preview"

    public init(resourceGroupName: String, automationAccountName: String, sourceControlName: String, sourceControlSyncJobId: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.automationAccountName = automationAccountName
        self.sourceControlName = sourceControlName
        self.sourceControlSyncJobId = sourceControlSyncJobId
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/sourceControls/{sourceControlName}/sourceControlSyncJobs/{sourceControlSyncJobId}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{automationAccountName}"] = String(describing: self.automationAccountName)
        self.pathParameters["{sourceControlName}"] = String(describing: self.sourceControlName)
        self.pathParameters["{sourceControlSyncJobId}"] = String(describing: self.sourceControlSyncJobId)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(SourceControlSyncJobData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (SourceControlSyncJobProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: SourceControlSyncJobData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
