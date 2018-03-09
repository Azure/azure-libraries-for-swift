import Foundation
import azureSwiftRuntime
public protocol InteractionsSuggestRelationshipLinks  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var hubName : String { get set }
    var interactionName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (SuggestRelationshipLinksResponseProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Interactions {
// SuggestRelationshipLinks suggests relationships to create relationship links.
    internal class SuggestRelationshipLinksCommand : BaseCommand, InteractionsSuggestRelationshipLinks {
        public var resourceGroupName : String
        public var hubName : String
        public var interactionName : String
        public var subscriptionId : String
        public var apiVersion = "2017-04-26"

        public init(resourceGroupName: String, hubName: String, interactionName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.hubName = hubName
            self.interactionName = interactionName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/interactions/{interactionName}/suggestRelationshipLinks"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{hubName}"] = String(describing: self.hubName)
            self.pathParameters["{interactionName}"] = String(describing: self.interactionName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(SuggestRelationshipLinksResponseData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (SuggestRelationshipLinksResponseProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: SuggestRelationshipLinksResponseData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
