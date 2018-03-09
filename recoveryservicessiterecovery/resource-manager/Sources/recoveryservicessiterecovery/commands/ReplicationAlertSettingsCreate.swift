import Foundation
import azureSwiftRuntime
public protocol ReplicationAlertSettingsCreate  {
    var headerParameters: [String: String] { get set }
    var resourceName : String { get set }
    var resourceGroupName : String { get set }
    var subscriptionId : String { get set }
    var alertSettingName : String { get set }
    var apiVersion : String { get set }
    var request :  ConfigureAlertRequestProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (AlertProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ReplicationAlertSettings {
// Create create or update an email notification(alert) configuration.
    internal class CreateCommand : BaseCommand, ReplicationAlertSettingsCreate {
        public var resourceName : String
        public var resourceGroupName : String
        public var subscriptionId : String
        public var alertSettingName : String
        public var apiVersion = "2018-01-10"
    public var request :  ConfigureAlertRequestProtocol?

        public init(resourceName: String, resourceGroupName: String, subscriptionId: String, alertSettingName: String, request: ConfigureAlertRequestProtocol) {
            self.resourceName = resourceName
            self.resourceGroupName = resourceGroupName
            self.subscriptionId = subscriptionId
            self.alertSettingName = alertSettingName
            self.request = request
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{resourceName}/replicationAlertSettings/{alertSettingName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceName}"] = String(describing: self.resourceName)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{alertSettingName}"] = String(describing: self.alertSettingName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = request

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(request as? ConfigureAlertRequestData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(AlertData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (AlertProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: AlertData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
