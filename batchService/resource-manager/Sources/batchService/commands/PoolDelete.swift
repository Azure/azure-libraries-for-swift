import Foundation
import azureSwiftRuntime
public protocol PoolDelete  {
    var headerParameters: [String: String] { get set }
    var poolId : String { get set }
    var timeout : Int32? { get set }
    var apiVersion : String { get set }
    var clientRequestId : String? { get set }
    var returnClientRequestId : Bool? { get set }
    var ocpDate : Date? { get set }
    var ifMatch : String? { get set }
    var ifNoneMatch : String? { get set }
    var ifModifiedSince : Date? { get set }
    var ifUnmodifiedSince : Date? { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Pool {
// Delete when you request that a pool be deleted, the following actions occur: the pool state is set to deleting; any
// ongoing resize operation on the pool are stopped; the Batch service starts resizing the pool to zero nodes; any
// tasks running on existing nodes are terminated and requeued (as if a resize pool operation had been requested with
// the default requeue option); finally, the pool is removed from the system. Because running tasks are requeued, the
// user can rerun these tasks by updating their job to target a different pool. The tasks can then run on the new pool.
// If you want to override the requeue behavior, then you should call resize pool explicitly to shrink the pool to zero
// size before deleting the pool. If you call an Update, Patch or Delete API on a pool in the deleting state, it will
// fail with HTTP status code 409 with error code PoolBeingDeleted.
    internal class DeleteCommand : BaseCommand, PoolDelete {
        public var poolId : String
        public var timeout : Int32?
        public var apiVersion = "2017-09-01.6.0"
        public var clientRequestId : String?
        public var returnClientRequestId : Bool?
        public var ocpDate : Date?
        public var ifMatch : String?
        public var ifNoneMatch : String?
        public var ifModifiedSince : Date?
        public var ifUnmodifiedSince : Date?

        public init(poolId: String) {
            self.poolId = poolId
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = false
            self.path = "/pools/{poolId}"
            self.headerParameters = ["Content-Type":"application/json; odata=minimalmetadata; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{poolId}"] = String(describing: self.poolId)
            if self.timeout != nil { queryParameters["timeout"] = String(describing: self.timeout!) }
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            if self.clientRequestId != nil { headerParameters["client-request-id"] = String(describing: self.clientRequestId!) }
            if self.returnClientRequestId != nil { headerParameters["return-client-request-id"] = String(describing: self.returnClientRequestId!) }
            if self.ocpDate != nil { headerParameters["ocp-date"] = String(describing: self.ocpDate!) }
            if self.ifMatch != nil { headerParameters["If-Match"] = String(describing: self.ifMatch!) }
            if self.ifNoneMatch != nil { headerParameters["If-None-Match"] = String(describing: self.ifNoneMatch!) }
            if self.ifModifiedSince != nil { headerParameters["If-Modified-Since"] = String(describing: self.ifModifiedSince!) }
            if self.ifUnmodifiedSince != nil { headerParameters["If-Unmodified-Since"] = String(describing: self.ifUnmodifiedSince!) }

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
