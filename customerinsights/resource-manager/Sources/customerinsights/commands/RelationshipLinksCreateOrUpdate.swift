import Foundation
import azureSwiftRuntime
public protocol RelationshipLinksCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var hubName : String { get set }
    var relationshipLinkName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  RelationshipLinkResourceFormatProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (RelationshipLinkResourceFormatProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.RelationshipLinks {
// CreateOrUpdate creates a relationship link or updates an existing relationship link within a hub. This method may
// poll for completion. Polling can be canceled by passing the cancel channel argument. The channel will be used to
// cancel polling and any outstanding HTTP requests.
internal class CreateOrUpdateCommand : BaseCommand, RelationshipLinksCreateOrUpdate {
    public var resourceGroupName : String
    public var hubName : String
    public var relationshipLinkName : String
    public var subscriptionId : String
    public var apiVersion = "2017-04-26"
    public var parameters :  RelationshipLinkResourceFormatProtocol?

    public init(resourceGroupName: String, hubName: String, relationshipLinkName: String, subscriptionId: String, parameters: RelationshipLinkResourceFormatProtocol) {
        self.resourceGroupName = resourceGroupName
        self.hubName = hubName
        self.relationshipLinkName = relationshipLinkName
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/relationshipLinks/{relationshipLinkName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{hubName}"] = String(describing: self.hubName)
        self.pathParameters["{relationshipLinkName}"] = String(describing: self.relationshipLinkName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = parameters
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(parameters)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(RelationshipLinkResourceFormatData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (RelationshipLinkResourceFormatProtocol?, Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (result: RelationshipLinkResourceFormatData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
