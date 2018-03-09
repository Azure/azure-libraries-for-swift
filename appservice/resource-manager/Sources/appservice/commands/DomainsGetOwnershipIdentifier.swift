import Foundation
import azureSwiftRuntime
public protocol DomainsGetOwnershipIdentifier  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var domainName : String { get set }
    var name : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (DomainOwnershipIdentifierProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Domains {
// GetOwnershipIdentifier get ownership identifier for domain
    internal class GetOwnershipIdentifierCommand : BaseCommand, DomainsGetOwnershipIdentifier {
        public var resourceGroupName : String
        public var domainName : String
        public var name : String
        public var subscriptionId : String
        public var apiVersion = "2015-04-01"

        public init(resourceGroupName: String, domainName: String, name: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.domainName = domainName
            self.name = name
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DomainRegistration/domains/{domainName}/domainOwnershipIdentifiers/{name}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{domainName}"] = String(describing: self.domainName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(DomainOwnershipIdentifierData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (DomainOwnershipIdentifierProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: DomainOwnershipIdentifierData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
