import Foundation
import azureSwiftRuntime
public protocol WebhooksUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var registryName : String { get set }
    var webhookName : String { get set }
    var apiVersion : String { get set }
    var webhookUpdateParameters :  WebhookUpdateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (WebhookProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Webhooks {
// Update updates a webhook with the specified parameters. This method may poll for completion. Polling can be canceled
// by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
    internal class UpdateCommand : BaseCommand, WebhooksUpdate {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var registryName : String
        public var webhookName : String
        public var apiVersion = "2017-10-01"
    public var webhookUpdateParameters :  WebhookUpdateParametersProtocol?

        public init(subscriptionId: String, resourceGroupName: String, registryName: String, webhookName: String, webhookUpdateParameters: WebhookUpdateParametersProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.registryName = registryName
            self.webhookName = webhookName
            self.webhookUpdateParameters = webhookUpdateParameters
            super.init()
            self.method = "Patch"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerRegistry/registries/{registryName}/webhooks/{webhookName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{registryName}"] = String(describing: self.registryName)
            self.pathParameters["{webhookName}"] = String(describing: self.webhookName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = webhookUpdateParameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(webhookUpdateParameters as? WebhookUpdateParametersData)
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
            client.executeAsyncLRO(command: self) {
                (result: WebhookData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
