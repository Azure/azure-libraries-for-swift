import Foundation
import azureSwiftRuntime
public protocol SubscriptionUsagesListByLocation  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var locationName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (SubscriptionUsageListResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.SubscriptionUsages {
// ListByLocation gets all subscription usage metrics in a given location.
    internal class ListByLocationCommand : BaseCommand, SubscriptionUsagesListByLocation {
        var nextLink: String?
        public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
        public var locationName : String
        public var subscriptionId : String
        public var apiVersion = "2015-05-01-preview"

        public init(locationName: String, subscriptionId: String) {
            self.locationName = locationName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationName}/usages"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{locationName}"] = String(describing: self.locationName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                if var pageDecoder = decoder as? PageDecoder {
                    pageDecoder.isPagedData = true
                    pageDecoder.nextLinkName = "NextLink"
                }
                let result = try decoder.decode(SubscriptionUsageListResultData?.self, from: data)
                if var pageDecoder = decoder as? PageDecoder {
                    self.nextLink = pageDecoder.nextLink
                }
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (SubscriptionUsageListResultProtocol?, Error?) -> Void) -> Void {
            if self.nextLink != nil {
                self.path = nextLink!
                self.nextLink = nil;
                self.pathType = .absolute
            }
            client.executeAsync(command: self) {
                (result: SubscriptionUsageListResultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
