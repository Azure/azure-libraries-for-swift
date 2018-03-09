import Foundation
import azureSwiftRuntime
public protocol ConnectionMonitorsStop  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var networkWatcherName : String { get set }
    var connectionMonitorName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.ConnectionMonitors {
// Stop stops the specified connection monitor. This method may poll for completion. Polling can be canceled by passing
// the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
    internal class StopCommand : BaseCommand, ConnectionMonitorsStop {
        public var resourceGroupName : String
        public var networkWatcherName : String
        public var connectionMonitorName : String
        public var subscriptionId : String
        public var apiVersion = "2018-01-01"

        public init(resourceGroupName: String, networkWatcherName: String, connectionMonitorName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.networkWatcherName = networkWatcherName
            self.connectionMonitorName = connectionMonitorName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors/{connectionMonitorName}/stop"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{networkWatcherName}"] = String(describing: self.networkWatcherName)
            self.pathParameters["{connectionMonitorName}"] = String(describing: self.connectionMonitorName)
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
