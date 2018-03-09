import Foundation
import azureSwiftRuntime
public protocol StorageAccountsGetStorageContainer  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var accountName : String { get set }
    var storageAccountName : String { get set }
    var containerName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (StorageContainerProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.StorageAccounts {
// GetStorageContainer gets the specified Azure Storage container associated with the given Data Lake Analytics and
// Azure Storage accounts.
    internal class GetStorageContainerCommand : BaseCommand, StorageAccountsGetStorageContainer {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var accountName : String
        public var storageAccountName : String
        public var containerName : String
        public var apiVersion = "2016-11-01"

        public init(subscriptionId: String, resourceGroupName: String, accountName: String, storageAccountName: String, containerName: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.accountName = accountName
            self.storageAccountName = storageAccountName
            self.containerName = containerName
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataLakeAnalytics/accounts/{accountName}/storageAccounts/{storageAccountName}/containers/{containerName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{accountName}"] = String(describing: self.accountName)
            self.pathParameters["{storageAccountName}"] = String(describing: self.storageAccountName)
            self.pathParameters["{containerName}"] = String(describing: self.containerName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(StorageContainerData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (StorageContainerProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: StorageContainerData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
