import Foundation
import azureSwiftRuntime
public protocol WebAppsGetRelayServiceConnection  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var entityName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (RelayServiceConnectionEntityProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WebApps {
// GetRelayServiceConnection gets a hybrid connection configuration by its name.
internal class GetRelayServiceConnectionCommand : BaseCommand, WebAppsGetRelayServiceConnection {
    public var resourceGroupName : String
    public var name : String
    public var entityName : String
    public var subscriptionId : String
    public var apiVersion = "2016-08-01"

    public init(resourceGroupName: String, name: String, entityName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.name = name
        self.entityName = entityName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/hybridconnection/{entityName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{name}"] = String(describing: self.name)
        self.pathParameters["{entityName}"] = String(describing: self.entityName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(RelayServiceConnectionEntityData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (RelayServiceConnectionEntityProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: RelayServiceConnectionEntityData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
