import Foundation
import azureSwiftRuntime
public protocol InboundNatRulesDelete  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var loadBalancerName : String { get set }
    var inboundNatRuleName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.InboundNatRules {
// Delete deletes the specified load balancer inbound nat rule. This method may poll for completion. Polling can be
// canceled by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
    internal class DeleteCommand : BaseCommand, InboundNatRulesDelete {
        public var resourceGroupName : String
        public var loadBalancerName : String
        public var inboundNatRuleName : String
        public var subscriptionId : String
        public var apiVersion = "2018-01-01"

        public init(resourceGroupName: String, loadBalancerName: String, inboundNatRuleName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.loadBalancerName = loadBalancerName
            self.inboundNatRuleName = inboundNatRuleName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules/{inboundNatRuleName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{loadBalancerName}"] = String(describing: self.loadBalancerName)
            self.pathParameters["{inboundNatRuleName}"] = String(describing: self.inboundNatRuleName)
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
