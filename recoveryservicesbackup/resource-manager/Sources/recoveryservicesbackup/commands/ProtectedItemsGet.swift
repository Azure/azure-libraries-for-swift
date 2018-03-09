import Foundation
import azureSwiftRuntime
public protocol ProtectedItemsGet  {
    var headerParameters: [String: String] { get set }
    var vaultName : String { get set }
    var resourceGroupName : String { get set }
    var subscriptionId : String { get set }
    var fabricName : String { get set }
    var containerName : String { get set }
    var protectedItemName : String { get set }
    var apiVersion : String { get set }
    var filter : String? { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ProtectedItemResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ProtectedItems {
// Get provides the details of the backed up item. This is an asynchronous operation. To know the status of the
// operation, call the GetItemOperationResult API.
    internal class GetCommand : BaseCommand, ProtectedItemsGet {
        public var vaultName : String
        public var resourceGroupName : String
        public var subscriptionId : String
        public var fabricName : String
        public var containerName : String
        public var protectedItemName : String
        public var apiVersion = "2016-12-01"
        public var filter : String?

        public init(vaultName: String, resourceGroupName: String, subscriptionId: String, fabricName: String, containerName: String, protectedItemName: String) {
            self.vaultName = vaultName
            self.resourceGroupName = resourceGroupName
            self.subscriptionId = subscriptionId
            self.fabricName = fabricName
            self.containerName = containerName
            self.protectedItemName = protectedItemName
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{vaultName}"] = String(describing: self.vaultName)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{fabricName}"] = String(describing: self.fabricName)
            self.pathParameters["{containerName}"] = String(describing: self.containerName)
            self.pathParameters["{protectedItemName}"] = String(describing: self.protectedItemName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            if self.filter != nil { queryParameters["$filter"] = String(describing: self.filter!) }

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ProtectedItemResourceData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ProtectedItemResourceProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: ProtectedItemResourceData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
