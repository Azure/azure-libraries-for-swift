import Foundation
import azureSwiftRuntime
public protocol SecurityRulesCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var networkSecurityGroupName : String { get set }
    var securityRuleName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var securityRuleParameters :  SecurityRuleProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (SecurityRuleProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.SecurityRules {
// CreateOrUpdate creates or updates a security rule in the specified network security group. This method may poll for
// completion. Polling can be canceled by passing the cancel channel argument. The channel will be used to cancel
// polling and any outstanding HTTP requests.
internal class CreateOrUpdateCommand : BaseCommand, SecurityRulesCreateOrUpdate {
    public var resourceGroupName : String
    public var networkSecurityGroupName : String
    public var securityRuleName : String
    public var subscriptionId : String
    public var apiVersion = "2018-01-01"
    public var securityRuleParameters :  SecurityRuleProtocol?

    public init(resourceGroupName: String, networkSecurityGroupName: String, securityRuleName: String, subscriptionId: String, securityRuleParameters: SecurityRuleProtocol) {
        self.resourceGroupName = resourceGroupName
        self.networkSecurityGroupName = networkSecurityGroupName
        self.securityRuleName = securityRuleName
        self.subscriptionId = subscriptionId
        self.securityRuleParameters = securityRuleParameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}/securityRules/{securityRuleName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{networkSecurityGroupName}"] = String(describing: self.networkSecurityGroupName)
        self.pathParameters["{securityRuleName}"] = String(describing: self.securityRuleName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = securityRuleParameters
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(securityRuleParameters)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(SecurityRuleData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (SecurityRuleProtocol?, Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (result: SecurityRuleData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
