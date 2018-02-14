import Foundation
import azureSwiftRuntime
public protocol BillingPeriodsGet  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var billingPeriodName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (BillingPeriodProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.BillingPeriods {
// Get gets a named billing period.
internal class GetCommand : BaseCommand, BillingPeriodsGet {
    public var subscriptionId : String
    public var billingPeriodName : String
    public var apiVersion = "2017-04-24-preview"

    public init(subscriptionId: String, billingPeriodName: String) {
        self.subscriptionId = subscriptionId
        self.billingPeriodName = billingPeriodName
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Billing/billingPeriods/{billingPeriodName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{billingPeriodName}"] = String(describing: self.billingPeriodName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(BillingPeriodData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (BillingPeriodProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: BillingPeriodData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
