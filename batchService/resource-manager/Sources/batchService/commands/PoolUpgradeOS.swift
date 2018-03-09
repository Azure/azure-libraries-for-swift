import Foundation
import azureSwiftRuntime
public protocol PoolUpgradeOS  {
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
    var poolUpgradeOSParameter :  PoolUpgradeOSParameterProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Pool {
// UpgradeOS during an upgrade, the Batch service upgrades each compute node in the pool. When a compute node is chosen
// for upgrade, any tasks running on that node are removed from the node and returned to the queue to be rerun later
// (or on a different compute node). The node will be unavailable until the upgrade is complete. This operation results
// in temporarily reduced pool capacity as nodes are taken out of service to be upgraded. Although the Batch service
// tries to avoid upgrading all compute nodes at the same time, it does not guarantee to do this (particularly on small
// pools); therefore, the pool may be temporarily unavailable to run tasks. When this operation runs, the pool state
// changes to upgrading. When all compute nodes have finished upgrading, the pool state returns to active. While the
// upgrade is in progress, the pool's currentOSVersion reflects the OS version that nodes are upgrading from, and
// targetOSVersion reflects the OS version that nodes are upgrading to. Once the upgrade is complete, currentOSVersion
// is updated to reflect the OS version now running on all nodes. This operation can only be invoked on pools created
// with the cloudServiceConfiguration property.
    internal class UpgradeOSCommand : BaseCommand, PoolUpgradeOS {
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
    public var poolUpgradeOSParameter :  PoolUpgradeOSParameterProtocol?

        public init(poolId: String, poolUpgradeOSParameter: PoolUpgradeOSParameterProtocol) {
            self.poolId = poolId
            self.poolUpgradeOSParameter = poolUpgradeOSParameter
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/pools/{poolId}/upgradeos"
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
            self.body = poolUpgradeOSParameter

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(poolUpgradeOSParameter as? PoolUpgradeOSParameterData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
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
