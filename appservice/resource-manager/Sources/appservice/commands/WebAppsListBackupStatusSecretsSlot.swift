import Foundation
import azureSwiftRuntime
public protocol WebAppsListBackupStatusSecretsSlot  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var backupId : String { get set }
    var slot : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var request :  BackupRequestProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (BackupItemProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WebApps {
// ListBackupStatusSecretsSlot gets status of a web app backup that may be in progress, including secrets associated
// with the backup, such as the Azure Storage SAS URL. Also can be used to update the SAS URL for the backup if a new
// URL is passed in the request body.
internal class ListBackupStatusSecretsSlotCommand : BaseCommand, WebAppsListBackupStatusSecretsSlot {
    public var resourceGroupName : String
    public var name : String
    public var backupId : String
    public var slot : String
    public var subscriptionId : String
    public var apiVersion = "2016-08-01"
    public var request :  BackupRequestProtocol?

    public init(resourceGroupName: String, name: String, backupId: String, slot: String, subscriptionId: String, request: BackupRequestProtocol) {
        self.resourceGroupName = resourceGroupName
        self.name = name
        self.backupId = backupId
        self.slot = slot
        self.subscriptionId = subscriptionId
        self.request = request
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/backups/{backupId}/list"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{name}"] = String(describing: self.name)
        self.pathParameters["{backupId}"] = String(describing: self.backupId)
        self.pathParameters["{slot}"] = String(describing: self.slot)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = request
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(request)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(BackupItemData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (BackupItemProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: BackupItemData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
