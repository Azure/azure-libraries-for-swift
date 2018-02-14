import Foundation
import azureSwiftRuntime
public protocol TopicsCreateOrUpdateAuthorizationRule  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var namespaceName : String { get set }
    var topicName : String { get set }
    var authorizationRuleName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  SBAuthorizationRuleProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (SBAuthorizationRuleProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Topics {
// CreateOrUpdateAuthorizationRule creates an authorizatio rule for the specified topic.
internal class CreateOrUpdateAuthorizationRuleCommand : BaseCommand, TopicsCreateOrUpdateAuthorizationRule {
    public var resourceGroupName : String
    public var namespaceName : String
    public var topicName : String
    public var authorizationRuleName : String
    public var subscriptionId : String
    public var apiVersion = "2017-04-01"
    public var parameters :  SBAuthorizationRuleProtocol?

    public init(resourceGroupName: String, namespaceName: String, topicName: String, authorizationRuleName: String, subscriptionId: String, parameters: SBAuthorizationRuleProtocol) {
        self.resourceGroupName = resourceGroupName
        self.namespaceName = namespaceName
        self.topicName = topicName
        self.authorizationRuleName = authorizationRuleName
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}/authorizationRules/{authorizationRuleName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{namespaceName}"] = String(describing: self.namespaceName)
        self.pathParameters["{topicName}"] = String(describing: self.topicName)
        self.pathParameters["{authorizationRuleName}"] = String(describing: self.authorizationRuleName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
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
