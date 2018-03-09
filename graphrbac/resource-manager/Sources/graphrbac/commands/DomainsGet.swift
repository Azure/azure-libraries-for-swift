import Foundation
import azureSwiftRuntime
public protocol DomainsGet  {
    var headerParameters: [String: String] { get set }
    var domainName : String { get set }
    var tenantID : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (DomainProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Domains {
// Get gets a specific domain in the current tenant.
    internal class GetCommand : BaseCommand, DomainsGet {
        public var domainName : String
        public var tenantID : String
        public var apiVersion = "1.6"

        public init(domainName: String, tenantID: String) {
            self.domainName = domainName
            self.tenantID = tenantID
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/{tenantID}/domains/{domainName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{domainName}"] = String(describing: self.domainName)
            self.pathParameters["{tenantID}"] = String(describing: self.tenantID)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(DomainData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (DomainProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: DomainData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
