import Foundation
import azureSwiftRuntime
public protocol BillingAccountsList  {
    var headerParameters: [String: String] { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (BillingAccountListResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.BillingAccounts {
// List lists the billing accounts the caller has access to.
    internal class ListCommand : BaseCommand, BillingAccountsList {
        public var apiVersion = "2018-03-01-preview"

    public override init() {
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/providers/Microsoft.Billing/billingAccounts"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(BillingAccountListResultData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (BillingAccountListResultProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: BillingAccountListResultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
