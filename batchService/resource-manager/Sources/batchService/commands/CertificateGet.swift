import Foundation
import azureSwiftRuntime
public protocol CertificateGet  {
    var headerParameters: [String: String] { get set }
    var thumbprintAlgorithm : String { get set }
    var thumbprint : String { get set }
    var select : String? { get set }
    var timeout : Int32? { get set }
    var apiVersion : String { get set }
    var clientRequestId : String? { get set }
    var returnClientRequestId : Bool? { get set }
    var ocpDate : Date? { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (CertificateProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Certificate {
// Get gets information about the specified certificate.
    internal class GetCommand : BaseCommand, CertificateGet {
        public var thumbprintAlgorithm : String
        public var thumbprint : String
        public var select : String?
        public var timeout : Int32?
        public var apiVersion = "2017-09-01.6.0"
        public var clientRequestId : String?
        public var returnClientRequestId : Bool?
        public var ocpDate : Date?

        public init(thumbprintAlgorithm: String, thumbprint: String) {
            self.thumbprintAlgorithm = thumbprintAlgorithm
            self.thumbprint = thumbprint
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/certificates(thumbprintAlgorithm={thumbprintAlgorithm},thumbprint={thumbprint})"
            self.headerParameters = ["Content-Type":"application/json; odata=minimalmetadata; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{thumbprintAlgorithm}"] = String(describing: self.thumbprintAlgorithm)
            self.pathParameters["{thumbprint}"] = String(describing: self.thumbprint)
            if self.select != nil { queryParameters["$select"] = String(describing: self.select!) }
            if self.timeout != nil { queryParameters["timeout"] = String(describing: self.timeout!) }
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            if self.clientRequestId != nil { headerParameters["client-request-id"] = String(describing: self.clientRequestId!) }
            if self.returnClientRequestId != nil { headerParameters["return-client-request-id"] = String(describing: self.returnClientRequestId!) }
            if self.ocpDate != nil { headerParameters["ocp-date"] = String(describing: self.ocpDate!) }

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
