import Foundation
import azureSwiftRuntime
public protocol MetricBaselineGet  {
    var headerParameters: [String: String] { get set }
    var resourceUri : String { get set }
    var metricName : String { get set }
    var timespan : String? { get set }
    var interval : String? { get set }
    var aggregation : String? { get set }
    var sensitivities : String? { get set }
    var resultType : ResultTypeEnum? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (BaselineResponseProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.MetricBaseline {
// Get **Gets the baseline values for a specific metric**.
internal class GetCommand : BaseCommand, MetricBaselineGet {
    public var resourceUri : String
    public var metricName : String
    public var timespan : String?
    public var interval : String?
    public var aggregation : String?
    public var sensitivities : String?
    public var resultType : ResultTypeEnum?
    public var apiVersion = "2017-11-01-preview"

    public init(resourceUri: String, metricName: String) {
        self.resourceUri = resourceUri
        self.metricName = metricName
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/{resourceUri}/providers/microsoft.insights/baseline/{metricName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceUri}"] = String(describing: self.resourceUri)
        self.pathParameters["{metricName}"] = String(describing: self.metricName)
        if self.timespan != nil { queryParameters["timespan"] = String(describing: self.timespan!) }
        if self.interval != nil { queryParameters["interval"] = String(describing: self.interval!) }
        if self.aggregation != nil { queryParameters["aggregation"] = String(describing: self.aggregation!) }
        if self.sensitivities != nil { queryParameters["sensitivities"] = String(describing: self.sensitivities!) }
        if self.resultType != nil { queryParameters["resultType"] = String(describing: self.resultType!) }
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(BaselineResponseData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (BaselineResponseProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: BaselineResponseData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
