import Foundation
import azureSwiftRuntime
public protocol DomainsDelete  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var domainName : String { get set }
    var subscriptionId : String { get set }
    var forceHardDeleteDomain : Bool? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Domains {
// Delete delete a domain.
    internal class DeleteCommand : BaseCommand, DomainsDelete {
        public var resourceGroupName : String
        public var domainName : String
        public var subscriptionId : String
        public var forceHardDeleteDomain : Bool?
        public var apiVersion = "2015-04-01"

        public init(resourceGroupName: String, domainName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.domainName = domainName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DomainRegistration/domains/{domainName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{domainName}"] = String(describing: self.domainName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            if self.forceHardDeleteDomain != nil { queryParameters["forceHardDeleteDomain"] = String(describing: self.forceHardDeleteDomain!) }
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
