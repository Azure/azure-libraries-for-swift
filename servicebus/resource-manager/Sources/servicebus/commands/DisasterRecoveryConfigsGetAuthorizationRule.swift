import Foundation
import azureSwiftRuntime
public protocol DisasterRecoveryConfigsGetAuthorizationRule  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var namespaceName : String { get set }
    var alias : String { get set }
    var authorizationRuleName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (SBAuthorizationRuleProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.DisasterRecoveryConfigs {
// GetAuthorizationRule gets an authorization rule for a namespace by rule name.
    internal class GetAuthorizationRuleCommand : BaseCommand, DisasterRecoveryConfigsGetAuthorizationRule {
        public var resourceGroupName : String
        public var namespaceName : String
        public var alias : String
        public var authorizationRuleName : String
        public var subscriptionId : String
        public var apiVersion = "2017-04-01"

        public init(resourceGroupName: String, namespaceName: String, alias: String, authorizationRuleName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.namespaceName = namespaceName
            self.alias = alias
            self.authorizationRuleName = authorizationRuleName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/AuthorizationRules/{authorizationRuleName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{namespaceName}"] = String(describing: self.namespaceName)
            self.pathParameters["{alias}"] = String(describing: self.alias)
            self.pathParameters["{authorizationRuleName}"] = String(describing: self.authorizationRuleName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(SBAuthorizationRuleData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (SBAuthorizationRuleProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: SBAuthorizationRuleData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
