import Foundation
import azureSwiftRuntime
public protocol VaultCertificatesCreate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var vaultName : String { get set }
    var certificateName : String { get set }
    var apiVersion : String { get set }
    var certificateRequest :  CertificateRequestProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (VaultCertificateResponseProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.VaultCertificates {
// Create uploads a certificate for a resource.
internal class CreateCommand : BaseCommand, VaultCertificatesCreate {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var vaultName : String
    public var certificateName : String
    public var apiVersion = "2016-06-01"
    public var certificateRequest :  CertificateRequestProtocol?

    public init(subscriptionId: String, resourceGroupName: String, vaultName: String, certificateName: String, certificateRequest: CertificateRequestProtocol) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.vaultName = vaultName
        self.certificateName = certificateName
        self.certificateRequest = certificateRequest
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/certificates/{certificateName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{vaultName}"] = String(describing: self.vaultName)
        self.pathParameters["{certificateName}"] = String(describing: self.certificateName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = certificateRequest
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(certificateRequest)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(VaultCertificateResponseData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (VaultCertificateResponseProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: VaultCertificateResponseData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
