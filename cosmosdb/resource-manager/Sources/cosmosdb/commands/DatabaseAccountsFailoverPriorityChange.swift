import Foundation
import azureSwiftRuntime
public protocol DatabaseAccountsFailoverPriorityChange  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var accountName : String { get set }
    var apiVersion : String { get set }
    var failoverParameters :  FailoverPoliciesProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.DatabaseAccounts {
// FailoverPriorityChange changes the failover priority for the Azure Cosmos DB database account. A failover priority
// of 0 indicates a write region. The maximum value for a failover priority = (total number of regions - 1). Failover
// priority values must be unique for each of the regions in which the database account exists. This method may poll
// for completion. Polling can be canceled by passing the cancel channel argument. The channel will be used to cancel
// polling and any outstanding HTTP requests.
    internal class FailoverPriorityChangeCommand : BaseCommand, DatabaseAccountsFailoverPriorityChange {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var accountName : String
        public var apiVersion = "2015-04-08"
    public var failoverParameters :  FailoverPoliciesProtocol?

        public init(subscriptionId: String, resourceGroupName: String, accountName: String, failoverParameters: FailoverPoliciesProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.accountName = accountName
            self.failoverParameters = failoverParameters
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DocumentDB/databaseAccounts/{accountName}/failoverPriorityChange"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{accountName}"] = String(describing: self.accountName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = failoverParameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(failoverParameters as? FailoverPoliciesData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public func execute(client: RuntimeClient,
            completionHandler: @escaping (Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (error) in
                completionHandler(error)
            }
        }
    }
}
