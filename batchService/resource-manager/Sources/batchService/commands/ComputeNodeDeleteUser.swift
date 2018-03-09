import Foundation
import azureSwiftRuntime
public protocol ComputeNodeDeleteUser  {
    var headerParameters: [String: String] { get set }
    var poolId : String { get set }
    var nodeId : String { get set }
    var userName : String { get set }
    var timeout : Int32? { get set }
    var apiVersion : String { get set }
    var clientRequestId : String? { get set }
    var returnClientRequestId : Bool? { get set }
    var ocpDate : Date? { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.ComputeNode {
// DeleteUser you can delete a user account to a node only when it is in the idle or running state.
    internal class DeleteUserCommand : BaseCommand, ComputeNodeDeleteUser {
        public var poolId : String
        public var nodeId : String
        public var userName : String
        public var timeout : Int32?
        public var apiVersion = "2017-09-01.6.0"
        public var clientRequestId : String?
        public var returnClientRequestId : Bool?
        public var ocpDate : Date?

        public init(poolId: String, nodeId: String, userName: String) {
            self.poolId = poolId
            self.nodeId = nodeId
            self.userName = userName
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = false
            self.path = "/pools/{poolId}/nodes/{nodeId}/users/{userName}"
            self.headerParameters = ["Content-Type":"application/json; odata=minimalmetadata; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{poolId}"] = String(describing: self.poolId)
            self.pathParameters["{nodeId}"] = String(describing: self.nodeId)
            self.pathParameters["{userName}"] = String(describing: self.userName)
            if self.timeout != nil { queryParameters["timeout"] = String(describing: self.timeout!) }
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            if self.clientRequestId != nil { headerParameters["client-request-id"] = String(describing: self.clientRequestId!) }
            if self.returnClientRequestId != nil { headerParameters["return-client-request-id"] = String(describing: self.returnClientRequestId!) }
            if self.ocpDate != nil { headerParameters["ocp-date"] = String(describing: self.ocpDate!) }

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
