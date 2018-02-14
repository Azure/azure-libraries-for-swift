import Foundation
import azureSwiftRuntime
public protocol ServiceListSkus  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (SkuInfosProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Service {
// ListSkus list all SKUs.
internal class ListSkusCommand : BaseCommand, ServiceListSkus {
    public var subscriptionId : String
    public var apiVersion = "2016-03-01"

    public init(subscriptionId: String) {
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Web/skus"
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
            let result = try decoder.decode(SkuInfosData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (SkuInfosProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: SkuInfosData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
