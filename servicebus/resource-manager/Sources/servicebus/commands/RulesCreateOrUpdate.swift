import Foundation
import azureSwiftRuntime
public protocol RulesCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var namespaceName : String { get set }
    var topicName : String { get set }
    var subscriptionName : String { get set }
    var ruleName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  RuleProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (RuleProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Rules {
// CreateOrUpdate creates a new rule and updates an existing rule
internal class CreateOrUpdateCommand : BaseCommand, RulesCreateOrUpdate {
    public var resourceGroupName : String
    public var namespaceName : String
    public var topicName : String
    public var subscriptionName : String
    public var ruleName : String
    public var subscriptionId : String
    public var apiVersion = "2017-04-01"
    public var parameters :  RuleProtocol?

    public init(resourceGroupName: String, namespaceName: String, topicName: String, subscriptionName: String, ruleName: String, subscriptionId: String, parameters: RuleProtocol) {
        self.resourceGroupName = resourceGroupName
        self.namespaceName = namespaceName
        self.topicName = topicName
        self.subscriptionName = subscriptionName
        self.ruleName = ruleName
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}/subscriptions/{subscriptionName}/rules/{ruleName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{namespaceName}"] = String(describing: self.namespaceName)
        self.pathParameters["{topicName}"] = String(describing: self.topicName)
        self.pathParameters["{subscriptionName}"] = String(describing: self.subscriptionName)
        self.pathParameters["{ruleName}"] = String(describing: self.ruleName)
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
            let result = try decoder.decode(RuleData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (RuleProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: RuleData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
