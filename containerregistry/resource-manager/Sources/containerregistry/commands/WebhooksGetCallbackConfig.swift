import Foundation
import azureSwiftRuntime
public protocol WebhooksGetCallbackConfig  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var registryName : String { get set }
    var webhookName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (CallbackConfigProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Webhooks {
// GetCallbackConfig gets the configuration of service URI and custom headers for the webhook.
    internal class GetCallbackConfigCommand : BaseCommand, WebhooksGetCallbackConfig {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var registryName : String
        public var webhookName : String
        public var apiVersion = "2017-10-01"

        public init(subscriptionId: String, resourceGroupName: String, registryName: String, webhookName: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.registryName = registryName
            self.webhookName = webhookName
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerRegistry/registries/{registryName}/webhooks/{webhookName}/getCallbackConfig"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{registryName}"] = String(describing: self.registryName)
            self.pathParameters["{webhookName}"] = String(describing: self.webhookName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(CallbackConfigData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (CallbackConfigProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: CallbackConfigData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
