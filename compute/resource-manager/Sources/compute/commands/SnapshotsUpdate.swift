import Foundation
import azureSwiftRuntime
public protocol SnapshotsUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var snapshotName : String { get set }
    var apiVersion : String { get set }
    var snapshot :  SnapshotUpdateProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (SnapshotProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Snapshots {
// Update updates (patches) a snapshot. This method may poll for completion. Polling can be canceled by passing the
// cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
internal class UpdateCommand : BaseCommand, SnapshotsUpdate {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var snapshotName : String
    public var apiVersion = "2017-03-30"
    public var snapshot :  SnapshotUpdateProtocol?

    public init(subscriptionId: String, resourceGroupName: String, snapshotName: String, snapshot: SnapshotUpdateProtocol) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.snapshotName = snapshotName
        self.snapshot = snapshot
        super.init()
        self.method = "Patch"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/snapshots/{snapshotName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{snapshotName}"] = String(describing: self.snapshotName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = snapshot
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(snapshot)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
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
        client.executeAsyncLRO(command: self) {
            (result: SnapshotData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
