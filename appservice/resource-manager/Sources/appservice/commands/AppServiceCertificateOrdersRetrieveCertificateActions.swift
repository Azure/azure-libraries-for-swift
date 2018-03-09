import Foundation
import azureSwiftRuntime
public protocol AppServiceCertificateOrdersRetrieveCertificateActions  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping ([CertificateOrderActionProtocol?]?, Error?) -> Void) -> Void ;
}

extension Commands.AppServiceCertificateOrders {
// RetrieveCertificateActions retrieve the list of certificate actions.
    internal class RetrieveCertificateActionsCommand : BaseCommand, AppServiceCertificateOrdersRetrieveCertificateActions {
        public var resourceGroupName : String
        public var name : String
        public var subscriptionId : String
        public var apiVersion = "2015-08-01"

        public init(resourceGroupName: String, name: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CertificateRegistration/certificateOrders/{name}/retrieveCertificateActions"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode([CertificateOrderActionData?]?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping ([CertificateOrderActionProtocol?]?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: [CertificateOrderActionData?]?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
