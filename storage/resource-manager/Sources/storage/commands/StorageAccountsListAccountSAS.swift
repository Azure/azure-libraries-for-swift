import Foundation
import azureSwiftRuntime
public protocol StorageAccountsListAccountSAS  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var accountName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  AccountSasParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ListAccountSasResponseProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.StorageAccounts {
// ListAccountSAS list SAS credentials of a storage account.
internal class ListAccountSASCommand : BaseCommand, StorageAccountsListAccountSAS {
    public var resourceGroupName : String
    public var accountName : String
    public var subscriptionId : String
    public var apiVersion = "2017-10-01"
    public var parameters :  AccountSasParametersProtocol?

    public init(resourceGroupName: String, accountName: String, subscriptionId: String, parameters: AccountSasParametersProtocol) {
        self.resourceGroupName = resourceGroupName
        self.accountName = accountName
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/ListAccountSas"
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
            let result = try decoder.decode(ListAccountSasResponseData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ListAccountSasResponseProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: ListAccountSasResponseData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
