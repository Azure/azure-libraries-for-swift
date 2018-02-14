import Foundation
import azureSwiftRuntime
public protocol WebAppsCreateOrUpdatePublicCertificate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var publicCertificateName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var publicCertificate :  PublicCertificateProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (PublicCertificateProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WebApps {
// CreateOrUpdatePublicCertificate creates a hostname binding for an app.
internal class CreateOrUpdatePublicCertificateCommand : BaseCommand, WebAppsCreateOrUpdatePublicCertificate {
    public var resourceGroupName : String
    public var name : String
    public var publicCertificateName : String
    public var subscriptionId : String
    public var apiVersion = "2016-08-01"
    public var publicCertificate :  PublicCertificateProtocol?

    public init(resourceGroupName: String, name: String, publicCertificateName: String, subscriptionId: String, publicCertificate: PublicCertificateProtocol) {
        self.resourceGroupName = resourceGroupName
        self.name = name
        self.publicCertificateName = publicCertificateName
        self.subscriptionId = subscriptionId
        self.publicCertificate = publicCertificate
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/publicCertificates/{publicCertificateName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{name}"] = String(describing: self.name)
        self.pathParameters["{publicCertificateName}"] = String(describing: self.publicCertificateName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = publicCertificate
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(publicCertificate)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
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
