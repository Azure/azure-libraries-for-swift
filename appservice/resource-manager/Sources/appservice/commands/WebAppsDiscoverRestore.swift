import Foundation
import azureSwiftRuntime
public protocol WebAppsDiscoverRestore  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var request :  RestoreRequestProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (RestoreRequestProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WebApps {
// DiscoverRestore discovers an existing app backup that can be restored from a blob in Azure storage.
internal class DiscoverRestoreCommand : BaseCommand, WebAppsDiscoverRestore {
    public var resourceGroupName : String
    public var name : String
    public var subscriptionId : String
    public var apiVersion = "2016-08-01"
    public var request :  RestoreRequestProtocol?

    public init(resourceGroupName: String, name: String, subscriptionId: String, request: RestoreRequestProtocol) {
        self.resourceGroupName = resourceGroupName
        self.name = name
        self.subscriptionId = subscriptionId
        self.request = request
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/backups/discover"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{name}"] = String(describing: self.name)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = request
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(request)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(RestoreRequestData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (RestoreRequestProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: RestoreRequestData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
