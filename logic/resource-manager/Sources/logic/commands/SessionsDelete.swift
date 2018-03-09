import Foundation
import azureSwiftRuntime
public protocol SessionsDelete  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var integrationAccountName : String { get set }
    var sessionName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Sessions {
// Delete deletes an integration account session.
    internal class DeleteCommand : BaseCommand, SessionsDelete {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var integrationAccountName : String
        public var sessionName : String
        public var apiVersion = "2016-06-01"

        public init(subscriptionId: String, resourceGroupName: String, integrationAccountName: String, sessionName: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.integrationAccountName = integrationAccountName
            self.sessionName = sessionName
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/integrationAccounts/{integrationAccountName}/sessions/{sessionName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{integrationAccountName}"] = String(describing: self.integrationAccountName)
            self.pathParameters["{sessionName}"] = String(describing: self.sessionName)
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
