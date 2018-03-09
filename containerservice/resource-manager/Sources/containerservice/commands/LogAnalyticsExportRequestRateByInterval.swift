import Foundation
import azureSwiftRuntime
public protocol LogAnalyticsExportRequestRateByInterval  {
    var headerParameters: [String: String] { get set }
    var location : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  RequestRateByIntervalInputProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (LogAnalyticsOperationResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.LogAnalytics {
// ExportRequestRateByInterval export logs that show Api requests made by this subscription in the given time window to
// show throttling activities. This method may poll for completion. Polling can be canceled by passing the cancel
// channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
    internal class ExportRequestRateByIntervalCommand : BaseCommand, LogAnalyticsExportRequestRateByInterval {
        public var location : String
        public var subscriptionId : String
        public var apiVersion = "2017-12-01"
    public var parameters :  RequestRateByIntervalInputProtocol?

        public init(location: String, subscriptionId: String, parameters: RequestRateByIntervalInputProtocol) {
            self.location = location
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/logAnalytics/apiAccess/getRequestRateByInterval"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{location}"] = String(describing: self.location)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? RequestRateByIntervalInputData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(LogAnalyticsOperationResultData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (LogAnalyticsOperationResultProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: LogAnalyticsOperationResultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
