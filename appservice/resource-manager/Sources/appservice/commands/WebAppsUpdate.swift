import Foundation
import azureSwiftRuntime
public protocol WebAppsUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var subscriptionId : String { get set }
    var skipDnsRegistration : Bool? { get set }
    var skipCustomDomainVerification : Bool? { get set }
    var forceDnsRegistration : Bool? { get set }
    var ttlInSeconds : String? { get set }
    var apiVersion : String { get set }
    var siteEnvelope :  SitePatchResourceProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (SiteProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WebApps {
// Update creates a new web, mobile, or API app in an existing resource group, or updates an existing app.
    internal class UpdateCommand : BaseCommand, WebAppsUpdate {
        public var resourceGroupName : String
        public var name : String
        public var subscriptionId : String
        public var skipDnsRegistration : Bool?
        public var skipCustomDomainVerification : Bool?
        public var forceDnsRegistration : Bool?
        public var ttlInSeconds : String?
        public var apiVersion = "2016-08-01"
    public var siteEnvelope :  SitePatchResourceProtocol?

        public init(resourceGroupName: String, name: String, subscriptionId: String, siteEnvelope: SitePatchResourceProtocol) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.subscriptionId = subscriptionId
            self.siteEnvelope = siteEnvelope
            super.init()
            self.method = "Patch"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
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
                let encodedValue = try encoder.encode(siteEnvelope as? SitePatchResourceData)
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
            client.executeAsync(command: self) {
                (result: SiteData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
