import Foundation
import azureSwiftRuntime
public protocol WebAppsCreateOrUpdateDomainOwnershipIdentifierSlot  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var domainOwnershipIdentifierName : String { get set }
    var slot : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var domainOwnershipIdentifier :  IdentifierProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (IdentifierProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WebApps {
// CreateOrUpdateDomainOwnershipIdentifierSlot creates a domain ownership identifier for web app, or updates an
// existing ownership identifier.
    internal class CreateOrUpdateDomainOwnershipIdentifierSlotCommand : BaseCommand, WebAppsCreateOrUpdateDomainOwnershipIdentifierSlot {
        public var resourceGroupName : String
        public var name : String
        public var domainOwnershipIdentifierName : String
        public var slot : String
        public var subscriptionId : String
        public var apiVersion = "2016-08-01"
    public var domainOwnershipIdentifier :  IdentifierProtocol?

        public init(resourceGroupName: String, name: String, domainOwnershipIdentifierName: String, slot: String, subscriptionId: String, domainOwnershipIdentifier: IdentifierProtocol) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.domainOwnershipIdentifierName = domainOwnershipIdentifierName
            self.slot = slot
            self.subscriptionId = subscriptionId
            self.domainOwnershipIdentifier = domainOwnershipIdentifier
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/domainOwnershipIdentifiers/{domainOwnershipIdentifierName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{domainOwnershipIdentifierName}"] = String(describing: self.domainOwnershipIdentifierName)
            self.pathParameters["{slot}"] = String(describing: self.slot)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = domainOwnershipIdentifier

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(domainOwnershipIdentifier as? IdentifierData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(IdentifierData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (IdentifierProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: IdentifierData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
