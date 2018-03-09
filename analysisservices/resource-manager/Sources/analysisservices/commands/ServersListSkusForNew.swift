import Foundation
import azureSwiftRuntime
public protocol ServersListSkusForNew  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (SkuEnumerationForNewResourceResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Servers {
// ListSkusForNew lists eligible SKUs for Analysis Services resource provider.
    internal class ListSkusForNewCommand : BaseCommand, ServersListSkusForNew {
        public var subscriptionId : String
        public var apiVersion = "2017-08-01"

        public init(subscriptionId: String) {
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.AnalysisServices/skus"
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
                let result = try decoder.decode(SkuEnumerationForNewResourceResultData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (SkuEnumerationForNewResourceResultProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: SkuEnumerationForNewResourceResultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
