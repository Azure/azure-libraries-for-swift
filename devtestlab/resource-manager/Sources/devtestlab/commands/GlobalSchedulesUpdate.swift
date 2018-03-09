import Foundation
import azureSwiftRuntime
public protocol GlobalSchedulesUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var apiVersion : String { get set }
    var schedule :  ScheduleFragmentProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ScheduleProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.GlobalSchedules {
// Update modify properties of schedules.
    internal class UpdateCommand : BaseCommand, GlobalSchedulesUpdate {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var name : String
        public var apiVersion = "2016-05-15"
    public var schedule :  ScheduleFragmentProtocol?

        public init(subscriptionId: String, resourceGroupName: String, name: String, schedule: ScheduleFragmentProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.schedule = schedule
            super.init()
            self.method = "Patch"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/schedules/{name}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = schedule

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(schedule as? ScheduleFragmentData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ScheduleData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ScheduleProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: ScheduleData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
