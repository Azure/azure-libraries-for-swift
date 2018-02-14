import Foundation
import azureSwiftRuntime
public protocol SecurityRulesGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var networkSecurityGroupName : String { get set }
    var securityRuleName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (SecurityRuleProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.SecurityRules {
// Get get the specified network security rule.
internal class GetCommand : BaseCommand, SecurityRulesGet {
    public var resourceGroupName : String
    public var networkSecurityGroupName : String
    public var securityRuleName : String
    public var subscriptionId : String
    public var apiVersion = "2018-01-01"

    public init(resourceGroupName: String, networkSecurityGroupName: String, securityRuleName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.networkSecurityGroupName = networkSecurityGroupName
        self.securityRuleName = securityRuleName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}/securityRules/{securityRuleName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{networkSecurityGroupName}"] = String(describing: self.networkSecurityGroupName)
        self.pathParameters["{securityRuleName}"] = String(describing: self.securityRuleName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
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
        client.executeAsync(command: self) {
            (result: SecurityRuleData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
