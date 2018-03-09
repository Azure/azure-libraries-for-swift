import Foundation
import azureSwiftRuntime
public protocol ServicePrincipalsCreate  {
    var headerParameters: [String: String] { get set }
    var tenantID : String { get set }
    var apiVersion : String { get set }
    var parameters :  ServicePrincipalCreateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ServicePrincipalProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ServicePrincipals {
// Create creates a service principal in the directory.
    internal class CreateCommand : BaseCommand, ServicePrincipalsCreate {
        public var tenantID : String
        public var apiVersion = "1.6"
    public var parameters :  ServicePrincipalCreateParametersProtocol?

        public init(tenantID: String, parameters: ServicePrincipalCreateParametersProtocol) {
            self.tenantID = tenantID
            self.parameters = parameters
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/{tenantID}/servicePrincipals"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{tenantID}"] = String(describing: self.tenantID)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? ServicePrincipalCreateParametersData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
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
