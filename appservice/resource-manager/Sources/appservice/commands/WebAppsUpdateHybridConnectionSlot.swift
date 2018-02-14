import Foundation
import azureSwiftRuntime
public protocol WebAppsUpdateHybridConnectionSlot  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var namespaceName : String { get set }
    var relayName : String { get set }
    var slot : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var connectionEnvelope :  HybridConnectionProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (HybridConnectionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WebApps {
// UpdateHybridConnectionSlot creates a new Hybrid Connection using a Service Bus relay.
internal class UpdateHybridConnectionSlotCommand : BaseCommand, WebAppsUpdateHybridConnectionSlot {
    public var resourceGroupName : String
    public var name : String
    public var namespaceName : String
    public var relayName : String
    public var slot : String
    public var subscriptionId : String
    public var apiVersion = "2016-08-01"
    public var connectionEnvelope :  HybridConnectionProtocol?

    public init(resourceGroupName: String, name: String, namespaceName: String, relayName: String, slot: String, subscriptionId: String, connectionEnvelope: HybridConnectionProtocol) {
        self.resourceGroupName = resourceGroupName
        self.name = name
        self.namespaceName = namespaceName
        self.relayName = relayName
        self.slot = slot
        self.subscriptionId = subscriptionId
        self.connectionEnvelope = connectionEnvelope
        super.init()
        self.method = "Patch"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/hybridConnectionNamespaces/{namespaceName}/relays/{relayName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{name}"] = String(describing: self.name)
        self.pathParameters["{namespaceName}"] = String(describing: self.namespaceName)
        self.pathParameters["{relayName}"] = String(describing: self.relayName)
        self.pathParameters["{slot}"] = String(describing: self.slot)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = connectionEnvelope
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(connectionEnvelope)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(HybridConnectionData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (HybridConnectionProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: HybridConnectionData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
