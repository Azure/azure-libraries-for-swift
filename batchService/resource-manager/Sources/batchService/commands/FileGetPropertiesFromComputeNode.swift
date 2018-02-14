import Foundation
import azureSwiftRuntime
public protocol FileGetPropertiesFromComputeNode  {
    var headerParameters: [String: String] { get set }
    var poolId : String { get set }
    var nodeId : String { get set }
    var filePath : String { get set }
    var timeout : Int32? { get set }
    var apiVersion : String { get set }
    var clientRequestId : String? { get set }
    var returnClientRequestId : Bool? { get set }
    var ocpDate : Date? { get set }
    var ifModifiedSince : Date? { get set }
    var ifUnmodifiedSince : Date? { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.File {
// GetPropertiesFromComputeNode gets the properties of the specified compute node file.
internal class GetPropertiesFromComputeNodeCommand : BaseCommand, FileGetPropertiesFromComputeNode {
    public var poolId : String
    public var nodeId : String
    public var filePath : String
    public var timeout : Int32?
    public var apiVersion = "2017-09-01.6.0"
    public var clientRequestId : String?
    public var returnClientRequestId : Bool?
    public var ocpDate : Date?
    public var ifModifiedSince : Date?
    public var ifUnmodifiedSince : Date?

    public init(poolId: String, nodeId: String, filePath: String) {
        self.poolId = poolId
        self.nodeId = nodeId
        self.filePath = filePath
        super.init()
        self.method = "Head"
        self.isLongRunningOperation = false
        self.path = "/pools/{poolId}/nodes/{nodeId}/files/{filePath}"
        self.headerParameters = ["Content-Type":"application/json; odata=minimalmetadata; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{poolId}"] = String(describing: self.poolId)
        self.pathParameters["{nodeId}"] = String(describing: self.nodeId)
        self.pathParameters["{filePath}"] = String(describing: self.filePath)
        if self.timeout != nil { queryParameters["timeout"] = String(describing: self.timeout!) }
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
        if self.clientRequestId != nil { headerParameters["client-request-id"] = String(describing: self.clientRequestId!) }
        if self.returnClientRequestId != nil { headerParameters["return-client-request-id"] = String(describing: self.returnClientRequestId!) }
        if self.ocpDate != nil { headerParameters["ocp-date"] = String(describing: self.ocpDate!) }
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
