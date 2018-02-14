import Foundation
import azureSwiftRuntime
public protocol CertificateCancelDeletion  {
    var headerParameters: [String: String] { get set }
    var thumbprintAlgorithm : String { get set }
    var thumbprint : String { get set }
    var timeout : Int32? { get set }
    var apiVersion : String { get set }
    var clientRequestId : String? { get set }
    var returnClientRequestId : Bool? { get set }
    var ocpDate : Date? { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Certificate {
// CancelDeletion if you try to delete a certificate that is being used by a pool or compute node, the status of the
// certificate changes to deleteFailed. If you decide that you want to continue using the certificate, you can use this
// operation to set the status of the certificate back to active. If you intend to delete the certificate, you do not
// need to run this operation after the deletion failed. You must make sure that the certificate is not being used by
// any resources, and then you can try again to delete the certificate.
internal class CancelDeletionCommand : BaseCommand, CertificateCancelDeletion {
    public var thumbprintAlgorithm : String
    public var thumbprint : String
    public var timeout : Int32?
    public var apiVersion = "2017-09-01.6.0"
    public var clientRequestId : String?
    public var returnClientRequestId : Bool?
    public var ocpDate : Date?

    public init(thumbprintAlgorithm: String, thumbprint: String) {
        self.thumbprintAlgorithm = thumbprintAlgorithm
        self.thumbprint = thumbprint
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/certificates(thumbprintAlgorithm={thumbprintAlgorithm},thumbprint={thumbprint})/canceldelete"
        self.headerParameters = ["Content-Type":"application/json; odata=minimalmetadata; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{thumbprintAlgorithm}"] = String(describing: self.thumbprintAlgorithm)
        self.pathParameters["{thumbprint}"] = String(describing: self.thumbprint)
        if self.timeout != nil { queryParameters["timeout"] = String(describing: self.timeout!) }
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
        if self.clientRequestId != nil { headerParameters["client-request-id"] = String(describing: self.clientRequestId!) }
        if self.returnClientRequestId != nil { headerParameters["return-client-request-id"] = String(describing: self.returnClientRequestId!) }
        if self.ocpDate != nil { headerParameters["ocp-date"] = String(describing: self.ocpDate!) }
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
