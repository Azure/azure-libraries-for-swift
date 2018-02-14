import Foundation
import azureSwiftRuntime
public protocol ServiceListSiteIdentifiersAssignedToHostName  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var nameIdentifier :  NameIdentifierProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (IdentifierCollectionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Service {
// ListSiteIdentifiersAssignedToHostName list all apps that are assigned to a hostname.
internal class ListSiteIdentifiersAssignedToHostNameCommand : BaseCommand, ServiceListSiteIdentifiersAssignedToHostName {
    var nextLink: String?
    public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
    public var subscriptionId : String
    public var apiVersion = "2016-03-01"
    public var nameIdentifier :  NameIdentifierProtocol?

    public init(subscriptionId: String, nameIdentifier: NameIdentifierProtocol) {
        self.subscriptionId = subscriptionId
        self.nameIdentifier = nameIdentifier
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Web/listSitesAssignedToHostName"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = nameIdentifier
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(nameIdentifier)
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
            let result = try decoder.decode(IdentifierCollectionData?.self, from: data)
            if var pageDecoder = decoder as? PageDecoder {
                self.nextLink = pageDecoder.nextLink
            }
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (IdentifierCollectionProtocol?, Error?) -> Void) -> Void {
        if self.nextLink != nil {
            self.path = nextLink!
            self.nextLink = nil;
            self.pathType = .absolute
        }
        client.executeAsync(command: self) {
            (result: IdentifierCollectionData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
