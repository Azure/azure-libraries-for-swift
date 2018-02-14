import Foundation
import azureSwiftRuntime
public protocol CertificatesCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var integrationAccountName : String { get set }
    var certificateName : String { get set }
    var apiVersion : String { get set }
    var certificate :  IntegrationAccountCertificateProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (IntegrationAccountCertificateProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Certificates {
// CreateOrUpdate creates or updates an integration account certificate.
internal class CreateOrUpdateCommand : BaseCommand, CertificatesCreateOrUpdate {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var integrationAccountName : String
    public var certificateName : String
    public var apiVersion = "2016-06-01"
    public var certificate :  IntegrationAccountCertificateProtocol?

    public init(subscriptionId: String, resourceGroupName: String, integrationAccountName: String, certificateName: String, certificate: IntegrationAccountCertificateProtocol) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.integrationAccountName = integrationAccountName
        self.certificateName = certificateName
        self.certificate = certificate
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/integrationAccounts/{integrationAccountName}/certificates/{certificateName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{integrationAccountName}"] = String(describing: self.integrationAccountName)
        self.pathParameters["{certificateName}"] = String(describing: self.certificateName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = certificate
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(certificate)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(IntegrationAccountCertificateData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (IntegrationAccountCertificateProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: IntegrationAccountCertificateData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
