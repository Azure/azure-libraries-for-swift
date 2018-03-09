import Foundation
import azureSwiftRuntime
public protocol CertificatesCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var resourceName : String { get set }
    var certificateName : String { get set }
    var apiVersion : String { get set }
    var ifMatch : String? { get set }
    var certificateDescription :  CertificateBodyDescriptionProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (CertificateDescriptionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Certificates {
// CreateOrUpdate adds new or replaces existing certificate.
    internal class CreateOrUpdateCommand : BaseCommand, CertificatesCreateOrUpdate {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var resourceName : String
        public var certificateName : String
        public var apiVersion = "2017-07-01"
        public var ifMatch : String?
    public var certificateDescription :  CertificateBodyDescriptionProtocol?

        public init(subscriptionId: String, resourceGroupName: String, resourceName: String, certificateName: String, certificateDescription: CertificateBodyDescriptionProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.resourceName = resourceName
            self.certificateName = certificateName
            self.certificateDescription = certificateDescription
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/certificates/{certificateName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{resourceName}"] = String(describing: self.resourceName)
            self.pathParameters["{certificateName}"] = String(describing: self.certificateName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            if self.ifMatch != nil { headerParameters["If-Match"] = String(describing: self.ifMatch!) }
            self.body = certificateDescription

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(certificateDescription as? CertificateBodyDescriptionData)
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
