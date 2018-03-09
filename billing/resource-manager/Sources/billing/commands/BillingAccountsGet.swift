import Foundation
import azureSwiftRuntime
public protocol BillingAccountsGet  {
    var headerParameters: [String: String] { get set }
    var name : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (BillingAccountResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.BillingAccounts {
// Get gets a billing account by name.
    internal class GetCommand : BaseCommand, BillingAccountsGet {
        public var name : String
        public var apiVersion = "2018-03-01-preview"

        public init(name: String) {
            self.name = name
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/providers/Microsoft.Billing/billingAccounts/{name}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{name}"] = String(describing: self.name)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(BillingAccountResultData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (BillingAccountResultProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: BillingAccountResultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
