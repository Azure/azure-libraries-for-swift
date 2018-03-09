import Foundation
import azureSwiftRuntime
public protocol DatabaseAccountsCheckNameExists  {
    var headerParameters: [String: String] { get set }
    var accountName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.DatabaseAccounts {
// CheckNameExists checks that the Azure Cosmos DB account name already exists. A valid account name may contain only
// lowercase letters, numbers, and the '-' character, and must be between 3 and 50 characters.
    internal class CheckNameExistsCommand : BaseCommand, DatabaseAccountsCheckNameExists {
        public var accountName : String
        public var apiVersion = "2015-04-08"

        public init(accountName: String) {
            self.accountName = accountName
            super.init()
            self.method = "Head"
            self.isLongRunningOperation = false
            self.path = "/providers/Microsoft.DocumentDB/databaseAccountNames/{accountName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{accountName}"] = String(describing: self.accountName)
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
