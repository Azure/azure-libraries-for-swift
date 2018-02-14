import Foundation
import azureSwiftRuntime
public protocol PredictionsGetTrainingResults  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var hubName : String { get set }
    var predictionName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (PredictionTrainingResultsProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Predictions {
// GetTrainingResults gets training results.
internal class GetTrainingResultsCommand : BaseCommand, PredictionsGetTrainingResults {
    public var resourceGroupName : String
    public var hubName : String
    public var predictionName : String
    public var subscriptionId : String
    public var apiVersion = "2017-04-26"

    public init(resourceGroupName: String, hubName: String, predictionName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.hubName = hubName
        self.predictionName = predictionName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/predictions/{predictionName}/getTrainingResults"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{hubName}"] = String(describing: self.hubName)
        self.pathParameters["{predictionName}"] = String(describing: self.predictionName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(PredictionTrainingResultsData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (PredictionTrainingResultsProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: PredictionTrainingResultsData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
