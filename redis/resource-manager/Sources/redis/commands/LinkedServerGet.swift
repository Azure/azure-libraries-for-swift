import Foundation
import azureSwiftRuntime
public protocol LinkedServerGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var linkedServerName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (RedisLinkedServerWithPropertiesProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.LinkedServer {
// Get gets the detailed information about a linked server of a redis cache (requires Premium SKU).
    internal class GetCommand : BaseCommand, LinkedServerGet {
        public var resourceGroupName : String
        public var name : String
        public var linkedServerName : String
        public var subscriptionId : String
        public var apiVersion = "2017-10-01"

        public init(resourceGroupName: String, name: String, linkedServerName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.linkedServerName = linkedServerName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/Redis/{name}/linkedServers/{linkedServerName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{linkedServerName}"] = String(describing: self.linkedServerName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(RedisLinkedServerWithPropertiesData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (RedisLinkedServerWithPropertiesProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: RedisLinkedServerWithPropertiesData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
