import Foundation
import azureSwiftRuntime
public protocol RecommendationsDisableAllForWebApp  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var siteName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Recommendations {
// DisableAllForWebApp disable all recommendations for an app.
internal class DisableAllForWebAppCommand : BaseCommand, RecommendationsDisableAllForWebApp {
    public var resourceGroupName : String
    public var siteName : String
    public var subscriptionId : String
    public var apiVersion = "2016-03-01"

    public init(resourceGroupName: String, siteName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.siteName = siteName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/recommendations/disable"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{siteName}"] = String(describing: self.siteName)
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
