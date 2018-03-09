import Foundation
import azureSwiftRuntime
public protocol MetricsList  {
    var headerParameters: [String: String] { get set }
    var resourceUri : String { get set }
    var timespan : String? { get set }
    var interval : String? { get set }
    var metricnames : String? { get set }
    var aggregation : String? { get set }
    var top : Double? { get set }
    var orderby : String? { get set }
    var filter : String? { get set }
    var resultType : ResultTypeEnum? { get set }
    var apiVersion : String { get set }
    var metricnamespace : String? { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ResponseProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Metrics {
// List **Lists the metric values for a resource**.
    internal class ListCommand : BaseCommand, MetricsList {
        public var resourceUri : String
        public var timespan : String?
        public var interval : String?
        public var metricnames : String?
        public var aggregation : String?
        public var top : Double?
        public var orderby : String?
        public var filter : String?
        public var resultType : ResultTypeEnum?
        public var apiVersion = "2018-01-01"
        public var metricnamespace : String?

        public init(resourceUri: String) {
            self.resourceUri = resourceUri
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/{resourceUri}/providers/microsoft.insights/metrics"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceUri}"] = String(describing: self.resourceUri)
            if self.timespan != nil { queryParameters["timespan"] = String(describing: self.timespan!) }
            if self.interval != nil { queryParameters["interval"] = String(describing: self.interval!) }
            if self.metricnames != nil { queryParameters["metricnames"] = String(describing: self.metricnames!) }
            if self.aggregation != nil { queryParameters["aggregation"] = String(describing: self.aggregation!) }
            if self.top != nil { queryParameters["top"] = String(describing: self.top!) }
            if self.orderby != nil { queryParameters["orderby"] = String(describing: self.orderby!) }
            if self.filter != nil { queryParameters["$filter"] = String(describing: self.filter!) }
            if self.resultType != nil { queryParameters["resultType"] = String(describing: self.resultType!) }
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            if self.metricnamespace != nil { queryParameters["metricnamespace"] = String(describing: self.metricnamespace!) }

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ResponseData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ResponseProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: ResponseData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
