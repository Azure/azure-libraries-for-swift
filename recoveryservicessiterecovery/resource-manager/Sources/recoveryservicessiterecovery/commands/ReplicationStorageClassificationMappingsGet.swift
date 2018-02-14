import Foundation
import azureSwiftRuntime
public protocol ReplicationStorageClassificationMappingsGet  {
    var headerParameters: [String: String] { get set }
    var resourceName : String { get set }
    var resourceGroupName : String { get set }
    var subscriptionId : String { get set }
    var fabricName : String { get set }
    var storageClassificationName : String { get set }
    var storageClassificationMappingName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (StorageClassificationMappingProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ReplicationStorageClassificationMappings {
// Get gets the details of the specified storage classification mapping.
internal class GetCommand : BaseCommand, ReplicationStorageClassificationMappingsGet {
    public var resourceName : String
    public var resourceGroupName : String
    public var subscriptionId : String
    public var fabricName : String
    public var storageClassificationName : String
    public var storageClassificationMappingName : String
    public var apiVersion = "2016-08-10"

    public init(resourceName: String, resourceGroupName: String, subscriptionId: String, fabricName: String, storageClassificationName: String, storageClassificationMappingName: String) {
        self.resourceName = resourceName
        self.resourceGroupName = resourceGroupName
        self.subscriptionId = subscriptionId
        self.fabricName = fabricName
        self.storageClassificationName = storageClassificationName
        self.storageClassificationMappingName = storageClassificationMappingName
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
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
        client.executeAsync(command: self) {
            (result: StorageClassificationMappingData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
