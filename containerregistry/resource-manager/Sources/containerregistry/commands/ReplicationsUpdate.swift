import Foundation
import azureSwiftRuntime
public protocol ReplicationsUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var registryName : String { get set }
    var replicationName : String { get set }
    var apiVersion : String { get set }
    var replicationUpdateParameters :  ReplicationUpdateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ReplicationProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Replications {
// Update updates a replication for a container registry with the specified parameters. This method may poll for
// completion. Polling can be canceled by passing the cancel channel argument. The channel will be used to cancel
// polling and any outstanding HTTP requests.
internal class UpdateCommand : BaseCommand, ReplicationsUpdate {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var registryName : String
    public var replicationName : String
    public var apiVersion = "2017-10-01"
    public var replicationUpdateParameters :  ReplicationUpdateParametersProtocol?

    public init(subscriptionId: String, resourceGroupName: String, registryName: String, replicationName: String, replicationUpdateParameters: ReplicationUpdateParametersProtocol) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.registryName = registryName
        self.replicationName = replicationName
        self.replicationUpdateParameters = replicationUpdateParameters
        super.init()
        self.method = "Patch"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerRegistry/registries/{registryName}/replications/{replicationName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{registryName}"] = String(describing: self.registryName)
        self.pathParameters["{replicationName}"] = String(describing: self.replicationName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = replicationUpdateParameters
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(replicationUpdateParameters)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(ReplicationData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ReplicationProtocol?, Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (result: ReplicationData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
