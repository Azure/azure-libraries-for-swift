import Foundation
import azureSwiftRuntime
public protocol SubscriptionUsagesGet  {
    var headerParameters: [String: String] { get set }
    var locationName : String { get set }
    var usageName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (SubscriptionUsageProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.SubscriptionUsages {
// Get gets a subscription usage metric.
    internal class GetCommand : BaseCommand, SubscriptionUsagesGet {
        public var locationName : String
        public var usageName : String
        public var subscriptionId : String
        public var apiVersion = "2015-05-01-preview"

        public init(locationName: String, usageName: String, subscriptionId: String) {
            self.locationName = locationName
            self.usageName = usageName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/usages/{usageName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{locationName}"] = String(describing: self.locationName)
            self.pathParameters["{usageName}"] = String(describing: self.usageName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(SubscriptionUsageData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (SubscriptionUsageProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: SubscriptionUsageData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
