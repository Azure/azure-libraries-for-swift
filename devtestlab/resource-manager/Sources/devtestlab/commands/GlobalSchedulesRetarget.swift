import Foundation
import azureSwiftRuntime
public protocol GlobalSchedulesRetarget  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var apiVersion : String { get set }
    var retargetScheduleProperties :  RetargetSchedulePropertiesProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.GlobalSchedules {
// Retarget updates a schedule's target resource Id. This operation can take a while to complete. This method may poll
// for completion. Polling can be canceled by passing the cancel channel argument. The channel will be used to cancel
// polling and any outstanding HTTP requests.
    internal class RetargetCommand : BaseCommand, GlobalSchedulesRetarget {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var name : String
        public var apiVersion = "2016-05-15"
    public var retargetScheduleProperties :  RetargetSchedulePropertiesProtocol?

        public init(subscriptionId: String, resourceGroupName: String, name: String, retargetScheduleProperties: RetargetSchedulePropertiesProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.retargetScheduleProperties = retargetScheduleProperties
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/schedules/{name}/retarget"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = retargetScheduleProperties

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(retargetScheduleProperties as? RetargetSchedulePropertiesData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public func execute(client: RuntimeClient,
            completionHandler: @escaping (Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (error) in
                completionHandler(error)
            }
        }
    }
}
