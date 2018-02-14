import Foundation
import azureSwiftRuntime
public protocol KpiReprocess  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var hubName : String { get set }
    var kpiName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Kpi {
// Reprocess reprocesses the Kpi values of the specified KPI.
internal class ReprocessCommand : BaseCommand, KpiReprocess {
    public var resourceGroupName : String
    public var hubName : String
    public var kpiName : String
    public var subscriptionId : String
    public var apiVersion = "2017-04-26"

    public init(resourceGroupName: String, hubName: String, kpiName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.hubName = hubName
        self.kpiName = kpiName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/kpi/{kpiName}/reprocess"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{hubName}"] = String(describing: self.hubName)
        self.pathParameters["{kpiName}"] = String(describing: self.kpiName)
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
