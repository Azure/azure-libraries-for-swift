import Foundation
import azureSwiftRuntime
public protocol CertificateUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var accountName : String { get set }
    var certificateName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var ifMatch : String? { get set }
    var parameters :  CertificateCreateOrUpdateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (CertificateProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Certificate {
// Update updates the properties of an existing certificate.
internal class UpdateCommand : BaseCommand, CertificateUpdate {
    public var resourceGroupName : String
    public var accountName : String
    public var certificateName : String
    public var subscriptionId : String
    public var apiVersion = "2017-09-01"
    public var ifMatch : String?
    public var parameters :  CertificateCreateOrUpdateParametersProtocol?

    public init(resourceGroupName: String, accountName: String, certificateName: String, subscriptionId: String, parameters: CertificateCreateOrUpdateParametersProtocol) {
        self.resourceGroupName = resourceGroupName
        self.accountName = accountName
        self.certificateName = certificateName
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Patch"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}/certificates/{certificateName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{accountName}"] = String(describing: self.accountName)
        self.pathParameters["{certificateName}"] = String(describing: self.certificateName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
        if self.ifMatch != nil { headerParameters["If-Match"] = String(describing: self.ifMatch!) }
    self.body = parameters
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(parameters)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(CertificateData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (CertificateProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: CertificateData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
