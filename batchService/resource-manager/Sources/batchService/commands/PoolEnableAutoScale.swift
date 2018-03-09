import Foundation
import azureSwiftRuntime
public protocol PoolEnableAutoScale  {
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
    var poolEnableAutoScaleParameter :  PoolEnableAutoScaleParameterProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Pool {
// EnableAutoScale you cannot enable automatic scaling on a pool if a resize operation is in progress on the pool. If
// automatic scaling of the pool is currently disabled, you must specify a valid autoscale formula as part of the
// request. If automatic scaling of the pool is already enabled, you may specify a new autoscale formula and/or a new
// evaluation interval. You cannot call this API for the same pool more than once every 30 seconds.
    internal class EnableAutoScaleCommand : BaseCommand, PoolEnableAutoScale {
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
    public var poolEnableAutoScaleParameter :  PoolEnableAutoScaleParameterProtocol?

        public init(poolId: String, poolEnableAutoScaleParameter: PoolEnableAutoScaleParameterProtocol) {
            self.poolId = poolId
            self.poolEnableAutoScaleParameter = poolEnableAutoScaleParameter
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/pools/{poolId}/enableautoscale"
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
            self.body = poolEnableAutoScaleParameter

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(poolEnableAutoScaleParameter as? PoolEnableAutoScaleParameterData)
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
