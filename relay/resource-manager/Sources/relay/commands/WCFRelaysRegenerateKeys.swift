import Foundation
import azureSwiftRuntime
public protocol WCFRelaysRegenerateKeys  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var namespaceName : String { get set }
    var relayName : String { get set }
    var authorizationRuleName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  RegenerateAccessKeyParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (AccessKeysProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WCFRelays {
// RegenerateKeys regenerates the primary or secondary connection strings to the WCF relay.
    internal class RegenerateKeysCommand : BaseCommand, WCFRelaysRegenerateKeys {
        public var resourceGroupName : String
        public var namespaceName : String
        public var relayName : String
        public var authorizationRuleName : String
        public var subscriptionId : String
        public var apiVersion = "2017-04-01"
    public var parameters :  RegenerateAccessKeyParametersProtocol?

        public init(resourceGroupName: String, namespaceName: String, relayName: String, authorizationRuleName: String, subscriptionId: String, parameters: RegenerateAccessKeyParametersProtocol) {
            self.resourceGroupName = resourceGroupName
            self.namespaceName = namespaceName
            self.relayName = relayName
            self.authorizationRuleName = authorizationRuleName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/wcfRelays/{relayName}/authorizationRules/{authorizationRuleName}/regenerateKeys"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{namespaceName}"] = String(describing: self.namespaceName)
            self.pathParameters["{relayName}"] = String(describing: self.relayName)
            self.pathParameters["{authorizationRuleName}"] = String(describing: self.authorizationRuleName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? RegenerateAccessKeyParametersData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(AccessKeysData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (AccessKeysProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: AccessKeysData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
