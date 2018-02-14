import Foundation
import azureSwiftRuntime
public protocol StorageAccountsUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var accountName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  StorageAccountUpdateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (StorageAccountProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.StorageAccounts {
// Update the update operation can be used to update the SKU, encryption, access tier, or tags for a storage account.
// It can also be used to map the account to a custom domain. Only one custom domain is supported per storage account;
// the replacement/change of custom domain is not supported. In order to replace an old custom domain, the old value
// must be cleared/unregistered before a new value can be set. The update of multiple properties is supported. This
// call does not change the storage keys for the account. If you want to change the storage account keys, use the
// regenerate keys operation. The location and name of the storage account cannot be changed after creation.
internal class UpdateCommand : BaseCommand, StorageAccountsUpdate {
    public var resourceGroupName : String
    public var accountName : String
    public var subscriptionId : String
    public var apiVersion = "2017-10-01"
    public var parameters :  StorageAccountUpdateParametersProtocol?

    public init(resourceGroupName: String, accountName: String, subscriptionId: String, parameters: StorageAccountUpdateParametersProtocol) {
        self.resourceGroupName = resourceGroupName
        self.accountName = accountName
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Patch"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{accountName}"] = String(describing: self.accountName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = parameters
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(parameters)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(StorageAccountData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (StorageAccountProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: StorageAccountData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
