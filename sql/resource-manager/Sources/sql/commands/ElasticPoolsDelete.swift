import Foundation
import azureSwiftRuntime
public protocol ElasticPoolsDelete  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var elasticPoolName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.ElasticPools {
// Delete deletes the elastic pool.
    internal class DeleteCommand : BaseCommand, ElasticPoolsDelete {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var serverName : String
        public var elasticPoolName : String
        public var apiVersion = "2014-04-01"

        public init(subscriptionId: String, resourceGroupName: String, serverName: String, elasticPoolName: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.serverName = serverName
            self.elasticPoolName = elasticPoolName
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{serverName}"] = String(describing: self.serverName)
            self.pathParameters["{elasticPoolName}"] = String(describing: self.elasticPoolName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public func execute(client: RuntimeClient,
            completionHandler: @escaping (Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (error) in
                completionHandler(error)
            }
        }
    }
}
