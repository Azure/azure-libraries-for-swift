import Foundation
import azureSwiftRuntime
public protocol TestJobStreamsGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var automationAccountName : String { get set }
    var runbookName : String { get set }
    var jobStreamId : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (JobStreamProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.TestJobStreams {
// Get retrieve a test job streams identified by runbook name and stream id.
internal class GetCommand : BaseCommand, TestJobStreamsGet {
    public var resourceGroupName : String
    public var automationAccountName : String
    public var runbookName : String
    public var jobStreamId : String
    public var subscriptionId : String
    public var apiVersion = "2015-10-31"

    public init(resourceGroupName: String, automationAccountName: String, runbookName: String, jobStreamId: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.automationAccountName = automationAccountName
        self.runbookName = runbookName
        self.jobStreamId = jobStreamId
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/runbooks/{runbookName}/draft/testJob/streams/{jobStreamId}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{automationAccountName}"] = String(describing: self.automationAccountName)
        self.pathParameters["{runbookName}"] = String(describing: self.runbookName)
        self.pathParameters["{jobStreamId}"] = String(describing: self.jobStreamId)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(JobStreamData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (JobStreamProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: JobStreamData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
