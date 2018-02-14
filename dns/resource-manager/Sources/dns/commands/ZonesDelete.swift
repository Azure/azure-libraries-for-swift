import Foundation
import azureSwiftRuntime
public protocol ZonesDelete  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var zoneName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var ifMatch : String? { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Zones {
// Delete deletes a DNS zone. WARNING: All DNS records in the zone will also be deleted. This operation cannot be
// undone. This method may poll for completion. Polling can be canceled by passing the cancel channel argument. The
// channel will be used to cancel polling and any outstanding HTTP requests.
internal class DeleteCommand : BaseCommand, ZonesDelete {
    public var resourceGroupName : String
    public var zoneName : String
    public var subscriptionId : String
    public var apiVersion = "2017-09-01"
    public var ifMatch : String?

    public init(resourceGroupName: String, zoneName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.zoneName = zoneName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsZones/{zoneName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{zoneName}"] = String(describing: self.zoneName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
        if self.ifMatch != nil { headerParameters["If-Match"] = String(describing: self.ifMatch!) }
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
