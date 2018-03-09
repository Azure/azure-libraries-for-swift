import Foundation
import azureSwiftRuntime
public protocol NamespacesCreateOrUpdateAuthorizationRule  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var namespaceName : String { get set }
    var authorizationRuleName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  SharedAccessAuthorizationRuleCreateOrUpdateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (SharedAccessAuthorizationRuleResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Namespaces {
// CreateOrUpdateAuthorizationRule creates an authorization rule for a namespace
    internal class CreateOrUpdateAuthorizationRuleCommand : BaseCommand, NamespacesCreateOrUpdateAuthorizationRule {
        public var resourceGroupName : String
        public var namespaceName : String
        public var authorizationRuleName : String
        public var subscriptionId : String
        public var apiVersion = "2017-04-01"
    public var parameters :  SharedAccessAuthorizationRuleCreateOrUpdateParametersProtocol?

        public init(resourceGroupName: String, namespaceName: String, authorizationRuleName: String, subscriptionId: String, parameters: SharedAccessAuthorizationRuleCreateOrUpdateParametersProtocol) {
            self.resourceGroupName = resourceGroupName
            self.namespaceName = namespaceName
            self.authorizationRuleName = authorizationRuleName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/AuthorizationRules/{authorizationRuleName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{namespaceName}"] = String(describing: self.namespaceName)
            self.pathParameters["{authorizationRuleName}"] = String(describing: self.authorizationRuleName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? SharedAccessAuthorizationRuleCreateOrUpdateParametersData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(SharedAccessAuthorizationRuleResourceData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (SharedAccessAuthorizationRuleResourceProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: SharedAccessAuthorizationRuleResourceData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
