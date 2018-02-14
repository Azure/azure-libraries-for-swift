import Foundation
import azureSwiftRuntime
public protocol TrafficManagerUserMetricsKeysDelete  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (DeleteOperationResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.TrafficManagerUserMetricsKeys {
// Delete delete a subscription-level key used for Real User Metrics collection.
internal class DeleteCommand : BaseCommand, TrafficManagerUserMetricsKeysDelete {
    public var subscriptionId : String
    public var apiVersion = "2017-09-01-preview"

    public init(subscriptionId: String) {
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Delete"
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
            let result = try decoder.decode(DeleteOperationResultData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (DeleteOperationResultProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: DeleteOperationResultData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
