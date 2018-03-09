import Foundation
import azureSwiftRuntime
public protocol WebAppsStartWebSiteNetworkTraceSlot  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var slot : String { get set }
    var subscriptionId : String { get set }
    var durationInSeconds : Int32? { get set }
    var maxFrameLength : Int32? { get set }
    var sasUrl : String? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (String?, Error?) -> Void) -> Void ;
}

extension Commands.WebApps {
// StartWebSiteNetworkTraceSlot start capturing network packets for the site.
    internal class StartWebSiteNetworkTraceSlotCommand : BaseCommand, WebAppsStartWebSiteNetworkTraceSlot {
        public var resourceGroupName : String
        public var name : String
        public var slot : String
        public var subscriptionId : String
        public var durationInSeconds : Int32?
        public var maxFrameLength : Int32?
        public var sasUrl : String?
        public var apiVersion = "2016-08-01"

        public init(resourceGroupName: String, name: String, slot: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.slot = slot
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/networkTrace/start"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{slot}"] = String(describing: self.slot)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            if self.durationInSeconds != nil { queryParameters["durationInSeconds"] = String(describing: self.durationInSeconds!) }
            if self.maxFrameLength != nil { queryParameters["maxFrameLength"] = String(describing: self.maxFrameLength!) }
            if self.sasUrl != nil { queryParameters["sasUrl"] = String(describing: self.sasUrl!) }
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(String?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (String?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: String?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
