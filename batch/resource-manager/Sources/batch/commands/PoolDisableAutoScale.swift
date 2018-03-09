import Foundation
import azureSwiftRuntime
public protocol PoolDisableAutoScale  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var accountName : String { get set }
    var poolName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (PoolProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Pool {
// DisableAutoScale disables automatic scaling for a pool.
    internal class DisableAutoScaleCommand : BaseCommand, PoolDisableAutoScale {
        public var resourceGroupName : String
        public var accountName : String
        public var poolName : String
        public var subscriptionId : String
        public var apiVersion = "2017-09-01"

        public init(resourceGroupName: String, accountName: String, poolName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.accountName = accountName
            self.poolName = poolName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}/pools/{poolName}/disableAutoScale"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{accountName}"] = String(describing: self.accountName)
            self.pathParameters["{poolName}"] = String(describing: self.poolName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(PoolData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (PoolProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: PoolData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
