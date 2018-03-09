import Foundation
import azureSwiftRuntime
public protocol PredictionsCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var hubName : String { get set }
    var predictionName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  PredictionResourceFormatProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (PredictionResourceFormatProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Predictions {
// CreateOrUpdate creates a Prediction or updates an existing Prediction in the hub. This method may poll for
// completion. Polling can be canceled by passing the cancel channel argument. The channel will be used to cancel
// polling and any outstanding HTTP requests.
    internal class CreateOrUpdateCommand : BaseCommand, PredictionsCreateOrUpdate {
        public var resourceGroupName : String
        public var hubName : String
        public var predictionName : String
        public var subscriptionId : String
        public var apiVersion = "2017-04-26"
    public var parameters :  PredictionResourceFormatProtocol?

        public init(resourceGroupName: String, hubName: String, predictionName: String, subscriptionId: String, parameters: PredictionResourceFormatProtocol) {
            self.resourceGroupName = resourceGroupName
            self.hubName = hubName
            self.predictionName = predictionName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/predictions/{predictionName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{hubName}"] = String(describing: self.hubName)
            self.pathParameters["{predictionName}"] = String(describing: self.predictionName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? PredictionResourceFormatData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(PredictionResourceFormatData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (PredictionResourceFormatProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: PredictionResourceFormatData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
