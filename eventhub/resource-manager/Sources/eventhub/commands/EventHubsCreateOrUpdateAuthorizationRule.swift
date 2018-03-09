import Foundation
import azureSwiftRuntime
public protocol EventHubsCreateOrUpdateAuthorizationRule  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var namespaceName : String { get set }
    var eventHubName : String { get set }
    var authorizationRuleName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  AuthorizationRuleProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (AuthorizationRuleProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.EventHubs {
// CreateOrUpdateAuthorizationRule creates or updates an AuthorizationRule for the specified Event Hub.
    internal class CreateOrUpdateAuthorizationRuleCommand : BaseCommand, EventHubsCreateOrUpdateAuthorizationRule {
        public var resourceGroupName : String
        public var namespaceName : String
        public var eventHubName : String
        public var authorizationRuleName : String
        public var subscriptionId : String
        public var apiVersion = "2017-04-01"
    public var parameters :  AuthorizationRuleProtocol?

        public init(resourceGroupName: String, namespaceName: String, eventHubName: String, authorizationRuleName: String, subscriptionId: String, parameters: AuthorizationRuleProtocol) {
            self.resourceGroupName = resourceGroupName
            self.namespaceName = namespaceName
            self.eventHubName = eventHubName
            self.authorizationRuleName = authorizationRuleName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{namespaceName}"] = String(describing: self.namespaceName)
            self.pathParameters["{eventHubName}"] = String(describing: self.eventHubName)
            self.pathParameters["{authorizationRuleName}"] = String(describing: self.authorizationRuleName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? AuthorizationRuleData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(AuthorizationRuleData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (AuthorizationRuleProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: AuthorizationRuleData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
