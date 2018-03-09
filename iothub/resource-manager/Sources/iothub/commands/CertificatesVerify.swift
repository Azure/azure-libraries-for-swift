import Foundation
import azureSwiftRuntime
public protocol CertificatesVerify  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var resourceName : String { get set }
    var certificateName : String { get set }
    var apiVersion : String { get set }
    var ifMatch : String { get set }
    var certificateVerificationBody :  CertificateVerificationDescriptionProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (CertificateDescriptionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Certificates {
// Verify verifies the certificate's private key possession by providing the leaf cert issued by the verifying pre
// uploaded certificate.
    internal class VerifyCommand : BaseCommand, CertificatesVerify {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var resourceName : String
        public var certificateName : String
        public var apiVersion = "2017-07-01"
        public var ifMatch : String
    public var certificateVerificationBody :  CertificateVerificationDescriptionProtocol?

        public init(subscriptionId: String, resourceGroupName: String, resourceName: String, certificateName: String, ifMatch: String, certificateVerificationBody: CertificateVerificationDescriptionProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.resourceName = resourceName
            self.certificateName = certificateName
            self.ifMatch = ifMatch
            self.certificateVerificationBody = certificateVerificationBody
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/certificates/{certificateName}/verify"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{resourceName}"] = String(describing: self.resourceName)
            self.pathParameters["{certificateName}"] = String(describing: self.certificateName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.headerParameters["If-Match"] = String(describing: self.ifMatch)
            self.body = certificateVerificationBody

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(certificateVerificationBody as? CertificateVerificationDescriptionData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(CertificateDescriptionData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (CertificateDescriptionProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: CertificateDescriptionData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
