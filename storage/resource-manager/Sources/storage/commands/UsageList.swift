import Foundation
import azureSwiftRuntime
public protocol UsageList  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (UsageListResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Usage {
// List gets the current usage count and the limit for the resources under the subscription.
internal class ListCommand : BaseCommand, UsageList {
    public var subscriptionId : String
    public var apiVersion : String = "2017-06-01"

    public init(subscriptionId: String, apiVersion: String) {
        self.subscriptionId = subscriptionId
        self.apiVersion = apiVersion
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Storage/usages"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["{api-version}"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            return try decoder.decode(UsageListResultData?.self, from: data)
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (UsageListResultProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: UsageListResultData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
