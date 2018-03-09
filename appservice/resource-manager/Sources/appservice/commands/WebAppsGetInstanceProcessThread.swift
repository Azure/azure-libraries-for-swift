import Foundation
import azureSwiftRuntime
public protocol WebAppsGetInstanceProcessThread  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var processId : String { get set }
    var threadId : String { get set }
    var instanceId : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ProcessThreadInfoProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WebApps {
// GetInstanceProcessThread get thread information by Thread ID for a specific process, in a specific scaled-out
// instance in a web site.
    internal class GetInstanceProcessThreadCommand : BaseCommand, WebAppsGetInstanceProcessThread {
        public var resourceGroupName : String
        public var name : String
        public var processId : String
        public var threadId : String
        public var instanceId : String
        public var subscriptionId : String
        public var apiVersion = "2016-08-01"

        public init(resourceGroupName: String, name: String, processId: String, threadId: String, instanceId: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.processId = processId
            self.threadId = threadId
            self.instanceId = instanceId
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/instances/{instanceId}/processes/{processId}/threads/{threadId}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{processId}"] = String(describing: self.processId)
            self.pathParameters["{threadId}"] = String(describing: self.threadId)
            self.pathParameters["{instanceId}"] = String(describing: self.instanceId)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ProcessThreadInfoData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ProcessThreadInfoProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: ProcessThreadInfoData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
