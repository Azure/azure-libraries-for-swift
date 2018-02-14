import Foundation
import azureSwiftRuntime
public protocol DisasterRecoveryConfigsGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var namespaceName : String { get set }
    var alias : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ArmDisasterRecoveryProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.DisasterRecoveryConfigs {
// Get retrieves Alias(Disaster Recovery configuration) for primary or secondary namespace
internal class GetCommand : BaseCommand, DisasterRecoveryConfigsGet {
    public var resourceGroupName : String
    public var namespaceName : String
    public var alias : String
    public var subscriptionId : String
    public var apiVersion = "2017-04-01"

    public init(resourceGroupName: String, namespaceName: String, alias: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.namespaceName = namespaceName
        self.alias = alias
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{namespaceName}"] = String(describing: self.namespaceName)
        self.pathParameters["{alias}"] = String(describing: self.alias)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(ArmDisasterRecoveryData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ArmDisasterRecoveryProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: ArmDisasterRecoveryData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
