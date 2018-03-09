import Foundation
import azureSwiftRuntime
public protocol ContainerGroupUsageList  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var location : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (UsageListResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ContainerGroupUsage {
// List get the usage for a subscription
    internal class ListCommand : BaseCommand, ContainerGroupUsageList {
        public var subscriptionId : String
        public var location : String
        public var apiVersion = "2018-02-01-preview"

        public init(subscriptionId: String, location: String) {
            self.subscriptionId = subscriptionId
            self.location = location
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.ContainerInstance/locations/{location}/usages"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{location}"] = String(describing: self.location)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(UsageListResultData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (UsageListResultProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: UsageListResultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
