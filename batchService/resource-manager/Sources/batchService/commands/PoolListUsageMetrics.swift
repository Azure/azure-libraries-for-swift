import Foundation
import azureSwiftRuntime
public protocol PoolListUsageMetrics  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var startTime : Date? { get set }
    var endTime : Date? { get set }
    var filter : String? { get set }
    var maxResults : Int32? { get set }
    var timeout : Int32? { get set }
    var apiVersion : String { get set }
    var clientRequestId : String? { get set }
    var returnClientRequestId : Bool? { get set }
    var ocpDate : Date? { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (PoolListUsageMetricsResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Pool {
// ListUsageMetrics if you do not specify a $filter clause including a poolId, the response includes all pools that
// existed in the account in the time range of the returned aggregation intervals. If you do not specify a $filter
// clause including a startTime or endTime these filters default to the start and end times of the last aggregation
// interval currently available; that is, only the last aggregation interval is returned.
    internal class ListUsageMetricsCommand : BaseCommand, PoolListUsageMetrics {
        var nextLink: String?
        public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
        public var startTime : Date?
        public var endTime : Date?
        public var filter : String?
        public var maxResults : Int32?
        public var timeout : Int32?
        public var apiVersion = "2017-09-01.6.0"
        public var clientRequestId : String?
        public var returnClientRequestId : Bool?
        public var ocpDate : Date?

    public override init() {
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/poolusagemetrics"
            self.headerParameters = ["Content-Type":"application/json; odata=minimalmetadata; charset=utf-8"]
        }

        public override func preCall()  {
            if self.startTime != nil { queryParameters["starttime"] = String(describing: self.startTime!) }
            if self.endTime != nil { queryParameters["endtime"] = String(describing: self.endTime!) }
            if self.filter != nil { queryParameters["$filter"] = String(describing: self.filter!) }
            if self.maxResults != nil { queryParameters["maxresults"] = String(describing: self.maxResults!) }
            if self.timeout != nil { queryParameters["timeout"] = String(describing: self.timeout!) }
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            if self.clientRequestId != nil { headerParameters["client-request-id"] = String(describing: self.clientRequestId!) }
            if self.returnClientRequestId != nil { headerParameters["return-client-request-id"] = String(describing: self.returnClientRequestId!) }
            if self.ocpDate != nil { headerParameters["ocp-date"] = String(describing: self.ocpDate!) }

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                if var pageDecoder = decoder as? PageDecoder {
                    pageDecoder.isPagedData = true
                    pageDecoder.nextLinkName = "OdatanextLink"
                }
                let result = try decoder.decode(PoolListUsageMetricsResultData?.self, from: data)
                if var pageDecoder = decoder as? PageDecoder {
                    self.nextLink = pageDecoder.nextLink
                }
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (PoolListUsageMetricsResultProtocol?, Error?) -> Void) -> Void {
            if self.nextLink != nil {
                self.path = nextLink!
                self.nextLink = nil;
                self.pathType = .absolute
            }
            client.executeAsync(command: self) {
                (result: PoolListUsageMetricsResultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
