import Foundation
import azureSwiftRuntime
public protocol ExportJobsOperationResultsGet  {
    var headerParameters: [String: String] { get set }
    var vaultName : String { get set }
    var resourceGroupName : String { get set }
    var subscriptionId : String { get set }
    var operationId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (OperationResultInfoBaseResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ExportJobsOperationResults {
// Get gets the operation result of operation triggered by Export Jobs API. If the operation is successful, then it
// also contains URL of a Blob and a SAS key to access the same. The blob contains exported jobs in JSON serialized
// format.
internal class GetCommand : BaseCommand, ExportJobsOperationResultsGet {
    public var vaultName : String
    public var resourceGroupName : String
    public var subscriptionId : String
    public var operationId : String
    public var apiVersion = "2017-07-01"

    public init(vaultName: String, resourceGroupName: String, subscriptionId: String, operationId: String) {
        self.vaultName = vaultName
        self.resourceGroupName = resourceGroupName
        self.subscriptionId = subscriptionId
        self.operationId = operationId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupJobs/operationResults/{operationId}"
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
            let result = try decoder.decode(OperationResultInfoBaseResourceData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (OperationResultInfoBaseResourceProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: OperationResultInfoBaseResourceData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
