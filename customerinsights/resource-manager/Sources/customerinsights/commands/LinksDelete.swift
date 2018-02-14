import Foundation
import azureSwiftRuntime
public protocol LinksDelete  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var hubName : String { get set }
    var linkName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Links {
// Delete deletes a link in the hub.
internal class DeleteCommand : BaseCommand, LinksDelete {
    public var resourceGroupName : String
    public var hubName : String
    public var linkName : String
    public var subscriptionId : String
    public var apiVersion = "2017-04-26"

    public init(resourceGroupName: String, hubName: String, linkName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.hubName = hubName
        self.linkName = linkName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/links/{linkName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{hubName}"] = String(describing: self.hubName)
        self.pathParameters["{linkName}"] = String(describing: self.linkName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
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
