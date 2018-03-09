import Foundation
import azureSwiftRuntime
public protocol NotificationChannelsCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var labName : String { get set }
    var name : String { get set }
    var apiVersion : String { get set }
    var notificationChannel :  NotificationChannelProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (NotificationChannelProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.NotificationChannels {
// CreateOrUpdate create or replace an existing notificationChannel.
    internal class CreateOrUpdateCommand : BaseCommand, NotificationChannelsCreateOrUpdate {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var labName : String
        public var name : String
        public var apiVersion = "2016-05-15"
    public var notificationChannel :  NotificationChannelProtocol?

        public init(subscriptionId: String, resourceGroupName: String, labName: String, name: String, notificationChannel: NotificationChannelProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.labName = labName
            self.name = name
            self.notificationChannel = notificationChannel
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/notificationchannels/{name}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{labName}"] = String(describing: self.labName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = notificationChannel

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(notificationChannel as? NotificationChannelData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(NotificationChannelData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (NotificationChannelProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: NotificationChannelData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
