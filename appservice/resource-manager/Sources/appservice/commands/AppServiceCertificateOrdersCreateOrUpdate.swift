import Foundation
import azureSwiftRuntime
public protocol AppServiceCertificateOrdersCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var certificateOrderName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var certificateDistinguishedName :  AppServiceCertificateOrderProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (AppServiceCertificateOrderProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.AppServiceCertificateOrders {
// CreateOrUpdate create or update a certificate purchase order. This method may poll for completion. Polling can be
// canceled by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
internal class CreateOrUpdateCommand : BaseCommand, AppServiceCertificateOrdersCreateOrUpdate {
    public var resourceGroupName : String
    public var certificateOrderName : String
    public var subscriptionId : String
    public var apiVersion = "2015-08-01"
    public var certificateDistinguishedName :  AppServiceCertificateOrderProtocol?

    public init(resourceGroupName: String, certificateOrderName: String, subscriptionId: String, certificateDistinguishedName: AppServiceCertificateOrderProtocol) {
        self.resourceGroupName = resourceGroupName
        self.certificateOrderName = certificateOrderName
        self.subscriptionId = subscriptionId
        self.certificateDistinguishedName = certificateDistinguishedName
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
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
        client.executeAsyncLRO(command: self) {
            (result: AppServiceCertificateOrderData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
