import Foundation
import azureSwiftRuntime
public protocol PoolGetAllLifetimeStatistics  {
    var headerParameters: [String: String] { get set }
    var timeout : Int32? { get set }
    var apiVersion : String { get set }
    var clientRequestId : String? { get set }
    var returnClientRequestId : Bool? { get set }
    var ocpDate : Date? { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (PoolStatisticsProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Pool {
// GetAllLifetimeStatistics statistics are aggregated across all pools that have ever existed in the account, from
// account creation to the last update time of the statistics.
    internal class GetAllLifetimeStatisticsCommand : BaseCommand, PoolGetAllLifetimeStatistics {
        public var timeout : Int32?
        public var apiVersion = "2017-09-01.6.0"
        public var clientRequestId : String?
        public var returnClientRequestId : Bool?
        public var ocpDate : Date?

    public override init() {
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/lifetimepoolstats"
            self.headerParameters = ["Content-Type":"application/json; odata=minimalmetadata; charset=utf-8"]
        }

        public override func preCall()  {
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
                let result = try decoder.decode(PoolStatisticsData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (PoolStatisticsProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: PoolStatisticsData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
