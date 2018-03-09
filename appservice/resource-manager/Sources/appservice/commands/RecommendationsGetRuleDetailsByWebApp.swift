import Foundation
import azureSwiftRuntime
public protocol RecommendationsGetRuleDetailsByWebApp  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var siteName : String { get set }
    var name : String { get set }
    var subscriptionId : String { get set }
    var updateSeen : Bool? { get set }
    var recommendationId : String? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (RecommendationRuleProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Recommendations {
// GetRuleDetailsByWebApp get a recommendation rule for an app.
    internal class GetRuleDetailsByWebAppCommand : BaseCommand, RecommendationsGetRuleDetailsByWebApp {
        public var resourceGroupName : String
        public var siteName : String
        public var name : String
        public var subscriptionId : String
        public var updateSeen : Bool?
        public var recommendationId : String?
        public var apiVersion = "2016-03-01"

        public init(resourceGroupName: String, siteName: String, name: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.siteName = siteName
            self.name = name
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/recommendations/{name}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{siteName}"] = String(describing: self.siteName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            if self.updateSeen != nil { queryParameters["updateSeen"] = String(describing: self.updateSeen!) }
            if self.recommendationId != nil { queryParameters["recommendationId"] = String(describing: self.recommendationId!) }
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(RecommendationRuleData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (RecommendationRuleProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: RecommendationRuleData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
