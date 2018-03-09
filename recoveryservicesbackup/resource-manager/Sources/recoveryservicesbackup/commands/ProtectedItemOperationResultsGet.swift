import Foundation
import azureSwiftRuntime
public protocol ProtectedItemOperationResultsGet  {
    var headerParameters: [String: String] { get set }
    var vaultName : String { get set }
    var resourceGroupName : String { get set }
    var subscriptionId : String { get set }
    var fabricName : String { get set }
    var containerName : String { get set }
    var protectedItemName : String { get set }
    var operationId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ProtectedItemResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ProtectedItemOperationResults {
// Get fetches the result of any operation on the backup item.
    internal class GetCommand : BaseCommand, ProtectedItemOperationResultsGet {
        public var vaultName : String
        public var resourceGroupName : String
        public var subscriptionId : String
        public var fabricName : String
        public var containerName : String
        public var protectedItemName : String
        public var operationId : String
        public var apiVersion = "2016-12-01"

        public init(vaultName: String, resourceGroupName: String, subscriptionId: String, fabricName: String, containerName: String, protectedItemName: String, operationId: String) {
            self.vaultName = vaultName
            self.resourceGroupName = resourceGroupName
            self.subscriptionId = subscriptionId
            self.fabricName = fabricName
            self.containerName = containerName
            self.protectedItemName = protectedItemName
            self.operationId = operationId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/operationResults/{operationId}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{vaultName}"] = String(describing: self.vaultName)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{fabricName}"] = String(describing: self.fabricName)
            self.pathParameters["{containerName}"] = String(describing: self.containerName)
            self.pathParameters["{protectedItemName}"] = String(describing: self.protectedItemName)
            self.pathParameters["{operationId}"] = String(describing: self.operationId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

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
