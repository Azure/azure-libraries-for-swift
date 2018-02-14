import Foundation
import azureSwiftRuntime
public protocol IotHubResourceGetKeysForKeyName  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var resourceName : String { get set }
    var keyName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (SharedAccessSignatureAuthorizationRuleProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.IotHubResource {
// GetKeysForKeyName get a shared access policy by name from an IoT hub. For more information, see:
// https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-security.
internal class GetKeysForKeyNameCommand : BaseCommand, IotHubResourceGetKeysForKeyName {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var resourceName : String
    public var keyName : String
    public var apiVersion = "2017-07-01"

    public init(subscriptionId: String, resourceGroupName: String, resourceName: String, keyName: String) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.resourceName = resourceName
        self.keyName = keyName
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/IotHubKeys/{keyName}/listkeys"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{resourceName}"] = String(describing: self.resourceName)
        self.pathParameters["{keyName}"] = String(describing: self.keyName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(SharedAccessSignatureAuthorizationRuleData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (SharedAccessSignatureAuthorizationRuleProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: SharedAccessSignatureAuthorizationRuleData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
