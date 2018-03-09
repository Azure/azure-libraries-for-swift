import Foundation
import azureSwiftRuntime
public protocol FirewallRulesCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var cacheName : String { get set }
    var ruleName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  RedisFirewallRuleCreateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (RedisFirewallRuleProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.FirewallRules {
// CreateOrUpdate create or update a redis cache firewall rule
    internal class CreateOrUpdateCommand : BaseCommand, FirewallRulesCreateOrUpdate {
        public var resourceGroupName : String
        public var cacheName : String
        public var ruleName : String
        public var subscriptionId : String
        public var apiVersion = "2017-10-01"
    public var parameters :  RedisFirewallRuleCreateParametersProtocol?

        public init(resourceGroupName: String, cacheName: String, ruleName: String, subscriptionId: String, parameters: RedisFirewallRuleCreateParametersProtocol) {
            self.resourceGroupName = resourceGroupName
            self.cacheName = cacheName
            self.ruleName = ruleName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/Redis/{cacheName}/firewallRules/{ruleName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{cacheName}"] = String(describing: self.cacheName)
            self.pathParameters["{ruleName}"] = String(describing: self.ruleName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? RedisFirewallRuleCreateParametersData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(RedisFirewallRuleData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (RedisFirewallRuleProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: RedisFirewallRuleData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
