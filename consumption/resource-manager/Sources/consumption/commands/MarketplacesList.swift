import Foundation
import azureSwiftRuntime
public protocol MarketplacesList  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var filter : String? { get set }
    var top : Int32? { get set }
    var skiptoken : String? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (MarketplacesListResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Marketplaces {
// List lists the marketplaces for a scope by subscriptionId. Marketplaces are available via this API only for May 1,
// 2014 or later.
    internal class ListCommand : BaseCommand, MarketplacesList {
        var nextLink: String?
        public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
        public var subscriptionId : String
        public var filter : String?
        public var top : Int32?
        public var skiptoken : String?
        public var apiVersion = "2018-01-31"

        public init(subscriptionId: String) {
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Consumption/marketplaces"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            if self.filter != nil { queryParameters["$filter"] = String(describing: self.filter!) }
            if self.top != nil { queryParameters["$top"] = String(describing: self.top!) }
            if self.skiptoken != nil { queryParameters["$skiptoken"] = String(describing: self.skiptoken!) }
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                if var pageDecoder = decoder as? PageDecoder {
                    pageDecoder.isPagedData = true
                    pageDecoder.nextLinkName = "NextLink"
                }
                let result = try decoder.decode(MarketplacesListResultData?.self, from: data)
                if var pageDecoder = decoder as? PageDecoder {
                    self.nextLink = pageDecoder.nextLink
                }
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (MarketplacesListResultProtocol?, Error?) -> Void) -> Void {
            if self.nextLink != nil {
                self.path = nextLink!
                self.nextLink = nil;
                self.pathType = .absolute
            }
            client.executeAsync(command: self) {
                (result: MarketplacesListResultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
