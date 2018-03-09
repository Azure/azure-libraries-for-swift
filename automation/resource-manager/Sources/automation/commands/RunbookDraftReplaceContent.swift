import Foundation
import azureSwiftRuntime
public protocol RunbookDraftReplaceContent  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var automationAccountName : String { get set }
    var runbookName : String { get set }
    var apiVersion : String { get set }
    var runbookContent :  String?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.RunbookDraft {
// ReplaceContent replaces the runbook draft content. This method may poll for completion. Polling can be canceled by
// passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
    internal class ReplaceContentCommand : BaseCommand, RunbookDraftReplaceContent {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var automationAccountName : String
        public var runbookName : String
        public var apiVersion = "2015-10-31"
    public var runbookContent :  String?

        public init(subscriptionId: String, resourceGroupName: String, automationAccountName: String, runbookName: String, runbookContent: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.automationAccountName = automationAccountName
            self.runbookName = runbookName
            self.runbookContent = runbookContent
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/runbooks/{runbookName}/draft/content"
            self.headerParameters = ["Content-Type":"text/powershell"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{automationAccountName}"] = String(describing: self.automationAccountName)
            self.pathParameters["{runbookName}"] = String(describing: self.runbookName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = runbookContent

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "text/powershell"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(runbookContent as? String)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public func execute(client: RuntimeClient,
            completionHandler: @escaping (Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (error) in
                completionHandler(error)
            }
        }
    }
}
