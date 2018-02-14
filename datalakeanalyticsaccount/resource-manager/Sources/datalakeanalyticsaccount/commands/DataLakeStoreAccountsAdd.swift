import Foundation
import azureSwiftRuntime
public protocol DataLakeStoreAccountsAdd  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var accountName : String { get set }
    var dataLakeStoreAccountName : String { get set }
    var apiVersion : String { get set }
    var parameters :  AddDataLakeStoreParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.DataLakeStoreAccounts {
// Add updates the specified Data Lake Analytics account to include the additional Data Lake Store account.
internal class AddCommand : BaseCommand, DataLakeStoreAccountsAdd {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var accountName : String
    public var dataLakeStoreAccountName : String
    public var apiVersion = "2016-11-01"
    public var parameters :  AddDataLakeStoreParametersProtocol?

    public init(subscriptionId: String, resourceGroupName: String, accountName: String, dataLakeStoreAccountName: String) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.accountName = accountName
        self.dataLakeStoreAccountName = dataLakeStoreAccountName
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataLakeAnalytics/accounts/{accountName}/dataLakeStoreAccounts/{dataLakeStoreAccountName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{accountName}"] = String(describing: self.accountName)
        self.pathParameters["{dataLakeStoreAccountName}"] = String(describing: self.dataLakeStoreAccountName)
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

    public func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (error) in
            completionHandler(error)
        }
    }
}
}
