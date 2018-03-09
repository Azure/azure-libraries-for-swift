import Foundation
import azureSwiftRuntime
public protocol WebAppsInstallSiteExtensionSlot  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var siteExtensionId : String { get set }
    var slot : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (SiteExtensionInfoProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WebApps {
// InstallSiteExtensionSlot install site extension on a web site, or a deployment slot. This method may poll for
// completion. Polling can be canceled by passing the cancel channel argument. The channel will be used to cancel
// polling and any outstanding HTTP requests.
    internal class InstallSiteExtensionSlotCommand : BaseCommand, WebAppsInstallSiteExtensionSlot {
        public var resourceGroupName : String
        public var name : String
        public var siteExtensionId : String
        public var slot : String
        public var subscriptionId : String
        public var apiVersion = "2016-08-01"

        public init(resourceGroupName: String, name: String, siteExtensionId: String, slot: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.siteExtensionId = siteExtensionId
            self.slot = slot
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/siteextensions/{siteExtensionId}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{siteExtensionId}"] = String(describing: self.siteExtensionId)
            self.pathParameters["{slot}"] = String(describing: self.slot)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(SiteExtensionInfoData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (SiteExtensionInfoProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: SiteExtensionInfoData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
