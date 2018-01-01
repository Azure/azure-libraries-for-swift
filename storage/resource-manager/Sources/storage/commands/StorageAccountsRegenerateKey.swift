import Foundation
import azureSwiftRuntime
public protocol StorageAccountsRegenerateKey  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var accountName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var regenerateKey :  StorageAccountRegenerateKeyParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (StorageAccountListKeysResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.StorageAccounts {
// RegenerateKey regenerates one of the access keys for the specified storage account.
internal class RegenerateKeyCommand : BaseCommand, StorageAccountsRegenerateKey {
    public var resourceGroupName : String
    public var accountName : String
    public var subscriptionId : String
    public var apiVersion : String = "2017-06-01"
    public var regenerateKey :  StorageAccountRegenerateKeyParametersProtocol?

    public init(resourceGroupName: String, accountName: String, subscriptionId: String, apiVersion: String, regenerateKey: StorageAccountRegenerateKeyParametersProtocol) {
        self.resourceGroupName = resourceGroupName
        self.accountName = accountName
        self.subscriptionId = subscriptionId
        self.apiVersion = apiVersion
        self.regenerateKey = regenerateKey
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/regenerateKey"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{accountName}"] = String(describing: self.accountName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["{api-version}"] = String(describing: self.apiVersion)
    self.body = regenerateKey
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(regenerateKey)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            return try decoder.decode(StorageAccountListKeysResultData?.self, from: data)
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (StorageAccountListKeysResultProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: StorageAccountListKeysResultData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
