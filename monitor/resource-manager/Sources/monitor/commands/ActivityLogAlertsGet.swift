import Foundation
import azureSwiftRuntime
public protocol ActivityLogAlertsGet  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var activityLogAlertName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ActivityLogAlertResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ActivityLogAlerts {
// Get get an activity log alert.
    internal class GetCommand : BaseCommand, ActivityLogAlertsGet {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var activityLogAlertName : String
        public var apiVersion = "2017-04-01"

        public init(subscriptionId: String, resourceGroupName: String, activityLogAlertName: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.activityLogAlertName = activityLogAlertName
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.insights/activityLogAlerts/{activityLogAlertName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{activityLogAlertName}"] = String(describing: self.activityLogAlertName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ActivityLogAlertResourceData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ActivityLogAlertResourceProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: ActivityLogAlertResourceData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
