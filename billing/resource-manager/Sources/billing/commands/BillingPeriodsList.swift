import Foundation
import azureSwiftRuntime
public protocol BillingPeriodsList  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var filter : String? { get set }
    var skiptoken : String? { get set }
    var top : Int32? { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (BillingPeriodsListResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.BillingPeriods {
// List lists the available billing periods for a subscription in reverse chronological order.
internal class ListCommand : BaseCommand, BillingPeriodsList {
    var nextLink: String?
    public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
    public var subscriptionId : String
    public var apiVersion = "2017-04-24-preview"
    public var filter : String?
    public var skiptoken : String?
    public var top : Int32?

    public init(subscriptionId: String) {
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Billing/billingPeriods"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
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
            let result = try decoder.decode(BillingPeriodsListResultData?.self, from: data)
            if var pageDecoder = decoder as? PageDecoder {
                self.nextLink = pageDecoder.nextLink
            }
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (BillingPeriodsListResultProtocol?, Error?) -> Void) -> Void {
        if self.nextLink != nil {
            self.path = nextLink!
            self.nextLink = nil;
            self.pathType = .absolute
        }
        client.executeAsync(command: self) {
            (result: BillingPeriodsListResultData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
