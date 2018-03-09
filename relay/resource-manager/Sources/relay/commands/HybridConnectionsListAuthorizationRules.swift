import Foundation
import azureSwiftRuntime
public protocol HybridConnectionsListAuthorizationRules  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var namespaceName : String { get set }
    var hybridConnectionName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (AuthorizationRuleListResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.HybridConnections {
// ListAuthorizationRules authorization rules for a hybrid connection.
    internal class ListAuthorizationRulesCommand : BaseCommand, HybridConnectionsListAuthorizationRules {
        var nextLink: String?
        public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
        public var resourceGroupName : String
        public var namespaceName : String
        public var hybridConnectionName : String
        public var subscriptionId : String
        public var apiVersion = "2017-04-01"

        public init(resourceGroupName: String, namespaceName: String, hybridConnectionName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.namespaceName = namespaceName
            self.hybridConnectionName = hybridConnectionName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/hybridConnections/{hybridConnectionName}/authorizationRules"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{namespaceName}"] = String(describing: self.namespaceName)
            self.pathParameters["{hybridConnectionName}"] = String(describing: self.hybridConnectionName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                if var pageDecoder = decoder as? PageDecoder {
                    pageDecoder.isPagedData = true
                    pageDecoder.nextLinkName = "NextLink"
                }
                let result = try decoder.decode(AuthorizationRuleListResultData?.self, from: data)
                if var pageDecoder = decoder as? PageDecoder {
                    self.nextLink = pageDecoder.nextLink
                }
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (AuthorizationRuleListResultProtocol?, Error?) -> Void) -> Void {
            if self.nextLink != nil {
                self.path = nextLink!
                self.nextLink = nil;
                self.pathType = .absolute
            }
            client.executeAsync(command: self) {
                (result: AuthorizationRuleListResultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
