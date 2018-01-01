import Foundation
import azureSwiftRuntime
public protocol StorageAccountsGetProperties  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var accountName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (StorageAccountProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.StorageAccounts {
// GetProperties returns the properties for the specified storage account including but not limited to name, SKU name,
// location, and account status. The ListKeys operation should be used to retrieve storage keys.
internal class GetPropertiesCommand : BaseCommand, StorageAccountsGetProperties {
    public var resourceGroupName : String
    public var accountName : String
    public var subscriptionId : String
    public var apiVersion : String = "2017-06-01"

    public init(resourceGroupName: String, accountName: String, subscriptionId: String, apiVersion: String) {
        self.resourceGroupName = resourceGroupName
        self.accountName = accountName
        self.subscriptionId = subscriptionId
        self.apiVersion = apiVersion
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{accountName}"] = String(describing: self.accountName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["{api-version}"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            return try decoder.decode(StorageAccountData?.self, from: data)
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
