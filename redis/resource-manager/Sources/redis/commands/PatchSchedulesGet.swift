import Foundation
import azureSwiftRuntime
public protocol PatchSchedulesGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var _default : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (RedisPatchScheduleProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.PatchSchedules {
// Get gets the patching schedule of a redis cache (requires Premium SKU).
    internal class GetCommand : BaseCommand, PatchSchedulesGet {
        public var resourceGroupName : String
        public var name : String
        public var _default : String
        public var subscriptionId : String
        public var apiVersion = "2017-10-01"

        public init(resourceGroupName: String, name: String, _default: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self._default = _default
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/Redis/{name}/patchSchedules/{default}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{default}"] = String(describing: self._default)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(RedisPatchScheduleData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (RedisPatchScheduleProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: RedisPatchScheduleData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
