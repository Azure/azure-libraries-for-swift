import Foundation
import azureSwiftRuntime
public protocol DataLakeStoreAccountsDelete  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var accountName : String { get set }
    var dataLakeStoreAccountName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.DataLakeStoreAccounts {
// Delete updates the Data Lake Analytics account specified to remove the specified Data Lake Store account.
internal class DeleteCommand : BaseCommand, DataLakeStoreAccountsDelete {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var accountName : String
    public var dataLakeStoreAccountName : String
    public var apiVersion = "2016-11-01"

    public init(subscriptionId: String, resourceGroupName: String, accountName: String, dataLakeStoreAccountName: String) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.accountName = accountName
        self.dataLakeStoreAccountName = dataLakeStoreAccountName
        super.init()
        self.method = "Delete"
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
