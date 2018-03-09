import Foundation
import azureSwiftRuntime
public protocol PoolStopResize  {
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
// StopResize this does not restore the pool to its previous state before the resize operation: it only stops any
// further changes being made, and the pool maintains its current state. After stopping, the pool stabilizes at the
// number of nodes it was at when the stop operation was done. During the stop operation, the pool allocation state
// changes first to stopping and then to steady. A resize operation need not be an explicit resize pool request; this
// API can also be used to halt the initial sizing of the pool when it is created.
    internal class StopResizeCommand : BaseCommand, PoolStopResize {
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
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}/pools/{poolName}/stopResize"
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
