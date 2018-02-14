import Foundation
import azureSwiftRuntime
public protocol RunbookUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var automationAccountName : String { get set }
    var runbookName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  RunbookUpdateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (RunbookProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Runbook {
// Update update the runbook identified by runbook name.
internal class UpdateCommand : BaseCommand, RunbookUpdate {
    public var resourceGroupName : String
    public var automationAccountName : String
    public var runbookName : String
    public var subscriptionId : String
    public var apiVersion = "2015-10-31"
    public var parameters :  RunbookUpdateParametersProtocol?

    public init(resourceGroupName: String, automationAccountName: String, runbookName: String, subscriptionId: String, parameters: RunbookUpdateParametersProtocol) {
        self.resourceGroupName = resourceGroupName
        self.automationAccountName = automationAccountName
        self.runbookName = runbookName
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Patch"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/runbooks/{runbookName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{automationAccountName}"] = String(describing: self.automationAccountName)
        self.pathParameters["{runbookName}"] = String(describing: self.runbookName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = parameters
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(parameters)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(RunbookData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (RunbookProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: RunbookData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
