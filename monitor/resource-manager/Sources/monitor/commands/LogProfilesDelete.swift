import Foundation
import azureSwiftRuntime
public protocol LogProfilesDelete  {
    var headerParameters: [String: String] { get set }
    var logProfileName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.LogProfiles {
// Delete deletes the log profile.
    internal class DeleteCommand : BaseCommand, LogProfilesDelete {
        public var logProfileName : String
        public var subscriptionId : String
        public var apiVersion = "2016-03-01"

        public init(logProfileName: String, subscriptionId: String) {
            self.logProfileName = logProfileName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/providers/microsoft.insights/logprofiles/{logProfileName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{logProfileName}"] = String(describing: self.logProfileName)
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
