import Foundation
import azureSwiftRuntime
public protocol AppServiceCertificateOrdersUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var certificateOrderName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var certificateDistinguishedName :  AppServiceCertificateOrderPatchResourceProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (AppServiceCertificateOrderProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.AppServiceCertificateOrders {
// Update create or update a certificate purchase order.
internal class UpdateCommand : BaseCommand, AppServiceCertificateOrdersUpdate {
    public var resourceGroupName : String
    public var certificateOrderName : String
    public var subscriptionId : String
    public var apiVersion = "2015-08-01"
    public var certificateDistinguishedName :  AppServiceCertificateOrderPatchResourceProtocol?

    public init(resourceGroupName: String, certificateOrderName: String, subscriptionId: String, certificateDistinguishedName: AppServiceCertificateOrderPatchResourceProtocol) {
        self.resourceGroupName = resourceGroupName
        self.certificateOrderName = certificateOrderName
        self.subscriptionId = subscriptionId
        self.certificateDistinguishedName = certificateDistinguishedName
        super.init()
        self.method = "Patch"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CertificateRegistration/certificateOrders/{certificateOrderName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{certificateOrderName}"] = String(describing: self.certificateOrderName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = certificateDistinguishedName
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(certificateDistinguishedName)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(AppServiceCertificateOrderData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (AppServiceCertificateOrderProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: AppServiceCertificateOrderData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
