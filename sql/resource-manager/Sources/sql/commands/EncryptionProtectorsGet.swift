import Foundation
import azureSwiftRuntime
public protocol EncryptionProtectorsGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var encryptionProtectorName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (EncryptionProtectorProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.EncryptionProtectors {
// Get gets a server encryption protector.
internal class GetCommand : BaseCommand, EncryptionProtectorsGet {
    public var resourceGroupName : String
    public var serverName : String
    public var encryptionProtectorName : String
    public var subscriptionId : String
    public var apiVersion = "2015-05-01-preview"

    public init(resourceGroupName: String, serverName: String, encryptionProtectorName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.serverName = serverName
        self.encryptionProtectorName = encryptionProtectorName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/encryptionProtector/{encryptionProtectorName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{serverName}"] = String(describing: self.serverName)
        self.pathParameters["{encryptionProtectorName}"] = String(describing: self.encryptionProtectorName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(EncryptionProtectorData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (EncryptionProtectorProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: EncryptionProtectorData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
