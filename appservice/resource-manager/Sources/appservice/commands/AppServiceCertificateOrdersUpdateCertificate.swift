import Foundation
import azureSwiftRuntime
public protocol AppServiceCertificateOrdersUpdateCertificate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var certificateOrderName : String { get set }
    var name : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var keyVaultCertificate :  AppServiceCertificatePatchResourceProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (AppServiceCertificateResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.AppServiceCertificateOrders {
// UpdateCertificate creates or updates a certificate and associates with key vault secret.
    internal class UpdateCertificateCommand : BaseCommand, AppServiceCertificateOrdersUpdateCertificate {
        public var resourceGroupName : String
        public var certificateOrderName : String
        public var name : String
        public var subscriptionId : String
        public var apiVersion = "2015-08-01"
    public var keyVaultCertificate :  AppServiceCertificatePatchResourceProtocol?

        public init(resourceGroupName: String, certificateOrderName: String, name: String, subscriptionId: String, keyVaultCertificate: AppServiceCertificatePatchResourceProtocol) {
            self.resourceGroupName = resourceGroupName
            self.certificateOrderName = certificateOrderName
            self.name = name
            self.subscriptionId = subscriptionId
            self.keyVaultCertificate = keyVaultCertificate
            super.init()
            self.method = "Patch"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CertificateRegistration/certificateOrders/{certificateOrderName}/certificates/{name}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{certificateOrderName}"] = String(describing: self.certificateOrderName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = keyVaultCertificate

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(keyVaultCertificate as? AppServiceCertificatePatchResourceData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(AppServiceCertificateResourceData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (AppServiceCertificateResourceProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: AppServiceCertificateResourceData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
