import Foundation
import azureSwiftRuntime
public protocol WebAppsUpdateSourceControlSlot  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var slot : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var siteSourceControl :  SiteSourceControlProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (SiteSourceControlProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WebApps {
// UpdateSourceControlSlot updates the source control configuration of an app.
    internal class UpdateSourceControlSlotCommand : BaseCommand, WebAppsUpdateSourceControlSlot {
        public var resourceGroupName : String
        public var name : String
        public var slot : String
        public var subscriptionId : String
        public var apiVersion = "2016-08-01"
    public var siteSourceControl :  SiteSourceControlProtocol?

        public init(resourceGroupName: String, name: String, slot: String, subscriptionId: String, siteSourceControl: SiteSourceControlProtocol) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.slot = slot
            self.subscriptionId = subscriptionId
            self.siteSourceControl = siteSourceControl
            super.init()
            self.method = "Patch"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/sourcecontrols/web"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{slot}"] = String(describing: self.slot)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = siteSourceControl

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(siteSourceControl as? SiteSourceControlData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(SiteSourceControlData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (SiteSourceControlProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: SiteSourceControlData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
