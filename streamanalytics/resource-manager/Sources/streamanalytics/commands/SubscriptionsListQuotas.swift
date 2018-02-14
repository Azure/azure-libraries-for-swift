import Foundation
import azureSwiftRuntime
public protocol SubscriptionsListQuotas  {
    var headerParameters: [String: String] { get set }
    var location : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (SubscriptionQuotasListResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Subscriptions {
// ListQuotas retrieves the subscription's current quota information in a particular region.
internal class ListQuotasCommand : BaseCommand, SubscriptionsListQuotas {
    public var location : String
    public var subscriptionId : String
    public var apiVersion = "2016-03-01"

    public init(location: String, subscriptionId: String) {
        self.location = location
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.StreamAnalytics/locations/{location}/quotas"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{location}"] = String(describing: self.location)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(SubscriptionQuotasListResultData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (SubscriptionQuotasListResultProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: SubscriptionQuotasListResultData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
