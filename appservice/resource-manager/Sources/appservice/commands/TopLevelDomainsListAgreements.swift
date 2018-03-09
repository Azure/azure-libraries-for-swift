import Foundation
import azureSwiftRuntime
public protocol TopLevelDomainsListAgreements  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var name : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var agreementOption :  TopLevelDomainAgreementOptionProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (TldLegalAgreementCollectionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.TopLevelDomains {
// ListAgreements gets all legal agreements that user needs to accept before purchasing a domain.
    internal class ListAgreementsCommand : BaseCommand, TopLevelDomainsListAgreements {
        var nextLink: String?
        public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
        public var name : String
        public var subscriptionId : String
        public var apiVersion = "2015-04-01"
    public var agreementOption :  TopLevelDomainAgreementOptionProtocol?

        public init(name: String, subscriptionId: String, agreementOption: TopLevelDomainAgreementOptionProtocol) {
            self.name = name
            self.subscriptionId = subscriptionId
            self.agreementOption = agreementOption
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.DomainRegistration/topLevelDomains/{name}/listAgreements"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = agreementOption

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(agreementOption as? TopLevelDomainAgreementOptionData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                if var pageDecoder = decoder as? PageDecoder {
                    pageDecoder.isPagedData = true
                    pageDecoder.nextLinkName = "NextLink"
                }
                let result = try decoder.decode(TldLegalAgreementCollectionData?.self, from: data)
                if var pageDecoder = decoder as? PageDecoder {
                    self.nextLink = pageDecoder.nextLink
                }
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (TldLegalAgreementCollectionProtocol?, Error?) -> Void) -> Void {
            if self.nextLink != nil {
                self.path = nextLink!
                self.nextLink = nil;
                self.pathType = .absolute
            }
            client.executeAsync(command: self) {
                (result: TldLegalAgreementCollectionData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
