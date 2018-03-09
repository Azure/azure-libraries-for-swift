import Foundation
import azureSwiftRuntime
public protocol WebAppsUpdateBackupConfiguration  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var request :  BackupRequestProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (BackupRequestProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WebApps {
// UpdateBackupConfiguration updates the backup configuration of an app.
    internal class UpdateBackupConfigurationCommand : BaseCommand, WebAppsUpdateBackupConfiguration {
        public var resourceGroupName : String
        public var name : String
        public var subscriptionId : String
        public var apiVersion = "2016-08-01"
    public var request :  BackupRequestProtocol?

        public init(resourceGroupName: String, name: String, subscriptionId: String, request: BackupRequestProtocol) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.subscriptionId = subscriptionId
            self.request = request
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/config/backup"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = request

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(request as? BackupRequestData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(BackupRequestData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (BackupRequestProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: BackupRequestData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
