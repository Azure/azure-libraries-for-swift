import Foundation
import azureSwiftRuntime
public protocol DomainsCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var domainName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var domain :  DomainProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (DomainProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Domains {
// CreateOrUpdate creates or updates a domain. This method may poll for completion. Polling can be canceled by passing
// the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
    internal class CreateOrUpdateCommand : BaseCommand, DomainsCreateOrUpdate {
        public var resourceGroupName : String
        public var domainName : String
        public var subscriptionId : String
        public var apiVersion = "2015-04-01"
    public var domain :  DomainProtocol?

        public init(resourceGroupName: String, domainName: String, subscriptionId: String, domain: DomainProtocol) {
            self.resourceGroupName = resourceGroupName
            self.domainName = domainName
            self.subscriptionId = subscriptionId
            self.domain = domain
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DomainRegistration/domains/{domainName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{domainName}"] = String(describing: self.domainName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = domain

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(domain as? DomainData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
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
            client.executeAsyncLRO(command: self) {
                (result: DomainData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
