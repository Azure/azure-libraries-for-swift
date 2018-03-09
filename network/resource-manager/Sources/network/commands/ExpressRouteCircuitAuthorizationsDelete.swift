import Foundation
import azureSwiftRuntime
public protocol ExpressRouteCircuitAuthorizationsDelete  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var circuitName : String { get set }
    var authorizationName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.ExpressRouteCircuitAuthorizations {
// Delete deletes the specified authorization from the specified express route circuit. This method may poll for
// completion. Polling can be canceled by passing the cancel channel argument. The channel will be used to cancel
// polling and any outstanding HTTP requests.
    internal class DeleteCommand : BaseCommand, ExpressRouteCircuitAuthorizationsDelete {
        public var resourceGroupName : String
        public var circuitName : String
        public var authorizationName : String
        public var subscriptionId : String
        public var apiVersion = "2018-01-01"

        public init(resourceGroupName: String, circuitName: String, authorizationName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.circuitName = circuitName
            self.authorizationName = authorizationName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}/authorizations/{authorizationName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{circuitName}"] = String(describing: self.circuitName)
            self.pathParameters["{authorizationName}"] = String(describing: self.authorizationName)
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
