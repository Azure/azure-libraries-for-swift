import Foundation
import azureSwiftRuntime
public protocol ApplicationGet  {
    var headerParameters: [String: String] { get set }
    var applicationId : String { get set }
    var timeout : Int32? { get set }
    var apiVersion : String { get set }
    var clientRequestId : String? { get set }
    var returnClientRequestId : Bool? { get set }
    var ocpDate : Date? { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ApplicationSummaryProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Application {
// Get this operation returns only applications and versions that are available for use on compute nodes; that is, that
// can be used in an application package reference. For administrator information about applications and versions that
// are not yet available to compute nodes, use the Azure portal or the Azure Resource Manager API.
    internal class GetCommand : BaseCommand, ApplicationGet {
        public var applicationId : String
        public var timeout : Int32?
        public var apiVersion = "2017-09-01.6.0"
        public var clientRequestId : String?
        public var returnClientRequestId : Bool?
        public var ocpDate : Date?

        public init(applicationId: String) {
            self.applicationId = applicationId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/applications/{applicationId}"
            self.headerParameters = ["Content-Type":"application/json; odata=minimalmetadata; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{applicationId}"] = String(describing: self.applicationId)
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
                let result = try decoder.decode(ApplicationSummaryData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ApplicationSummaryProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: ApplicationSummaryData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
