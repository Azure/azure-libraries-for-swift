import Foundation
import azureSwiftRuntime
public protocol WebhookCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var automationAccountName : String { get set }
    var webhookName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  WebhookCreateOrUpdateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (WebhookProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Webhook {
// CreateOrUpdate create the webhook identified by webhook name.
    internal class CreateOrUpdateCommand : BaseCommand, WebhookCreateOrUpdate {
        public var resourceGroupName : String
        public var automationAccountName : String
        public var webhookName : String
        public var subscriptionId : String
        public var apiVersion = "2015-10-31"
    public var parameters :  WebhookCreateOrUpdateParametersProtocol?

        public init(resourceGroupName: String, automationAccountName: String, webhookName: String, subscriptionId: String, parameters: WebhookCreateOrUpdateParametersProtocol) {
            self.resourceGroupName = resourceGroupName
            self.automationAccountName = automationAccountName
            self.webhookName = webhookName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/webhooks/{webhookName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{automationAccountName}"] = String(describing: self.automationAccountName)
            self.pathParameters["{webhookName}"] = String(describing: self.webhookName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? WebhookCreateOrUpdateParametersData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(WebhookData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (WebhookProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: WebhookData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
