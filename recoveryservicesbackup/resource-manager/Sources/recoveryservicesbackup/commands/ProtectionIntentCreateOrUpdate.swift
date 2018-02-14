import Foundation
import azureSwiftRuntime
public protocol ProtectionIntentCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var vaultName : String { get set }
    var resourceGroupName : String { get set }
    var subscriptionId : String { get set }
    var fabricName : String { get set }
    var intentObjectName : String { get set }
    var apiVersion : String { get set }
    var parameters :  ProtectionIntentResourceProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ProtectionIntentResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ProtectionIntent {
// CreateOrUpdate create Intent for Enabling backup of an item. This is a synchronous operation.
internal class CreateOrUpdateCommand : BaseCommand, ProtectionIntentCreateOrUpdate {
    public var vaultName : String
    public var resourceGroupName : String
    public var subscriptionId : String
    public var fabricName : String
    public var intentObjectName : String
    public var apiVersion = "2017-07-01"
    public var parameters :  ProtectionIntentResourceProtocol?

    public init(vaultName: String, resourceGroupName: String, subscriptionId: String, fabricName: String, intentObjectName: String, parameters: ProtectionIntentResourceProtocol) {
        self.vaultName = vaultName
        self.resourceGroupName = resourceGroupName
        self.subscriptionId = subscriptionId
        self.fabricName = fabricName
        self.intentObjectName = intentObjectName
        self.parameters = parameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/backupProtectionIntent/{intentObjectName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{vaultName}"] = String(describing: self.vaultName)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{fabricName}"] = String(describing: self.fabricName)
        self.pathParameters["{intentObjectName}"] = String(describing: self.intentObjectName)
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
            let result = try decoder.decode(ProtectionIntentResourceData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ProtectionIntentResourceProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: ProtectionIntentResourceData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
