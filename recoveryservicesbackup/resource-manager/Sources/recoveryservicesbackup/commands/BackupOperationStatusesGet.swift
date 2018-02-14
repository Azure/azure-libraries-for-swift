import Foundation
import azureSwiftRuntime
public protocol BackupOperationStatusesGet  {
    var headerParameters: [String: String] { get set }
    var vaultName : String { get set }
    var resourceGroupName : String { get set }
    var subscriptionId : String { get set }
    var operationId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (OperationStatusProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.BackupOperationStatuses {
// Get fetches the status of an operation such as triggering a backup, restore. The status can be in progress,
// completed or failed. You can refer to the OperationStatus enum for all the possible states of an operation. Some
// operations create jobs. This method returns the list of jobs when the operation is complete.
internal class GetCommand : BaseCommand, BackupOperationStatusesGet {
    public var vaultName : String
    public var resourceGroupName : String
    public var subscriptionId : String
    public var operationId : String
    public var apiVersion = "2016-12-01"

    public init(vaultName: String, resourceGroupName: String, subscriptionId: String, operationId: String) {
        self.vaultName = vaultName
        self.resourceGroupName = resourceGroupName
        self.subscriptionId = subscriptionId
        self.operationId = operationId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupOperations/{operationId}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{vaultName}"] = String(describing: self.vaultName)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{operationId}"] = String(describing: self.operationId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(OperationStatusData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (OperationStatusProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: OperationStatusData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
