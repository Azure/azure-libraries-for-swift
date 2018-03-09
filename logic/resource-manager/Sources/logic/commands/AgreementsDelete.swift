import Foundation
import azureSwiftRuntime
public protocol AgreementsDelete  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var integrationAccountName : String { get set }
    var agreementName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Agreements {
// Delete deletes an integration account agreement.
    internal class DeleteCommand : BaseCommand, AgreementsDelete {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var integrationAccountName : String
        public var agreementName : String
        public var apiVersion = "2016-06-01"

        public init(subscriptionId: String, resourceGroupName: String, integrationAccountName: String, agreementName: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.integrationAccountName = integrationAccountName
            self.agreementName = agreementName
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/integrationAccounts/{integrationAccountName}/agreements/{agreementName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{integrationAccountName}"] = String(describing: self.integrationAccountName)
            self.pathParameters["{agreementName}"] = String(describing: self.agreementName)
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
