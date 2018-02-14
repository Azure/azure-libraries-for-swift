import Foundation
import azureSwiftRuntime
public protocol WCFRelaysCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var namespaceName : String { get set }
    var relayName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  WcfRelayProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (WcfRelayProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WCFRelays {
// CreateOrUpdate creates or updates a WCF relay. This operation is idempotent.
internal class CreateOrUpdateCommand : BaseCommand, WCFRelaysCreateOrUpdate {
    public var resourceGroupName : String
    public var namespaceName : String
    public var relayName : String
    public var subscriptionId : String
    public var apiVersion = "2017-04-01"
    public var parameters :  WcfRelayProtocol?

    public init(resourceGroupName: String, namespaceName: String, relayName: String, subscriptionId: String, parameters: WcfRelayProtocol) {
        self.resourceGroupName = resourceGroupName
        self.namespaceName = namespaceName
        self.relayName = relayName
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/wcfRelays/{relayName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{namespaceName}"] = String(describing: self.namespaceName)
        self.pathParameters["{relayName}"] = String(describing: self.relayName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = parameters
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(parameters)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(WcfRelayData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (WcfRelayProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: WcfRelayData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
