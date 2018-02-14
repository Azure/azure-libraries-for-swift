import Foundation
import azureSwiftRuntime
public protocol CertificatesUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var certificateEnvelope :  CertificatePatchResourceProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (CertificateProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Certificates {
// Update create or update a certificate.
internal class UpdateCommand : BaseCommand, CertificatesUpdate {
    public var resourceGroupName : String
    public var name : String
    public var subscriptionId : String
    public var apiVersion = "2016-03-01"
    public var certificateEnvelope :  CertificatePatchResourceProtocol?

    public init(resourceGroupName: String, name: String, subscriptionId: String, certificateEnvelope: CertificatePatchResourceProtocol) {
        self.resourceGroupName = resourceGroupName
        self.name = name
        self.subscriptionId = subscriptionId
        self.certificateEnvelope = certificateEnvelope
        super.init()
        self.method = "Patch"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/certificates/{name}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{name}"] = String(describing: self.name)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = certificateEnvelope
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(certificateEnvelope)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(CertificateData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (CertificateProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: CertificateData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
