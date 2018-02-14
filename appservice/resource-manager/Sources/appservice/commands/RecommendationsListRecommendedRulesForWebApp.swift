import Foundation
import azureSwiftRuntime
public protocol RecommendationsListRecommendedRulesForWebApp  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var siteName : String { get set }
    var subscriptionId : String { get set }
    var featured : Bool? { get set }
    var filter : String? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping ([RecommendationProtocol?]?, Error?) -> Void) -> Void ;
}

extension Commands.Recommendations {
// ListRecommendedRulesForWebApp get all recommendations for an app.
internal class ListRecommendedRulesForWebAppCommand : BaseCommand, RecommendationsListRecommendedRulesForWebApp {
    public var resourceGroupName : String
    public var siteName : String
    public var subscriptionId : String
    public var featured : Bool?
    public var filter : String?
    public var apiVersion = "2016-03-01"

    public init(resourceGroupName: String, siteName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.siteName = siteName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/recommendations"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{siteName}"] = String(describing: self.siteName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        if self.featured != nil { queryParameters["featured"] = String(describing: self.featured!) }
        if self.filter != nil { queryParameters["$filter"] = String(describing: self.filter!) }
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode([RecommendationData?]?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping ([RecommendationProtocol?]?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: [RecommendationData?]?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
