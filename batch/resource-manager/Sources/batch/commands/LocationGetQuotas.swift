import Foundation
import azureSwiftRuntime
public protocol LocationGetQuotas  {
    var headerParameters: [String: String] { get set }
    var locationName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (BatchLocationQuotaProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Location {
// GetQuotas gets the Batch service quotas for the specified subscription at the given location.
    internal class GetQuotasCommand : BaseCommand, LocationGetQuotas {
        public var locationName : String
        public var subscriptionId : String
        public var apiVersion = "2017-09-01"

        public init(locationName: String, subscriptionId: String) {
            self.locationName = locationName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Batch/locations/{locationName}/quotas"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{locationName}"] = String(describing: self.locationName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(BatchLocationQuotaData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (BatchLocationQuotaProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: BatchLocationQuotaData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
