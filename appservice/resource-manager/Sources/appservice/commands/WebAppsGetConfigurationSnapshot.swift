import Foundation
import azureSwiftRuntime
public protocol WebAppsGetConfigurationSnapshot  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var snapshotId : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (SiteConfigResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WebApps {
// GetConfigurationSnapshot gets a snapshot of the configuration of an app at a previous point in time.
internal class GetConfigurationSnapshotCommand : BaseCommand, WebAppsGetConfigurationSnapshot {
    public var resourceGroupName : String
    public var name : String
    public var snapshotId : String
    public var subscriptionId : String
    public var apiVersion = "2016-08-01"

    public init(resourceGroupName: String, name: String, snapshotId: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.name = name
        self.snapshotId = snapshotId
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/config/web/snapshots/{snapshotId}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{name}"] = String(describing: self.name)
        self.pathParameters["{snapshotId}"] = String(describing: self.snapshotId)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(SiteConfigResourceData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (SiteConfigResourceProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: SiteConfigResourceData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
