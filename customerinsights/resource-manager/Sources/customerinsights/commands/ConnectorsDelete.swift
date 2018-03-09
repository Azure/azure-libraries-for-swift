import Foundation
import azureSwiftRuntime
public protocol ConnectorsDelete  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var hubName : String { get set }
    var connectorName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Connectors {
// Delete deletes a connector in the hub. This method may poll for completion. Polling can be canceled by passing the
// cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
    internal class DeleteCommand : BaseCommand, ConnectorsDelete {
        public var resourceGroupName : String
        public var hubName : String
        public var connectorName : String
        public var subscriptionId : String
        public var apiVersion = "2017-04-26"

        public init(resourceGroupName: String, hubName: String, connectorName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.hubName = hubName
            self.connectorName = connectorName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/connectors/{connectorName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{hubName}"] = String(describing: self.hubName)
            self.pathParameters["{connectorName}"] = String(describing: self.connectorName)
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
