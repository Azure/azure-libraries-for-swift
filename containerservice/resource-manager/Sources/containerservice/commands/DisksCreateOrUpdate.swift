import Foundation
import azureSwiftRuntime
public protocol DisksCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var diskName : String { get set }
    var apiVersion : String { get set }
    var disk :  DiskProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (DiskProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Disks {
// CreateOrUpdate creates or updates a disk. This method may poll for completion. Polling can be canceled by passing
// the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
    internal class CreateOrUpdateCommand : BaseCommand, DisksCreateOrUpdate {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var diskName : String
        public var apiVersion = "2017-03-30"
    public var disk :  DiskProtocol?

        public init(subscriptionId: String, resourceGroupName: String, diskName: String, disk: DiskProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.diskName = diskName
            self.disk = disk
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/disks/{diskName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{diskName}"] = String(describing: self.diskName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = disk

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(disk as? DiskData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(DiskData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (DiskProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: DiskData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
