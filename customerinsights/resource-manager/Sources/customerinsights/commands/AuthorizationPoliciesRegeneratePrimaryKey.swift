import Foundation
import azureSwiftRuntime
public protocol AuthorizationPoliciesRegeneratePrimaryKey  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var hubName : String { get set }
    var authorizationPolicyName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (AuthorizationPolicyProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.AuthorizationPolicies {
// RegeneratePrimaryKey regenerates the primary policy key of the specified authorization policy.
    internal class RegeneratePrimaryKeyCommand : BaseCommand, AuthorizationPoliciesRegeneratePrimaryKey {
        public var resourceGroupName : String
        public var hubName : String
        public var authorizationPolicyName : String
        public var subscriptionId : String
        public var apiVersion = "2017-04-26"

        public init(resourceGroupName: String, hubName: String, authorizationPolicyName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.hubName = hubName
            self.authorizationPolicyName = authorizationPolicyName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/authorizationPolicies/{authorizationPolicyName}/regeneratePrimaryKey"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{hubName}"] = String(describing: self.hubName)
            self.pathParameters["{authorizationPolicyName}"] = String(describing: self.authorizationPolicyName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(AuthorizationPolicyData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (AuthorizationPolicyProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: AuthorizationPolicyData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
