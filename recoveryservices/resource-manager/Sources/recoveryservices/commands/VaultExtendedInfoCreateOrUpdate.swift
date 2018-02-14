import Foundation
import azureSwiftRuntime
public protocol VaultExtendedInfoCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var vaultName : String { get set }
    var apiVersion : String { get set }
    var resourceResourceExtendedInfoDetails :  VaultExtendedInfoResourceProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (VaultExtendedInfoResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.VaultExtendedInfo {
// CreateOrUpdate create vault extended info.
internal class CreateOrUpdateCommand : BaseCommand, VaultExtendedInfoCreateOrUpdate {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var vaultName : String
    public var apiVersion = "2016-06-01"
    public var resourceResourceExtendedInfoDetails :  VaultExtendedInfoResourceProtocol?

    public init(subscriptionId: String, resourceGroupName: String, vaultName: String, resourceResourceExtendedInfoDetails: VaultExtendedInfoResourceProtocol) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.vaultName = vaultName
        self.resourceResourceExtendedInfoDetails = resourceResourceExtendedInfoDetails
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/extendedInformation/vaultExtendedInfo"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{vaultName}"] = String(describing: self.vaultName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = resourceResourceExtendedInfoDetails
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(resourceResourceExtendedInfoDetails)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(VaultExtendedInfoResourceData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (VaultExtendedInfoResourceProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: VaultExtendedInfoResourceData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
