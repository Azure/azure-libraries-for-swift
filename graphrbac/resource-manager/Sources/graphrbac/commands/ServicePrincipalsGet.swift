import Foundation
import azureSwiftRuntime
public protocol ServicePrincipalsGet  {
    var headerParameters: [String: String] { get set }
    var objectId : String { get set }
    var tenantID : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ServicePrincipalProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ServicePrincipals {
// Get gets service principal information from the directory.
    internal class GetCommand : BaseCommand, ServicePrincipalsGet {
        public var objectId : String
        public var tenantID : String
        public var apiVersion = "1.6"

        public init(objectId: String, tenantID: String) {
            self.objectId = objectId
            self.tenantID = tenantID
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/{tenantID}/servicePrincipals/{objectId}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{objectId}"] = String(describing: self.objectId)
            self.pathParameters["{tenantID}"] = String(describing: self.tenantID)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ServicePrincipalData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ServicePrincipalProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: ServicePrincipalData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
