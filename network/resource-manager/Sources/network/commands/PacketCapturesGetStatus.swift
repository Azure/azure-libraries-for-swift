import Foundation
import azureSwiftRuntime
public protocol PacketCapturesGetStatus  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var networkWatcherName : String { get set }
    var packetCaptureName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (PacketCaptureQueryStatusResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.PacketCaptures {
// GetStatus query the status of a running packet capture session. This method may poll for completion. Polling can be
// canceled by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
internal class GetStatusCommand : BaseCommand, PacketCapturesGetStatus {
    public var resourceGroupName : String
    public var networkWatcherName : String
    public var packetCaptureName : String
    public var subscriptionId : String
    public var apiVersion = "2018-01-01"

    public init(resourceGroupName: String, networkWatcherName: String, packetCaptureName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.networkWatcherName = networkWatcherName
        self.packetCaptureName = packetCaptureName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}/queryStatus"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{networkWatcherName}"] = String(describing: self.networkWatcherName)
        self.pathParameters["{packetCaptureName}"] = String(describing: self.packetCaptureName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(PacketCaptureQueryStatusResultData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (PacketCaptureQueryStatusResultProtocol?, Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (result: PacketCaptureQueryStatusResultData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
