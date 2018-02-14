import Foundation
import azureSwiftRuntime
public protocol CertificateCancelDeletion  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var accountName : String { get set }
    var certificateName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (CertificateProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Certificate {
// CancelDeletion if you try to delete a certificate that is being used by a pool or compute node, the status of the
// certificate changes to deleteFailed. If you decide that you want to continue using the certificate, you can use this
// operation to set the status of the certificate back to active. If you intend to delete the certificate, you do not
// need to run this operation after the deletion failed. You must make sure that the certificate is not being used by
// any resources, and then you can try again to delete the certificate.
internal class CancelDeletionCommand : BaseCommand, CertificateCancelDeletion {
    public var resourceGroupName : String
    public var accountName : String
    public var certificateName : String
    public var subscriptionId : String
    public var apiVersion = "2017-09-01"

    public init(resourceGroupName: String, accountName: String, certificateName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.accountName = accountName
        self.certificateName = certificateName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}/certificates/{certificateName}/cancelDelete"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{accountName}"] = String(describing: self.accountName)
        self.pathParameters["{certificateName}"] = String(describing: self.certificateName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
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
