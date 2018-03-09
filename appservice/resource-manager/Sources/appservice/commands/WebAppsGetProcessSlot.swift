import Foundation
import azureSwiftRuntime
public protocol WebAppsGetProcessSlot  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var processId : String { get set }
    var slot : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ProcessInfoProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WebApps {
// GetProcessSlot get process information by its ID for a specific scaled-out instance in a web site.
    internal class GetProcessSlotCommand : BaseCommand, WebAppsGetProcessSlot {
        public var resourceGroupName : String
        public var name : String
        public var processId : String
        public var slot : String
        public var subscriptionId : String
        public var apiVersion = "2016-08-01"

        public init(resourceGroupName: String, name: String, processId: String, slot: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.processId = processId
            self.slot = slot
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/processes/{processId}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{processId}"] = String(describing: self.processId)
            self.pathParameters["{slot}"] = String(describing: self.slot)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ProcessInfoData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ProcessInfoProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: ProcessInfoData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
