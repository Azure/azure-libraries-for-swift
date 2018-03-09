import Foundation
import azureSwiftRuntime
public protocol ElasticPoolDatabaseActivitiesListByElasticPool  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var elasticPoolName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ElasticPoolDatabaseActivityListResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ElasticPoolDatabaseActivities {
// ListByElasticPool returns activity on databases inside of an elastic pool.
    internal class ListByElasticPoolCommand : BaseCommand, ElasticPoolDatabaseActivitiesListByElasticPool {
        var nextLink: String?
        public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
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
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/elasticPoolDatabaseActivity"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{serverName}"] = String(describing: self.serverName)
            self.pathParameters["{elasticPoolName}"] = String(describing: self.elasticPoolName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                if var pageDecoder = decoder as? PageDecoder {
                    pageDecoder.isPagedData = true
                    pageDecoder.nextLinkName = "nil"
                }
                let result = try decoder.decode(ElasticPoolDatabaseActivityListResultData?.self, from: data)
                if var pageDecoder = decoder as? PageDecoder {
                    self.nextLink = pageDecoder.nextLink
                }
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ElasticPoolDatabaseActivityListResultProtocol?, Error?) -> Void) -> Void {
            if self.nextLink != nil {
                self.path = nextLink!
                self.nextLink = nil;
                self.pathType = .absolute
            }
            client.executeAsync(command: self) {
                (result: ElasticPoolDatabaseActivityListResultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
