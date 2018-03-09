import Foundation
import azureSwiftRuntime
public protocol AppServiceCertificateOrdersRenew  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var certificateOrderName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var renewCertificateOrderRequest :  RenewCertificateOrderRequestProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.AppServiceCertificateOrders {
// Renew renew an existing certificate order.
    internal class RenewCommand : BaseCommand, AppServiceCertificateOrdersRenew {
        public var resourceGroupName : String
        public var certificateOrderName : String
        public var subscriptionId : String
        public var apiVersion = "2015-08-01"
    public var renewCertificateOrderRequest :  RenewCertificateOrderRequestProtocol?

        public init(resourceGroupName: String, certificateOrderName: String, subscriptionId: String, renewCertificateOrderRequest: RenewCertificateOrderRequestProtocol) {
            self.resourceGroupName = resourceGroupName
            self.certificateOrderName = certificateOrderName
            self.subscriptionId = subscriptionId
            self.renewCertificateOrderRequest = renewCertificateOrderRequest
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CertificateRegistration/certificateOrders/{certificateOrderName}/renew"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{certificateOrderName}"] = String(describing: self.certificateOrderName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = renewCertificateOrderRequest

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(renewCertificateOrderRequest as? RenewCertificateOrderRequestData)
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
