import Foundation
import azureSwiftRuntime
public protocol SnapshotsGet  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var snapshotName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (SnapshotProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Snapshots {
// Get gets information about a snapshot.
internal class GetCommand : BaseCommand, SnapshotsGet {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var snapshotName : String
    public var apiVersion = "2017-03-30"

    public init(subscriptionId: String, resourceGroupName: String, snapshotName: String) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.snapshotName = snapshotName
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/snapshots/{snapshotName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{snapshotName}"] = String(describing: self.snapshotName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(SnapshotData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (SnapshotProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: SnapshotData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
