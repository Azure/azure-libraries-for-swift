import Foundation
import azureSwiftRuntime
public protocol InvoicesGetLatest  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (InvoiceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Invoices {
// GetLatest gets the most recent invoice. When getting a single invoice, the downloadUrl property is expanded
// automatically.
internal class GetLatestCommand : BaseCommand, InvoicesGetLatest {
    public var subscriptionId : String
    public var apiVersion = "2017-04-24-preview"

    public init(subscriptionId: String) {
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Billing/invoices/latest"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(InvoiceData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (InvoiceProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: InvoiceData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
