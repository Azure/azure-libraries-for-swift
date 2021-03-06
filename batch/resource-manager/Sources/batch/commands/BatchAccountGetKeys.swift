import Foundation
import azureSwiftRuntime
public protocol BatchAccountGetKeys  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var accountName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (BatchAccountKeysProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.BatchAccount {
// GetKeys this operation applies only to Batch accounts created with a poolAllocationMode of 'BatchService'. If the
// Batch account was created with a poolAllocationMode of 'UserSubscription', clients cannot use access to keys to
// authenticate, and must use Azure Active Directory instead. In this case, getting the keys will fail.
    internal class GetKeysCommand : BaseCommand, BatchAccountGetKeys {
        public var resourceGroupName : String
        public var accountName : String
        public var subscriptionId : String
        public var apiVersion = "2017-09-01"

        public init(resourceGroupName: String, accountName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.accountName = accountName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}/listKeys"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{accountName}"] = String(describing: self.accountName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(BatchAccountKeysData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (BatchAccountKeysProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: BatchAccountKeysData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
