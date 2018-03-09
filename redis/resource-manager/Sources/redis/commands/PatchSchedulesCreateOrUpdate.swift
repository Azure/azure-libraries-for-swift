import Foundation
import azureSwiftRuntime
public protocol PatchSchedulesCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var _default : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  RedisPatchScheduleProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (RedisPatchScheduleProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.PatchSchedules {
// CreateOrUpdate create or replace the patching schedule for Redis cache (requires Premium SKU).
    internal class CreateOrUpdateCommand : BaseCommand, PatchSchedulesCreateOrUpdate {
        public var resourceGroupName : String
        public var name : String
        public var _default : String
        public var subscriptionId : String
        public var apiVersion = "2017-10-01"
    public var parameters :  RedisPatchScheduleProtocol?

        public init(resourceGroupName: String, name: String, _default: String, subscriptionId: String, parameters: RedisPatchScheduleProtocol) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self._default = _default
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Put"
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
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? RedisPatchScheduleData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
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
