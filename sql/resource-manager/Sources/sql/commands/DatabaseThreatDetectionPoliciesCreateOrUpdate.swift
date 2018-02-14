import Foundation
import azureSwiftRuntime
public protocol DatabaseThreatDetectionPoliciesCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var databaseName : String { get set }
    var securityAlertPolicyName : String { get set }
    var apiVersion : String { get set }
    var parameters :  DatabaseSecurityAlertPolicyProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (DatabaseSecurityAlertPolicyProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.DatabaseThreatDetectionPolicies {
// CreateOrUpdate creates or updates a database's threat detection policy.
internal class CreateOrUpdateCommand : BaseCommand, DatabaseThreatDetectionPoliciesCreateOrUpdate {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var serverName : String
    public var databaseName : String
    public var securityAlertPolicyName : String
    public var apiVersion = "2014-04-01"
    public var parameters :  DatabaseSecurityAlertPolicyProtocol?

    public init(subscriptionId: String, resourceGroupName: String, serverName: String, databaseName: String, securityAlertPolicyName: String, parameters: DatabaseSecurityAlertPolicyProtocol) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.serverName = serverName
        self.databaseName = databaseName
        self.securityAlertPolicyName = securityAlertPolicyName
        self.parameters = parameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/securityAlertPolicies/{securityAlertPolicyName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{serverName}"] = String(describing: self.serverName)
        self.pathParameters["{databaseName}"] = String(describing: self.databaseName)
        self.pathParameters["{securityAlertPolicyName}"] = String(describing: self.securityAlertPolicyName)
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
            let result = try decoder.decode(DatabaseSecurityAlertPolicyData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (DatabaseSecurityAlertPolicyProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: DatabaseSecurityAlertPolicyData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
