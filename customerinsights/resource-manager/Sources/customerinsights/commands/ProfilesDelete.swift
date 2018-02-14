import Foundation
import azureSwiftRuntime
public protocol ProfilesDelete  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var hubName : String { get set }
    var profileName : String { get set }
    var subscriptionId : String { get set }
    var localeCode : String? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Profiles {
// Delete deletes a profile within a hub This method may poll for completion. Polling can be canceled by passing the
// cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
internal class DeleteCommand : BaseCommand, ProfilesDelete {
    public var resourceGroupName : String
    public var hubName : String
    public var profileName : String
    public var subscriptionId : String
    public var localeCode : String?
    public var apiVersion = "2017-04-26"

    public init(resourceGroupName: String, hubName: String, profileName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.hubName = hubName
        self.profileName = profileName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/profiles/{profileName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{hubName}"] = String(describing: self.hubName)
        self.pathParameters["{profileName}"] = String(describing: self.profileName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        if self.localeCode != nil { queryParameters["locale-code"] = String(describing: self.localeCode!) }
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
