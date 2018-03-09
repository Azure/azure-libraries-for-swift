import Foundation
import azureSwiftRuntime
public protocol NotificationHubsRegenerateKeys  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var namespaceName : String { get set }
    var notificationHubName : String { get set }
    var authorizationRuleName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  PolicykeyResourceProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ResourceListKeysProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.NotificationHubs {
// RegenerateKeys regenerates the Primary/Secondary Keys to the NotificationHub Authorization Rule
    internal class RegenerateKeysCommand : BaseCommand, NotificationHubsRegenerateKeys {
        public var resourceGroupName : String
        public var namespaceName : String
        public var notificationHubName : String
        public var authorizationRuleName : String
        public var subscriptionId : String
        public var apiVersion = "2017-04-01"
    public var parameters :  PolicykeyResourceProtocol?

        public init(resourceGroupName: String, namespaceName: String, notificationHubName: String, authorizationRuleName: String, subscriptionId: String, parameters: PolicykeyResourceProtocol) {
            self.resourceGroupName = resourceGroupName
            self.namespaceName = namespaceName
            self.notificationHubName = notificationHubName
            self.authorizationRuleName = authorizationRuleName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/notificationHubs/{notificationHubName}/AuthorizationRules/{authorizationRuleName}/regenerateKeys"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{namespaceName}"] = String(describing: self.namespaceName)
            self.pathParameters["{notificationHubName}"] = String(describing: self.notificationHubName)
            self.pathParameters["{authorizationRuleName}"] = String(describing: self.authorizationRuleName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? PolicykeyResourceData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ResourceListKeysData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ResourceListKeysProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: ResourceListKeysData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
