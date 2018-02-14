import Foundation
import azureSwiftRuntime
public protocol WebhookGenerateUri  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var automationAccountName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (String?, Error?) -> Void) -> Void ;
}

extension Commands.Webhook {
// GenerateUri generates a Uri for use in creating a webhook.
internal class GenerateUriCommand : BaseCommand, WebhookGenerateUri {
    public var resourceGroupName : String
    public var automationAccountName : String
    public var subscriptionId : String
    public var apiVersion = "2015-10-31"

    public init(resourceGroupName: String, automationAccountName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.automationAccountName = automationAccountName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/webhooks/generateUri"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{automationAccountName}"] = String(describing: self.automationAccountName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(String?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (String?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: String?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
