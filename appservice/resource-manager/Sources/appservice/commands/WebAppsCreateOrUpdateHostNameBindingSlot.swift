import Foundation
import azureSwiftRuntime
public protocol WebAppsCreateOrUpdateHostNameBindingSlot  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var hostName : String { get set }
    var slot : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var hostNameBinding :  HostNameBindingProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (HostNameBindingProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WebApps {
// CreateOrUpdateHostNameBindingSlot creates a hostname binding for an app.
    internal class CreateOrUpdateHostNameBindingSlotCommand : BaseCommand, WebAppsCreateOrUpdateHostNameBindingSlot {
        public var resourceGroupName : String
        public var name : String
        public var hostName : String
        public var slot : String
        public var subscriptionId : String
        public var apiVersion = "2016-08-01"
    public var hostNameBinding :  HostNameBindingProtocol?

        public init(resourceGroupName: String, name: String, hostName: String, slot: String, subscriptionId: String, hostNameBinding: HostNameBindingProtocol) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.hostName = hostName
            self.slot = slot
            self.subscriptionId = subscriptionId
            self.hostNameBinding = hostNameBinding
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hostNameBindings/{hostName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{hostName}"] = String(describing: self.hostName)
            self.pathParameters["{slot}"] = String(describing: self.slot)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = hostNameBinding

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(hostNameBinding as? HostNameBindingData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(HostNameBindingData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (HostNameBindingProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: HostNameBindingData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
