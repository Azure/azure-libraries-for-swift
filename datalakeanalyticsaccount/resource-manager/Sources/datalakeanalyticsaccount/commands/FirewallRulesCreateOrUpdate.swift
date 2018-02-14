import Foundation
import azureSwiftRuntime
public protocol FirewallRulesCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var accountName : String { get set }
    var firewallRuleName : String { get set }
    var apiVersion : String { get set }
    var parameters :  CreateOrUpdateFirewallRuleParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (FirewallRuleProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.FirewallRules {
// CreateOrUpdate creates or updates the specified firewall rule. During update, the firewall rule with the specified
// name will be replaced with this new firewall rule.
internal class CreateOrUpdateCommand : BaseCommand, FirewallRulesCreateOrUpdate {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var accountName : String
    public var firewallRuleName : String
    public var apiVersion = "2016-11-01"
    public var parameters :  CreateOrUpdateFirewallRuleParametersProtocol?

    public init(subscriptionId: String, resourceGroupName: String, accountName: String, firewallRuleName: String, parameters: CreateOrUpdateFirewallRuleParametersProtocol) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.accountName = accountName
        self.firewallRuleName = firewallRuleName
        self.parameters = parameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataLakeAnalytics/accounts/{accountName}/firewallRules/{firewallRuleName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{accountName}"] = String(describing: self.accountName)
        self.pathParameters["{firewallRuleName}"] = String(describing: self.firewallRuleName)
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
            let result = try decoder.decode(FirewallRuleData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (FirewallRuleProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: FirewallRuleData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
