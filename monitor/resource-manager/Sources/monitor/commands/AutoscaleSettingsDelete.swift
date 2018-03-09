import Foundation
import azureSwiftRuntime
public protocol AutoscaleSettingsDelete  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var autoscaleSettingName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.AutoscaleSettings {
// Delete deletes and autoscale setting
    internal class DeleteCommand : BaseCommand, AutoscaleSettingsDelete {
        public var resourceGroupName : String
        public var autoscaleSettingName : String
        public var subscriptionId : String
        public var apiVersion = "2015-04-01"

        public init(resourceGroupName: String, autoscaleSettingName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.autoscaleSettingName = autoscaleSettingName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/microsoft.insights/autoscalesettings/{autoscaleSettingName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{autoscaleSettingName}"] = String(describing: self.autoscaleSettingName)
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
