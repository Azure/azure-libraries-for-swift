import Foundation
import azureSwiftRuntime
public protocol MetricBaselineCalculateBaseline  {
    var headerParameters: [String: String] { get set }
    var resourceUri : String { get set }
    var apiVersion : String { get set }
    var timeSeriesInformation :  TimeSeriesInformationProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (CalculateBaselineResponseProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.MetricBaseline {
// CalculateBaseline **Lists the baseline values for a resource**.
    internal class CalculateBaselineCommand : BaseCommand, MetricBaselineCalculateBaseline {
        public var resourceUri : String
        public var apiVersion = "2017-11-01-preview"
    public var timeSeriesInformation :  TimeSeriesInformationProtocol?

        public init(resourceUri: String, timeSeriesInformation: TimeSeriesInformationProtocol) {
            self.resourceUri = resourceUri
            self.timeSeriesInformation = timeSeriesInformation
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/{resourceUri}/providers/microsoft.insights/calculatebaseline"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceUri}"] = String(describing: self.resourceUri)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = timeSeriesInformation

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(timeSeriesInformation as? TimeSeriesInformationData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(CalculateBaselineResponseData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (CalculateBaselineResponseProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: CalculateBaselineResponseData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
