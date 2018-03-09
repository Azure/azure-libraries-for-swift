import Foundation
import azureSwiftRuntime
public protocol ServersListOperationResults  {
    var headerParameters: [String: String] { get set }
    var location : String { get set }
    var operationId : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Servers {
// ListOperationResults list the result of the specified operation.
    internal class ListOperationResultsCommand : BaseCommand, ServersListOperationResults {
        public var location : String
        public var operationId : String
        public var subscriptionId : String
        public var apiVersion = "2017-08-01"

        public init(location: String, operationId: String, subscriptionId: String) {
            self.location = location
            self.operationId = operationId
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.AnalysisServices/locations/{location}/operationresults/{operationId}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{location}"] = String(describing: self.location)
            self.pathParameters["{operationId}"] = String(describing: self.operationId)
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
