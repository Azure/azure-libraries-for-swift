import Foundation
import azureSwiftRuntime
public protocol PriceSheetGetByBillingPeriod  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var billingPeriodName : String { get set }
    var expand : String? { get set }
    var skiptoken : String? { get set }
    var top : Int32? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (PriceSheetResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.PriceSheet {
// GetByBillingPeriod get the price sheet for a scope by subscriptionId and billing period. Price sheet is available
// via this API only for May 1, 2014 or later.
    internal class GetByBillingPeriodCommand : BaseCommand, PriceSheetGetByBillingPeriod {
        public var subscriptionId : String
        public var billingPeriodName : String
        public var expand : String?
        public var skiptoken : String?
        public var top : Int32?
        public var apiVersion = "2018-01-31"

        public init(subscriptionId: String, billingPeriodName: String) {
            self.subscriptionId = subscriptionId
            self.billingPeriodName = billingPeriodName
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Billing/billingPeriods/{billingPeriodName}/providers/Microsoft.Consumption/pricesheets/default"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{billingPeriodName}"] = String(describing: self.billingPeriodName)
            if self.expand != nil { queryParameters["$expand"] = String(describing: self.expand!) }
            if self.skiptoken != nil { queryParameters["$skiptoken"] = String(describing: self.skiptoken!) }
            if self.top != nil { queryParameters["$top"] = String(describing: self.top!) }
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(PriceSheetResultData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (PriceSheetResultProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: PriceSheetResultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
