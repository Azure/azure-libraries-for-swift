import Foundation
import azureSwiftRuntime
public protocol ReplicationNetworkMappingsUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceName : String { get set }
    var resourceGroupName : String { get set }
    var subscriptionId : String { get set }
    var fabricName : String { get set }
    var networkName : String { get set }
    var networkMappingName : String { get set }
    var apiVersion : String { get set }
    var input :  UpdateNetworkMappingInputProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (NetworkMappingProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ReplicationNetworkMappings {
// Update the operation to update an ASR network mapping. This method may poll for completion. Polling can be canceled
// by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
internal class UpdateCommand : BaseCommand, ReplicationNetworkMappingsUpdate {
    public var resourceName : String
    public var resourceGroupName : String
    public var subscriptionId : String
    public var fabricName : String
    public var networkName : String
    public var networkMappingName : String
    public var apiVersion = "2016-08-10"
    public var input :  UpdateNetworkMappingInputProtocol?

    public init(resourceName: String, resourceGroupName: String, subscriptionId: String, fabricName: String, networkName: String, networkMappingName: String, input: UpdateNetworkMappingInputProtocol) {
        self.resourceName = resourceName
        self.resourceGroupName = resourceGroupName
        self.subscriptionId = subscriptionId
        self.fabricName = fabricName
        self.networkName = networkName
        self.networkMappingName = networkMappingName
        self.input = input
        super.init()
        self.method = "Patch"
        self.isLongRunningOperation = true
        self.path = "/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{resourceName}/replicationFabrics/{fabricName}/replicationNetworks/{networkName}/replicationNetworkMappings/{networkMappingName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceName}"] = String(describing: self.resourceName)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{fabricName}"] = String(describing: self.fabricName)
        self.pathParameters["{networkName}"] = String(describing: self.networkName)
        self.pathParameters["{networkMappingName}"] = String(describing: self.networkMappingName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = input
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(input)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(NetworkMappingData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (NetworkMappingProtocol?, Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (result: NetworkMappingData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
