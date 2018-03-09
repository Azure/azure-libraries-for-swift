import Foundation
import azureSwiftRuntime
public protocol DataMaskingPoliciesCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var databaseName : String { get set }
    var dataMaskingPolicyName : String { get set }
    var apiVersion : String { get set }
    var parameters :  DataMaskingPolicyProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (DataMaskingPolicyProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.DataMaskingPolicies {
// CreateOrUpdate creates or updates a database data masking policy
    internal class CreateOrUpdateCommand : BaseCommand, DataMaskingPoliciesCreateOrUpdate {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var serverName : String
        public var databaseName : String
        public var dataMaskingPolicyName : String
        public var apiVersion = "2014-04-01"
    public var parameters :  DataMaskingPolicyProtocol?

        public init(subscriptionId: String, resourceGroupName: String, serverName: String, databaseName: String, dataMaskingPolicyName: String, parameters: DataMaskingPolicyProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.serverName = serverName
            self.databaseName = databaseName
            self.dataMaskingPolicyName = dataMaskingPolicyName
            self.parameters = parameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataMaskingPolicies/{dataMaskingPolicyName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{serverName}"] = String(describing: self.serverName)
            self.pathParameters["{databaseName}"] = String(describing: self.databaseName)
            self.pathParameters["{dataMaskingPolicyName}"] = String(describing: self.dataMaskingPolicyName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? DataMaskingPolicyData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(DataMaskingPolicyData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (DataMaskingPolicyProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: DataMaskingPolicyData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
