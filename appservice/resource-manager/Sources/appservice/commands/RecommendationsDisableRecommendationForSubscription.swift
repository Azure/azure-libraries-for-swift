import Foundation
import azureSwiftRuntime
public protocol RecommendationsDisableRecommendationForSubscription  {
    var headerParameters: [String: String] { get set }
    var name : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Recommendations {
// DisableRecommendationForSubscription disables the specified rule so it will not apply to a subscription in the
// future.
    internal class DisableRecommendationForSubscriptionCommand : BaseCommand, RecommendationsDisableRecommendationForSubscription {
        public var name : String
        public var subscriptionId : String
        public var apiVersion = "2016-03-01"

        public init(name: String, subscriptionId: String) {
            self.name = name
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Web/recommendations/{name}/disable"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public func execute(client: RuntimeClient,
            completionHandler: @escaping (Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (error) in
                completionHandler(error)
            }
        }
    }
}
