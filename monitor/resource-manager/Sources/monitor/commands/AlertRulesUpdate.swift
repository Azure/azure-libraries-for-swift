import Foundation
import azureSwiftRuntime
public protocol AlertRulesUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var ruleName : String { get set }
    var apiVersion : String { get set }
    var alertRulesResource :  AlertRuleResourcePatchProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (AlertRuleResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.AlertRules {
// Update updates an existing AlertRuleResource. To update other fields use the CreateOrUpdate method.
internal class UpdateCommand : BaseCommand, AlertRulesUpdate {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var ruleName : String
    public var apiVersion = "2016-03-01"
    public var alertRulesResource :  AlertRuleResourcePatchProtocol?

    public init(subscriptionId: String, resourceGroupName: String, ruleName: String, alertRulesResource: AlertRuleResourcePatchProtocol) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.ruleName = ruleName
        self.alertRulesResource = alertRulesResource
        super.init()
        self.method = "Patch"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/microsoft.insights/alertrules/{ruleName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{ruleName}"] = String(describing: self.ruleName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = alertRulesResource
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(alertRulesResource)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(AlertRuleResourceData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (AlertRuleResourceProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: AlertRuleResourceData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
