import Foundation
import azureSwiftRuntime
public protocol AccountsGet  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var accountName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (DataLakeStoreAccountProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Accounts {
// Get gets the specified Data Lake Store account.
internal class GetCommand : BaseCommand, AccountsGet {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var accountName : String
    public var apiVersion = "2016-11-01"

    public init(subscriptionId: String, resourceGroupName: String, accountName: String) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.accountName = accountName
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataLakeStore/accounts/{accountName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{accountName}"] = String(describing: self.accountName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(DataLakeStoreAccountData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (DataLakeStoreAccountProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: DataLakeStoreAccountData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
