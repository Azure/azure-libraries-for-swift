import Foundation
import azureSwiftRuntime
public protocol RedisListUpgradeNotifications  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var history : Double { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (NotificationListResponseProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Redis {
// ListUpgradeNotifications gets any upgrade notifications for a Redis cache.
    internal class ListUpgradeNotificationsCommand : BaseCommand, RedisListUpgradeNotifications {
        public var resourceGroupName : String
        public var name : String
        public var subscriptionId : String
        public var apiVersion = "2017-10-01"
        public var history : Double

        public init(resourceGroupName: String, name: String, subscriptionId: String, history: Double) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.subscriptionId = subscriptionId
            self.history = history
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/Redis/{name}/listUpgradeNotifications"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.queryParameters["history"] = String(describing: self.history)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(NotificationListResponseData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (NotificationListResponseProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: NotificationListResponseData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
