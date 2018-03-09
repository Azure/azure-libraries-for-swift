import Foundation
import azureSwiftRuntime
public protocol CertificateDelete  {
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
// Delete you cannot delete a certificate if a resource (pool or compute node) is using it. Before you can delete a
// certificate, you must therefore make sure that the certificate is not associated with any existing pools, the
// certificate is not installed on any compute nodes (even if you remove a certificate from a pool, it is not removed
// from existing compute nodes in that pool until they restart), and no running tasks depend on the certificate. If you
// try to delete a certificate that is in use, the deletion fails. The certificate status changes to deleteFailed. You
// can use Cancel Delete Certificate to set the status back to active if you decide that you want to continue using the
// certificate.
    internal class DeleteCommand : BaseCommand, CertificateDelete {
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
            self.method = "Delete"
            self.isLongRunningOperation = false
            self.path = "/certificates(thumbprintAlgorithm={thumbprintAlgorithm},thumbprint={thumbprint})"
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
