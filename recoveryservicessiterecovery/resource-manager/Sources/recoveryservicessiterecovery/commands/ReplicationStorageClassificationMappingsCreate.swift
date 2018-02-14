import Foundation
import azureSwiftRuntime
public protocol ReplicationStorageClassificationMappingsCreate  {
    var headerParameters: [String: String] { get set }
    var resourceName : String { get set }
    var resourceGroupName : String { get set }
    var subscriptionId : String { get set }
    var fabricName : String { get set }
    var storageClassificationName : String { get set }
    var storageClassificationMappingName : String { get set }
    var apiVersion : String { get set }
    var pairingInput :  StorageClassificationMappingInputProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (StorageClassificationMappingProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ReplicationStorageClassificationMappings {
// Create the operation to create a storage classification mapping. This method may poll for completion. Polling can be
// canceled by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
internal class CreateCommand : BaseCommand, ReplicationStorageClassificationMappingsCreate {
    public var resourceName : String
    public var resourceGroupName : String
    public var subscriptionId : String
    public var fabricName : String
    public var storageClassificationName : String
    public var storageClassificationMappingName : String
    public var apiVersion = "2016-08-10"
    public var pairingInput :  StorageClassificationMappingInputProtocol?

    public init(resourceName: String, resourceGroupName: String, subscriptionId: String, fabricName: String, storageClassificationName: String, storageClassificationMappingName: String, pairingInput: StorageClassificationMappingInputProtocol) {
        self.resourceName = resourceName
        self.resourceGroupName = resourceGroupName
        self.subscriptionId = subscriptionId
        self.fabricName = fabricName
        self.storageClassificationName = storageClassificationName
        self.storageClassificationMappingName = storageClassificationMappingName
        self.pairingInput = pairingInput
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{resourceName}/replicationFabrics/{fabricName}/replicationStorageClassifications/{storageClassificationName}/replicationStorageClassificationMappings/{storageClassificationMappingName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceName}"] = String(describing: self.resourceName)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{fabricName}"] = String(describing: self.fabricName)
        self.pathParameters["{storageClassificationName}"] = String(describing: self.storageClassificationName)
        self.pathParameters["{storageClassificationMappingName}"] = String(describing: self.storageClassificationMappingName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = pairingInput
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(pairingInput)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(StorageClassificationMappingData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (StorageClassificationMappingProtocol?, Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (result: StorageClassificationMappingData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
