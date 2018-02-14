import Foundation
import azureSwiftRuntime
public protocol AppServiceCertificateOrdersRetrieveSiteSeal  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var certificateOrderName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var siteSealRequest :  SiteSealRequestProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (SiteSealProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.AppServiceCertificateOrders {
// RetrieveSiteSeal verify domain ownership for this certificate order.
internal class RetrieveSiteSealCommand : BaseCommand, AppServiceCertificateOrdersRetrieveSiteSeal {
    public var resourceGroupName : String
    public var certificateOrderName : String
    public var subscriptionId : String
    public var apiVersion = "2015-08-01"
    public var siteSealRequest :  SiteSealRequestProtocol?

    public init(resourceGroupName: String, certificateOrderName: String, subscriptionId: String, siteSealRequest: SiteSealRequestProtocol) {
        self.resourceGroupName = resourceGroupName
        self.certificateOrderName = certificateOrderName
        self.subscriptionId = subscriptionId
        self.siteSealRequest = siteSealRequest
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CertificateRegistration/certificateOrders/{certificateOrderName}/retrieveSiteSeal"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{certificateOrderName}"] = String(describing: self.certificateOrderName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = siteSealRequest
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(siteSealRequest)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(SiteSealData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (SiteSealProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: SiteSealData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
