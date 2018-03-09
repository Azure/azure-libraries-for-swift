import Foundation
import azureSwiftRuntime
public protocol InvoicesList  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var expand : String? { get set }
    var filter : String? { get set }
    var skiptoken : String? { get set }
    var top : Int32? { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (InvoicesListResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Invoices {
// List lists the available invoices for a subscription in reverse chronological order beginning with the most recent
// invoice. In preview, invoices are available via this API only for invoice periods which end December 1, 2016 or
// later.  This is only supported for Azure Web-Direct subscriptions. Other subscription types which were not purchased
// directly through the Azure web portal are not supported through this preview API.
    internal class ListCommand : BaseCommand, InvoicesList {
        var nextLink: String?
        public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
        public var subscriptionId : String
        public var apiVersion = "2018-03-01-preview"
        public var expand : String?
        public var filter : String?
        public var skiptoken : String?
        public var top : Int32?

        public init(subscriptionId: String) {
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Billing/invoices"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            if self.expand != nil { queryParameters["$expand"] = String(describing: self.expand!) }
            if self.filter != nil { queryParameters["$filter"] = String(describing: self.filter!) }
            if self.skiptoken != nil { queryParameters["$skiptoken"] = String(describing: self.skiptoken!) }
            if self.top != nil { queryParameters["$top"] = String(describing: self.top!) }

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                if var pageDecoder = decoder as? PageDecoder {
                    pageDecoder.isPagedData = true
                    pageDecoder.nextLinkName = "NextLink"
                }
                let result = try decoder.decode(InvoicesListResultData?.self, from: data)
                if var pageDecoder = decoder as? PageDecoder {
                    self.nextLink = pageDecoder.nextLink
                }
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (InvoicesListResultProtocol?, Error?) -> Void) -> Void {
            if self.nextLink != nil {
                self.path = nextLink!
                self.nextLink = nil;
                self.pathType = .absolute
            }
            client.executeAsync(command: self) {
                (result: InvoicesListResultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
