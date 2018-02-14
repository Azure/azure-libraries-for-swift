import Foundation
import azureSwiftRuntime
public protocol RestorableDroppedDatabasesGet  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var restorableDroppededDatabaseId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (RestorableDroppedDatabaseProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.RestorableDroppedDatabases {
// Get gets a deleted database that can be restored
internal class GetCommand : BaseCommand, RestorableDroppedDatabasesGet {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var serverName : String
    public var restorableDroppededDatabaseId : String
    public var apiVersion = "2014-04-01"

    public init(subscriptionId: String, resourceGroupName: String, serverName: String, restorableDroppededDatabaseId: String) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.serverName = serverName
        self.restorableDroppededDatabaseId = restorableDroppededDatabaseId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/restorableDroppedDatabases/{restorableDroppededDatabaseId}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{serverName}"] = String(describing: self.serverName)
        self.pathParameters["{restorableDroppededDatabaseId}"] = String(describing: self.restorableDroppededDatabaseId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(RestorableDroppedDatabaseData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (RestorableDroppedDatabaseProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: RestorableDroppedDatabaseData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
