import Foundation
import azureSwiftRuntime
public protocol PartnersCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var integrationAccountName : String { get set }
    var partnerName : String { get set }
    var apiVersion : String { get set }
    var partner :  IntegrationAccountPartnerProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (IntegrationAccountPartnerProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Partners {
// CreateOrUpdate creates or updates an integration account partner.
internal class CreateOrUpdateCommand : BaseCommand, PartnersCreateOrUpdate {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var integrationAccountName : String
    public var partnerName : String
    public var apiVersion = "2016-06-01"
    public var partner :  IntegrationAccountPartnerProtocol?

    public init(subscriptionId: String, resourceGroupName: String, integrationAccountName: String, partnerName: String, partner: IntegrationAccountPartnerProtocol) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.integrationAccountName = integrationAccountName
        self.partnerName = partnerName
        self.partner = partner
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/integrationAccounts/{integrationAccountName}/partners/{partnerName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{integrationAccountName}"] = String(describing: self.integrationAccountName)
        self.pathParameters["{partnerName}"] = String(describing: self.partnerName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = partner
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(partner)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(IntegrationAccountPartnerData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (IntegrationAccountPartnerProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: IntegrationAccountPartnerData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
