import Foundation
import azureSwiftRuntime
public protocol PoolEvaluateAutoScale  {
    var headerParameters: [String: String] { get set }
    var poolId : String { get set }
    var timeout : Int32? { get set }
    var apiVersion : String { get set }
    var clientRequestId : String? { get set }
    var returnClientRequestId : Bool? { get set }
    var ocpDate : Date? { get set }
    var poolEvaluateAutoScaleParameter :  PoolEvaluateAutoScaleParameterProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (AutoScaleRunProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Pool {
// EvaluateAutoScale this API is primarily for validating an autoscale formula, as it simply returns the result without
// applying the formula to the pool. The pool must have auto scaling enabled in order to evaluate a formula.
internal class EvaluateAutoScaleCommand : BaseCommand, PoolEvaluateAutoScale {
    public var poolId : String
    public var timeout : Int32?
    public var apiVersion = "2017-09-01.6.0"
    public var clientRequestId : String?
    public var returnClientRequestId : Bool?
    public var ocpDate : Date?
    public var poolEvaluateAutoScaleParameter :  PoolEvaluateAutoScaleParameterProtocol?

    public init(poolId: String, poolEvaluateAutoScaleParameter: PoolEvaluateAutoScaleParameterProtocol) {
        self.poolId = poolId
        self.poolEvaluateAutoScaleParameter = poolEvaluateAutoScaleParameter
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/pools/{poolId}/evaluateautoscale"
        self.headerParameters = ["Content-Type":"application/json; odata=minimalmetadata; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{poolId}"] = String(describing: self.poolId)
        if self.timeout != nil { queryParameters["timeout"] = String(describing: self.timeout!) }
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
        if self.clientRequestId != nil { headerParameters["client-request-id"] = String(describing: self.clientRequestId!) }
        if self.returnClientRequestId != nil { headerParameters["return-client-request-id"] = String(describing: self.returnClientRequestId!) }
        if self.ocpDate != nil { headerParameters["ocp-date"] = String(describing: self.ocpDate!) }
    self.body = poolEvaluateAutoScaleParameter
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(poolEvaluateAutoScaleParameter)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(AutoScaleRunData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (AutoScaleRunProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: AutoScaleRunData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
