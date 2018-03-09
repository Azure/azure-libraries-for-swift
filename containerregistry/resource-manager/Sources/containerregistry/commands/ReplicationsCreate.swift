import Foundation
import azureSwiftRuntime
public protocol ReplicationsCreate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var registryName : String { get set }
    var replicationName : String { get set }
    var apiVersion : String { get set }
    var replication :  ReplicationProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ReplicationProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Replications {
// Create creates a replication for a container registry with the specified parameters. This method may poll for
// completion. Polling can be canceled by passing the cancel channel argument. The channel will be used to cancel
// polling and any outstanding HTTP requests.
    internal class CreateCommand : BaseCommand, ReplicationsCreate {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var registryName : String
        public var replicationName : String
        public var apiVersion = "2017-10-01"
    public var replication :  ReplicationProtocol?

        public init(subscriptionId: String, resourceGroupName: String, registryName: String, replicationName: String, replication: ReplicationProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.registryName = registryName
            self.replicationName = replicationName
            self.replication = replication
            super.init()
            self.method = "Put"
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
            self.body = replication

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(replication as? ReplicationData)
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
