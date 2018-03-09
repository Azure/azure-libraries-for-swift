import Foundation
import azureSwiftRuntime
public protocol WebAppsGetPublicCertificateSlot  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var slot : String { get set }
    var publicCertificateName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (PublicCertificateProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WebApps {
// GetPublicCertificateSlot get the named public certificate for an app (or deployment slot, if specified).
    internal class GetPublicCertificateSlotCommand : BaseCommand, WebAppsGetPublicCertificateSlot {
        public var resourceGroupName : String
        public var name : String
        public var slot : String
        public var publicCertificateName : String
        public var subscriptionId : String
        public var apiVersion = "2016-08-01"

        public init(resourceGroupName: String, name: String, slot: String, publicCertificateName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.slot = slot
            self.publicCertificateName = publicCertificateName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/publicCertificates/{publicCertificateName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{slot}"] = String(describing: self.slot)
            self.pathParameters["{publicCertificateName}"] = String(describing: self.publicCertificateName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(PublicCertificateData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (PublicCertificateProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: PublicCertificateData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
