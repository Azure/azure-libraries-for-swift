import Foundation
import azureSwiftRuntime
public protocol CredentialCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var automationAccountName : String { get set }
    var credentialName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  CredentialCreateOrUpdateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (CredentialProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Credential {
// CreateOrUpdate create a credential.
internal class CreateOrUpdateCommand : BaseCommand, CredentialCreateOrUpdate {
    public var resourceGroupName : String
    public var automationAccountName : String
    public var credentialName : String
    public var subscriptionId : String
    public var apiVersion = "2015-10-31"
    public var parameters :  CredentialCreateOrUpdateParametersProtocol?

    public init(resourceGroupName: String, automationAccountName: String, credentialName: String, subscriptionId: String, parameters: CredentialCreateOrUpdateParametersProtocol) {
        self.resourceGroupName = resourceGroupName
        self.automationAccountName = automationAccountName
        self.credentialName = credentialName
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/credentials/{credentialName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{automationAccountName}"] = String(describing: self.automationAccountName)
        self.pathParameters["{credentialName}"] = String(describing: self.credentialName)
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
            let result = try decoder.decode(CredentialData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (CredentialProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: CredentialData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
