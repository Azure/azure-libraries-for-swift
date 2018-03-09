import Foundation
import azureSwiftRuntime
public protocol WebAppsCreateOrUpdateSlot  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var slot : String { get set }
    var subscriptionId : String { get set }
    var skipDnsRegistration : Bool? { get set }
    var skipCustomDomainVerification : Bool? { get set }
    var forceDnsRegistration : Bool? { get set }
    var ttlInSeconds : String? { get set }
    var apiVersion : String { get set }
    var siteEnvelope :  SiteProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (SiteProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WebApps {
// CreateOrUpdateSlot creates a new web, mobile, or API app in an existing resource group, or updates an existing app.
// This method may poll for completion. Polling can be canceled by passing the cancel channel argument. The channel
// will be used to cancel polling and any outstanding HTTP requests.
    internal class CreateOrUpdateSlotCommand : BaseCommand, WebAppsCreateOrUpdateSlot {
        public var resourceGroupName : String
        public var name : String
        public var slot : String
        public var subscriptionId : String
        public var skipDnsRegistration : Bool?
        public var skipCustomDomainVerification : Bool?
        public var forceDnsRegistration : Bool?
        public var ttlInSeconds : String?
        public var apiVersion = "2016-08-01"
    public var siteEnvelope :  SiteProtocol?

        public init(resourceGroupName: String, name: String, slot: String, subscriptionId: String, siteEnvelope: SiteProtocol) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.slot = slot
            self.subscriptionId = subscriptionId
            self.siteEnvelope = siteEnvelope
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{slot}"] = String(describing: self.slot)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            if self.skipDnsRegistration != nil { queryParameters["skipDnsRegistration"] = String(describing: self.skipDnsRegistration!) }
            if self.skipCustomDomainVerification != nil { queryParameters["skipCustomDomainVerification"] = String(describing: self.skipCustomDomainVerification!) }
            if self.forceDnsRegistration != nil { queryParameters["forceDnsRegistration"] = String(describing: self.forceDnsRegistration!) }
            if self.ttlInSeconds != nil { queryParameters["ttlInSeconds"] = String(describing: self.ttlInSeconds!) }
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = siteEnvelope

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(siteEnvelope as? SiteData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(SiteData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (SiteProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: SiteData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
