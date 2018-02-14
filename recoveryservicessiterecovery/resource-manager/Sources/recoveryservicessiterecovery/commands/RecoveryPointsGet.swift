import Foundation
import azureSwiftRuntime
public protocol RecoveryPointsGet  {
    var headerParameters: [String: String] { get set }
    var resourceName : String { get set }
    var resourceGroupName : String { get set }
    var subscriptionId : String { get set }
    var fabricName : String { get set }
    var protectionContainerName : String { get set }
    var replicatedProtectedItemName : String { get set }
    var recoveryPointName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (RecoveryPointProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.RecoveryPoints {
// Get get the details of specified recovery point.
internal class GetCommand : BaseCommand, RecoveryPointsGet {
    public var resourceName : String
    public var resourceGroupName : String
    public var subscriptionId : String
    public var fabricName : String
    public var protectionContainerName : String
    public var replicatedProtectedItemName : String
    public var recoveryPointName : String
    public var apiVersion = "2016-08-10"

    public init(resourceName: String, resourceGroupName: String, subscriptionId: String, fabricName: String, protectionContainerName: String, replicatedProtectedItemName: String, recoveryPointName: String) {
        self.resourceName = resourceName
        self.resourceGroupName = resourceGroupName
        self.subscriptionId = subscriptionId
        self.fabricName = fabricName
        self.protectionContainerName = protectionContainerName
        self.replicatedProtectedItemName = replicatedProtectedItemName
        self.recoveryPointName = recoveryPointName
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{resourceName}/replicationFabrics/{fabricName}/replicationProtectionContainers/{protectionContainerName}/replicationProtectedItems/{replicatedProtectedItemName}/recoveryPoints/{recoveryPointName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceName}"] = String(describing: self.resourceName)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{fabricName}"] = String(describing: self.fabricName)
        self.pathParameters["{protectionContainerName}"] = String(describing: self.protectionContainerName)
        self.pathParameters["{replicatedProtectedItemName}"] = String(describing: self.replicatedProtectedItemName)
        self.pathParameters["{recoveryPointName}"] = String(describing: self.recoveryPointName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(RecoveryPointData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (RecoveryPointProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: RecoveryPointData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
