import Foundation
import azureSwiftRuntime
public protocol DataMaskingRulesCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var databaseName : String { get set }
    var dataMaskingPolicyName : String { get set }
    var dataMaskingRuleName : String { get set }
    var apiVersion : String { get set }
    var parameters :  DataMaskingRuleProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (DataMaskingRuleProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.DataMaskingRules {
// CreateOrUpdate creates or updates a database data masking rule.
    internal class CreateOrUpdateCommand : BaseCommand, DataMaskingRulesCreateOrUpdate {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var serverName : String
        public var databaseName : String
        public var dataMaskingPolicyName : String
        public var dataMaskingRuleName : String
        public var apiVersion = "2014-04-01"
    public var parameters :  DataMaskingRuleProtocol?

        public init(subscriptionId: String, resourceGroupName: String, serverName: String, databaseName: String, dataMaskingPolicyName: String, dataMaskingRuleName: String, parameters: DataMaskingRuleProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.serverName = serverName
            self.databaseName = databaseName
            self.dataMaskingPolicyName = dataMaskingPolicyName
            self.dataMaskingRuleName = dataMaskingRuleName
            self.parameters = parameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataMaskingPolicies/{dataMaskingPolicyName}/rules/{dataMaskingRuleName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{serverName}"] = String(describing: self.serverName)
            self.pathParameters["{databaseName}"] = String(describing: self.databaseName)
            self.pathParameters["{dataMaskingPolicyName}"] = String(describing: self.dataMaskingPolicyName)
            self.pathParameters["{dataMaskingRuleName}"] = String(describing: self.dataMaskingRuleName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? DataMaskingRuleData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(DataMaskingRuleData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (DataMaskingRuleProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: DataMaskingRuleData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
