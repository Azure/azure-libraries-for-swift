import Foundation
import azureSwiftRuntime
public protocol PoolUpdateProperties  {
    var headerParameters: [String: String] { get set }
    var poolId : String { get set }
    var timeout : Int32? { get set }
    var apiVersion : String { get set }
    var clientRequestId : String? { get set }
    var returnClientRequestId : Bool? { get set }
    var ocpDate : Date? { get set }
    var poolUpdatePropertiesParameter :  PoolUpdatePropertiesParameterProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Pool {
// UpdateProperties this fully replaces all the updateable properties of the pool. For example, if the pool has a start
// task associated with it and if start task is not specified with this request, then the Batch service will remove the
// existing start task.
    internal class UpdatePropertiesCommand : BaseCommand, PoolUpdateProperties {
        public var poolId : String
        public var timeout : Int32?
        public var apiVersion = "2017-09-01.6.0"
        public var clientRequestId : String?
        public var returnClientRequestId : Bool?
        public var ocpDate : Date?
    public var poolUpdatePropertiesParameter :  PoolUpdatePropertiesParameterProtocol?

        public init(poolId: String, poolUpdatePropertiesParameter: PoolUpdatePropertiesParameterProtocol) {
            self.poolId = poolId
            self.poolUpdatePropertiesParameter = poolUpdatePropertiesParameter
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/pools/{poolId}/updateproperties"
            self.headerParameters = ["Content-Type":"application/json; odata=minimalmetadata; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{poolId}"] = String(describing: self.poolId)
            if self.timeout != nil { queryParameters["timeout"] = String(describing: self.timeout!) }
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            if self.clientRequestId != nil { headerParameters["client-request-id"] = String(describing: self.clientRequestId!) }
            if self.returnClientRequestId != nil { headerParameters["return-client-request-id"] = String(describing: self.returnClientRequestId!) }
            if self.ocpDate != nil { headerParameters["ocp-date"] = String(describing: self.ocpDate!) }
            self.body = poolUpdatePropertiesParameter

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(poolUpdatePropertiesParameter as? PoolUpdatePropertiesParameterData)
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
