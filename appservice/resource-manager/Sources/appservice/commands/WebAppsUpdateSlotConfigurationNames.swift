import Foundation
import azureSwiftRuntime
public protocol WebAppsUpdateSlotConfigurationNames  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var slotConfigNames :  SlotConfigNamesResourceProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (SlotConfigNamesResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WebApps {
// UpdateSlotConfigurationNames updates the names of application settings and connection string that remain with the
// slot during swap operation.
    internal class UpdateSlotConfigurationNamesCommand : BaseCommand, WebAppsUpdateSlotConfigurationNames {
        public var resourceGroupName : String
        public var name : String
        public var subscriptionId : String
        public var apiVersion = "2016-08-01"
    public var slotConfigNames :  SlotConfigNamesResourceProtocol?

        public init(resourceGroupName: String, name: String, subscriptionId: String, slotConfigNames: SlotConfigNamesResourceProtocol) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.subscriptionId = subscriptionId
            self.slotConfigNames = slotConfigNames
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/config/slotConfigNames"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = slotConfigNames

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(slotConfigNames as? SlotConfigNamesResourceData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(SlotConfigNamesResourceData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (SlotConfigNamesResourceProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: SlotConfigNamesResourceData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
