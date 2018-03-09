import Foundation
import azureSwiftRuntime
public protocol NotificationHubsGetPnsCredentials  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var namespaceName : String { get set }
    var notificationHubName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (PnsCredentialsResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.NotificationHubs {
// GetPnsCredentials lists the PNS Credentials associated with a notification hub .
    internal class GetPnsCredentialsCommand : BaseCommand, NotificationHubsGetPnsCredentials {
        public var resourceGroupName : String
        public var namespaceName : String
        public var notificationHubName : String
        public var subscriptionId : String
        public var apiVersion = "2017-04-01"

        public init(resourceGroupName: String, namespaceName: String, notificationHubName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.namespaceName = namespaceName
            self.notificationHubName = notificationHubName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/notificationHubs/{notificationHubName}/pnsCredentials"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{namespaceName}"] = String(describing: self.namespaceName)
            self.pathParameters["{notificationHubName}"] = String(describing: self.notificationHubName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(PnsCredentialsResourceData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (PnsCredentialsResourceProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: PnsCredentialsResourceData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
