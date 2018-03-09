import Foundation
import azureSwiftRuntime
public protocol UsageDetailsListByBillingPeriod  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var billingPeriodName : String { get set }
    var expand : String? { get set }
    var filter : String? { get set }
    var skiptoken : String? { get set }
    var top : Int32? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (UsageDetailsListResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.UsageDetails {
// ListByBillingPeriod lists the usage details for a scope by billing period. Usage details are available via this API
// only for May 1, 2014 or later.
    internal class ListByBillingPeriodCommand : BaseCommand, UsageDetailsListByBillingPeriod {
        var nextLink: String?
        public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
        public var subscriptionId : String
        public var billingPeriodName : String
        public var expand : String?
        public var filter : String?
        public var skiptoken : String?
        public var top : Int32?
        public var apiVersion = "2018-01-31"

        public init(subscriptionId: String, billingPeriodName: String) {
            self.subscriptionId = subscriptionId
            self.billingPeriodName = billingPeriodName
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Billing/billingPeriods/{billingPeriodName}/providers/Microsoft.Consumption/usageDetails"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{billingPeriodName}"] = String(describing: self.billingPeriodName)
            if self.expand != nil { queryParameters["$expand"] = String(describing: self.expand!) }
            if self.filter != nil { queryParameters["$filter"] = String(describing: self.filter!) }
            if self.skiptoken != nil { queryParameters["$skiptoken"] = String(describing: self.skiptoken!) }
            if self.top != nil { queryParameters["$top"] = String(describing: self.top!) }
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
                let result = try decoder.decode(UsageDetailsListResultData?.self, from: data)
                if var pageDecoder = decoder as? PageDecoder {
                    self.nextLink = pageDecoder.nextLink
                }
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (UsageDetailsListResultProtocol?, Error?) -> Void) -> Void {
            if self.nextLink != nil {
                self.path = nextLink!
                self.nextLink = nil;
                self.pathType = .absolute
            }
            client.executeAsync(command: self) {
                (result: UsageDetailsListResultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
