import Foundation
import azureSwiftRuntime
public protocol RouteTablesUpdateTags  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var routeTableName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  TagsObjectProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (RouteTableProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.RouteTables {
// UpdateTags updates a route table tags. This method may poll for completion. Polling can be canceled by passing the
// cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
internal class UpdateTagsCommand : BaseCommand, RouteTablesUpdateTags {
    public var resourceGroupName : String
    public var routeTableName : String
    public var subscriptionId : String
    public var apiVersion = "2018-01-01"
    public var parameters :  TagsObjectProtocol?

    public init(resourceGroupName: String, routeTableName: String, subscriptionId: String, parameters: TagsObjectProtocol) {
        self.resourceGroupName = resourceGroupName
        self.routeTableName = routeTableName
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Patch"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/routeTables/{routeTableName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{routeTableName}"] = String(describing: self.routeTableName)
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
            let result = try decoder.decode(RouteTableData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (RouteTableProtocol?, Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (result: RouteTableData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
