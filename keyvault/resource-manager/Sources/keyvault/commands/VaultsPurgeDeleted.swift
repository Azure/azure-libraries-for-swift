import Foundation
import azureSwiftRuntime
public protocol VaultsPurgeDeleted  {
    var headerParameters: [String: String] { get set }
    var vaultName : String { get set }
    var location : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Vaults {
// PurgeDeleted permanently deletes the specified vault. aka Purges the deleted Azure key vault. This method may poll
// for completion. Polling can be canceled by passing the cancel channel argument. The channel will be used to cancel
// polling and any outstanding HTTP requests.
internal class PurgeDeletedCommand : BaseCommand, VaultsPurgeDeleted {
    public var vaultName : String
    public var location : String
    public var subscriptionId : String
    public var apiVersion = "2016-10-01"

    public init(vaultName: String, location: String, subscriptionId: String) {
        self.vaultName = vaultName
        self.location = location
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.KeyVault/locations/{location}/deletedVaults/{vaultName}/purge"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{vaultName}"] = String(describing: self.vaultName)
        self.pathParameters["{location}"] = String(describing: self.location)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (error) in
            completionHandler(error)
        }
    }
}
}
