import Foundation
import azureSwiftRuntime
public protocol TrafficManagerUserMetricsKeysCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (TrafficManagerUserMetricsKeyModelProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.TrafficManagerUserMetricsKeys {
// CreateOrUpdate create or update a subscription-level key used for Real User Metrics collection.
internal class CreateOrUpdateCommand : BaseCommand, TrafficManagerUserMetricsKeysCreateOrUpdate {
    public var subscriptionId : String
    public var apiVersion = "2017-09-01-preview"

    public init(subscriptionId: String) {
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Network/trafficManagerUserMetricsKeys"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(TrafficManagerUserMetricsKeyModelData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (TrafficManagerUserMetricsKeyModelProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: TrafficManagerUserMetricsKeyModelData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
