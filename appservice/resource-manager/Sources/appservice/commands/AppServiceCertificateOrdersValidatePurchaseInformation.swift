import Foundation
import azureSwiftRuntime
public protocol AppServiceCertificateOrdersValidatePurchaseInformation  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var appServiceCertificateOrder :  AppServiceCertificateOrderProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.AppServiceCertificateOrders {
// ValidatePurchaseInformation validate information for a certificate order.
internal class ValidatePurchaseInformationCommand : BaseCommand, AppServiceCertificateOrdersValidatePurchaseInformation {
    public var subscriptionId : String
    public var apiVersion = "2015-08-01"
    public var appServiceCertificateOrder :  AppServiceCertificateOrderProtocol?

    public init(subscriptionId: String, appServiceCertificateOrder: AppServiceCertificateOrderProtocol) {
        self.subscriptionId = subscriptionId
        self.appServiceCertificateOrder = appServiceCertificateOrder
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.CertificateRegistration/validateCertificateRegistrationInformation"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = appServiceCertificateOrder
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(appServiceCertificateOrder)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (error) in
            completionHandler(error)
        }
    }
}
}
